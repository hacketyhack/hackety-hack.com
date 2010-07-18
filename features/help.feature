Feature: Getting Help
	Scenario: Contributor help
		Given I go to the help page
		When I follow "GitHub"
		Then I should be on the github page
