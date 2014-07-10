class AnswerChoice < ActiveRecord::Base
  before_validation :ensure_order
  validates :question_id, :order, presence: true
  validates :body, presence: true, uniqueness: {scope: :question_id}
  belongs_to :question
  
  private
  
  def ensure_order
    # use to_i to translate nil to 0 on first answer_choice created
    order || self.order = question.answer_choices.maximum(:order).to_i + 1
  end
end