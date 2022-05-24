class ChatPost < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :chat_post_reads, dependent: :destroy
end
