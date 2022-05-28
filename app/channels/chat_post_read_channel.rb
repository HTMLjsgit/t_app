class ChatPostReadChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_post_read_channel_#{params[:room_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def read(data)
    @chat_post = ChatPost.find data["chat_post_id"]

    if @chat_post.chat_post_read == true
      return false
    end
    @room = Room.find params[:room_id]
    @chat_post.chat_post_read.update(user_id: data["user_id"], chat_post_id: data["chat_post_id"], read: true)
  end
end
