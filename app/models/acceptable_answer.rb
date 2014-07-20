class AcceptableAnswer < ActiveRecord::Base
  validates :user_id, presence: true
  validates :answer_choice_id, presence: true, uniqueness: {scope: :user_id}
  belongs_to :answer_choice
end