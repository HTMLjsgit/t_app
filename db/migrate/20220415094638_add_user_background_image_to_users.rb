class AddUserBackgroundImageToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :background_image, :string
  end
end
