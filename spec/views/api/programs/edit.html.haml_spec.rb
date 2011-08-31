require 'spec_helper'

describe "api_programs/edit.html.haml" do
  before(:each) do
    @program = assign(:program, stub_model(Api::Program))
  end

  it "renders the edit program form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => api_programs_path(@program), :method => "post" do
    end
  end
end
