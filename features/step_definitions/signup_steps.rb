def register_user(user)
  visit new_user_registration_path
  fill_in("Username", :with => user[:username])
  fill_in("Email", :with => user[:email])
  fill_in("Password", :with => user[:password])
  fill_in("Password confirmation", :with => user[:password])

  click_button "Sign up"
end

When /^I register a new account$/ do
  @new_user = {:username => "username", :password => "password", :email => "test@example.com"}
  register_user @new_user
end

When /^I register a duplicate account$/ do
  @existing_user = User.create!(username:              "existing_user",
                                email:                 "existing_user@example.com",
                                password:              "foobar",
                                password_confirmation: "foobar")
  register_user @existing_user
end

When /^I should be logged in with my new account$/ do
  page.should have_content("You have signed up successfully")
  page.should have_content(@new_user[:username])
end

Then /^I should see validation errors$/ do
  page.should have_selector(".error_notification")
end
