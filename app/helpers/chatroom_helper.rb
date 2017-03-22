module ChatroomHelper
  def message_title(chatroom)
    chatroom.users.map { |u| link_to(u.name, user_path(u)) }.to_sentence
  end
end
