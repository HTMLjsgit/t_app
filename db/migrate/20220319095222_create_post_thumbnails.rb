class CreatePostThumbnails < ActiveRecord::Migration[5.2]
  def change
    create_table :post_thumbnails do |t|
      t.references :post, foreign_key: true
      t.string :picture

      t.timestamps
    end
  end
end
