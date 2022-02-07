class ImagePost < ApplicationRecord
  belongs_to :post, optional: true
  mount_uploader :image_url, ImageUploader
end
