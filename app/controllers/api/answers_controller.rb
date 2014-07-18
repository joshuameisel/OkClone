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

  def update
    @answer = current_user
      .answers
      .where(
        "answer_choice_id IN (?)",
        Answer.find(params[:id]).answer_choice.other_choices.map(&:id))
      .limit(1)
      .first

    if @answer.update_attributes(answer_params)
      render "update"
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:answer_choice_id)
  end
end