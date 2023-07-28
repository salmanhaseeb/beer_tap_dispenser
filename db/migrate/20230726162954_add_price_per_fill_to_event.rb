# frozen_string_literal: true

class AddPricePerFillToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :total_drink_poured, :float
  end
end
