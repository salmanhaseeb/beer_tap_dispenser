# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe DispenserService, type: :model do
  describe '#call' do
    let(:dispenser) do
      FactoryBot.create(:dispenser)
    end
    it 'starts pouring' do
      @dispenser = DispenserService.new(dispenser).start_pouring
      expect(@dispenser).to be_present
    end
  end
  describe '#call' do
    before do
      @dispenser = FactoryBot.create(:dispenser)
      @dispenser.events.create(event_type: 'open', event_time: Time.now)
    end
    it 'Checks if already open' do
      @dispenser = DispenserService.new(@dispenser).start_pouring
      expect(@dispenser[:errors]).to be_present
      expect(@dispenser[:errors].first).to eq('Dispenser is already open!')
    end
  end

  describe '#call' do
    before do
      @dispenser = FactoryBot.create(:dispenser)
      @dispenser.update(remaining_volume: 0)
    end
    it 'Checks if empty' do
      @dispenser = DispenserService.new(@dispenser).start_pouring
      expect(@dispenser[:errors]).to be_present
      expect(@dispenser[:errors].first).to eq('Dispenser is empty. Please refill!')
    end
  end

  describe '#call' do
    before do
      @dispenser = FactoryBot.create(:dispenser)
      @dispenser.events.create(event_type: 'open', event_time: Time.now)
    end
    it 'stops pouring' do
      @dispenser = DispenserService.new(@dispenser).stop_pouring
      expect(@dispenser).to be_present
    end
  end
  describe '#call' do
    before do
      @dispenser = FactoryBot.create(:dispenser)
      @dispenser.events.create(event_type: 'open', event_time: Time.now)
    end
    it 'starts pouring' do
      @total_spend = DispenserService.new(@dispenser).calculate_total_spend
      expect(@total_spend).to be_present
    end
  end
  describe '#call' do
    before do
      @dispenser = FactoryBot.create(:dispenser)
      @dispenser.events.create(event_type: 'open', event_time: Time.now)
    end
    it 'total liters poured pouring' do
      @total_liters_poured = DispenserService.new(@dispenser).calculate_total_liters_poured
      expect(@total_liters_poured).to be_present
    end
  end
end
