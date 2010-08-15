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
	Scenario: Following Hackers
		Given there's a hacker with the username "fela"
		And I'm logged in as "steve"
		When I go to the hacker page for "fela"
		And I follow "Follow fela"
		Then I should see "Now following fela."
		And I should be on the hacker page for "steve"
		And I should see "Following: 1"
		And I go to the hacker page for "fela"
		And I should see "Followers: 1"
	Scenario: Seeing Followers
		Given there's a hacker with the username "steve"
		And there's a hacker with the username "fela"
		And the hacker "steve" is following the hacker "fela"
		When I go to the hacker page for "fela"
		And I follow "1"
		Then I should see "steve"
	Scenario: Seeing Following
		Given there's a hacker with the username "steve"
		And there's a hacker with the username "fela"
		And the hacker "steve" is following the hacker "fela"
		When I go to the hacker page for "steve"
		And I follow "1"
		Then I should see "fela"
