class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms, dependent: :destroy
  has_many :chat_posts, dependent: :destroy
end
