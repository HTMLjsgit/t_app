class RealReport < ApplicationRecord
  belongs_to :real
  belongs_to :user
  validates :body, presence: true
end
