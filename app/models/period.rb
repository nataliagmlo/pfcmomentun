class Period < ActiveRecord::Base
  attr_accessible :end_time, :start_time, :total_audience, :total_mentions, :total_users, :users_with_subscribers

  	scope :find_previous, lambda { |previous_hour|
		{:conditions => ["start_time <= ? and end_time >= ?", previous_hour, previous_hour]}
	}

	scope :find_another_previous, lambda { |previous_hour|
		{:conditions => ["end_time <= ?", previous_hour], :order => "end_time desc"}
	}
end
