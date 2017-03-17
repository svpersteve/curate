$(document).on('turbolinks:load', function() {
  $('.js-dismiss-trigger').on('click', function(event) {
    event.preventDefault();
    $(this).parents('.js-dismiss-container').fadeOut();
  });
});
