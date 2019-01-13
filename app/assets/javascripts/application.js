// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//= require cable
//= require ckeditor/init
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require material
//= require bootstrap
//= require bootstrap-sprockets

$.ajaxSetup({
  headers: {
    'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
  }
});

$(() => {
  $("#flashmsg").hide(3000)
});   

$( ($) => {
  $('.like-to-user').click( function() {
    var msg = $(this)
    console.log($(msg).parent().parent().parent().hide())
    var n = $("#messages").children().length-1;
    console.log(n)
    $("#count_notification").text(n)  
    $.ajax({
      url: '/messages/' + $(msg).attr('data-message_id'),
      type: 'POST',
      data: { _method: 'PATCH' },
      success: (data) => {
        if(!data.plike)
        {
          alert('You already put like')
        }
      } 
    })
  })
});   

$( ($) => {
  $('.deletemsg').click( function() {
    var msg = $(this)
    console.log($(msg).parent().parent().parent().hide())
    var n = $("#messages").children().length-1;
    $("#count_notification").text(n)  
    console.log($(this).attr('data-message_id'))
    $.ajax({
      url: '/messages/' + $(msg).attr('data-message_id'),
      type: 'POST',
      data: { _method: 'DELETE' },
      success: () => {
        console.log('Complete')
      } 
    })
  })
});   

$(() => {
  var n = $("#messages").children().length;
  $("#count_notification").text(n)
});
