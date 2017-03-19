$(document).on('turbolinks:load', function() {
  var $navbarWithCanvas = $('.js-stick--below-canvas');

  $(window).scroll(function() {
    if( $(this).scrollTop() > $(this).height()) {
      $navbarWithCanvas.addClass('s-navbar--fixed');
    }
    else {
      $navbarWithCanvas.removeClass('s-navbar--fixed');
    }
  })
});
