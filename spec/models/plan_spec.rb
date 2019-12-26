require 'rails_helper'

RSpec.describe Plan, type: :model do
  describe "validation" do
    context "プランの編集に成功する場合" do
      it "詳細がない場合でも、編集に成功すること" do
        plan = build(:plan, description: nil)
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
end
