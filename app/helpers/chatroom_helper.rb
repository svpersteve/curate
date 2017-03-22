module ChatroomHelper
  def message_title(chatroom)
    chatroom.users.map { |u| link_to(u.name, user_path(u)) }.to_sentence
  end

  def user_list_without_current(chatroom)
    users = chatroom.users.where.not(id: current_user.id)
    users.map { |u| u.name }.to_sentence
  end
end
