class Message
	include MongoMapper::Document
	key :email, Array	
	key :subject, String
	key :body, String
	validates_presence_of :email, :body
end