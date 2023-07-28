# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Dispenser, type: :model do
  let(:dispenser) { FactoryBot.create(:dispenser) }
  it 'creates a dispenser' do
    expect(dispenser).to be_valid
  end

  it 'validates that price_per_liter is greater than 0' do
    dispenser.update(price_per_liter: 5)
    expect(dispenser).to be_valid

    dispenser.update(price_per_liter: 0)
    expect(dispenser).not_to be_valid

    dispenser.update(price_per_liter: -10)
    expect(dispenser).not_to be_valid
  end

  it 'validates that total_capacity is greater than 0' do
    dispenser.update(total_capacity: 10_000)
    expect(dispenser).to be_valid

    dispenser.update(total_capacity: 0)
    expect(dispenser).not_to be_valid

    dispenser.update(total_capacity: -500)
    expect(dispenser).not_to be_valid
  end

  it 'updates remaining_volume to total_capacity after creation' do
    @dispenser = Dispenser.new(flow_volume: Faker::Number.decimal(r_digits: 2),
                               price_per_liter: Faker::Number.decimal(r_digits: 2),
                               total_capacity: 25_000.0)  # Assuming a valid total capacity value

    expect(@dispenser.remaining_volume).to be_nil
    @dispenser.save
    @dispenser.reload
    expect(@dispenser.remaining_volume).to eq(@dispenser.total_capacity)
  end
end
