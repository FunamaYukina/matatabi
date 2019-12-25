# frozen_string_literal: true

require "rails_helper"

RSpec.describe Profile, type: :request do
  describe "新規登録した場合" do
    it "プロフィールも作られること" do
      user_params = attributes_for(:another_user)
      expect do
        post user_registration_path, params: { user: user_params }
      end.to change(Profile, :count)
      expect(Profile.last.user_id).to eq User.last.id
    end
  end
end
