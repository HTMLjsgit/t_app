$(function () {
  var animate = null;
  App.chat_post_read = App.cable.subscriptions.create({
    channel: "ChatPostReadChannel", room_id: $("#room-show").data("room_id")
  }, {
    connected: function () {
      // Called when the subscription is ready for use on the server
    },

    disconnected: function () {
      // Called when the subscription has been terminated by the server
    },

    received: function (data) {
      // Called when there's incoming data on the websocket for this channel
      var current_user_id = $("#room-show").data("current_user");

      var chat_post_id = data["chat_post_id"];
      if (current_user_id != data["chat_user_id"]) {
        $(`#message-${chat_post_id} .room-chat-already-text-box`).text("既読");
      }


    },

    read: function (user_id, chat_post_id) {
      debugger;
      return this.perform('read', { user_id: user_id, chat_post_id: chat_post_id });
    }
  });

});
