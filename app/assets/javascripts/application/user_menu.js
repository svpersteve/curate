$(document).on('turbolinks:load', function() {
  var $userMenu = $('.js-user-menu');
  var $trigger = $('.js-user-menu-trigger');

  var toggleUserMenu = function(e) {
    e.preventDefault();
    $('.js-dropdown').addClass('u-hide--mobile');
    $userMenu.removeClass('u-hide--mobile');
    $userMenu.toggle();
  };

  $trigger.on('click', toggleUserMenu);
});
