# frozen_string_literal: true

class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.string :image_file
      t.string :introduction_title
      t.text :introduction
      t.string :place

      t.timestamps
    end
  end
end
