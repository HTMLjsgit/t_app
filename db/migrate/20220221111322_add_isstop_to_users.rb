class AddIsstopToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :isstopped, :boolean, default: false, null: false
  end
end
