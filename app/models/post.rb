class Post < ApplicationRecord
   validates :content, {presence: true, length: {maximum: 140}}
   validates :user_id, {presence: true}
   validates :title, presence: true
   validates :description, presence: true
   validates :amount, presence: true
   validate :amount_min_check
   validate :thumbnails_check
   belongs_to :user
   has_many :comments
   has_many :likes
   
   
   has_many :image_posts, dependent: :destroy
   has_many :post_thumbnails, dependent: :destroy
   accepts_nested_attributes_for :image_posts, allow_destroy: true
   accepts_nested_attributes_for :post_thumbnails, allow_destroy: true
   is_impressionable

   mount_uploader :poster, ImageUploader
   def user
      return User.find_by(id: self.user_id)
   end

   def amount_min_check
      if self.amount < 50
         errors.add(:amount_min, "指定できる最低金額は50円です。")
      end
   end

   def thumbnails_check
      if self.post_thumbnails.length > 4
         errors.add(:post_thumbnails, "投稿できるサムネイルの数は4つまでです。")
      end
   end
end
