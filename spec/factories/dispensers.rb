# frozen_string_literal: true

FactoryBot.define do
  factory :dispenser do
    flow_volume { Faker::Number.decimal(r_digits: 2) }
    price_per_liter { Faker::Number.decimal(r_digits: 2) }
    total_capacity { Faker::Number.decimal(r_digits: 2) }
    remaining_volume { total_capacity }
  end
end
