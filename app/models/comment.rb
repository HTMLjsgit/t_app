class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  def post
     return Post.find_by(id: self.post_id)
  end
end
