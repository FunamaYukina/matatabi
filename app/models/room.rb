class Room < ApplicationRecord
  belongs_to :questioner, class_name: "User"
  belongs_to :answerer, class_name: "User"
  has_many :talks, dependent: :destroy
end
