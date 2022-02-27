class Real < ApplicationRecord
  validates :user_id,{presence: true}
  validates :content, {presence: true, length: {maximum: 140}}
  belongs_to :user
  has_many :real_comments
  has_many :real_likes
  has_many_attached :images
  has_many :image_reals, dependent: :destroy
  accepts_nested_attributes_for :image_reals, allow_destroy: true
  is_impressionable

  def user
     return User.find_by(id: self.user_id)
  end
end
