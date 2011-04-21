# encoding: utf-8

# This is the source code for the [Hackety Hack website][hw]. Hackety Hack is
# the easiest way to learn programming, and so our documentation should be
# top-notch.
#
# To get started, you'll need to install some prerequisite software:
#
# **Ruby** is used to power the site. We're currently using ruby 1.9.2p0. I 
# highly reccomend that you use [rvm][rvm] to install and manage your Rubies.
# It's a fantastic tool. If you do decide to use `rvm`, you can install the 
# appropriate Ruby and create a gemset by simply `cd`-ing into the root project
# directory; I have a magical `.rvmrc` file that'll set you up.
#
# **MongoDB** is a really awesome document store. We use it to persist all of
# the data on the website. To get MongoDB, please visit their 
# [downloads page](http://www.mongodb.org/downloads) to find a package for your
# system.
#
# After installing Ruby and MongoDB, you need to aquire all of the Ruby gems
# that we use. This is pretty easy, since we're using **bundler**. Just do
# this:
#
#     $ gem install bundler
#     $ bundle install
#
# That'll set it all up! Then, you need to make sure you're running MongoDB.
# I have to open up another tab in my terminal and type
#
#     $ mongod
#
# to get this to happen. When you're done hacking, you can hit ^-c to stop
# `mongod` from running.
#
# To actually start up the site, just 
#
#     $ rackup
#
# and then visit [http://localhost:9292/](http://localhost:9292). You're good
# to go!
# 
# [hw]: http://hackety-hack.com
# [rvm]: http://rvm.beginrescueend.com/

#### About hackety.rb
#
# This file is the main entry point to the application. It has three main
# purposes:
#
# 1. Include all relevant gems and library code.
# 2. Configure all settings based on our environment.
# 3. Set up a few basic routes.
#
# Everything else is handled by code that's included from this file.

#### Including gems

# We need to require rubygems and bundler to get things going. Then we call
# `Bundler.setup` to get all of the magic started.

require 'rubygems'
require 'bundler'
Bundler.setup

# We use [sinatra](http://sinatrarb.com/) for our web framework. Sinatra is
# very light and simple. Good stuff.
require 'sinatra'

# [Pony](https://github.com/adamwiggins/pony) is used to send emails, just like the Pony express. Also, running `gem install pony` is really satisfying.
require 'pony'

# [haml](http://haml-lang.com/) creates all of our templates. haml is concise
# and expressive. I really enjoy it.
require 'haml'

# [MongoMapper](http://mongomapper.com/) is a library we use to make it easy to
# store our model classes into MongoDB.
require 'mongo_mapper'

# We need a secret for our sessions. This is set via an environment variable so
# that we don't have to give it away in the source code. Heroku makes it really
# easy to keep environment variables set up, so this ends up being pretty nice.
# This also has to be included before rack-flash, or it blows up.
use Rack::Session::Cookie, :secret => ENV['COOKIE_SECRET']

# If you've used Rails' flash messages, you know how convenient they are.
# rack-flash lets us use them.
require 'rack-flash'
use Rack::Flash

# [rdiscount](https://github.com/rtomayko/rdiscount) is a fast implementation
# of the Markdown markup language. The web site renders most user submitted
# comment with Markdown.
require 'rdiscount'

# Rails has a `content_for` helper that lets you place different parts of your
# view into different places in your template. This helps a lot with
# javascript, and conditional stylesheets or other includes. It's so nice that
# foca has written 
# [a Sinatra version](https://github.com/foca/sinatra-content-for).
require 'sinatra/content_for'

# We moved lots of helpers into a separate file. These are all things that are
# useful throughout the rest of the application. This file
require_relative 'helpers'

#### Configure settings

# We use [Exceptional](http://www.getexceptional.com/) to keep track of errors
# that happen. This code is from their 
# [example documentation](http://docs.getexceptional.com/getting-started/sinatra/)
# for Sinatra. It _might_ be better off inside of a config block, but I haven't
# tested it in that role yet.
if ENV['RACK_ENV'] == 'production'
  set :raise_errors, true

  require 'exceptional'
  use Rack::Exceptional, ENV['EXCEPTIONAL_API_KEY']
