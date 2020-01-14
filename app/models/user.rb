# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, uniqueness: {case_sensitive: true}
  has_one :advisor, dependent: :destroy
  has_one :traveler, dependent: :destroy
  accepts_nested_attributes_for :advisor
  accepts_nested_attributes_for :traveler

  has_one :profile, dependent: :destroy
  before_create :create_user_type
  after_create :create_profile

  has_many :talks, dependent: :destroy
  has_many :rooms, dependent: :destroy

  def create_user_type
    if self.traveler_type == true
      self.build_traveler
    elsif self.traveler_type == false
      self.build_advisor
    end
  end

  def find_questioner
    @answering_rooms = Room.where(answerer_id: self.id)
  end

  def find_answerer
    @questioning_rooms = Room.where(questioner_id: self.id)
  end
end
