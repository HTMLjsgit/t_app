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
    user_profile_render = ApplicationController.render_with_signed_in_user(chat_post.user,partial: "users/user_profile", locals: {user: chat_post.user, username: ""})
    ActionCable.server.broadcast "room_channel_#{params[:room_id]}", message_render: message_render, user_id: chat_post.user_id, message_id: chat_post.id, user_profile_render: user_profile_render
  end

  def image_upload(data)
    room = Room.find params[:room_id]
    chat_post = room.chat_posts.new(message: "", user_id: current_user.id)

    unless Dir.exist?("public/uploads/chat_post_images/#{chat_post.id}")
      FileUtils.mkdir_p("public/uploads/chat_post_images/#{chat_post.id}")
    end
    base64_url = data["base64"].sub %r/data:((image|application)\/.{3,}),/, ''
    target_file_information = Base64.decode64(base64_url)

    File.open("public/uploads/chat_post_images/#{chat_post.id}/#{data["filename"]}", "wb") {|f| f.write(target_file_information) }

    chat_post_image = chat_post.chat_post_images.new(picture: "/uploads/chat_post_images/#{chat_post.id}/#{data["filename"]}")

    chat_post.save!

    message_render = ApplicationController.render_with_signed_in_user(chat_post.user,partial: "rooms/message", locals: {chat: chat_post, user: chat_post.user})
    user_profile_render = ApplicationController.render_with_signed_in_user(chat_post.user,partial: "users/user_profile", locals: {user: chat_post.user, username: ""})
    ActionCable.server.broadcast "room_channel_#{params[:room_id]}", message_render: message_render, user_id: chat_post.user_id, message_id: chat_post.id, user_profile_render: user_profile_render

  end
end
