require 'spec_helper'

describe Api::RelsController do
  let(:slug){Fabricate(:rel)}

  describe "GET index" do
    it "responds with success" do
      get :index
      response.should be_success
    end
  end

  describe "GET show" do
    it "responds with success" do
      get :show
      response.should be_success
    end
  end
end