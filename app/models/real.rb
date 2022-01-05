class Real < ApplicationRecord
  validates :user_id,{presence: true}
  validates :content, {presence: true, length: {maximum: 140}}
  belongs_to :user

  def user
     return User.find_by(id: self.user_id)
  end
end
