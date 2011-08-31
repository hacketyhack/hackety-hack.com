require 'spec_helper'

describe "api_programs/show.html.haml" do
  before(:each) do
    @program = assign(:program, stub_model(Api::Program))
  end

  it "renders attributes in <p>" do
    render
  end
end
