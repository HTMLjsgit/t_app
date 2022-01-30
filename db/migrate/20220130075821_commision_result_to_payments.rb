class CommisionResultToPayments < ActiveRecord::Migration[5.2]
  def change
    add_column :payments, :commision_amount_result, :bigint
  end
end
