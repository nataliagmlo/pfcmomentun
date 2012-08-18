require_relative './websocket-client'

namespace :run do

	task :websocket_client => :environment do
		c = Client.new
	end

	task :default => :websocket_client
end

