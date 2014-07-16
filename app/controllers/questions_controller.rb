class QuestionsController < ApplicationController
  def index
    user = 
    @questions = 
      User.find(params[:user_id]).answered_questions.order("RANDOM()")
  end
end
