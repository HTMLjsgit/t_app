class RealLike < ApplicationRecord
  belongs_to :user
  belongs_to :real
  #validates :real_id
  validates :user_id, uniqueness: true
  def self.like_attach(current_user, real_id)
    return current_user.real_likes.find_by(real_id: real_id)
  end
end
