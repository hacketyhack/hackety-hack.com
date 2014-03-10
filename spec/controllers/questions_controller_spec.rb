require 'spec_helper'

describe QuestionsController do
  describe "GET index" do
    context "with format atom" do
      it "responds with success" do
        get :index, format: :atom
        response.should be_success
      end
    end
  end
end
