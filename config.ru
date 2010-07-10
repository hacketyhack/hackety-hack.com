require 'rubygems'
require 'sinatra'

set :env, :development
set :public, File.expand_path(File.dirname(__FILE__) + '/public')

require 'hackety'

run Sinatra::Application
