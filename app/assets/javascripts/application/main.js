$(document).on('turbolinks:load', function() {
  messages = $('#messages')
  $('.chosen-select').chosen({
    allow_single_deselect: true,
    width: '400px'
  });
  messages_to_bottom = function() {
    messages.scrollTop(messages.prop("scrollHeight"))
  };

  messages_to_bottom()
});
