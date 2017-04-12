$(document).on('turbolinks:load', function() {
  var $menuTrigger = $('#js-nav-menu-dropdown-mobile-trigger');
  var $menuContents = $('#nav-menu-dropdown-mobile');

  var toggleMenu = function(e) {
    e.preventDefault();
    $menuContents.toggle();
    $userNavContents.hide();
    $notificationsContents.hide();
  };

  $menuTrigger.on('click', toggleMenu);

  var $userNavTrigger = $('.js-user-nav-trigger');
  var $userNavContents = $('#user-nav-menu-dropdown');

  var toggleUserNav = function(e) {
    e.preventDefault();
    $userNavContents.toggle();
    $menuContents.hide();
    $notificationsContents.hide();
  };

  $userNavTrigger.on('click', toggleUserNav);

  var $notificationsTrigger = $('.js-open-notifications');
  var $notificationsContents = $('#notifications-dropdown');

  var toggleNotifications = function(e) {
    e.preventDefault();
    $notificationsContents.toggle();
    $menuContents.hide();
    $userNavContents.hide();
  };

  $notificationsTrigger.on('click', toggleNotifications);
});
