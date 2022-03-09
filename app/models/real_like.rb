class RealLike < ApplicationRecord
  validates :user_id,{presence: true}
  validates :real_id,{presence: true}
  
  belongs_to :user
  belongs_to :real
end
