# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: { case_sensitive: true }
  has_one :advisor, dependent: :destroy
  has_one :traveler, dependent: :destroy
  accepts_nested_attributes_for :advisor
  accepts_nested_attributes_for :traveler

  has_one :profile, dependent: :destroy
  before_create :create_user_type
  after_create :create_profile

  has_many :talks, dependent: :destroy
  has_many :room_members, dependent: :destroy
  def create_user_type
    if self.traveler_type == true
      self.build_traveler
    elsif self.traveler_type == false
      self.build_advisor
    end
  end

  def find_talking_user
    Room_member.where(user_id: self.id)
    user_ids = Room_member.pluck(:room_id).uniq
    user_ids.delete(self.id)
    @users = User.where(id: user_ids)
    # users.delete(id: self.id)
    # users
  end
end
