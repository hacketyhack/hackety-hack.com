#this is the model for a Comment on the blog

class Comment
	# we need to make it embedded, since it's always embedded in a Post
	include MongoMapper::EmbeddedDocument

	#we'll save the email of the user that makes the comment, so we can give them credit!
	key :user_email, String

	key :body, String
end
