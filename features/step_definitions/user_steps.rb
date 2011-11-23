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
