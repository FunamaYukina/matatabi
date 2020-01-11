# frozen_string_literal: true

class Plan < ApplicationRecord
  belongs_to :advisor
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }

  def self.search(name)
    return Plan.none if name.empty?

    Plan.where(["description LIKE ? OR title LIKE ? ", "%#{name}%", "%#{name}%"])
  end
end
