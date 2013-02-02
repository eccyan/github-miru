$(document).ready(function($){
  var rand = function () { return 20 + Math.floor( Math.random() * 80 ); }
  var em = parseFloat( $container.css('font-size') );
  $('.container').masonry({
    itemSelector: '.source',
    columnWidth: rand() * em,
    isAnimated: true,
    animationOptions: {
      duration: 750,
      easing: 'linear',
      queue: false
    }
  });
});
