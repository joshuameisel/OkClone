class PhotosController < ApplicationController
  before_filter :require_current_user!, except: :index

  def index
    @user = User.find(params[:user_id])
    @photos = @user.photos.order(:photo_id)
  end

  def new
  end

  def create
    photo = current_user.photos.new(photo_file: params[:photo_file])
    if photo.save
      redirect_to user_photos_url(current_user)
    else
      redirect_to new_user_photo_url(current_user)
    end
  end

  private

  def require_current_user!
    if !current_user
      redirect_to root_url
    elsif params[:user_id].to_i != current_user.id
      redirect_to users_url
    end
  end
end
