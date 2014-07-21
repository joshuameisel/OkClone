class QuestionsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    if user == current_user
      @questions = Question.all.order("Random()")
    else
      @questions = user.answered_questions.order("Random()")
    end
  end
end
