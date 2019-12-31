# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :request do
  let(:user) { create(:user) }

  describe "registrations#new" do
    context "新規登録ユーザー登録に成功する場合" do
      it "新規ユーザーが登録されること" do
        user_params = attributes_for(:another_user)
        post user_registration_path, params: { user: user_params }
        expect(response.status).to eq(302)
        expect(User.last.email).to eq user_params[:email]
        expect(response).to redirect_to top_path
      end
    end

    context "ログイン済みの場合" do
      it "TOPページへリダイレクトされること" do
        sign_in user
        expect do
          user_params = attributes_for(:another_user)
          post user_registration_path, params: { user: user_params }
        end.not_to change(User, :count)
        expect(response).to redirect_to top_path
      end
    end
  end

  describe "sessions#new" do
    context "未ログインの場合" do
      it "レスポンス200が返ってくること" do
        get new_user_session_path
        expect(response).to be_success
        expect(response).to have_http_status(:ok)
      end

      it "ユーザーが存在する場合、ログイン出来ること" do
        user.save
        post user_session_path, params: {
          email: user.email,
          password: user.password
        }
        # request specでのログインテストの書き方 未完成(わからない)
      end

      it "ユーザーが存在しない場合、ログインできないこと" do
        post user_session_path, params: {
          email: "xxx@test.com",
          password: "test_password"
        }
        expect(flash[:notice]).to be nil
        expect(flash[:alert]).to include "メールアドレスまたはパスワードが違います。"
      end
    end

    context "ログイン済みの場合" do
      it "TOPページへリダイレクトされること" do
        sign_in user
        get new_user_session_path
        expect(response).to redirect_to top_path
      end
    end
  end

  describe "sessions#destroy" do
    context "未ログインの場合" do
      it "TOPページへリダイレクトされること" do
        delete destroy_user_session_path
        expect(flash[:notice]).to include "既にログアウト済みです。"
        expect(response).to redirect_to top_path
      end
    end

    context "ログイン済みの場合" do
      it "TOPページへリダイレクトされること" do
        sign_in user
        delete destroy_user_session_path
        expect(flash[:notice]).to include "ログアウトしました。"
        expect(response).to redirect_to top_path
      end
    end
  end
end