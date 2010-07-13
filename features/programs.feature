Feature: Programs
	Scenario: I can create new programs
		Given I'm logged in as "steve"
		When I go to the new program page
		And I fill in "Title" with "Hello world"
		And I fill in "Body" with "puts 'Hello, world!'"
		And I press "Create"
		Then I should be on the "steve/helloworld" program page.
		And I should see "Program created"
		And I should see "Hello world"
		And I should see "By steve"
		And I should see "puts"
