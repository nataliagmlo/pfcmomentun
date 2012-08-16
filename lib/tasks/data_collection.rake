require_relative './websocket-client'

namespace :run do

	task :websocket_client do
		c = Client.new
	end

	task :default => :websocket_client
end

