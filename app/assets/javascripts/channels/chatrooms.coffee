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

      if document.hidden
        if $('.strike').length == 0
          active_chatroom.append("<div class='m-chat__strike'><p>New messages</p></div>")

        if Notification.permission == 'granted'
          notification = new Notification(data.user_full_name, {body: data.message})

      else
        App.last_read.update(data.chatroom_id)

      active_chatroom.append(
        "<div class='m-chat__message'>
        <img src='#{data.avatar}' class='a-avatar--thumb-square' />
        <div class='m-chat__message-body'>
        <p>#{data.user_full_name}</p>
        <p>#{data.message}</p></div></div>"
        )

      messages_to_bottom()

    else
      $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")

  send_message: (chatroom_id, message) ->
    @perform "send_message", {
      chatroom_id: chatroom_id,
      message: message
    }
