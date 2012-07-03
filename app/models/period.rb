class Period < ActiveRecord::Base
  attr_accessible :acceleration, :end_time, :mean_time_mentions, :start_time, :total_audience, :total_mentions, :velocity
end
