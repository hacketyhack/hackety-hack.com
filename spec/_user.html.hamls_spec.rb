require 'spec_helper'

  describe "testing home page" do
    it "should have the text 'Log In'" do
    visit 'http://www.hackety-hack.com'
    click_link "Log In"
    page.should have_content('Log In')
     
    end
  end

