class TransferCompletion < ApplicationRecord
  belongs_to :user
  belongs_to :transfer_request
end
