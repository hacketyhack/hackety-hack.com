set :views, File.join(File.dirname(__FILE__), 'views')

set :haml, :escape_html => true

def setup_db environ
	MongoMapper.connection = Mongo::Connection.new('localhost')
	MongoMapper.database = "hackety-#{environ}"
end

configure :test do
	setup_db(:test)
end

configure :development do
	setup_db(:development)
end

configure do
	require_directory "models"
end
