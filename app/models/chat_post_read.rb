class ChatPostRead < ApplicationRecord
  belongs_to :chat_post
  belongs_to :room
  belongs_to :user, optional: true
  after_create_commit :after_create

  def after_create
    ActionCable.server.broadcast "chat_post_read_channel_#{self.room.id}", chat_post_id: self.chat_post_id, chat_user_id: self.user_id
  end
end
