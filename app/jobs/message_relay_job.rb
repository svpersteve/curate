class MessageRelayJob < ApplicationJob
  queue_as :default

  def perform(message)
    ActionCable.server.broadcast "chatrooms:#{message.chatroom.id}", message: message.body, user_full_name: message.user.full_name, chatroom_id: message.chatroom.id, avatar: message.user.avatar
  end
end
