App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    messages = $('#messages')
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))
    active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")

    if active_chatroom.length > 0

      active_chatroom.append(
        "<div class='m-chat__message'>
        <img src='#{data.avatar}' class='a-avatar--thumb-square' />
        <div class='m-chat__message-body'>
        <p>#{data.user_full_name}</p>
        <p>#{data.message}</p></div></div>"
        )
      messages_to_bottom()

      if document.hidden && Notification.permission == 'granted'
        new Notification(data.user_full_name, {body: data.message})

    else
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")

  send_message: (chatroom_id, message) ->
    @perform "send_message", {
      chatroom_id: chatroom_id,
      message: message
    }
