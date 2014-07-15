class Api::QuestionsController < ApplicationController
  def index
    @answers = User.find(params[:user_id]).answers.order('RANDOM()')
    render :json => @answers.to_json(methods: :question)
  end
end