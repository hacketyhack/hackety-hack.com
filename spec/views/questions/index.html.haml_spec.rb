require 'spec_helper'

describe "questions/index.html.haml" do
  before(:each) do
    assign(:questions, [
      stub_model(Question,
        :title => "Title",
        :description => "Description"
      ),
      stub_model(Question,
        :title => "Title",
        :description => "Description"
      )
    ])
  end

  it "renders a list of questions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
