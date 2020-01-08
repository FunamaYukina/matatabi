# frozen_string_literal: true

require "rails_helper"

RSpec.describe Advisor, type: :model do
  describe "新規登録の際アドバイザーを選択した場合" do
    it "アドバイザーとして登録されること" do
      create(:user)
      expect(Advisor.last.user.name).to eq User.last.name
    end
  end
end
