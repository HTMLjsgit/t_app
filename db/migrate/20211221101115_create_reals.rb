class CreateReals < ActiveRecord::Migration[5.2]
  def change
    create_table :reals do |t|
      t.text :content

      t.timestamps
    end
  end
end
