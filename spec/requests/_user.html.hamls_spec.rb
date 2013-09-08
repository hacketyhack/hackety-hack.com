require 'spec_helper'
  describe "testing home page" do

    it "should have the text 'Log In'" do
      visit 'http://www.hackety-hack.com'
      click_link "Log In"
      page.should have_content('Log In')
    end

    it "should have image 'github'" do
      visit 'http://wwww.hackety-hack.com'
      click_link "Log In"
      click_link 'github_login'
    # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
    end
  end
