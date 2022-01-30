class AddCommissionToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :commission, :bigint
  end
end
