require_relative '../client/websocket-client'

# @author Natalia Garcia Menendez
# @version 1.0
# Task WebSockets client starts
namespace :run do

	task :websocket_client => :environment do
		c = Client.new
	end

	task :default => :websocket_client
end

