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
end
