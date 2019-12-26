# frozen_string_literal: true

class Advisor < ApplicationRecord
  belongs_to :user
  has_many :plans, dependent: :destroy
  accepts_nested_attributes_for :plans
end
