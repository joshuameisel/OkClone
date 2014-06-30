class ConversationsController < ApplicationController
  before_filter :require_participation!, only: :show
  
  def index
    @conversations = current_user.conversations
  end
  
  def show
    @conversation = Conversation.find(params[:id])
  end
  
  private
  
  def require_participation!
    unless Conversation.find(params[:id]).participants.include?(current_user)
      raise "not found"
    end
  end
end
