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

end
