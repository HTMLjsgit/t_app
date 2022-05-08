class AddCommisionToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :commision_result, :float
    add_column :payments, :receipt_commision, :float
  end
end
