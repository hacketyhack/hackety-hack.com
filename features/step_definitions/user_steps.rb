Given /^a logged in user$/ do
  @user = User.create!(username:              "test_user",
                       email:                 "test_user@example.com",
                       password:              "foobar",
                       password_confirmation: "foobar")
  visit('/login')
  fill_in("Username", :with => @user.username)
  fill_in("Password", :with => @user.password)
  click_button("Sign in")
end

When /^I go to look at my profile page$/ do
  visit user_path(@user)
end

Then /^it should have the right information$/ do
  page.should have_selector('title', :content => "#{@user.username}'s page")
  page.should have_content("About #{@user.username}")
end

When /^I edit my profile$/ do
  visit('/users/edit')
  fill_in("About", with: "Test user likes to edit his profile|")
  fill_in("Current password", with: @user.password)
  click_button "Update"
end

Then /^I should be notified that my profile was updated$/ do
  page.should have_content("updated your account")
end

Then /^I should see my changes reflected on my profile page$/ do
  visit("/users/#{@user.username}")
  page.should have_content("Test user likes to edit his profile")
end
