# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
PaymentSetting.create!(buyer_post_commision: 0.15, seller_post_commision: 0.30, stripe_commission: 0.036, consumption_tax: 0.1)

if User.find_by(username: "まどかまじか").blank?
  first_user = User.new(username: "まどかまじか", password: "aaaaaa", email: "a@a", admin: true)
  first_user.confirm
  first_user.save!
end
10.times do |i|
  if User.find_by(username: "testくん_#{i}").blank?
    user = User.new(username: "testくん_#{i}", password: "aaaaaa", email: "s_#{i}@yahoo.co.jp")
    user.confirm
    user.save!
  end
end

user_1 = User.find_by(username: "testくん_1").id
user_2 = User.find_by(username: "testくん_2").id
room = Room.create!(name: "aa")
UserRoom.create!(user_id: user_1, room_id: room.id)
UserRoom.create!(user_id: user_2, room_id: room.id)
room.chat_posts.create!(user_id: user_1, message: "メッセージのテスト一個目だ test_1の投稿だ")
room.chat_posts.create!(user_id: user_2, message: "メッセージのテスト２個目だ test_2の投稿だ")
room.chat_posts.create!(user_id: user_1, message: "メッセージのテスト3個目だ test_1")
room.chat_posts.create!(user_id: user_2, message: "メッセージのテスと4個目だ test_2")
room.chat_posts.create!(user_id: user_1, message: "メッセージのテスト5個目だ test_1")
room.chat_posts.create!(user_id: user_1, message: "メッセージのテスト6個目だ test_1")
room.chat_posts.create!(user_id: user_1, message: "メッセージのテスト7個目だ test_1")
room.chat_posts.create!(user_id: user_2, message: "メッセージのテスと8個目だ test_2")
room.chat_posts.create!(user_id: user_2, message: "メッセージのテスと9個目だ test_2")
room.chat_posts.create!(user_id: user_2, message: "メッセージのテスと10個目だ test_2")
room.chat_posts.create!(user_id: user_1, message: "メッセージのテスト11個目だ test_1")
