Feature: Pagination for different types of questions

	As a user of the site, I can view pages of different types of questions

	Scenario: View support questions
		Given support questions exist
		When I visit the support questions page
		Then I should see a link to the next page of support questions

	Scenario: View non-support questions
		Given questions exist
		When I visit the questions page
		Then I should see a link to the next page of questions
