class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer_choice
  has_one :question, through: :answer_choice
  
  before_create :destroy_previous_answer
  validates :user_id, :answer_choice_id, presence: true
  
  private
  
  def destroy_previous_answer
    previous_answer = user.answers.where(
      "answer_choice_id IN 
        (#{answer_choice.question.answer_choices.ids.join(',')})"
    ).first
    
    if previous_answer
      Answer.destroy(previous_answer.id)
    end
  end
end