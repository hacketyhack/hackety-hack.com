Feature: Messages
	Scenario: I can send a message
		Given I'm logged in
		And there's a hacker with the username "fela"
		And I go to the hacker page for "fela"
		When I follow "Send fela a message"
		And I fill in "Message text" with "Hello, fela!"
		And I press "Send message"
		Then I should be on the hacker page for "fela"
		And I should see "Message sent."
	Scenario: I can't send a message when not logged in
		Given I'm not logged in
		And there's a hacker with the username "fela"
		When I go to the hacker page for "fela"
		Then I should not see "Send fela a message"
