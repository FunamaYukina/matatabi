# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "example@test.com" }
    name { "test_user_name" }
    password { "test_password" }
    password_confirmation { "test_password" }
    user_type { false }
  end

  factory :another_user, class: "User" do
    email { "another_example@test.com" }
    name { "test_another_user_name" }
    password { "test_another_password" }
    password_confirmation { "test_another_password" }
    user_type { true }
  end

  # trait :with_advisor do
  #   after(:create) do |user|
  #     user.advisor.create(attributes_for(:advisor))
  #   end
  # end
end
