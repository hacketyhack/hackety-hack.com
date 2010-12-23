#!/usr/bin/env ruby
# encoding: utf-8

require 'sinatra'
require 'haml'
require 'sass'

set :port, 9000

get '/' do
  haml :index
end

get '/post' do
  haml :post
end

get '/feed' do
  haml :feed
end
