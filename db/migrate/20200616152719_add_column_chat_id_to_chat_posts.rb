class AddColumnChatIdToChatPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :chat_posts, :chat_id, :integer
  end
end
