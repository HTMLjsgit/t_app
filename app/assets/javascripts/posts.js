$(function(){
  $('.post-slide-control-one-image-box').click(function(event){
    $(".image-contents-zoom.slick").slick("slickGoTo", event.currentTarget.dataset.index, false);
    modal_display(false, "image-post-zoom-modal-contents", "image-post-zoom-modal-background");
  });
  $('.post-slide-image-one-box').click(function(event){
    $(".image-contents-zoom.slick").slick("slickGoTo", event.currentTarget.dataset.index, false);
    modal_display(false, "image-post-zoom-modal-contents", "image-post-zoom-modal-background");
  });
});