end

# We're using [New Relic RPM](http://newrelic.com/) for statistics gathering
# and such. This code is from the [Heroku add-on documentation](http://docs.heroku.com/newrelic).
configure :production do
  require 'newrelic_rpm'
end


# This makes [Haml escape any html](http://haml-lang.com/docs/yardoc/file.HAML_REFERENCE.html#options) by default.
set :haml, :escape_html => true

# The `PONY_VIA_OPTIONS` hash is used to configure `pony`. Basically, we only
# want to actually send mail if we're in the production environment. So we set
# the hash to just be `{}`, except when we want to send mail.
configure :test do
  PONY_VIA_OPTIONS = {}
end

configure :development do
  PONY_VIA_OPTIONS = {}
end

# We're using [SendGrid](http://sendgrid.com/) to send our emails. It's really
# easy; the Heroku addon sets us up with environment variables with all of the
# configuration options that we need.
configure :production do
  PONY_VIA_OPTIONS =  {
    :address        => "smtp.sendgrid.net",
    :port           => "25",
    :authentication => :plain,
    :user_name      => ENV['SENDGRID_USERNAME'],
    :password       => ENV['SENDGRID_PASSWORD'],
    :domain         => ENV['SENDGRID_DOMAIN']
  }
  
end

# We don't want to bother with running our own MongoDB server in production;
# that's what The Cloud (tm) is for! So we want to double check our environment
# variables, and if it appears that we'd like to connect to 
# [MongoHQ](https://mongohq.com/), let's do that. Otherwise, just connect to
# our local server running on localhost.
configure do
  if ENV['MONGOHQ_URL']
    MongoMapper.config = {ENV['RACK_ENV'] => {'uri' => ENV['MONGOHQ_URL']}}
    MongoMapper.database = ENV['MONGOHQ_DATABASE']
    MongoMapper.connect("production")
  else
    MongoMapper.connection = Mongo::Connection.new('localhost')
    MongoMapper.database = "hackety-#{settings.environment}"
  end
end



# Since Sinatra doesn't automatically load anything, we have to do it
# ourselves. Remember that helpers.rb file? Well, we made a handy 
# `require_directory` method that, well, `require`s a whole directory. So let's
# include both of our models as well as our controllers.
require_directory "models"
require_directory "controllers"

#### Set up basic routes

# The first thing you'll ever see when going to the website is here. It all
# starts with `/`. If we're logged in, we want to just redirect to the main
# activity stream. If not, let's show that pretty splash page that sings all of
# our praises. 
#
# One small note about rendering, though: Our main layout doesn't exactly work
# for the main page, it's an exception. So we don't want to use our regular old
# `layout.haml` file. So we tell Sinatra not to.
get '/' do
  if logged_in?
    redirect "/stream"
  end
  haml :index, :layout => :plain
end

# Hopefully, anyone visiting the site will think that Hackety Hack sounds
# pretty cool. If they do, they'll visit the downloads page. This'll direct
# them to download Hackety, and sign up for an account.
#
# Similar to the home page, we also don't want our layout here, either.
get '/download' do
  haml :download, :layout => :plain
end

# The main activity stream is the main page for the site when a user is logged
# in. It lets them share what they're doing with others, and also view all of
# the content that others have posted. So we grab it all, and sort it in the
# opposite order that it's been updated. Wouldn't want to see old stuff!
get '/stream' do
  page = params[:page] || 1
  @content_list = Content.paginate( :page => params[:page], :per_page => params[:per_page] || 20, :order => :updated_at.desc)
  if @content_list.next_page
    @next_page = "?#{Rack::Utils.build_query :page => @content_list.next_page}"
  end

  if @content_list.previous_page
    @prev_page = "?#{Rack::Utils.build_query :page => @content_list.previous_page}"
  end
  haml :stream
end

# We want a minimal Terms of Service, at least.
get '/tos' do
  haml :tos
end

# This is used by the desktop app to see if we should upgrade or not.
get "/version.json" do
 content_type :json
  {:current_version => 1.0}.to_json
end
