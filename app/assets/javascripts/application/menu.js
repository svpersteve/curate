$(document).on('turbolinks:load', function() {
  var $section = $('.js-dropdown');
  var $trigger = $('.js-menu-trigger');

  var toggleSection = function(e) {
    e.preventDefault();
    $('.js-user-menu').addClass('u-hide--mobile');
    $section.removeClass('u-hide--mobile');
    $section.toggle();
  };

  $trigger.on('click', toggleSection);
});
