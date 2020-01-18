class Room < ApplicationRecord
  belongs_to :questioner, class_name: "User"
  belongs_to :answerer, class_name: "User"
  has_many :talks, dependent: :destroy

  def find_member(my_id)
    other_id = Room.find(self.id).questioner_id
    if my_id == Room.find(self.id).answerer_id
      User.find(other_id)
    else
      User.find(my_id)
    end
  end
end
