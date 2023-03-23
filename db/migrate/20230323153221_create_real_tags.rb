class CreateRealTags < ActiveRecord::Migration[5.2]
  def change
    create_table :real_tags do |t|
      t.references :real, foreign_key: true
      t.string :tag
      t.timestamps
    end
  end
end
