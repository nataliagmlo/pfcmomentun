require 'rubygems'
require 'time'
require 'pg'

require_relative '../../app/models/period.rb'
require_relative '../../app/models/user.rb'
require_relative '../../app/models/influence.rb'

# @author Natalia Garcia Menendez
# @version 1.0
#
#Class algorithm developed by Momentum. Performs calculations influences, velocity and acceleration
class Momentum

	# Method developed by the algorithm
	# @param users_mentions [Array,User] Users for which is calculated influence
	# @param date_tweet [string] Menssage date 
	def calculate_influences users_mentions, date_tweet

		# Extract data from de date
		y = date_tweet[26,4]
		m = date_tweet[4,3]
		d = date_tweet[8,2]
		h = date_tweet[11,2] 
		mn = date_tweet[14,2]
		s = date_tweet[17,2]
		z = date_tweet[20,3] + ":" + date_tweet[23,2]

		y = y.to_i
	    d= d.to_i
	    h= h.to_i
	    mn= mn.to_i
	    s= s.to_i

		# We get the previous hourly report to get some variables such as the number of mentions, followers, etc. And de current time
		current_hour = Time.new(y,m,d, h, mn, s, z)
		previous_hour = current_hour - 1.hour
		
		p = Period.find_previous(previous_hour)

		if p.first == nil
			p = Period.find_another_previous(previous_hour)
		end
		if p.first != nil

			previous_period_report = p.first
			# Now with the information calculated in the previous period some of the data necessary for the algorithm
			# Number of mentions
			mentions_per_hour = previous_period_report.total_mentions
			# Number of users
			users_per_hour = previous_period_report.total_users
			# The average number of mentions for a user
			average_mentions_per_hour = mentions_per_hour / users_per_hour.to_f
			# The average number of subscribers for a user 
			average_subscribers = previous_period_report.total_audience / previous_period_report.users_with_subscribers.to_f

			# Phi is a measure of how easy is to be replied.
			# If it's too easy (Phi too large because each user got a lot of mentions or had few subscribers when mentioned) you should have a lot of mentions or few followers to have any merit
			# If it's too hard (Phi too small because each user got few mentions or had a lot of subscribers to get the mentions) you could have merit even having less mentions or more followers
			phi = average_mentions_per_hour / average_subscribers

		end
		# Variables to store how must we update the current period
		subscribers = 0
		mentions = users_mentions.count
		new_mentioned_users = 0
		new_users_with_subscribers = 0


		users_mentions.each do |user|
			
				# Check if this is the first mention that the user receives in this period
				first_mention = true
				if user.last_mention_at != nil
					first_mention =  user.last_mention_at.strftime("%Y %b %d %H") < current_hour.strftime("%Y %b %d %H")
				end
				
				# Calculate the number of hours since the last mention of the user, if we know the time
				hours_since_last_mention = (current_hour - user.last_mention_at)/3600.0 if user.last_mention_at != nil

				# Increase by one the users mentioned
				new_mentioned_users += 1 if first_mention

			# If you have the number of followers the user can not calculate the influence
			unless user.subscribers == nil
				
				# Update the variables for the current period
				subscribers += user.subscribers
				new_users_with_subscribers += 1 if first_mention

				# Variables needed to calculat the influence
				user_subscribers = user.subscribers		 
				previous_influence = user.previous_influence
				acceleration = 0
				velocity = 0

				# Seek influence user's previous
				if previous_influence != nil
					acceleration = previous_influence.acceleration
					velocity = previous_influence.velocity
				end

				# Calculate the influence if there previous period when the last mention, and hours since the last mention and the number of followers are not 0
				if p.first != nil and user.last_mention_at != nil and hours_since_last_mention != 0.0 and user.subscribers > 0
					acceleration += 1/(user_subscribers.to_f * hours_since_last_mention) - phi
					velocity += acceleration * hours_since_last_mention
					
					i = Influence.new :acceleration => acceleration, :audience => user.subscribers, :date => current_hour, :velocity => velocity, :user_id => user.id
					i.save
					puts "calculate influence"
				end
			end

			# Updates the hour of the last mention of the user with the current time
			user.last_mention_at = current_hour
			user.save

		end
	

		# Update or create the current period
		current_period_report = Period.find_previous(current_hour).first

		if current_period_report == nil
			current_period_report = Period.new(:start_time => Time.new(y,m,d, h, 00, 00, z), :end_time => Time.new(y,m,d, h, 59, 59, z))
			current_period_report.total_mentions = mentions
			current_period_report.total_audience = subscribers
			current_period_report.total_users = new_mentioned_users
			current_period_report.users_with_subscribers = new_users_with_subscribers
		else
			current_period_report.total_mentions += mentions
			current_period_report.total_audience += subscribers
			current_period_report.total_users += new_mentioned_users
			current_period_report.users_with_subscribers += new_users_with_subscribers
		end
		current_period_report.save

	rescue Exception => ex
		puts "Momentum: #{ex}"
	end
end

