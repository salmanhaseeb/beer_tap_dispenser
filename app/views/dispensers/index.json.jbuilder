# frozen_string_literal: true

if @dispensers.present?
  json.dispensers @dispensers.each do |dispenser|
    json.id dispenser.id
    json.flow_volume dispenser.flow_volume
    json.price_per_liter dispenser.price_per_liter
    json.total_capacity dispenser.total_capacity
    json.remaining_volume dispenser.remaining_volume
    json.created_at dispenser.created_at
    json.updated_at dispenser.updated_at
  end
end
