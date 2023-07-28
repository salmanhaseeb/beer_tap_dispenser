# frozen_string_literal: true

class CreateDispensers < ActiveRecord::Migration[7.0]
  def change
    create_table :dispensers do |t|
      t.float :flow_volume
      t.float :price_per_liter
      t.float :total_capacity
      t.float :remaining_volume

      t.timestamps
    end
  end
end
