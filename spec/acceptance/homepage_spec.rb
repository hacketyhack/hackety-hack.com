require File.dirname(__FILE__) + '/acceptance_helper'

feature "Homepage" do

  scenario "displays a download link" do
    visit "/"
    page.should have_content "Download v"
  end

  scenario "provides a link to help" do
    visit "/"
    click_link "Ask a question"
    should_be_on "/stream"
  end

end
