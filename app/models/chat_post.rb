class ChatPost < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :chat_post_reads, dependent: :destroy
  has_many :chat_post_images, dependent: :destroy
end
