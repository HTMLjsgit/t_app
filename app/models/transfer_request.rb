class TransferRequest < ApplicationRecord
  belongs_to :user
  has_one :transfer_completion, dependent: :destroy
end
