class Message < ActiveRecord::Base
  before_creation: :ensure_thread 
  validates: :sender_id, :recipient_id, :message_id, presence: true

  belongs_to( 
    :thread, 
    class_name: "MessageThread", 
    foreign_key: :message_thread_id
  )
  
  private
  
  def ensure_thread
    MessageThread.find_or_create_by(sender_id: :sender_id, recipient_id: )
  end
end
