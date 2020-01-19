# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user_attributes = [
    {name: "ゆきな", email: "aaa@test.com", traveler_type: false, password: "aaaaaa", password_confirmation: "aaaaaa"},
    {name: "ゆい", email: "bbb@test.com", traveler_type: true, password: "bbbbbb", password_confirmation: "bbbbbb"},
    {name: "ゆみ", email: "ccc@test.com", traveler_type: true, password: "cccccc", password_confirmation: "cccccc"},
    {name: "ゆず", email: "ddd@test.com", traveler_type: false, password: "dddddd", password_confirmation: "dddddd"}
]

users = user_attributes.map do |attribute|
  User.create!(attribute)
end

advisors = []
travelers = []

users.map do |user|
  user.traveler_type ? travelers.push(user) : advisors.push(user)
end

plans = [
    {title: "[別府]温泉選びの手伝い", description: "別府の温泉選びをお手伝いいたします！一緒にお気に入りの温泉を探しましょう！", fee: "400"},
    {title: "[宮崎]高千穂の見どころ紹介", description: "高千穂峡は滝以外にも見どころいっぱい！美味しいお店など紹介します！", fee: "400"}
]

advisors.each do |user|
  plans.each do |plan|
    user.advisor.plans.create!(plan.merge({advisor_id: user.id}))
  end
end
