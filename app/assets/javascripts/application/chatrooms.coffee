$(document).on 'turbolinks:load', ->
  messages = $('#messages')
  messages_to_bottom = -> messages.scrollTop(messages.prop("scrollHeight"))

  messages_to_bottom()

  $('#new_message').on 'keypress', (e) ->
    if e && e.keyCode == 13
      e.preventDefault()
      $(this).submit()

  $('#new_message').on "submit", (e) ->
    e.preventDefault()
    chatroom_id = $("[data-behavior='messages']").data("chatroom-id")
    body        = $("#message_body")

    App.chatrooms.send_message(chatroom_id, body.val())
    body.val('')
