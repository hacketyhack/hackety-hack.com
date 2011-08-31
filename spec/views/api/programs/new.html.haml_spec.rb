require 'spec_helper'

describe "api_programs/new.html.haml" do
  before(:each) do
    assign(:program, stub_model(Api::Program).as_new_record)
  end

  it "renders new program form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => api_programs_path, :method => "post" do
    end
  end
end
