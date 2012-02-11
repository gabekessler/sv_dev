// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


  $("a#invite_fb_friends").click(function() {
    FB.init({ 
      appId:'311652035552967', 
      cookie:false, 
      status:true
    });

    FB.ui({ method: 'apprequests', message:  "This person thinks you are really Awesome."});
  });
