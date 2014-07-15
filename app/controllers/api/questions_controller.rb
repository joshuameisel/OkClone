class Api::QuestionsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    @questions = user.answered_questions.order("RANDOM()")
    
    @current_user = current_user
    # only set @user (which holds the un-editable answers) if you're not looking at your own profile
    @user = user unless @current_user == user
  end
end