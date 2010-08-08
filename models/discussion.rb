#this model represents a single discussion in the forum
class Discussion
	#we need to keep discussions in the database!
	include MongoMapper::Document
	
	#the title of a discussion
	key :title, String

	#the person who created this discussion
	key :author, String

	#the text of a discussion
	key :body, String

	#this is the forum that it's in.
	key :forum, String

	#these are all the replies people make
	many :replies

	#this is the slug for the url
	key :slug, String 

	before_save :make_slug
	validate_on_create :author_check
 
	private 
	def make_slug
		self.slug = self.title.to_slug
	end

	def author_check
		if author.nil?
			errors.add(:author, "Someone must have started this discussion!")
		end
	end

end
