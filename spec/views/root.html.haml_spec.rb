require 'spec_helper'

describe "static/root" do
  
  it "links to questions" do
    render
    rendered.should have_selector('a', :href => '/questions')
  end
  
end
