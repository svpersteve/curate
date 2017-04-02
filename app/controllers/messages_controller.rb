class MessagesController < ApplicationController
  before_action :find_conversation

  def index # rubocop:disable Metrics/MethodLength
    @messages = @conversation.messages
    @messages.not_sent_by(current_user).each do |m|
      m.read = true
      m.save
    end
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    @over_ten = false if params[:m]
    @message = @conversation.messages.new
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user
    @message.conversation.updated_at = Time.now
    @message.conversation.save

    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private

  def message_params
    params.require(:message).permit(:body)
  end

  def find_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
