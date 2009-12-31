Feature: Use hackety-hack.com

	Scenario: Visit a user's page
	Given there's a user named Steve
	When I go to Steve's user page
	Then I should see "Steve"
