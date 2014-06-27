class UsersController < ApplicationController
  before_filter :require_logged_out!, :only => :new
  before_filter :require_user!, :only => :index
  
  def index
    @users = current_user.users
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new, layout: "signed_out"
    end
  end

  def new
    @user = User.new
    render layout: "signed_out"
  end

  private
  def user_params
    params.require(:user).permit(
      :username, :gender, :orientation, :dob, :country, 
      :session_token, :zip_code, :email, :password
    )
  end
end
