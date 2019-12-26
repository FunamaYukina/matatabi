require 'rails_helper'

RSpec.describe Profile, type: :model do

  describe "validation" do
    context "プロフィールの編集に成功する場合" do
      it "PNG画像を追加した場合、投稿に成功すること" do
        profile = build(:profile)
        expect(profile).to be_valid
      end

      it "画像がない場合でも、編集に成功すること" do
        profile = build(:profile, image_file: nil)
        expect(profile).to be_valid
      end

      it "自己紹介文がない場合でも、編集に成功すること" do
        profile = build(:profile, introduction: nil)
        expect(profile).to be_valid
      end
    end

    context "プロフィールの編集に失敗する場合" do
      it "画像のサイズが4MBを超える場合、編集に失敗すること" do
        profile = build(:profile, image_file: nil)
        profile.image_file = Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/13MB.jpg"))
        profile.valid?
        expect(profile.errors.full_messages).to include "画像 は4MB以下のものをアップロードしてください"
      end

      it "自己紹介文が1000文字を超える場合、編集に失敗すること" do
        profile = build(:profile, introduction: "a" * 1001)
        profile.valid?
        expect(profile.errors.full_messages).to include "自己紹介文 は1000文字以下に設定して下さい。"
      end

      it "画像以外を追加した場合、編集に失敗すること" do
        profile = build(:profile, image_file: nil)
        profile.image_file = Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/test.xlsx"))
        profile.valid?
        expect(profile.errors.full_messages).to include "画像 の形式が違います"
      end
    end
  end
end
