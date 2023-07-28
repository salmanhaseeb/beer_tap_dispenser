# frozen_string_literal: true

class DispenserStatsService
  def initialize(dispenser)
    @dispenser = dispenser
  end

  def stats
    {
      times_used: times_used,
      total_pouring_time: total_pouring_time,
      total_money_made: total_money_made
    }
  end

  def times_used
    @dispenser.events.where(event_type: 'open').count
  end

  def total_pouring_time
    open_events = @dispenser.events.where(event_type: 'open')
    close_events = @dispenser.events.where(event_type: 'close')
    total_pouring_time = 0

    open_events.each_with_index do |event, index|
      next_event = close_events[index]
      total_pouring_time += next_event.event_time - event.event_time if next_event
    end

    total_pouring_time
  end

  def total_money_made
    @dispenser.events.where(event_type: 'close').sum(:total_spend)
  end
end
