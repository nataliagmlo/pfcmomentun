
require_relative '../../lib/tasks/XMLParser'

describe XMLParser do
  
  describe "#parser" do

    it "parses the tweet" do

    	p = XMLParser.new

      puts p
    	msg = '{"service":"Twitter","id":"212879154717274113","geo":null,"application":"web","location":null,"date":"Wed Jun 13 12:08:40 +0000 2012","source":"https://twitter.com/Sigohaciendorap/status/212879154717274113","text":"RT @HoneckerRDA: Me siguen los mineros asturianos @PorAsturies  Orgullo de la clase obrera y verdaderos heroes nacionales frente a la ...","description":null,"keywords":"","category":null,"duration":null,"likes":9,"dislikes":null,"favorites":281,"comments":null,"rates":null,"rating":null,"min_rating":null,"max_rating":null,"user":{"name":"Sigohaciendorap","real_name":"Ana Poleon Roja","id":"262670183","language":"es","utc":"Athens + 7200","geo":null,"description":"Prefiero una libertad peligrosa a una esclavitud tranquila.","avatar":"https://si0.twimg.com/profile_images/2263582427/conestasqueesmivoz_normal.jpg","location":"","subscribers":625,"subscriptions":1274,"postings":4327,"profile":"https://twitter.com/#!/Sigohaciendorap","website":"http://loquenecesitabas.blogspot.es/"},"links":[],"to_users":[{"name":"HoneckerRDA","id":"555993471","service":"mention","title":null,"thumbnail":null,"href":null},{"name":"PorAsturies","id":"594432676","service":"mention","title":null,"thumbnail":null,"href":null}]}';


    	p.parser msg



      user = User.find_by_user_id "262670183"
    	user.should_not be_nil
    	user.name.should_be eql, "Sigohaciendorap"

    end
  end

  # describe "parse_tweet_creator" do
  #   it "parses the creator of the tweet" do
  #     parser = Client::XmlParser.new

  #     msg = 'user:{"name":"Sigohaciendorap","real_name":"Ana Poleon Roja","id":"262670183","language":"es","utc":"Athens + 7200","geo":null,"description":"Prefiero una libertad peligrosa a una esclavitud tranquila.","avatar":"https://si0.twimg.com/profile_images/2263582427/conestasqueesmivoz_normal.jpg","location":"","subscribers":625,"subscriptions":1274,"postings":4327,"profile":"https://twitter.com/#!/Sigohaciendorap","website":"http://loquenecesitabas.blogspot.es/"},"links":[]}';


  #     status = JSON.parse(msg)
  #     if status.has_key? 'Error'
  #       raise "status malformed"
  #     end

  #     user = parser.parse_to_tweet_creator status

  #     user.should_not be_nil
  #     user.name.should_be eql, "Sigohaciendorap"
  #   end

  # end
  #test para comprobar que aunque no haya menciones se crea el usuario en la bd creador del tweet
end