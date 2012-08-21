require 'pg'
require 'json'

require_relative '../business/momentum'
require_relative '../../app/models/user'

# @author Natalia Garcia Menendez
# @version 1.0
#
#Class responsible for parsing the message format USMF to model objects, and then run the algorithm Momentum
class USMFParser

	# Method that creates a user with the data received in a hash table
	# @param user [Hash Table] User data to create
	def parse_tweet_creator user
		u = User.find_or_create_by_user_id user["id"]

		u.avatar = user["avatar"]
		u.description = user["description"]
		u.geo = user["geo"]
		u.language = user["language"]
		u.location = user["location"]
		u.name = user["name"]
		u.postings = user["postings"]
		u.profile = user["profile"]
		u.real_name = user["real_name"]
		u.subscribers = user["subscribers"]
		u.subscriptions = user["subscriptions"]
		u.utc = user["utc"]

		u.save
	end

	# Method that creates users with data received in a hash table, stores them in an array and sends them to the algorithm
	# @param users [Array, Hash Table] User data mentioned
	# @param date_tweet [string] Menssage date 
	def parse_users_mentions users, date_tweet
		users_mentions = []
		users.each do |item|
			u = User.find_or_create_by_user_id item["id"]
			u.name = item["name"]

			u.save

			users_mentions << u
		end
			m = Momentum.new
			m.calculate_influences users_mentions, date_tweet
	end

	# Method that parses the data with JSON
	# @param msg [USMF] message recieved a social network
	def parser msg

		status = JSON.parse(msg)
		if status.has_key? 'Error'
			raise "status malformed"
		end
		
		unless status["user"] == nil
			puts "id tweet " + status["id"] 
			
			parse_tweet_creator status["user"]

			users = status["to_users"]
			unless users == nil
				parse_users_mentions users, status["date"]
			end
			
		end

	end
end