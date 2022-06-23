class Room < ApplicationRecord
  has_many :user_rooms, dependent: :destroy
  has_many :users, through: :user_rooms, dependent: :destroy
  has_many :chat_posts, dependent: :destroy
  has_many :chat_post_reads, dependent: :destroy
  def current_user_other_users(current_user_id)
    #自分以外のユーザー
    self.users.where.not(id: current_user_id)
  end
end
