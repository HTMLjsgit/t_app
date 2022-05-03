$(function () {
  App.room = App.cable.subscriptions.create({ channel: "RoomChannel", room_id: $("#room-show").data("room_id") }, {
    connected: function () {
      // Called when the subscription is ready for use on the server

    },

    disconnected: function () {
      // Called when the subscription has been terminated by the server
    },

    received: function (data) {
      // Called when there's incoming data on the websocket for this channel
      $("#messages").append(data["message_render"]);
    },

    speak: function (message) {
      return this.perform('speak', { message: message });
    }
  });

  $(document).on('keypress', "[data-behavior='room_speaker']", function (event) {
    if (event.keyCode == 13) {

      App.room.speak(event.target.value)
      event.target.value = "";
    }
  });

});
