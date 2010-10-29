require 'rubygems'
require 'sinatra'
require 'spec'
require 'rack/test'
require 'factory_girl'
set :environment, :test

require 'hackety'

Dir.glob(File.join(File.dirname(__FILE__), '..', '/factories/*.rb')).each do |factory|
  require factory
end

describe "Hackety Website" do
  include Rack::Test::Methods
  def app; Sinatra::Application; end


  describe "routes" do
  end

end
