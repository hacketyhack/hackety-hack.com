def login hacker 
	visit "/login"
	fill_in "username", :with => hacker.username
	fill_in "password", :with => hacker.password
	click_button "Log in"
end

Given /^I'm logged in as admin$/ do
	password = "foobar"
	hacker = Factory(:admin,:password => password, :password_confirmation => password)
	login hacker
end

Given /^I'm not logged in$/ do
	visit "/logout"
end

Given /^I log out$/ do
	visit "/logout"
end

When /^I log in as "([^"]*)"$/ do |username|
	hacker = Factory(:hacker, :username => username)
	login hacker
end


Given /^I'm logged in$/ do
	password = "foobar"
	hacker = Factory(:hacker,:password => password, :password_confirmation => password)
	login hacker 
end

Given /^I'm logged in as "([^"]*)"$/ do |username|
	password = "foobar"
	hacker = Factory(:hacker,:username => username, :password => password, :password_confirmation => password)
	login hacker 
end

Given /^I'm logged in as a user with the email "([^"]*)"$/ do |email|
	password = "foobar"
	hacker = Factory(:hacker,:email => email, :password => password, :password_confirmation => password)
	login hacker 
end

Given /^there's a hacker with the username "([^"]*)"$/ do |username|
	Factory(:hacker, :username => username)
end

And /^open page$/ do
  save_and_open_page
end

