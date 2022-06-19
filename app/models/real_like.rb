class RealLike < ApplicationRecord
  belongs_to :user
  belongs_to :real
  def self.like_attach(current_user, real_id)
    return current_user.real_likes.find_by(real_id: real_id)
  end
end
