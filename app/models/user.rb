# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: true
  has_one :advisor, dependent: :destroy
  has_one :traveler, dependent: :destroy
  accepts_nested_attributes_for :advisor
  accepts_nested_attributes_for :traveler

  has_one :profile, dependent: :destroy
  after_create :create_profile
end
