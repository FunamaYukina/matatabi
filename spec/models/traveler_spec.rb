# frozen_string_literal: true

require "rails_helper"

RSpec.describe Traveler, type: :model do
  describe "新規登録の際トラベラーを選択した場合" do
    it "トラベラーとして登録されること" do
      create(:traveler_user)
      expect(Traveler.last.user.name).to eq User.last.name
    end
  end
end
