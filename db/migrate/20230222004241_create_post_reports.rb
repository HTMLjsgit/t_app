class CreatePostReports < ActiveRecord::Migration[5.2]
  def change
    create_table :post_reports do |t|
      t.text :body
      t.references :post, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
