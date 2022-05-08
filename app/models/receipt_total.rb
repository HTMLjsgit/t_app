class ReceiptTotal < ApplicationRecord
  belongs_to :user

  def total_caluation(amount)
    self.update!(total: self.total + amount)
  end
end
