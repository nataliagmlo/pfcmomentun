require 'rubygems'
require 'redis'
require 'em-websocket'
 
# @author Natalia Garcia Menendez
# @version 1.0
# Code to create the WebSockets server retransmit manage customers and clients information
SOCKETS = []
@redis = Redis.new(:host => '127.0.0.1', :port => 6379)
 
# Creating a thread for the EM event loop
Thread.new do
  EventMachine.run do
    # Creates a websocket listener
    EventMachine::WebSocket.start(:host => '0.0.0.0', :port => 8000) do |ws|
      ws.onopen do
        # When someone connects I want to add that socket to the SOCKETS array that
        # I instantiated above
        puts 'creating socket'
        SOCKETS << ws
      end
 
      ws.onclose do
        # Upon the close of the connection I remove it from my list of running sockets
        puts 'closing socket'
        SOCKETS.delete ws
      end
    end
  end
end
 
# Creating a thread for the redis subscribe block
Thread.new do
  @redis.subscribe('ws') do |on|
    # When a message is published to 'ws'
    on.message do |chan, msg|
     puts "sending message: #{msg}"
     # Send out the message on each open socket
     SOCKETS.each {|s| s.send msg}
    end
  end
end
 
sleep