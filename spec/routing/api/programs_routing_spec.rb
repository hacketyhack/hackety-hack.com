require "spec_helper"

describe Api::ProgramsController do
  describe "routing" do

    it "routes to #index" do
      get("/api_programs").should route_to("api_programs#index")
    end

    it "routes to #new" do
      get("/api_programs/new").should route_to("api_programs#new")
    end

    it "routes to #show" do
      get("/api_programs/1").should route_to("api_programs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/api_programs/1/edit").should route_to("api_programs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/api_programs").should route_to("api_programs#create")
    end

    it "routes to #update" do
      put("/api_programs/1").should route_to("api_programs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/api_programs/1").should route_to("api_programs#destroy", :id => "1")
    end

  end
end
