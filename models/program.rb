class Program
	include MongoMapper::Document
	key :creator_username, String
	key :title, String
	key :slug, String 

	before_save :make_slug
 
	private 
	def make_slug
		self.slug = self.title.to_slug
	end
end
