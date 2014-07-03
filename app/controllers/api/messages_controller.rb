class Api::MessagesController < ApplicationController
  def create
    5.times {puts}
    puts message_params
    @message = current_user.sent_messages.new(message_params)
    if @message.save
      render :json => @profile
    else
      render :json => @errors, :status => :unprocessable_entity
    end
  end

  private

  def message_params
    params.permit(:body, :recipient_id)
  end
end
