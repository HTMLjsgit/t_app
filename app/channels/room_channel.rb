class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    if data["message"] == ""
      return false
    end
    room = Room.find params[:room_id]
    chat_post = room.chat_posts.create(message: data["message"], user_id: current_user.id)
    message_render = ApplicationController.render_with_signed_in_user(chat_post.user,partial: "rooms/message", locals: {chat: chat_post, user: chat_post.user})
    ActionCable.server.broadcast "room_channel_#{params[:room_id]}", message_render: message_render, user_id: chat_post.user_id, message_id: chat_post.id
  end
end
