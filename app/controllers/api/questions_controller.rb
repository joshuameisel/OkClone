class Api::QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    
    # @user holds the "other user's" answers. not present on own profile
    user = User.find(params[:user_id])
    unless current_user == user
      @user = user
      @user_answer = @user.answers.where(
        "answer_choice_id IN (?)",
        @question.answer_choices.ids
      ).limit(1).first
    end
    
    if current_user
      @current_user_answer = current_user.answers.where(
        "answer_choice_id IN (?)",
        @question.answer_choices.ids
      ).limit(1).first
    end
  end
end