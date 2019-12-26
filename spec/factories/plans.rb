# frozen_string_literal: true

FactoryBot.define do
  factory :plan do
    title { "test_title" }
    description { "test_description" }
    fee { 500 }
    association :advisor
  end
end