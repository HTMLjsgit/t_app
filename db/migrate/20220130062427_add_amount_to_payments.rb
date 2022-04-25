class AddAmountToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :amount, :bigint
    add_column :payments, :payment_date, :time
  end
end
