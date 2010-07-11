Given /^I'm logged in as admin$/ do
	password = "foobar"
	@user = Factory(:admin,:password => password, :password_confirmation => password)
	visit "/login"
	fill_in "email", :with => @user.email
	fill_in "password", :with => password
	click_button "login"
end

