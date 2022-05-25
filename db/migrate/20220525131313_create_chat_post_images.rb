class CreateChatPostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_post_images do |t|
      t.string :picture
      t.references :chat_post

      t.timestamps
    end
  end
end
