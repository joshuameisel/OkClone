class Api::ProfilesController < ApplicationController
  def update
    @profile = Profile.find_by(user_id: params[:user_id])
    if @profile.update_attributes(profile_params)
      render :json => @profile
    else
      render :json => @profile.errors.full_messages, :status => :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(
      :summary, :likes, :most_private, :religion
    )
  end
end
