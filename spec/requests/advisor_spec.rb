require "rails_helper"

RSpec.describe Advisor, type: :request do
  describe "新規登録の際アドバイザーを選択した場合" do
    it "アドバイザーとして登録されること" do
      user_params = attributes_for(:user)
      expect do
        post user_registration_path, params: {user: user_params}
      end.to change(Advisor, :count)
      expect(Advisor.last.user.name).to eq user_params[:name]
    end
  end
end