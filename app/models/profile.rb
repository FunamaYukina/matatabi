class Profile < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  mount_uploader :image_file, ImageUploader
  validate :validate_file_size

  private

  def validate_file_size
    return unless image_file.size > 4.megabytes

    errors.add(:image_file, "は4MB以下のものをアップロードしてください")
  end
end
