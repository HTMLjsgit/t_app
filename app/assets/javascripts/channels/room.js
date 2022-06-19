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
      if (animate != null) {
        animate.stop();
      }
      $("#messages").append(data["message_render"]);
      var current_user_id = $("#room-show").data("current_user");
      var user_class = current_user_id != data["user_id"] ? "current-user-front-room" : "";
      if (data["user_id"] != current_user_id) {
        //プロフィールを読み込み
        $(`#message-${data["message_id"]} .room-message-user-profile`).html(data["user_profile_render"]);
        //既読をサーバーに送信
        App.chat_post_read.read(current_user_id, data["message_id"]);
      }
      $(`#message-${data["message_id"]}`).removeClass(user_class);
      setTimeout(function () {
        animate = $('.room-messages').animate({ scrollTop: $("#messages").height() });
      }, 100);
    },

    speak: function (message) {
      return this.perform('speak', { message: message });
    },
    image_upload: function (base64, filename) {
      return this.perform('image_upload', { base64: base64, filename: filename });
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
  $("#room-image-post-input").change(function (event) {
    let file = event.target.files[0]
    let file_reader = new FileReader();
    file_reader.onload = function (event) {
      let base_64 = event.target.result;
      App.room.image_upload(base_64, file.name);
    }
    file_reader.readAsDataURL(file);
  });
  function SpeakEvent(_target) {

    App.room.speak(_target.value);
    _target.value = "";


  }
});
