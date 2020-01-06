# frozen_string_literal: true

require "rails_helper"

RSpec.describe Profile, type: :request do
  let(:user) { create(:user) }

  describe "profiles#show" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトされること" do
        get user_profile_path(user_name: user.name)
        expect(response).not_to have_http_status(:ok)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済みの場合" do
      before do
        sign_in user
      end

      it "レスポンス200が返ってくること" do
        get user_profile_path(user_name: user.name)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "profiles#edit" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトされること" do
        get edit_user_profile_path(user_name: user.name)
        expect(response).not_to have_http_status(:ok)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済みの場合" do
      before do
        sign_in user
      end

      it "レスポンス200が返ってくること" do
        get edit_user_profile_path(user_name: user.name)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
