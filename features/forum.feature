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
	Scenario: View replies to a discussion
		Given I'm logged in
		And there's a discussion named "I need help" in "learning_ruby" with a reply
		When I go to the discussion "learning_ruby/i_need_help"
		Then I should see "I need help"
		And I should see "I'm here to help!"
