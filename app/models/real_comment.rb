class RealComment < ApplicationRecord
  belongs_to :user
  belongs_to :real
  validates :comment, presence: true
end
