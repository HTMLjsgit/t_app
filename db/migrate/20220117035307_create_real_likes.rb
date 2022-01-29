class CreateRealLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :real_likes do |t|
      t.integer :user_id
      t.integer :real_id

      t.timestamps
    end
  end
end
