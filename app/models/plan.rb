# frozen_string_literal: true

class Plan < ApplicationRecord
  belongs_to :advisor
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }

  def self.search(name)
    plans = []

    return plans if name.empty?
    # キーワード分割する
    keywords = name.split(/[[:blank:]]+/).select(&:present?)
    keywords.each do |keyword|
      plans += Plan.where(["title LIKE :name OR description LIKE :name", name: "%#{keyword}%"])
    end

    plans.uniq || []
  end
end
