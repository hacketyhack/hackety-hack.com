require 'spec_helper'

describe "answers/index.html.haml" do
  before(:each) do
    assign(:answers, [
      stub_model(Answer,
        :description => "Description",
        :user => ""
      ),
      stub_model(Answer,
        :description => "Description",
        :user => ""
      )
    ])
  end

  it "renders a list of answers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
