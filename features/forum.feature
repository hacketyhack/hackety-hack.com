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
	Scenario: Make a new reply
		Given I'm logged in as "steve"
		And there's a discussion named "I need help" in "learning_ruby" with a reply
		And I go to the forums
		And I follow "Learning Ruby"
		And I follow "I need help"
		When I follow "Reply"
		And I fill in "Body" with "I'll help you!"
		And I press "Create Reply"
		Then I should be on the discussion "learning_ruby/i_need_help" page
		And I should see "Replied!"
		And I should see "I'll help you"
		And I should see "steve says:"
	Scenario: Make a new discussion
		Given I'm logged in
		And I go to the forums
		And I follow "Learning Ruby"
		When I follow "New Discussion"
		And I fill in "Title" with "HALP!"
		And I fill in "Body" with "I'm really unsure as to how to do something."
		And I press "Create Discussion"
		Then I should be on the discussion "learning_ruby"
		And I should see "Discussion created!"
		And I should see "HALP!"
