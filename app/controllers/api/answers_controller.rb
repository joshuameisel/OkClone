class Api::AnswersController < ApplicationController
  def show
    @answer = Answer.find(params[:id])
    @question = @answer.question

    # @user holds the "other user's" answers. not present on own profile
    user = @answer.user
    unless current_user == user
      @user = user
      @user_answer = @user.answers.where(*where_args).limit(1).first
    end

    @current_user_answer =
      current_user.answers.where(*where_args).limit(1).first if current_user
  end

  def update
    @answer = current_user.answers.where(*where_args).limit(1).first
    @answer.update_attributes(answer_params)
  end

  private

  def where_args
    @where_var ||= Answer.find(params[:id]).question.answer_choices.ids
    ["answer_choice_id IN (?)", @where_var]
  end

  def answer_params
    params.require(:answer).permit(:answer_choice_id)
  end
end