# frozen_string_literal: true

class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :event_type
      t.datetime :event_time
      t.float :total_spend
      t.references :dispenser, null: false, foreign_key: true

      t.timestamps
    end
  end
end
