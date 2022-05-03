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
//
//= require rails-ujs
//= require activestorage
//= require_tree .
//= require jquery
$(function () {
  $(".modal-hide-button").click(function (event) {
    var id = event.target.parentElement.id.replace("-contents", "");
    modal_display(true, `${event.target.parentElement.id}`, `${id}-background`)
  });


});
function modal_display(hide, target_contents, target_background) {
  if (hide == true) {
    $(`.modal-contents#${target_contents}`).addClass("hide");
    $(`.modal-background#${target_background}`).addClass("hide");
  } else {
    $(`.modal-contents#${target_contents}`).removeClass("hide");
    $(`.modal-background#${target_background}`).removeClass("hide");
  }
}
