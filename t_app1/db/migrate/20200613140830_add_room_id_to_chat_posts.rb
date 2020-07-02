class AddRoomIdToChatPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :chat_posts, :room_id, :integer
  end
end
