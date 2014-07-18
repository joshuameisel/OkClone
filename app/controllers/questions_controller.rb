class QuestionsController < ApplicationController
  def index
    @answers =
      User.find(params[:user_id]).answers.order("RANDOM()")
  end
end
