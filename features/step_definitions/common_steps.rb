def login user
	visit "/login"
	fill_in "email", :with => user.email
	fill_in "password", :with => user.password
	click_button "login"
end

Given /^I'm logged in as admin$/ do
	password = "foobar"
	user = Factory(:admin,:password => password, :password_confirmation => password)
	login user
end

Given /^I'm not logged in$/ do
	visit "/logout"
end

Given /^I'm logged in$/ do
	password = "foobar"
	user = Factory(:user,:password => password, :password_confirmation => password)
	login user
end

Given /^I'm logged in as "([^"]*)"$/ do |email|
	password = "foobar"
	user = Factory(:user,:email => email, :password => password, :password_confirmation => password)
	login user
end

Given /^there's a user with the username "([^"]*)"$/ do |username|
	Factory(:user, :username => username)
end


And /^open page$/ do
  save_and_open_page
end

