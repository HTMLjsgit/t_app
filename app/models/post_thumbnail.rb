class PostThumbnail < ApplicationRecord
  belongs_to :post
  mount_uploader :picture, ImageUploader
end
