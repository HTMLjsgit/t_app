class CreateSales < ActiveRecord::Migration[5.2]
  def change
    create_table :sales do |t|
      t.references :payment
      t.boolean :transfer

      t.timestamps
    end
  end
end
