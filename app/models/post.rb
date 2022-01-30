class Post < ApplicationRecord
   validates :content, {presence: true, length: {maximum: 140}}
   validates :user_id, {presence: true}
   validates :title, presence: true
   validates :description, presence: true
   validates :amount, presence: true

   belongs_to :user
   has_many :comments
   has_many :likes
   
   has_one_attached :poster
   def user
      return User.find_by(id: self.user_id)
   end
end
