source 'http://rubygems.org'

#ruby=1.9.3-p392
#ruby-gemset=hackety-hack.com

ruby '1.9.3'

gem 'rails', '3.1.11'
gem 'json'

gem 'hackety_hack-lessons', '~> 1.1', :require => 'hackety_hack/lessons'

gem 'haml-rails'
gem 'jquery-rails'
gem 'mongo_mapper'
gem 'bson_ext'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   "~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem "devise",     "~> 2.2.2"
gem 'mm-devise',  '~> 2.0'
gem 'cancan'

gem 'inherited_resources'
gem 'simple_form',    git: "https://github.com/bitzesty/bootstrap_form.git"
gem "semantic_menu",  git: "git://github.com/michaek/semantic_menu.git"

gem 'will_paginate'    # Pagination
gem 'rdiscount'   # Markdown

group :development do
  # Use unicorn as the web server
  gem 'unicorn'
end

group :development, :test do
  gem 'fabrication'
  gem 'rspec-rails'
  gem 'cucumber-rails', require: false
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
