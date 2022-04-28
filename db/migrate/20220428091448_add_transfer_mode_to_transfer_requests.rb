class AddTransferModeToTransferRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :transfer_requests, :transfer_mode, :boolean, default: false, null: false
  end
end
