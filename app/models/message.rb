class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :recipient, class_name: "User", foreign_key: :recipient_id
  
  # before_creation doesn't work?
  before_validation :ensure_thread
  validates :sender_id, :recipient_id, :conversation_id, presence: true
  
  def snippet
    body.slice(0,20) + "..."
  end
  
  private
  
  def ensure_thread
    sender.conversations.each do |conversation|
      if conversation.participants.include?(recipient)
        self.conversation = conversation
      end
    end
    
    self.conversation = Conversation.create
    conversation.memberships.create([
      {user_id: sender_id},
      {user_id: recipient_id}
    ])
  end
end
