class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  belongs_to :user
  has_many :chat_posts, dependent: :destroy
end
