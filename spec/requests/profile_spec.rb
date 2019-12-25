# frozen_string_literal: true

require "rails_helper"

RSpec.describe Profile, type: :request do
  let(:user) { create(:user) }

  describe "新規登録した場合" do
    it "プロフィールも作られること" do
      user_params = attributes_for(:another_user)
      expect do
        post user_registration_path, params: { user: user_params }
      end.to change(Profile, :count)
      expect(Profile.last.user_id).to eq User.last.id
    end
  end

  describe "profiles#show" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトされること" do
        get user_profile_path(user_name: user.name)
        expect(response).to_not have_http_status(:ok)
        expect(response).to redirect_to new_user_session_path
      end
    end
    context "ログイン済みの場合" do
      before do
        sign_in user
      end
      it "レスポンス200が返ってくること" do
        get user_profile_path(user_name: user.name)
        expect(response).to be_success
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
