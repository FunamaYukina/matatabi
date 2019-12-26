class Plan < ApplicationRecord
  belongs_to :advisor
  validates :title, length: { maximum: 100 }
  validates :description, length: { maximum: 500 }
end
