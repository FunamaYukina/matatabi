# frozen_string_literal: true

require "rails_helper"

RSpec.describe Plan, type: :request do
  let(:user) { create(:user) }

  describe "plans#new" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトされること" do
        get new_user_plan_path(user_name: user.name)
        expect(response).not_to have_http_status(:ok)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済みの場合" do
      before do
        sign_in user
        advisor = create(:advisor, user: user)
        create(:plan, advisor: advisor)
      end

      it "レスポンス200が返ってくること" do
        get new_user_plan_path(user_name: user.name)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  let(:advisor) { create(:advisor, user: user) }
  let(:plan) { create(:plan, advisor: advisor) }
  
  describe "plans#edit" do
    context "未ログインの場合" do
      it "ログインページへリダイレクトされること" do
        get edit_user_plan_path(user_name: user.name, id: 1)
        expect(response).not_to have_http_status(:ok)
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "ログイン済みの場合" do
      before do
        sign_in user
      end

      it "レスポンス200が返ってくること" do
        get edit_user_plan_path(user_name: user.name, id: plan.id)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
