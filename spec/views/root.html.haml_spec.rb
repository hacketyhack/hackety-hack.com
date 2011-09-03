require 'spec_helper'

describe "static/root" do
  
  it "has homepage content" do
    render
    rendered.should have_selector('h1', :content => "Home!")
  end
  
end
