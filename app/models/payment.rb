class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :sale, optional: true, dependent: :destroy
  belongs_to :post, optional: true
  counter_culture :post
  # after_destroy_commit :on_destroy
  # def on_destroy
  #   Sale.find(self.sale_id).destroy
  # end
end
