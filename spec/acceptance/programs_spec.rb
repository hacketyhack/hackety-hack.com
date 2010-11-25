require File.dirname(__FILE__) + '/acceptance_helper'

feature "Programs" do

  scenario "can be created" do
    @hacker = Factory(:hacker)
    log_in @hacker

    visit "/programs/new"
    fill_in "Title", :with => "Hello world"
    fill_in "Body", :with => "puts 'Hello, world!'"
    click_button "Create"

    should_be_on "#{@hacker.username}/hello_world"

    page.should have_content "Program created"
    page.should have_content "Hello world"
    page.should have_content "By steve"
    page.should have_content "puts"

  end

end
