require File.dirname(__FILE__) + '/acceptance_helper'

feature "Hackers" do

  scenario "can register" do

    visit '/signup'
    
    fill_in "Email", :with => "steve@example.com"
    fill_in "Username", :with => "steve"
    fill_in "Password", :with => "foobar"
    fill_in "Confirm Password", :with => "foobar"
    click_button "Create account"

    page.should have_content "Account created."
    should_be_on "/"
  end

  scenario "visit a profile" do
    hacker = Factory(:hacker, :username => "steve")
    visit "/hackers/steve"
    page.should have_content "steve's page"
  end

  scenario "visit your profile" do
    @hacker = Factory(:hacker)
    log_in @hacker

    visit "/"
    click_link "Your Page"
    should_be_on "/hackers/#{@hacker.username}"
    page.should_not have_content "Send steve a message"
  end

end
