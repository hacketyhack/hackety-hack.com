require File.dirname(__FILE__) + "/../spec_helper"

require 'capybara/dsl'
require 'steak'

RSpec.configure do |config|

  config.include Capybara

end


require 'sinatra'
require 'rack/test'
set :environment, :test

app_file = File.join(File.dirname(__FILE__), '..', '..', 'hackety.rb')
require app_file
Sinatra::Application.app_file = app_file
Capybara.app = Sinatra::Application

Capybara.save_and_open_page_path = '/tmp'
Capybara.javascript_driver = :culerity

Dir["#{File.dirname(__FILE__)}/support/*.rb"].each {|f| require f}
