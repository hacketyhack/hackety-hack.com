Feature: Homepage looks correct
	Scenario: We should see a download link
		Given I go to the homepage
		Then I should see "Download Hackety"
