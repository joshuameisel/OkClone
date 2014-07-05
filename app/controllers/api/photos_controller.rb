class Api::PhotosController < ApplicationController
  before_filter :require_current_user!, except: :index

  def index
    @photos = User.find(params[:user_id]).photos
    render :json => @photos
  end

  # def create
  #   @message = current_user.sent_messages.new(message_params)
  #   if @message.save
  #     render :json => @profile
  #   else
  #     render :json => @errors, :status => :unprocessable_entity
  #   end
  # end

  private
  #
  # def message_params
  #   params.permit(:body, :recipient_id)
  # end

  def require_current_user!
    redirect_to users_url unless params[:user_id] == current_user.id
  end
end
