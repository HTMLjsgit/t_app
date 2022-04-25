class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :sale

  after_create_commit :payment_create

  def payment_create
    Sale.create(payment_id: self.id, transfer: false)
  end
end
