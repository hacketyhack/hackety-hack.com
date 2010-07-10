Feature: The Hackety Blog
	Scenario: I can see the blog
		Given there is a blog post with the title "First Post"
		When I go to the blog page
		Then I should see "First Post"
