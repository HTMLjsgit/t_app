class PostLike < ApplicationRecord
  belongs_to :post
  belongs_to :user
  def self.like_attach(current_user, post_id)
    return current_user.post_likes.find_by(post_id: post_id)
  end
end
