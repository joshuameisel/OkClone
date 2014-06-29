class Conversation < ActiveRecord::Base
  has_many(
    :memberships, 
    class_name: "ConversationMembership", 
    foreign_key: :conversation_id)
  has_many(
    :participants, 
    through: :memberships, 
    source: :user, 
    inverse_of: :conversations)
  has_many :messages
end
