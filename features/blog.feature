Feature: The Hackety Blog
	Scenario: I can see the blog
		Given there is a blog post with the title "First Post"
		When I go to the blog page
		Then I should see "First Post"
	Scenario: I can create a post
		Given I'm logged in as admin
		And I go to the new post page
		When I fill in "Title" with "new title"
		And I fill in "Body" with "new body"
		And I press "Create Post"
		Then I should see "Post Created"
		And I should see "new title"
		And I should see "new body"
	Scenario: I can view all posts
		Given there is a blog post with the title "First Post"
		And there is a blog post with the title "Second Post"
		When I go to the posts page
		Then I should see "First Post"
		And I should see "Second Post"
