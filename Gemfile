source 'http://rubygems.org'

#ruby=1.9.3-p448
#ruby-gemset=hackety-hack.com

ruby '1.9.3'

gem 'rails', '3.2.17'
gem 'json'

gem 'hackety_hack-lessons', '~> 1.1', :require => 'hackety_hack/lessons'

gem 'haml-rails'
gem 'jquery-rails'
gem 'mongo_mapper'
gem 'bson_ext'

gem "letter_opener", group: :development
  
gem "devise",     "~> 2.2.2"
gem 'mm-devise',  '~> 2.0'
gem 'cancan'

gem 'inherited_resources'
gem 'simple_form',    git: "https://github.com/bitzesty/bootstrap_form.git"
gem "semantic_menu",  git: "git://github.com/michaek/semantic_menu.git"

gem 'will_paginate'    # Pagination
gem 'redcarpet', '~> 3.0'   # Markdown

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :development do
  # Use unicorn as the web server
  gem 'unicorn'
end

group :development, :test do
  gem 'debugger'
  gem 'fabrication'
  gem 'rspec-rails'
  gem 'capybara'
  gem 'cucumber-rails', require: false
  gem "faker"
  gem 'pry'
  gem 'sqlite3'
end

group :production do
  gem 'pg' # ugh heroku
end

group :test do
  gem "simplecov", :require => false
  gem "coveralls"
  gem "mocha"
  gem "database_cleaner"
  gem "launchy"
end
