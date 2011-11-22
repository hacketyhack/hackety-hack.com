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
  step %{I go to the sign up page}
  step %{I fill in "Username" with "#{username}"}
  step %{I fill in "Email" with "#{username}@example.com"}
  step %{I fill in "Password" with "#{password}"}
  step %{I fill in "Password confirmation" with "#{password}"}
  step %{I press "Sign up"}
  step %{I should see "You have signed up successfully. If enabled, a confirmation was sent to your e-mail."}
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
  step %{I go to the sign in page}
  step %{I fill in "Username" with "#{username}"}
  step %{I fill in "Password" with "#{password}"}
  step %{I press "Sign in"}
end

Then /^I should be signed in$/ do
  step %{I should see "Signed in successfully."}
end

When /^I return next time$/ do
  step %{I go to the home page}
end

Then /^I should be signed out$/ do
  step %{I should see "Sign up"}
  step %{I should see "Login"}
  step %{I should not see "Logout"}
end
