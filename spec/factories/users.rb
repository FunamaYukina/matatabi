# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { "example@test.com" }
    name { "test_user_name" }
    password { "test_password" }
    password_confirmation { "test_password" }
    traveler_type { false }
  end

  factory :traveler_user, class: "User" do
    email { "another_example@test.com" }
    name { "test_another_user_name" }
    password { "test_another_password" }
    password_confirmation { "test_another_password" }
    traveler_type { true }
  end

  trait :with_plan do
    after(:create) do |user|
      user.advisor.plans.create(attributes_for(:plan))
    end
  end
end
