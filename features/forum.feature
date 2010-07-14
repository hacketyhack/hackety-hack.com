Feature: The Hackety Forum
	Scenario: View all forums
		Given I'm logged in
		When I go to the forums
		Then I should see "Learning Ruby"
		And I should see "Hackety Help"
		And I should see "Clubhouse"
	Scenario: View discussions in a forum
		Given I'm logged in
		And there's a discussion named "I need help!" in "learning_ruby"
		When I go to the forums
		And I follow "Learning Ruby"
		Then I should see "I need help!"
