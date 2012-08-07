# @author Natalia Garcia Menendez
# @version 1.0
#
# Class for each hour representing the data necessary to calculate the algorithm "Momentum"
class Period < ActiveRecord::Base
  	attr_accessible :end_time, :start_time, :total_audience, :total_mentions, :total_users, :users_with_subscribers

  	# Find the period in which time is between the beginning and end of period
  	# @param previous_hour [DateTime] Time and date of the period to seek
  	# @return [Array,Period] Periods that meet the condition
  	scope :find_previous, lambda { |previous_hour|
		{:conditions => ["start_time <= ? and end_time >= ?", previous_hour, previous_hour]}
	}

	# Look for the periods prior to the date and time received, sorted by date descending
  	# @param previous_hour [DateTime] Time and date of the period to seek
  	# @return [Array,Period] Periods that meet the condition
	scope :find_another_previous, lambda { |previous_hour|
		{:conditions => ["end_time <= ?", previous_hour], :order => "end_time desc"}
	}

  def to_s
    s = "Period:"
    s += "\n\tend: " + end_time.to_s
    s += "\n\tstart: " + start_time.to_s
    s += "\n\ttotal_audience: " + total_audience.to_s if total_audience!=nil
    s += "\n\ttotal_mentions: " + total_mentions.to_s if total_mentions!=nil
    s += "\n\ttotal_users: " + total_users.to_s if total_users!=nil
    s += "\n\tusers_with_subcribers: " + users_with_subscribers.to_s if users_with_subscribers!=nil
    s
  end
end
