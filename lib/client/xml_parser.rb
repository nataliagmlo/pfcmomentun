require 'pg'

class Client::USMFParser

	def initialize

	end

	def parser msg
		doc = Document.new(msg)
		name = doc.root.elements[1].elements[1].text
		id = doc.root.elements[1].elements[2].text
		audience = doc.root.elements[1].elements[3].text
		msg = doc.root.elements[2].text



		#res  = @conn.exec('insert into users(name,status_id) values(\'#{name}\', \'#{id}\')')
		#puts res

	end

	def parse_tweet_creator msg
		doc = Document.new(msg)
		name = doc.root.elements[1].elements[1].text
		id = doc.root.elements[1].elements[2].text

		u = User.find_or_create_by_status_id id
		u.name = name
		u.save

	end
end