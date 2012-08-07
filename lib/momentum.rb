
require 'rubygems'
require 'time'
require 'pg'

require_relative '../app/models/period.rb'
require_relative '../app/models/user.rb'
require_relative '../app/models/influence.rb'


class Momentum


	def calculate_influences users_mentions, date_tweet

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



		# We get the previous hourly report to get some variables such as the average number of mentions, followers, etc. and the current one so we fill it
		current_hour = Time.new(y,m,d, h, mn, s, z)
		
		previous_hour = current_hour - 1.hour
		
		p = Period.find_previous(previous_hour)

		if p.first == nil
			p = Period.find_another_previous(previous_hour)
		end

		puts p.first.to_s

		if p.first != nil
			puts "si hay periodo"

			previous_period_report = p.first
			puts previous_period_report.to_s
			# Now, with twitter info we shoud be able to compute Phi. We need:
			# The average number of mentions per hour (for now, the mentions in this period)
			mentions_per_hour = previous_period_report.total_mentions
			# Number of users
			users_per_hour = previous_period_report.total_users
			average_mentions_per_hour = mentions_per_hour / users_per_hour
			# The average number of subscribers for a user (taken from the users mentioned in the last period)
			average_subscribers = previous_period_report.total_audience / previous_period_report.users_with_subscribers

			# Phi is a measure of how easy is to be replied.
			# If it's too easy (Phi too large because each user got a lot of mentions or had few subscribers when mentioned) you should have a lot of mentions or few followers to have any merit
			# If it's too hard (Phi too small because each user got few mentions or had a lot of subscribers to get the mentions) you could have merit even having less mentions or more followers
			phi = average_mentions_per_hour / average_subscribers

			puts "mentions: #{average_mentions_per_hour}"
			puts "users: #{users_per_hour}"
			puts "subscribers: #{average_subscribers}"
			puts "phi: #{phi}"
		end
		# variables to store how must we update the current period
		subscribers = 0
		mentions = users_mentions.count
		new_mentioned_users = 0
		new_users_with_subscribers = 0

		users_mentions.each do |user|

			unless user.subscribers == nil
					

				first_mention =  user.last_mention_at.strftime("%Y %b %d %H") < current_hour.strftime("%Y %b %d %H")

				# Now let's increment the period variables
				subscribers += user.subscribers
				new_mentioned_users += 1 if first_mention
				

				new_users_with_subscribers += 1 if first_mention

				# We compute the new score for the user
				user_subscribers = user.subscribers
				hours_since_last_mention = (current_hour - user.last_mention_at)/3600.0
				
				if p.first != nil
					acceleration =  1/(user_subscribers * hours_since_last_mention) - phi 
					puts "acceleration" + acceleration.to_s
					velocity = acceleration * hours_since_last_mention
					puts "velocity" + velocity.to_s

					i = Influence.new :acceleration => acceleration, :audience => user.subscribers, :date => current_hour, :velocity => velocity, :user_id => user.user_id

					i.save
					puts "Inlfluencia calculada"
				end
			end
			user.last_mention_at = current_hour
			user.save
			puts "usuario actualizado"

		end
	

		# We get the current report and save it
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
		puts "periodo actualizado"

	rescue Exception => ex
		puts "Momentum: #{ex}"
	end
end

