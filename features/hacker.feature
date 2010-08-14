Feature: Hacker management
	Scenario: Users can register
		Given I'm not logged in
		And I go to the new hacker page
		And I fill in "Email" with "steve@example.com"
		And I fill in "Username" with "steve"
		And I fill in "Password" with "foobar"
		And I fill in "Confirm Password" with "foobar"
		When I press "Create account"
		Then I should see "Account created."
		And I should be on the main page
	Scenario: No duplicate usernames
		Given there's a hacker with the username "steve"
		And I'm not logged in
		And I go to the new hacker page
		And I fill in "Email" with "steve@example.com"
		And I fill in "Username" with "steve"
		And I fill in "Password" with "foobar"
		And I fill in "Confirm Password" with "foobar"
		When I press "Create account"
		Then I should see "There were some problems"
		And I should be on the new hacker page
	Scenario: Hacker pages
		Given there's a hacker with the username "steve"
		When I go to the hacker page for "steve"
		Then I should see "steve's page"
	Scenario: Going to your profile
		Given I'm logged in as "steve"
		And I go to the home page
		When I follow "Your Page"
		Then I should be on the hacker page for "steve"
		And I should not see "Send steve a message"
