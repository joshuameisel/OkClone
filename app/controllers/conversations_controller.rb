class ConversationsController < ApplicationController
  before_filter :require_user!

  def index
    @conversations = current_user.conversations
  end

  def show
    current_user.received_messages
                .where(sender_id: params[:user_id])
                .each do |unread_msg|
      unread_msg.update_attributes(read_status: 1)
    end
  end
end
