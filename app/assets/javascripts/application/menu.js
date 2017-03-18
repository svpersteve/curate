$(document).on('turbolinks:load', function() {
  var $menu = $('.js-dropdown');
  var $trigger = $('.js-menu-trigger');

  var toggleSection = function(e) {
    e.preventDefault();
    $menu.toggle();
  };

  $trigger.on('click', toggleSection);
});
