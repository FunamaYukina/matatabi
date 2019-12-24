require "rails_helper"

RSpec.describe User, type: :request do

  describe "registrations#new" do
    context "新規登録ユーザー登録に成功する場合" do
      it "新規ユーザーが登録されること" do
        user_params = attributes_for(:another_user)
        post user_registration_path, params: {user: user_params}
        expect(response.status).to eq(302)
        expect(User.last.email).to eq user_params[:email]
        expect(response).to redirect_to top_path
      end

      it "メールアドレスは小文字で登録されること" do
        user_params = attributes_for(:another_user)
        post user_registration_path, params: {user: user_params}
        expect(response.status).to eq(302)
        expect(User.last.email).to eq "another_example@test.com"
        expect(response).to redirect_to top_path
      end
    end
  end
end