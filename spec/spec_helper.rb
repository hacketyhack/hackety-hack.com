require 'rubygems'
require 'rspec'
require 'database_cleaner'
require 'factory_girl'

require "#{File.dirname(__FILE__)}/factories.rb"

RSpec.configure do |config|
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

