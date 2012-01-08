source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'json'

gem 'haml-rails'
gem 'jquery-rails'
gem 'mongo_mapper'
gem 'bson_ext'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jnunemaker-validatable', '>= 1.8.4' # Required by mm-devise
gem 'devise',                 '>= 1.2'
gem 'mm-devise',              '>= 1.2'
gem 'cancan'

gem 'inherited_resources'
gem 'simple_form', :git => "https://github.com/bitzesty/bootstrap_form.git"
gem "semantic_menu", :git => "git://github.com/michaek/semantic_menu.git"

gem 'will_paginate'    # Pagination
gem 'rdiscount'   # Markdown


group :development do
  # Use unicorn as the web server
  gem 'unicorn'
end


group :development, :test do
  gem 'fabrication'
  gem 'rspec-rails'
  gem 'cucumber-rails'
  gem "faker"
  gem 'pry'
  gem 'sqlite3'
end

group :production do
  gem 'pg' # ugh heroku
end

group :test do
  gem "mocha"
  gem "database_cleaner"
  gem "launchy"
end
