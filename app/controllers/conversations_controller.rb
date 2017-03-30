class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations
  end

  def create
    if Conversation.between(sender_id: current_user.id, recipient_id: params[:recipient_id]).present?
      @conversation = Conversation.between(current_user, @user).first
    else
      @conversation = Conversation.create!(sender: current_user, recipient_id: params[:recipient_id])
    end
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
