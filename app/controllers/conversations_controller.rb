class ConversationsController < ApplicationController
  before_filter :require_user!

  def index
    @conversations = current_user.conversations
  end

  def show
  end
end
