#this file contains various configuration options

#let's set up the views directory for sinatra
set :views, File.join(File.dirname(__FILE__), 'views')
#we'll also set up a public directory
set :public, File.expand_path(File.dirname(__FILE__) + '/public')

#this makes Haml escape any html by default. See here: http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html#options
set :haml, :escape_html => true

#this method will set up our database connection for any environment
def setup_db environ
	#we want to connect to mongohq
	MongoMapper.config = {RACK_ENV => {'uri' => ENV['MONGOHQ_URL']}}
	MongoMapper.connect(RACK_ENV)
end

#these configure blocks only run in one environment
#right now the only configuration we do special is set up the databse
#I'm sure these can be condensed into one block, I just havn't done it yet.
configure :test do
	setup_db(:test)
end

configure :development do
	setup_db(:development)
end

configure :production do
	setup_db(:production)
end

#for all environments,
configure do
	#require all of our models!
	require_directory "models"
end
