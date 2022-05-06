$(function () {
  var animate = null;
  App.room = App.cable.subscriptions.create({
    channel: "RoomChannel", room_id: $("#room-show").data("room_id")
  }, {
    connected: function () {
      // Called when the subscription is ready for use on the server

    },

    disconnected: function () {
      // Called when the subscription has been terminated by the server
    },

    received: function (data) {
      // Called when there's incoming data on the websocket for this channel
      $("#messages").append(data["message_render"]);
      var user_class = $("#room-show").data("current_user") != data["user_id"] ? "current-user-front-room" : "";
      console.log(user_class)
      console.log($("#room-show").data("current_user"));
      console.log(data["user_id"]);
      $(`#message-${data["message_id"]}`).removeClass(user_class);

    },

    speak: function (message) {
      return this.perform('speak', { message: message });
    }
  });

  $(document).on('keypress', "[data-behavior='room_speaker']", function (event) {
    if (event.keyCode == 13) {
      SpeakEvent(event.target);
    }
  });
  $(".room-form-send-button").click(function () {
    let target = document.querySelector("[data-behavior='room_speaker']");
    SpeakEvent(target);
  });
  function SpeakEvent(_target) {
    if (animate != null) {
      animate.stop();
    }
    App.room.speak(_target.value);
    _target.value = "";

    setTimeout(function () {
      animate = $('html, body').animate({ scrollTop: $(".room-show-bottom-box").offset().top });
    }, 100);
  }
});
