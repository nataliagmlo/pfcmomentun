
require 'rexml/document'
require 'pg'
require 'json'

include REXML

class XMLParser

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
		puts u.name
	end

	def parse_users_mentions users, date_tweet
		users_mentions = []
		users.each do |item|
			u = User.find_or_create_by_user_id item["id"]
			u.name = item["name"]

			u.save

			users_mentions << u

			m = Momentum.new
			m.calculate_influences users_mentions, date_tweet
		end
	end

	def parser msg

		status = JSON.parse(msg)
		if status.has_key? 'Error'
			raise "status malformed"
		end
		
		unless status["user"] == nil
			
			parse_tweet_creator status["user"]
			
			#puts u

			users = status["to_users"]
			unless users == nil
				parse_users_mentions users, status["date"]
			end
			
		end

	end
end