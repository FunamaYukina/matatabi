# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    questioner_id { User.last.id }
    answerer_id { User.first.id }
  end
end
