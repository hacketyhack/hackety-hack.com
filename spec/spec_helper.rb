require 'code_coverage'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'database_cleaner'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|
  # == Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  config.mock_with :rspec

  DatabaseCleaner.orm = "mongo_mapper"
  DatabaseCleaner[:mongo_mapper].strategy = :truncation

  config.before(:each) do
    DatabaseCleaner[:mongo_mapper].clean
  end

  config.include(MailerMacros)
  config.before(:each) { reset_email }

  config.include Devise::TestHelpers, :type => :controller
  config.include Capybara::DSL 
end
  config.before(:suite) do
  DatabaseCleaner.strategy = :truncation
end