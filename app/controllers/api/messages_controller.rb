class Api::MessagesController < ApplicationController
  def create
    @message = current_user.sent_messages.new(message_params)
    if @message.save
      render :json => @profile
    else
      render :json => @errors, :status => :unprocessable_entity
    end
  end

  def show
    @message = Message.find(params[:id])
    render "show"
  end

  def index
    @messages = Message.all
      .where(
        "sender_id=#{params[:user_id]} AND recipient_id=#{current_user.id} OR
        recipient_id=#{params[:user_id]} AND sender_id=#{current_user.id}")
      .order(:created_at)
    @other_user = params[:user_id]
    render "index"
  end
  
  def destroy
    @message = Message.find(params[:id]).destroy
    render "show"
  end

  private

  def message_params
    params.permit(:body, :recipient_id)
  end
end
