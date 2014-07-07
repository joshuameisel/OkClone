class ConversationsController < ApplicationController
  before_filter :require_user!

  def index
    current_user.received_messages.where(read_status: 0).each do |unread_msg|
      unread_msg.update_attributes(read_status: 1)
    end
    @conversations = current_user.conversations
  end

  def show
  end
end
