class CreateTransferTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :transfer_totals do |t|
      t.bigint :total, default: 0, null: false
      t.references :user
      t.timestamps
    end
  end
end
