class AddAmountToTransferRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :transfer_requests, :amount, :bigint, default: 0, null: false
  end
end
