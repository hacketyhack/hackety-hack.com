require File.dirname(__FILE__) + '/acceptance_helper'

feature "Forums" do
  
  scenario "can view all of them" do
    @hacker = Factory(:hacker)
    log_in @hacker

    visit "/forums"

    page.should have_content "Learning Ruby"
    page.should have_content "Hackety Help"
    page.should have_content "Clubhouse"
  end

end
