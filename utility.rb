#This file contains a few utility functions
#They're not sinatra 'helpers', but they're still useful!

#this lets us require a whole directory of .rb files!
def require_directory dirname

	#we glob every file, and loop through them
	Dir.glob("#{File.expand_path(File.dirname(__FILE__))}/#{dirname}/*.rb").each do |f|

		#and then require them!
		require f
	end
end

class String
	def to_slug
		self.gsub(/\W/, "").gsub(/\s/, "_").downcase
	end
end
