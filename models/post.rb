#this is our model for blog posts
class Post
	#it's its own document
	include MongoMapper::Document

	key :title, String
	key :body, String

	key :slug, String

	many :comments
	timestamps!
end

