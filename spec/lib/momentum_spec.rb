# encoding: utf-8
require_relative '../spec_helper'
require_relative '../../lib/momentum'
require_relative '../../app/models/period'
require_relative '../../app/models/user'
require_relative '../../app/models/influence'
require 'time'

describe Momentum do
  
  	describe "#calculate_influences" do

	    it "calculate velocity and acceleration for users" do

	    	prepare_previous_period()

	      	msg = '{"name":"Sigohaciendorap1","real_name":"Ana Poleon Roja1","id":"111111111","language":"es","utc":"Athens + 7200","geo":null,"description":"Prefiero !áuna libertad peligrosa a una esclavitud tranquila.","avatar":"https://si0.twimg.com/profile_images/2263582427/conestasqueesmivoz_normal.jpg","location":"","subscribers":625,"subscriptions":1274,"postings":4327,"profile":"https://twitter.com/#!/Sigohaciendorap","website":"http://loquenecesitabas.blogspot.es/"}';

	      	u = JSON.parse(msg)
			if u.has_key? 'Error'
				raise "u malformed"
			end

			users = []
	      	u1 = create_user u, Time.new(2012,"Jun",13, 9, 00, 00, "+00:00")
	      	users << u1

	      	msg = '{"name":"Sigohaciendorap2","real_name":"Ana Poleon Roja2","id":"222222222","language":"es","utc":"Athens + 7200","geo":null,"description":"Prefiero !áuna libertad peligrosa a una esclavitud tranquila.","avatar":"https://si0.twimg.com/profile_images/2263582427/conestasqueesmivoz_normal.jpg","location":"","subscribers":625,"subscriptions":1274,"postings":4327,"profile":"https://twitter.com/#!/Sigohaciendorap","website":"http://loquenecesitabas.blogspot.es/"}';

	      	u = JSON.parse(msg)
			if u.has_key? 'Error'
				raise "u malformed"
			end

	      	u2 = create_user u, Time.new(2012,"Jun",13, 11, 48, 00, "+00:00")
	      	users << u2

	      	puts "usuarios creados"
	      	m = Momentum.new

	      	m.calculate_influences(users, "Wed Jun 13 12:08:40 +0000 2012")
	      	puts "Influencias calculadas"

	      	puts "Influencia usuario 1"
	      	i1 = Influence.find_by_user_id "111111111"
	      	puts "velocidad " + i1.velocity.to_s
	      	puts "aceleracion " + i1.acceleration.to_s
	      	puts "audiencia " + i1.audience.to_s
	      	puts "Ahora la 2 "
	      	i2 = Influence.find_by_user_id "222222222"
	      	puts "velocidad " + i2.velocity.to_s
	      	puts "aceleracion " + i2.acceleration.to_s
	      	puts "audiencia " + i2.audience.to_s

	    end
    end
    def create_user user, last_mention_at
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
		puts "Crear user subscribers " + u.subscribers.to_s
		u.subscriptions = user["subscriptions"]
		u.utc = user["utc"]
		u.last_mention_at = last_mention_at

		u.save

		u
	end

	def prepare_previous_period
		period_previous = Period.new(:start_time => Time.new(2012,"Jun",13, 11, 00, 00, "+00:00"), :end_time => Time.new(2012,"Jun",13,11, 59, 59, "+00:00"))
		
		period_previous.total_mentions = 250
		period_previous.total_audience = 1000
		period_previous.total_users = 150
		period_previous.users_with_subscribers = 800

		period_previous.save

	end
end