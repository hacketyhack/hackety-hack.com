require 'rubygems'
require 'sinatra'

set :env, :development

require 'hackety'

run Sinatra::Application
