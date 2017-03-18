$(document).on('turbolinks:load', function() {
  var $userMenu = $('.js-user-menu');
  var $trigger = $('.js-user-menu-trigger');

  var toggleUserMenu = function(e) {
    e.preventDefault();
    $userMenu.toggle();
  };

  $trigger.on('click', toggleUserMenu);
});
