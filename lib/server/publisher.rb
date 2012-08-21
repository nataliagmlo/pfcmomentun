require 'rubygems'
require 'redis'
require 'json'
require_relative './PhraseGenerator'

# @author Natalia Garcia Menendez
# @version 1.0
# Part of code that publishes messages to the pub / sub redis
redis = Redis.new
data = {"user" => 'pepito'}

@pg = PhraseGenerator.new
 
loop do
    for i in (0..9)

    	redis.publish 'ws', @pg.generate(i)
    	sleep 5
	end
end