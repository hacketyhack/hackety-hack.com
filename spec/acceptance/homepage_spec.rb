require File.dirname(__FILE__) + '/acceptance_helper'

feature "Homepage" do

  scenario "displays a download link" do
    visit "/"
    page.should have_content "Click the Shoes logo"
  end

  scenario "provides a link to help" do
    visit "/"
    click_link "Help"
    should_be_on "/help"
  end

end
