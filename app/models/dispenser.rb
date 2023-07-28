# frozen_string_literal: true

class Dispenser < ApplicationRecord
  has_many :events

  validates :price_per_liter, :total_capacity, numericality: { greater_than: 0 }

  after_create :update_remaining_voulme

  def update_remaining_voulme
    update(remaining_volume: total_capacity)
  end
end
