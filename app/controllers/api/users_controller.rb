class Api::UsersController < ApplicationController
  respond_to :json
  
  def index
    @users = User.all
    render json: @users
  end
  
  def show
    @user = User.find(params[:id])
    render json: @user.to_json(methods: [:age, :profile])
  end
end
