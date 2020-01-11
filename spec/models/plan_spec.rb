# frozen_string_literal: true

require "rails_helper"

RSpec.describe Plan, type: :model do
  describe "validation" do
    context "プランの編集に成功する場合" do
      it "詳細がない場合でも、編集に成功すること" do
        user = create(:user)
        plan = build(:plan, description: nil, advisor_id: user.advisor.id)
        expect(plan).to be_valid
      end
    end

    context "プランの編集に失敗する場合" do
      it "プランタイトルが100文字を超える場合、編集に失敗すること" do
        plan = build(:plan, title: "a" * 101)
        plan.valid?
        expect(plan.errors.full_messages).to include "タイトル は100文字以下に設定して下さい。"
      end

      it "プラン詳細が500文字を超える場合、編集に失敗すること" do
        plan = build(:plan, description: "a" * 501)
        plan.valid?
        expect(plan.errors.full_messages).to include "プラン詳細 は500文字以下に設定して下さい。"
      end
    end
  end

  describe "#search" do
    let!(:user) { create(:user, :with_plan) }

    context "検索した言葉がプランテーブルにある場合" do
      it "該当するプランを返すこと" do
        # binding.pry
        expect(Plan.search("test")).to include user.advisor.plans.first
      end
    end

    context "検索した言葉がプランテーブルにない場合" do
      it "何も返さないこと" do
        expect(Plan.search("").empty?).to be true
      end
    end
  end
end
