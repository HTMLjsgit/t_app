class RoomChannel < ApplicationCable::Channel

  def subscribed
    # 接続された時
    stream_from 'room_channel'
  end

  def unsubscribed
    # 切断された時
  end

  def speak(data)
    # 以下を実行すれば、データベースに保存。実行しなければ保存しない
    post = ChatPost.new(message: data['message'][0], user_id: data['message'][1].to_i, room_id: data['message'][3].to_i)
    post.save

    ActionCable.server.broadcast 'room_channel', message: data['message'] # フロントへ返却
  end

end
