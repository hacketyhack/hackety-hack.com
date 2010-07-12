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
	Scenario: No duplicate usernames
		Given there's a user with the username "steve"
		And I'm not logged in
		And I go to the new user page
		And I fill in "Email" with "steve@example.com"
		And I fill in "Username" with "steve"
		And I fill in "Password" with "foobar"
		And I fill in "Confirm Password" with "foobar"
		When I press "Create account"
		Then I should see "There were some problems"
		And I should be on the new user page
	Scenario: User pages
		Given there's a user with the username "steve"
		When I go to the hacker page for "steve"
		Then I should see "steve's page"
