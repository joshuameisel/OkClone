class UsersController < ApplicationController
  before_filter :require_logged_out!, :only => :new
  before_filter :require_user!, :only => :index

  def index
    if params[:search]
      @users = current_user.users(search_params)
    else
      @users = current_user.users
    end
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      redirect_to match_url
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
  def search_params
    {
      show_me: User.genders(params[:search][:show_me].to_i),
      who_like: User.genders(params[:search][:who_like].to_i),
      min_age: params[:search][:min_age].to_i,
      max_age: params[:search][:max_age].to_i,
      order_by: params[:search][:order_by] == "0" ? :random : :match_pct
    }
  end

  def user_params
    params.require(:user).permit(
      :username, :gender, :orientation, :dob, :country,
      :session_token, :zip_code, :email, :password
    )
  end
end
