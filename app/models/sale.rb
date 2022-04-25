class Sale < ApplicationRecord
  has_one :payment, dependent: :destroy
end
