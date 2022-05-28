class ChatPost < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_one :chat_post_read, dependent: :destroy
  has_many :chat_post_images, dependent: :destroy
  validate :check_image_or_message
  after_create_commit :after_create
  def check_image_or_message
    if self.message.blank? && self.chat_post_images.empty?
      errors.add(:message_error, "メッセージを入力するか、画像を選択してください。")
    end
  end

  def after_create
    ChatPostRead.create!(room_id: self.room_id, chat_post_id: self.id, read: false)
  end
end
