# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.time_zone = 'UTC'

	config.gem "authlogic"
	config.gem "hpricot"
	config.gem "syntax"
  config.gem "bluecloth"
  config.gem "rdiscount"
  config.gem "haml"

end

begin
    require 'rdiscount'
    BlueCloth = RDiscount
rescue LoadError
    require 'bluecloth'
end
