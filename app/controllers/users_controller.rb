class UsersController < ApplicationController
  before_filter :require_logged_out!, :only => :new
  
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  private
  def user_params
    params.require(:user).permit(
      :username, :gender, :orientation, :dob, :country, 
      :session_token, :zip_code, :email, :password
    )
  end
end
