class Api::ProfilesController < ApplicationController
  def update
    @profile = Profile.find_by(user_id: params[:user_id])
    @profile.update_attributes(profile_params)

    @errors = @profile.errors.full_messages

    if @errors.empty?
      render :json => @profile
    else
      render :json => @errors, :status => :unprocessable_entity
    end
  end

  private

  def profile_params
    params.permit(:summary, :likes, :most_private, :religion)
  end
end
