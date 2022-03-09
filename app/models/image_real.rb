class ImageReal < ApplicationRecord
  belongs_to :real, optional: true
  mount_uploader :picture, ImageUploader
end
