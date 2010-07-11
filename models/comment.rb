class Comment
	include MongoMapper::EmbeddedDocument

	key :body, String
end
