# = Simple "Ping:Pong" websocket client
#
# See https://github.com/igrigorik/em-http-request/blob/master/examples/websocket-handler.rb
#
#    $ bundle install
#    $ bundle exec ruby ruby-websocket-client.rb
#
 
require 'rubygems'
require 'em-http'
require_relative './USMFParser'
 
class Client
  
  def initialize 
    parser = USMFParser.new
   
    EventMachine.run do
     
      puts '='*80, "Connecting to websockets server at ws://0.0.0.0:8000", '='*80
     
      http = EventMachine::HttpRequest.new("ws://0.0.0.0:8000/websocket").get :timeout => 0
     
      http.errback do
        puts "oops, error"
      end
     
      http.callback do
        puts "#{Time.now.strftime('%H:%M:%S')} : Connected to server"
      end
     
      http.stream do |msg|
        #puts "Recieved: #{msg}"

        parser.parser msg

      end
     
    end
  end
end