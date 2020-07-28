class AddSeeToChatposts < ActiveRecord::Migration[5.2]
  def change
    add_column :chat_posts, :see, :integer, :default => 0
  end
end
