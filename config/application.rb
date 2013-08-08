require File.expand_path('../boot', __FILE__)

require 'rails/all'
# require 'active_record/railtie'
require 'devise'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  #Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  Bundler.require(:default, :assets, Rails.env)
end

module HacketyHackCom
  class Application < Rails::Application
    config.autoload_paths << "#{config.root}/lib" << "#{config.root}/presenters"

    config.encoding = "utf-8"

    config.filter_parameters += [:password]

    config.assets.enabled = true

    config.generators do |g|
      g.template_engine :haml

      # you can also specify a different test framework or ORM here
      g.test_framework      :rspec, :fixture => true
      g.fixture_replacement :fabrication
      g.orm                 :mongo_mapper
    end
  end
end
