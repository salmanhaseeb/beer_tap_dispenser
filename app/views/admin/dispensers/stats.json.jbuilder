# frozen_string_literal: true

json.stats do
  json.times_used @stats[:times_used]
  json.total_pouring_time "#{@stats[:total_pouring_time].round(2)} seconds"
  json.total_money_made "$#{@stats[:total_money_made].round(2)}"
end
