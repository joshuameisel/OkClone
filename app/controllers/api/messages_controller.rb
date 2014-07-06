class Api::MessagesController < ApplicationController
  def create
    @message = current_user.sent_messages.new(message_params)
    if @message.save
      render :json => @profile
    else
      render :json => @errors, :status => :unprocessable_entity
    end
  end

  def index
    @messages = Message.all
      .where(
        "sender_id=#{params[:user_id]} AND recipient_id=#{current_user.id} OR
        recipient_id=#{params[:user_id]} AND sender_id=#{current_user.id}")
      .order(:created_at)
    render :json => @messages
  end

  private

  def message_params
    params.permit(:body, :recipient_id)
  end
end
