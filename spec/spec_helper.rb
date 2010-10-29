require 'rubygems'
require 'spec'
require 'database_cleaner'
require 'sinatra'
require 'rack/test'
require 'factory_girl'
set :environment, :test

require 'hackety'

Spec::Runner.configure do |config|
  config.mock_with :rspec

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

