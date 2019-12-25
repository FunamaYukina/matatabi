# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  describe FactoryBot do
    it "有効なファクトリを持つこと" do
      expect(build(:user)).to be_valid
    end
  end

  describe "validation" do
    let(:user) { build(:user) }

    context "新規ユーザーの登録に成功する場合" do
      it "ユーザーネーム、メールアドレス、パスワードがあれば有効であること" do
        user = User.new(email: "example@test.com",
                        name: "test_user_name",
                        password: "test_password",
                        password_confirmation: "test_password")
        expect(user).to be_valid
      end
    end

    context "新規ユーザーの登録に失敗する場合" do
      it "ユーザーネームが重複した場合、ユーザー登録に失敗すること" do
        create(:user)
        existing_user = build(:another_user, name: "test_user_name")
        existing_user.valid?
        expect(existing_user.errors.full_messages).to include "ユーザーネーム は既に使用されています。"
      end

      it "emailが重複した場合、ユーザー登録に失敗すること" do
        create(:user)
        existing_user = build(:another_user, email: "example@test.com")
        existing_user.valid?
        expect(existing_user.errors.full_messages).to include "メールアドレス は既に使用されています。"
      end

      it "ユーザーネームがない場合、ユーザー登録に失敗すること" do
        user.name = ""
        user.valid?
        expect(user.errors.full_messages).to include "ユーザーネーム が入力されていません。"
      end

      it "メールアドレスがない場合、ユーザー登録に失敗すること" do
        user.email = ""
        user.valid?
        expect(user.errors.full_messages).to include "メールアドレス が入力されていません。"
      end

      it "パスワードがない場合、ユーザー登録に失敗すること" do
        test_user = described_class.new(name: "test", email: "example@test.com")
        test_user.valid?
        expect(test_user.errors.full_messages).to include "パスワード が入力されていません。"
      end

      it "メールアドレスのフォーマットが正しくない場合、ユーザー登録に失敗すること" do
        user.email = "exampletestcom"
        user.valid?
        expect(user.errors.full_messages).to include "メールアドレス は有効でありません。"
      end

      it "パスワードが６文字未満の場合、ユーザー登録に失敗すること" do
        user.password = "pass"
        user.valid?
        expect(user.errors.full_messages).to include "パスワード は6文字以上に設定して下さい。"
      end

      it "パスワードと確認用パスワードが一致しない場合、ユーザー登録に失敗すること" do
        user.password = "password"
        user.password_confirmation = "pass"
        user.valid?
        expect(user.errors.full_messages).to include "確認用パスワード が一致していません。"
      end
    end
  end

  describe "新規登録した場合" do
    it "プロフィールも作られること" do
      create(:user)
      expect(Profile.last.user_id).to eq User.last.id
    end
  end
end
