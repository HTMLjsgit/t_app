class AddAmountToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :amount, :bigint
    add_column :payments, :mine_subtract_commision_amount, :bigint
    add_column :payments, :mine_commision, :bigint
    add_column :payments, :stripe_and_mine_subtract_commision_amount, :bigint
    add_column :payments, :payment_date, :time
  end
end
