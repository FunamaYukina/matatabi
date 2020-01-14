class CreateRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :rooms do |t|
      t.integer :questioner_id, null: false
      t.integer :answerer_id, null: false

      t.timestamps
    end
  end
end
