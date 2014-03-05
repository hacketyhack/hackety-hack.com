require 'spec_helper'

describe StaticController do
  describe "GET root" do
    it "responds with success" do
      expect(:get => "/").to route_to(:controller => "static", :action => "root")
    end
  end

  describe "GET api_root" do
    it "should render api layout" do
      get :api_root
      response.should render_template(:layout => "api")
    end
  end

  describe "GET newest_version" do
    it "should render version of api" do
      get :newest_version
      response.header['Content-Type'].should include 'application/json'
      response.body.should include "1.0.0".to_json
    end
  end
end