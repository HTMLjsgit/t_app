class CreateTransferRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :transfer_requests do |t|
      t.boolean :already_request
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
