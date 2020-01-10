# frozen_string_literal: true

class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.references :advisor, foreign_key: true
      t.string :title
      t.text :description
      t.integer :fee

      t.timestamps
    end
  end
end
