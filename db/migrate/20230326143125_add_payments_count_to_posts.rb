class AddPaymentsCountToPosts < ActiveRecord::Migration[5.2]
  def self.up
    add_column :posts, :payments_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :posts, :payments_count
  end
end
