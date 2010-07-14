#this model represents a single discussion in the forum
class Discussion
	#we need to keep discussions in the database!
	include MongoMapper::Document
	
	#the title of a discussion
	key :title, String

	#this is the forum that it's in.
	key :forum, String

	#these are all the replies people make
	many :replies

	#this is the slug for the url
	key :slug, String 

	before_save :make_slug
 
	private 
	def make_slug
		self.slug = self.title.to_slug
	end

end
