class ChatPost < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :chat_post_reads, dependent: :destroy
  has_many :chat_post_images, dependent: :destroy
  validate :check_image_or_message

  def check_image_or_message
    if self.message.blank? && self.chat_post_images.empty?
      errors.add(:message_error, "メッセージを入力するか、画像を選択してください。")
    end
  end
end
