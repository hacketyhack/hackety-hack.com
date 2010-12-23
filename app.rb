#!/usr/bin/env ruby
# encoding: utf-8

require 'sinatra'
require 'haml'
require 'sass'
require 'sinatra/content_for'

set :port, 9000

get '/' do
  haml :index
end

get '/post' do
  haml :post
end

get '/download' do
  haml :download
end

get '/feed' do
  haml :feed
end
