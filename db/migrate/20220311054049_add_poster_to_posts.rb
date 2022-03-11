class AddPosterToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :poster, :string
  end
end
