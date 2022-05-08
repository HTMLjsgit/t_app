class CreateReceiptTotals < ActiveRecord::Migration[5.2]
  def change
    create_table :receipt_totals do |t|
      t.bigint :total, default: 0, null: false
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
