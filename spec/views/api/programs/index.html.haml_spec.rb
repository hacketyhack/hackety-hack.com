require 'spec_helper'

describe "api_programs/index.html.haml" do
  before(:each) do
    assign(:api_programs, [
      stub_model(Api::Program),
      stub_model(Api::Program)
    ])
  end

  it "renders a list of api_programs" do
    render
  end
end
