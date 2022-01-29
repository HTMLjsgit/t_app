class AddUserIdToReals < ActiveRecord::Migration[5.2]
  def change
    add_column :reals,:user_id,:integer
  end
end
