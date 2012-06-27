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

    	redis.publish 'ws', data.merge('msg' => @pg.generate(i)).to_json
    	sleep 10
	end
end