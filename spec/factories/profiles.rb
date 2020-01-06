# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    image_file { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/test.jpg")) }
    introduction_title { "test_title" }
    introduction { "test_introduction" }
    place { "test_place" }
    association :user
  end
end
