jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if $('#messages').length > 0
    messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))

    messages_to_bottom()


    App.chatrooms = App.cable.subscriptions.create "ChatroomsChannel",
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        active_chatroom = $("[data-behavior='messages'][data-chatroom-id='#{data.chatroom_id}']")
        if active_chatroom.length > 0
          active_chatroom.append data['message']
          messages_to_bottom()
        else
          $("[data-behavior='chatroom-link'][data-chatroom-id='#{data.chatroom_id}']").css("font-weight", "bold")

      send_message: (chatroom_id, message) ->
        @perform "send_message", {
          chatroom_id: chatroom_id,
          message: message
        }
