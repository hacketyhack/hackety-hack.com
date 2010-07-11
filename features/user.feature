Feature: User management
	Scenario: Users can register
		Given I'm not logged in
		And I go to the new user page
		And I fill in "Email" with "steve@example.com"
		And I fill in "Username" with "steve"
		And I fill in "Password" with "foobar"
		And I fill in "Confirm Password" with "foobar"
		When I press "Create account"
		Then I should see "Account created."
		And I should be on the main page
