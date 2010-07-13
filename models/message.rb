#this is the class for inter-site messages
class Message
	#we want to include them in the database!
	include MongoMapper::Document

	#this is the body text of the message
	key :body, String

	#this is the username of the person who gets the message
	key :recipient, String

	#this is the username of the person who sent the message
	key :sender, String
end
