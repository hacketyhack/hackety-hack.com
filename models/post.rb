class Post
	include MongoMapper::Document
	key :title, String

	many :comments
	timestamps!
end

