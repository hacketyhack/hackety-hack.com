require 'rubygems'
require 'sinatra'

#sass gives us awesome CSS
require 'sass/plugin/rack'
use Sass::Plugin::Rack

set :env, :production

require 'hackety'

run Sinatra::Application
