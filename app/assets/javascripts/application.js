// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require h5bp
//= require authentications
//= require jquery.infinitescroll
//= require masonry

var $container = $('#content');

$container.imagesLoaded(function(){
      $container.masonry({
        itemSelector: '.item'
      });
    });

$container.infinitescroll({
    navSelector  : "div.navigation",
    nextSelector : "div.navigation a:first",
    itemSelector : "#content div.item",
    loadingText  : "Loading new products...",
    bufferPx     : 100
  },
  function( newElements ) {
    var $newElems = $( newElements ).css({ opacity: 0 });
    $newElems.imagesLoaded(function(){
      $newElems.animate({ opacity: 1 });
      $container.masonry( 'appended', $newElems, true ); 
    });
  });

$('input, textarea').placeholder();