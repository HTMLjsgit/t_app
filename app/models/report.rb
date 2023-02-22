class Report < ApplicationRecord
 has_many :post_reports, dependent: :destroy
 has_many :user_reports, dependent: :destroy
 has_many :posts, through: :post_reports
 has_many :users, through: :user_reports


end
