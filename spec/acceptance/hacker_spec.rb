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

  scenario "have visible profiles" do
    hacker = Factory(:hacker, :username => "steve")
    visit "/hackers/steve"
    page.should have_content "steve's page"
  end

  scenario "can't send messages to themselves" do
    @hacker = Factory(:hacker)
    log_in @hacker

    visit "/"
    click_link "Your Page"
    should_be_on "/hackers/#{@hacker.username}"
    page.should_not have_content "Send steve a message"
  end

  scenario "can follow other hackers" do
    @fela = Factory(:hacker, :username => "fela")

    @steve = Factory(:hacker, :username => "steve")
    log_in @steve

    visit "/hackers/fela"
    click_link "Follow fela"

    page.should have_content "Now following fela."
    should_be_on "/hackers/steve"
    page.should have_content "Following: 1"

    visit "/hackers/fela"
    page.should have_content "Followers: 1"
  end

  scenario "can see followers" do
    @fela = Factory(:hacker, :username => "fela")
    @steve = Factory(:hacker, :username => "steve")

    @steve.follow! @fela

    visit "/hackers/fela"

    click_link "1"
    page.should have_content "steve"
  end

  scenario "can see others following" do
    @fela = Factory(:hacker, :username => "fela")
    @steve = Factory(:hacker, :username => "steve")
    @steve.follow! @fela

    visit "/hackers/steve"
    click_link "1"
    page.should have_content "fela"
  end

  scenario "can unfollow other hackers" do
    @steve = Factory(:hacker, :username => "steve")
    log_in @steve

    @fela = Factory(:hacker, :username => "fela")
    @steve.follow! @fela

    visit "/hackers/fela"
    click_link "Unfollow fela"
    should_be_on "/hackers/steve"

    page.should have_content "No longer following fela."
    page.should have_content "Following: 0"
  end

end
