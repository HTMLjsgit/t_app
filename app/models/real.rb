class Real < ApplicationRecord
  validates :user_id,{presence: true}
  validates :content, {presence: false, length: {maximum: 140}}
  validate :validate_check
  belongs_to :user
  has_many :real_comments, dependent: :destroy
  has_many :real_likes, dependent: :destroy
  has_many :image_reals, dependent: :destroy
  has_many :real_reports, dependent: :destroy
  has_many :real_tags, dependent: :destroy
  accepts_nested_attributes_for :image_reals, allow_destroy: true
  accepts_nested_attributes_for :real_tags, allow_destroy: true
  is_impressionable
  attr_accessor :real_images_params
  def user
     return User.find_by(id: self.user_id)
  end

  def validate_check
    unless real_images_params.present? || self.content.present?
      errors.add(:real_image_content, "画像が投稿されていないかつ文章が空白です。")
    end
  end
end
