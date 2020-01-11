# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :request do
  let(:user) { create(:user,:with_plan) }

  describe "registrations#new" do
    context "新規登録ユーザー登録に成功する場合" do
      it "新規ユーザーが登録されること" do
        user_params = attributes_for(:traveler_user)
        post user_registration_path, params: {user: user_params}
        expect(response.status).to eq(302)
        expect(User.last.email).to eq user_params[:email]
        expect(response).to redirect_to top_path
      end
    end

    context "ログイン済みの場合" do
      it "TOPページへリダイレクトされること" do
        sign_in user
        expect do
          user_params = attributes_for(:traveler_user)
          post user_registration_path, params: {user: user_params}
        end.not_to change(User, :count)
        expect(response).to redirect_to top_path
      end
    end
  end

  describe "registrations#edit" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトされること" do
        get edit_user_registration_path
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済みの場合" do
      before do
        sign_in user
      end

      it "レスポンス200が返ってくること" do
        get edit_user_registration_path
        expect(response).to have_http_status(:ok)
      end

      it "ユーザー情報の更新ができること" do
        post user_registration_path, params: {
            user: {
                email: "changed@test.com",
                password: "changed_password"
            }
        }
        expect(response).to redirect_to top_path
      end
    end
  end

  describe "sessions#new" do
    context "未ログインの場合" do
      it "レスポンス200が返ってくること" do
        get new_user_session_path
        expect(response).to have_http_status(:ok)
      end

      it "ユーザーが存在する場合、ログイン出来ること" do
        create(:user)
        post user_session_path, params: {
            user: {
                email: "example@test.com",
                password: "test_password"
            }
        }
        expect(response).to redirect_to top_path
      end

      it "ユーザーが存在しない場合、ログインできないこと" do
        post user_session_path, params: {
            user: {
                email: "xxx@test.com",
                password: "test_password"
            }
        }
        expect(flash[:notice]).to be nil
        expect(flash[:alert]).to include "メールアドレスまたはパスワードが違います。"
        expect(response).to have_http_status(:ok)
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

  describe "#search" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトされること" do
        get search_users_path
        expect(flash[:alert]).to include "アカウント登録もしくはログインしてください。"
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済みの場合" do
      it "レスポンス200が返ってくること" do
        sign_in user
        get search_users_path(name: "test")
        expect(response).to have_http_status(:ok)
      end

      it "検索に該当したプランが表示されること" do
        sign_in user
        get search_users_path(name: "test")
        expect(response).to have_http_status(:ok)
        expect(response.body).to include user.advisor.plans.first.title
      end
    end
  end
end
