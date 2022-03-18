class CreateImagePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :image_posts do |t|
      t.string :number
      t.string :picture
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
