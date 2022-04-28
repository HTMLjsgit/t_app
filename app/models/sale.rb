class Sale < ApplicationRecord
  has_one :payment, dependent: :destroy
  belongs_to :post
  belongs_to :user
  def receipt_with_commision
    return self.payment.amount - (self.payment.amount * self.payment.receipt_commision).round
  end
  def self.total(array)
    result_total = 0
    array.each do |ar|
      result_total += ar
    end
    return result_total
  end
end
