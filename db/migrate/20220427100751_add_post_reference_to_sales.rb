class AddPostReferenceToSales < ActiveRecord::Migration[5.2]
  def change
    add_reference :sales, :post, foreign_key: true
  end
end
