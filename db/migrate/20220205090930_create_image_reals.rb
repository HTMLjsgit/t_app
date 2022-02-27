class CreateImageReals < ActiveRecord::Migration[5.2]
  def change
    create_table :image_reals do |t|
      t.string :number
      # t.string :image_url
      t.binary :picture
      t.references :real, foreign_key: true

      t.timestamps
    end
  end
end
