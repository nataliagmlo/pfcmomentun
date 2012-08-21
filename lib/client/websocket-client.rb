# encoding: utf-8
require 'rubygems'
require 'em-http'
require_relative './USMFParser'
 

# @author Natalia Garcia Menendez
# @version 1.0
#
# Class representing a WebSockets client which connects to a host and port and collects the data it receives, sending them to USFMParser
class Client
  
  # Method that makes the connection with the server and remains waiting picking up recividos messages
  def initialize 
    parser = USMFParser.new
   
    EventMachine.run do
     
      puts '='*80, "Connecting to websockets server at ws://0.0.0.0:8000", '='*80
     
      http = EventMachine::HttpRequest.new("ws://0.0.0.0:8000/websocket").get :timeout => 0
     
      http.errback do
        puts "Server not available, impossible to connect"
      end
     
      http.callback do
        puts "#{Time.now.strftime('%H:%M:%S')} : Connected to server"
      end
     
      http.stream do |msg|
        parser.parser msg

      end
     
    end
  end
end