class Period < ActiveRecord::Base
  attr_accessible :acceleration, :end_time, :float, :mean_time_between_mentions, :start_time, :total_audience, :total_mentions, :velocity
end
