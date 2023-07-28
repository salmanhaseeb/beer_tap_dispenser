# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe DispenserStatsService, type: :model do
  describe '#call' do
    let(:dispenser) do
      FactoryBot.create(:dispenser)
    end
    it 'shows times used' do
      times_used = DispenserStatsService.new(dispenser).times_used
      expect(times_used).to be_present
    end
  end
  describe '#call' do
    let(:dispenser) do
      FactoryBot.create(:dispenser)
    end
    it 'shows total time pouring' do
      total_time_pouring = DispenserStatsService.new(dispenser).total_pouring_time
      expect(total_time_pouring).to be_present
    end
  end
  describe '#call' do
    let(:dispenser) do
      FactoryBot.create(:dispenser)
    end
    it 'shows total money made' do
      money_made = DispenserStatsService.new(dispenser).total_money_made
      expect(money_made).to be_present
    end
  end
end
