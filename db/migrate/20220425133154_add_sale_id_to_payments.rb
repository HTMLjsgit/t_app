class AddSaleIdToPayments < ActiveRecord::Migration[5.2]
  def change
    add_reference :payments, :sale, foreign_key: true, null: true
  end
end
