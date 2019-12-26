# frozen_string_literal: true

FactoryBot.define do
  factory :advisor do
    association :user
  end
end