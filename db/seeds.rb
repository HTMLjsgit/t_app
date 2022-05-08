# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PaymentSetting.create!(buyer_post_commision: 0.15, seller_post_commision: 0.30, stripe_commission: 0.036, consumption_tax: 0.1)

if User.find_by(username: "まどかまじか").blank?
  user = User.new(username: "まどかまじか", password: "aaaaaa", email: "a@a", admin: true)
  user.confirm
  user.save!
end
10.times do |i|
  if User.find_by(username: "testくん_#{i}").blank?
    user = User.new(username: "testくん_#{i}", password: "aaaaaa", email: "s_#{i}@yahoo.co.jp")
    user.confirm
    user.save!
  end
end
