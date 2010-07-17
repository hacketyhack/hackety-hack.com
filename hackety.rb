#woo hoo! This is the main file for the Hackety site.

#first off, we need to include rubygems and sinatra
require 'rubygems'
require 'sinatra'

#haml gives us all of our templates
require 'haml'

#mongomapper connects us to our database
require 'mongo_mapper'

#rack-flash gives us nice flash messages
require 'rack-flash'

#rdiscount lets us write things using markdown
require 'rdiscount'

#we need to set up a secret to encrypt our sessions with
use Rack::Session::Cookie, :secret => 'h4ck3ty h4ck f0r gr347 g00d'

#we also have to let the world know we want to use flashes
use Rack::Flash

#let's require a bunch of files that do good things
require 'utility'
require 'configure'
require 'helpers'

#here's the root route. This is what happens when you go to '/'
get "/" do
	haml :index
end

#this will be used to make sass work
["site"].each do |sheet|
	get "/stylesheets/#{sheet}.css" do
		content_type 'text/css', :charset => 'utf-8'
		sass :"stylesheets/#{sheet}"
	end
end

#finally, let's require all of our controllers
require_directory "controllers"
