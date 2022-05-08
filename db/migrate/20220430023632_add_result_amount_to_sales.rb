class AddResultAmountToSales < ActiveRecord::Migration[5.2]
  def change
    add_column :sales, :result_amount, :bigint, default: 0, null: false
  end
end
