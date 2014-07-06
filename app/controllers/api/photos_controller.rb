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
    if !current_user
      redirect_to root_url
    elsif params[:user_id].to_i != current_user.id
      redirect_to match_url
    end
  end
end
