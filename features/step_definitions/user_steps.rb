Given /^no user exists with an email of "(.*)"$/ do |email|
  User.find(:first, :conditions => { :email => email }).should be_nil
end

Given /^I am a user with username "([^"]*)" and password "([^"]*)"$/ do |username, password|
  @user = User.new(:username => username,
            :email => "#{username}@example.com",
            :password => password,
            :password_confirmation => password)
  @user.save!
end

Then /^I should be already signed in$/ do
  step %{I should see "Logout"}
end

Given /^I am signed up as "(.*)\/(.*)"$/ do |username, password|
  step %{I am not logged in}
  visit(signup_path)
  fill_in("Username", :with => username)
  fill_in("Email", :with => "#{username}@example.com")
  fill_in("Password", :with => password)
  fill_in("Password confirmation", :with => password)
  click_button("Sign up")
  BROWSER.html.should include('signed up succesfully')
  step %{I am logout}
end

Then /^I sign out$/ do
  visit(logout_path)
end

Given /^I am logout$/ do
  step %{I sign out}
end

Given /^I am not logged in$/ do
  step %{I sign out}
end

When /^I sign in as "(.*)\/(.*)"$/ do |username, password|
  step %{I am not logged in}
  visit(login_path)
  fill_in("Username", :with => username)
  fill_in("Password", :with => password)
  click_button("Sign in")
end

Then /^I should be signed in$/ do
  BROWSER.html.should include("Signed in")
end

When /^I return next time$/ do
  visit(root)
end

Then /^I should be signed out$/ do
  BROWSER.html.should include("Sign up")
  BROWSER.html.should include("Login")
  BROWSER.html.should_not include("Logout")
end
