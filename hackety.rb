require 'rubygems'
require 'sinatra'
require 'haml'
require 'mongo_mapper'
require 'rack-flash'
require 'rdiscount'

use Rack::Session::Cookie, :secret => 'h4ck3ty h4ck f0r gr347 g00d'
use Rack::Flash

require 'utility'

require 'configure'

require 'helpers'

get "/" do
	haml :index
end

require_directory "controllers"
