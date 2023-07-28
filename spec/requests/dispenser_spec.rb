# frozen_string_literal: true

require 'rails_helper'
require 'swagger_helper'

RSpec.describe '/dispensers', type: :request do
  path '/dispensers' do
    get 'dispenser index' do
      response '200', 'dispensers index' do
        before do
          FactoryBot.create_list(:dispenser, 10)
        end

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to be_present
        end
      end
    end
  end

  path '/dispensers/{id}' do
    get 'dispenser Show' do
      tags 'Dispenser'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      response '200', 'Dispenser Show' do
        let(:dispenser) { FactoryBot.create(:dispenser) }
        let(:id) { dispenser.id }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data).to be_present
          expect(data['id']).to eq(dispenser.id)
        end
      end
    end
  end

  path '/dispensers/{id}' do
    patch 'Update dispenser' do
      tags 'Dispensers'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :dispenser, in: :body, schema: {
        type: :object,
        properties: {
          status: { type: :string }
        },
        required: %w[status]
      }

      response '200', 'dispenser updated with status OPEN' do
        let(:dispensers) { FactoryBot.create(:dispenser) }
        let(:id) { dispensers.id }
        let(:dispenser) { { status: 'open' } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['dispenser']).to be_present
          expect(data['dispenser']['message']).to eq('Dispenser is now open.')
        end
      end

      response '200', 'dispenser updated with status close' do
        before do
          @dispensers = FactoryBot.create(:dispenser)
          @dispensers.events.create(event_type: 'open', event_time: Time.now)
        end
        let(:id) { @dispensers.id }
        let(:dispenser) { { status: 'close' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['dispenser']).to be_present
          expect(data['dispenser']['message']).to eq('Dispenser is now closed.')
        end
      end

      response '422', 'dispenser updated with status CLOSE for first time' do
        let(:dispenser_c) { FactoryBot.create(:dispenser) }
        let(:id) { dispenser_c.id }
        let(:dispenser) { { status: 'close' } }

        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['dispenser']).to_not be_present
          expect(data['error']).to eq('Dispenser is already closed.')
        end
      end

      #   path '/dispensers/{id}' do
      #     patch 'Update dispenser' do
      #       tags 'Dispensers'
      #       consumes 'application/json'
      #       parameter name: :id, in: :path, type: :string
      #       parameter name: :dispenser, in: :body, schema: {
      #         type: :object,
      #         properties: {
      #           status: { type: :string }
      #         },
      #         required: %w[status]
      #       }

      #       response '200', 'dispenser updated with status open then close' do
      #         before do
      #         dispensers =FactoryBot.create(:dispenser)
      #         byebug

      #         # let(:dispenser) { {status: 'open' } }

      #         # run_test! do |response|
      #         #   data = JSON.parse(response.body)
      #         #   byebug
      #         #   expect(data['dispenser']).to be_present
      #         # end
      #         dispensers.events.last.update(event_type: 'open')
      #         end
      #         let(:id) { dispensers.id }
      #         let(:dispenser) { {status: 'close' } }
      #         run_test! do |response|
      #           data = JSON.parse(response.body)
      #           byebug
      #           expect(data['dispenser']).to be_present
      #           expect(data['dispenser']['message']).to eq('Dispenser is now closed.')

      #         end

      #       end
      #     end
      #     end
    end
  end
end
