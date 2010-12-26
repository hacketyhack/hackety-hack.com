# encoding: utf-8

#first off, we need to include rubygems and sinatra
require 'rubygems'

#this bundler stuff needed for heroku
require 'bundler'
Bundler.setup

require 'sinatra'

#this lets us send emails
require 'pony'

#haml gives us all of our templates
require 'haml'

#mongomapper connects us to our database
require 'mongo_mapper'

#rack-flash gives us nice flash messages
require 'rack-flash'

#rdiscount lets us write things using markdown
require 'rdiscount'

#we need to set up a secret to encrypt our sessions with
use Rack::Session::Cookie, :secret => ENV['COOKIE_SECRET']

#we also have to let the world know we want to use flashes
use Rack::Flash

require 'sinatra/content_for'

require_relative 'helpers'

if ENV['RACK_ENV'] == 'production'
  set :raise_errors, true

  require 'exceptional'
  use Rack::Exceptional, ENV['EXCEPTIONAL_API_KEY']
end

#this makes Haml escape any html by default. See here: http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html#options
set :haml, :escape_html => true

#these configure blocks only run in one environment
configure :test do
  PONY_VIA_OPTIONS = {}
end

configure :development do
  PONY_VIA_OPTIONS = {}
end

configure :production do

  PONY_VIA_OPTIONS =  {
    :address        => "smtp.sendgrid.net",
    :port           => "25",
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => ENV['SENDGRID_DOMAIN']
  }
  
end

#for all environments,
configure do
  if ENV['MONGOHQ_URL']
    MongoMapper.connection = Mongo::Connection.new(ENV['MONGOHQ_HOST'], ENV['MONGOHQ_PORT'])
    MongoMapper.database = ENV['MONGOHQ_DATABASE']
    MongoMapper.database.authenticate(ENV['MONGOHQ_USER'],ENV['MONGOHQ_PASSWORD'])
    
    MongoMapper.database = ENV['MONGOHQ_DATABASE']
  else
    MongoMapper.connection = Mongo::Connection.new('localhost')
    MongoMapper.database = "hackety-development"
  end
  #require all of our models!
  require_directory "models"
end

require_directory "controllers"

get '/' do
  if logged_in?
    redirect "/stream"
  end
  haml :index
end

get '/post' do
  haml :post
end

get '/download' do
  haml :download
end

get '/stream' do
  @content_list = Content.all.reverse
  haml :stream
end

