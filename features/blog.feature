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
	Scenario: Not logged in users cannot edit a post
		Given I'm not logged in
		And there is a blog post with the title "First Post"
		And I go to the edit post page for the post with the title "First Post"
		Then I should see "Sorry, buddy"
	Scenario: Non-admin users cannot edit a post
		Given I'm logged in
		And there is a blog post with the title "First Post"
		And I go to the edit post page for the post with the title "First Post"
		Then I should see "Sorry, buddy"	
	Scenario: Logged in Users can comment on the blog
		Given I'm logged in as a user with the email "awesome@example.com"
		And there is a blog post
		When I go to a blog post page
		And I fill in "Speak your mind:" with "This post is amazing!"
		And I press "Submit comment"
		Then I should be on a blog post page
		And I should see "Thanks for your comment!"
		And I should see "awesome@example.com says:"
		And I should see "This post is amazing!"
	Scenario: Logged out users can't comment on the blog
		Given I'm not logged in 
		And there is a blog post
		When I go to a blog post page
		Then should not see "Speak your mind:"
		And I should not see "Submit comment"
	Scenario: Blog should use Markdown
		Given I'm logged in as admin
		And I go to the new post page
		When I fill in "Title" with "new title"
		And I fill in "Body" with "new body with a link: [google](http://google.com/)"
		And I press "Create Post"
		Then I should see "Post Created"
		And I should see "new title"
		And I should see "google" within "//a"
