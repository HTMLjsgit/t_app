class CreateChatPostReads < ActiveRecord::Migration[5.2]
  def change
    create_table :chat_post_reads do |t|
      t.references :chat_post, foreign_key: true
      t.boolean :read, default: false, null: false
      t.timestamps
    end
  end
end
