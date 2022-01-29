class AddAmountToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :amount, :bigint
  end
end
