Feature: The Hackety Forum
	Scenario: View all forums
		Given I'm logged in
		When I go to the forums
		Then I should see "Learning Ruby"
		And I should see "Hackety Help"
		And I should see "Clubhouse"
