class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :recipient, class_name: "User", foreign_key: :recipient_id

  validates :sender_id, :recipient_id, :body, presence: true

  def snippet
    body.slice(0,20) + "..."
  end
end
