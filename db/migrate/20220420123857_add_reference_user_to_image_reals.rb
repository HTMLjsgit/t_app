class AddReferenceUserToImageReals < ActiveRecord::Migration[5.2]
  def change
    add_reference :image_reals, :user, foreign_key: true
  end
end
