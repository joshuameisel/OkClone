class Api::ProfilesController < ApplicationController
  def update
    @user = User.find(params[:user_id])
    @user.update_attributes(user_params) if params[:user]

    @profile = @user.profile
    @profile.update_attributes(profile_params)

    @errors = @user.errors.full_messages + @profile.errors.full_messages

    if @errors.empty?
      render :json => @profile
    else
      render :json => @errors, :status => :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:summary, :likes, :most_private, :religion)
  end

  def user_params
    params.require(:user).permit(:orientation)
  end
end
