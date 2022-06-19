class AddReferencesRoomToChatPostReads < ActiveRecord::Migration[5.2]
  def change
    add_reference :chat_post_reads, :room, foreign_key: true
  end
end
