class Api::UsersController < ApplicationController
  respond_to :json

  def index
    @users = User.all
    render json: @users
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @photos = @user.photos
    render "show"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      render :json => @user.to_json(methods: [:age, :profile, :likes])
    else
      render :json => @user.errors.full_messages,
        :status => :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(
      :username, :gender, :orientation, :dob, :country,
      :session_token, :zip_code, :email, :password
    )
  end
end
