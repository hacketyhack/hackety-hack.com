require 'spec_helper'
Dir.glob(File.join(File.dirname(__FILE__), '..', '/factories/*.rb')).each do |factory|
  require factory
end

describe "Hackety Website" do
  include Rack::Test::Methods
  def app; Sinatra::Application; end

  describe "routes" do
  end

end
