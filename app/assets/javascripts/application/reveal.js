$(document).on('turbolinks:load', function() {
  var $section = $('.js-reveal__hidden');
  var $trigger = $('.js-reveal__trigger');

  var toggleSection = function(e) {
    e.preventDefault();
    $section.toggle();
  };

  $trigger.on('click', toggleSection);
});
