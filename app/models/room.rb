class Room < ApplicationRecord
  has_many :talks, dependent: :destroy
end
