class Post < ApplicationRecord
   validates :content, {presence: true, length: {maximum: 140}}
   validates :user_id, {presence: true}
   validates :title, presence: true
   validates :description, presence: true
   validates :amount, presence: true
   validate :amount_min_check

   belongs_to :user
   has_many :comments
   has_many :likes

   has_one_attached :poster
   has_many_attached :thumbnails
   has_many :image_posts, dependent: :destroy
   accepts_nested_attributes_for :image_posts, allow_destroy: true
   is_impressionable

   def user
      return User.find_by(id: self.user_id)
   end

   def amount_min_check
      if self.amount < 50
         errors.add(:amount_min, "指定できる最低金額は50円です。")
      end
   end
end
