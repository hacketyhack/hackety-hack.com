def login_user
  @user = User.create!(username:              "test_user",
                        email:                 "test_user@example.com",
                        password:              "foobar",
                        password_confirmation: "foobar")
  visit login_path
  fill_in("Username", :with => @user.username)
  fill_in("Password", :with => @user.password)
  click_button("Sign in")
end

def create_other_user
  @other_user = User.create!(username:              "other_user",
                             email:                 "other_user@example.com",
                             password:              "123456",
                             password_confirmation: "123456")
end

Given /^a logged in user$/ do
  login_user unless @user
end

Given /^a steve exists$/ do
  @steve = User.create!(username:              "steve",
                        email:                 "steve_user@example.com",
                        password:              "foobar",
                        password_confirmation: "foobar")
end

When /^I go to look at my profile page$/ do
  visit user_path(@user)
end

Then /^it should have the right information$/ do
  page.should have_title("#{@user.username}'s Profile\n | Hackety Hack!")
  page.should have_content("#{@user.username}'s Profile")
end

When /^I edit my profile$/ do
  visit('/users/edit')
  fill_in("About", with: "Test user likes to edit his profile|")
  fill_in("Current password", with: @user.password)
  click_button "Update"
end

When /^I have a follower$/ do
  create_other_user
  @other_user.follow! @user
end

When /^I am following someone$/ do
  create_other_user
  @user.follow! @other_user
end

When /^I click on the number of followers on my profile$/ do
  step 'I go to look at my profile page'
  first('.user-followers').click
end

When /^I click on the number of people I am following on my profile$/ do
  step 'I go to look at my profile page'
  first('.user-following').click
end

Then /^I should see someone I'm following$/ do
  page.should have_link @other_user.username
end

Then /^I should see my follower$/ do
  page.should have_link @other_user.username
end

Then /^I should be notified that my profile was updated$/ do
  page.should have_content("updated your account")
end

Then /^I should see my changes reflected on my profile page$/ do
  visit("/users/#{@user.username}")
  page.should have_content("Test user likes to edit his profile")
end

Then(/^I should see 'Steve'$/) do
  @user.following?(@steve).should == true
  page.should have_link @steve.username
end
