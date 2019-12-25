# frozen_string_literal: true

require "rails_helper"

RSpec.describe Traveler, type: :request do
  describe "新規登録の際トラベラーを選択した場合" do
    it "トラベラーとして登録されること" do
      user_params = attributes_for(:another_user)
      expect do
        post user_registration_path, params: { user: user_params }
      end.to change(Traveler, :count)
      expect(Traveler.last.user.name).to eq user_params[:name]
    end
  end
end
