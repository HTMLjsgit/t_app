class AddColumnToUserIdToUserRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :user_rooms, :to_user_id, :integer
  end
end
