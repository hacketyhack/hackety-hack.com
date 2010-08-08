#this is a reply to a forum discussion
class Reply
	#it's embedded in a discussion
	include MongoMapper::EmbeddedDocument

	#the body of the reply
	key :body, String

	#the person who wrote it
	key :author, String

	#we need to make sure we have an author
	validate_on_create :author_check

	private

	def author_check
		if author.nil?
			errors.add(:author, "Someone must have written this reply!")
		end
	end

end
