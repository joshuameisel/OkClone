class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if user.nil?
      flash.now[:errors] = ["Incorrect username and/or password"]
      render :new
      return
    else
      login_user!(user)
      redirect_to users_url
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil

    redirect_to root_url
  end

  def new
    render :new
  end
end
