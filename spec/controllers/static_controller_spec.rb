require 'spec_helper'

describe StaticController do
  describe "GET root" do
    it "responds with success" do
      expect(:get => "/").to route_to(:controller => "static", :action => "root")
    end
  end
end