#this is a reply to a forum discussion
class Reply
	#it's embedded in a discussion
	include MongoMapper::EmbeddedDocument

	#the body of the reply
	key :body, String

end
