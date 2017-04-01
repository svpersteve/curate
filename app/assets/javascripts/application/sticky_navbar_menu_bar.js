$(document).on('turbolinks:load', function() {
  var $navbar = $('#primary-navbar');
  var $navbarWithCanvas = $('.js-stick--below-navbar')

  $(window).scroll(function() {
    if( $(this).scrollTop() > $navbar.height()) {
      $navbarWithCanvas.addClass('s-navbar--fixed');
    }
    else {
      $navbarWithCanvas.removeClass('s-navbar--fixed');
    }
  })
});
