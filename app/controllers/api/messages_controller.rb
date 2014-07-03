class Api::MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.save
      render :json => @profile
    else
      render :json => @errors, :status => :unprocessable_entity
    end
  end

  private

  def message_params
    params.permit(:sender_id, :recipient_id, :body)
  end
end
