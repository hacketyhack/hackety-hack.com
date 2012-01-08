When /^I register a new account$/ do
  @user_info = {:username => "username", :password => "password", :email => "test@example.com"}

  visit new_user_registration_path

  fill_in("Username", :with => @user_info[:username])
  fill_in("Email", :with => @user_info[:email])
  fill_in("Password", :with => @user_info[:password])
  fill_in("Password confirmation", :with => @user_info[:password])

  click_button "Sign up"
end

When /^I should be logged in with my new account$/ do
  page.should have_content("You have signed up successfully")
  page.should have_content(@user_info[:username])
end