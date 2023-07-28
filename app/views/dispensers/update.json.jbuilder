# frozen_string_literal: true

json.dispenser do
  json.id @dispenser_action.id
  json.flow_volume @dispenser_action.flow_volume
  json.price_per_liter @dispenser_action.price_per_liter
  json.total_capacity @dispenser_action.total_capacity
  json.created_at @dispenser_action.created_at
  json.updated_at @dispenser_action.updated_at
  # Check if the status is "open"
  if @dispenser_action.events.any?
    if @dispenser_action.events.last.event_type == 'open'
      json.message 'Dispenser is now open.'
    else
      json.message 'Dispenser is now closed.'
      json.total_drink_poured @dispenser_action.events.last.total_drink_poured
      json.total_spend @dispenser_action.events.last.total_spend
      json.remaining_volume @dispenser_action.remaining_volume
    end
  end
end
