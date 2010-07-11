Feature: The Hackety Blog
	Scenario: I can see the blog
		Given there is a blog post with the title "First Post"
		When I go to the blog page
		Then I should see "First Post"
	Scenario: Admins may create a post
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
	Scenario: Not logged in users cannot create a post
		Given I'm not logged in
		And I go to the new post page
		Then I should see "Sorry, buddy"
	Scenario: Non-admin users cannot create a post
		Given I'm logged in
		And I go to the new post page
		Then I should see "Sorry, buddy"
	Scenario: Admins may edit a post
		Given I'm logged in as admin
		And there is a blog post with the title "First Post"
		And I go to the edit post page for the post with the title "First Post"
		And I fill in "Title" with "new title"
		And I fill in "Body" with "new body"
		When I press "Modify Post"
		Then I should see "Post Modified"
		And I am on the post page for the post with the title "new title"
		And I should see "new title"
		And I should see "new body"
		
