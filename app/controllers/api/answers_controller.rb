class Api::AnswersController < ApplicationController
  def show
    @answer = Answer.find(params[:id])
    @question = @answer.question

    # @user holds the "other user's" answers. not present on own profile
    user = @answer.user
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