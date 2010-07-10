class Post
	include MongoMapper::Document
	key :title, String
	timestamps!
end

