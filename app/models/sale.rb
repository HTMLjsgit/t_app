class Sale < ApplicationRecord
  has_one :payment, dependent: :destroy
  belongs_to :user
end
