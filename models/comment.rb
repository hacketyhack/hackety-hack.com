class Comment
	include MongoMapper::EmbeddedDocument

	key :user_email, String
	key :body, String
end
