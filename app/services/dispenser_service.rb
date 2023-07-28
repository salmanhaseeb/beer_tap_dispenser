# frozen_string_literal: true

class DispenserService
  def initialize(dispenser)
    @dispenser = dispenser
  end

  def start_pouring
    if @dispenser.events.last.present? && (@dispenser.events.last.event_type == 'open')
      return { errors: ['Dispenser is already open!'] }
    end
    return { errors: ['Dispenser is empty. Please refill!'] } if @dispenser.remaining_volume.zero?

    @dispenser.events.create(event_type: 'open', event_time: Time.now)
    @dispenser
  end

  def stop_pouring
    return unless @dispenser.events.last.event_type == 'open'

    liters_poured = calculate_total_liters_poured
    total_spend = calculate_total_spend
    remaining = @dispenser.remaining_volume - (liters_poured * 1000)
    @dispenser.update(remaining_volume: [remaining, 0].max)
    raise StandardError, 'Dispenser is empty. Please refill!' if remaining.zero?

    @dispenser.events.create(event_type: 'close', event_time: Time.now, total_spend: total_spend,
                             total_drink_poured: liters_poured)
    @dispenser
  end

  def calculate_total_spend
    liters_poured = calculate_total_liters_poured
    liters_poured * @dispenser.price_per_liter
  end

  def calculate_total_liters_poured
    time_diff = Time.now - @dispenser.events.where(event_type: 'open').last.event_time
    liters_poured = (time_diff * @dispenser.flow_volume).round(2)
    liters_poured / 1000
  end
end
