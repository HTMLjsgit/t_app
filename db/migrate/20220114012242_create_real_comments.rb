class CreateRealComments < ActiveRecord::Migration[5.2]
  def change
    create_table :real_comments do |t|
      t.string :comment
      t.references :user, foreign_key: true
      t.references :real, foreign_key: true

      t.timestamps
    end
  end
end
