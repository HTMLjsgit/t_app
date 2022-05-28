class ChatPostRead < ApplicationRecord
  belongs_to :chat_post
  belongs_to :room
  belongs_to :user, optional: true
  after_update_commit :after_update

  def after_update
    ActionCable.server.broadcast "chat_post_read_channel_#{self.room.id}", chat_post_id: self.chat_post_id, chat_user_id: self.user_id, read_count_mode: false
    #no_read_count = self.room.chat_posts.joins(:chat_post_read).where(chat_post_reads: {read: false})
    #ActionCable.server.broadcast "chat_post_read_channel_#{self.user_id}", read_count: no_read_count, read_count_mode: true
  end
end
