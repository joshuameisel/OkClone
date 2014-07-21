class Api::QuestionsController < ApplicationController
  def show
    @question = Question.find(params[:id])
    @answers = {}
    @acceptable_answers = {}

    @users = current_user ? [current_user] : []

    # @user holds the "other user's" answers. not present on own profile
    user = User.find(params[:user_id])
    @users << user unless current_user == user
    @users.each do |u|
      @answers[u] = u.answers.where(*where_args).limit(1).first
      @acceptable_answers[u] = relevant_acceptable_answers(u)
    end
  end

  def update
    @answer = current_user.answers.where(*where_args).limit(1).first
    if @answer
      @answer.update_attributes(answer_params)
    else
      @answer = current_user.answers.create(answer_params)
    end

    AcceptableAnswer.destroy(relevant_acceptable_answers(current_user).ids)
    @acceptable_answers = current_user.acceptable_answers.create(
      params[:acceptable_answers].to_a.map do |answer_choice_id|
        {answer_choice_id: answer_choice_id}
      end
    )
  end

  private

  def where_args
    @where_var ||= @question.answer_choices.ids
    ["answer_choice_id IN (?)", @where_var]
  end

  def relevant_acceptable_answers(user)
    user.acceptable_answers.where(*where_args)
  end

  def answer_params
    params.require(:answer).permit(:answer_choice_id)
  end
end