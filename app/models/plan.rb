class Plan < ApplicationRecord
  belongs_to :advisor
  validates :title, length: {maximum: 100}
  validates :description, length: {maximum: 500}

  def self.search(name)
    return Plan.none unless name
    Plan.where(['description LIKE ?', "%#{name}%"])
  end
end
