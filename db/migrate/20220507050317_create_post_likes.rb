class CreatePostLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :post_likes do |t|
      t.references :post, foreign_key: true, unique: true
      t.references :user, foreign_key: true, unique: true

      t.timestamps
    end
  end
end
