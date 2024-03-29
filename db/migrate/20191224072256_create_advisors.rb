# frozen_string_literal: true

class CreateAdvisors < ActiveRecord::Migration[5.1]
  def change
    create_table :advisors do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
