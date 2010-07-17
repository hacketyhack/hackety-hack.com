require 'rubygems'
require 'sinatra'

#sass gives us awesome CSS
require 'sass/plugin/rack'
use Sass::Plugin::Rack

set :env, :development

require 'hackety'

run Sinatra::Application
