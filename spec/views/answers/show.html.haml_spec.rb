require 'spec_helper'

describe "answers/show.html.haml" do
  before(:each) do
    @answer = assign(:answer, stub_model(Answer,
      :description => "Description",
      :user => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Description/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
  end
end
