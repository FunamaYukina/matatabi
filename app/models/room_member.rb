class Room_member < ApplicationRecord
  belongs_to :room
  belongs_to :user
end
