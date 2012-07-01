require 'rubygems'
require 'redis'
require 'json'
require './PhraseGenerator'

 
#arrancar con publisher.rb
 
redis = Redis.new
data = {"user" => 'pepito'}

@pg = PhraseGenerator.new
 
loop do
    for i in (0..9)

    	redis.publish 'ws', @pg.generate(i)
    	sleep 5
	end
end