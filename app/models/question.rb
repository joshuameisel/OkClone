class Question < ActiveRecord::Base
  validates :body, presence: true
  has_many :answer_choices
end