class AddIndexPostTagsTag < ActiveRecord::Migration[5.2]
  def change
    add_index :post_tags, :tag
  end
end
