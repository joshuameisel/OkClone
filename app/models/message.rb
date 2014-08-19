class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "User", foreign_key: :sender_id
  belongs_to :recipient, class_name: "User", foreign_key: :recipient_id

  validates :sender_id, :recipient_id, :body, presence: true

  def self.snippet(body)
    body.slice(0,45) + (body.length > 45 ? "..." : "")
  end
end
