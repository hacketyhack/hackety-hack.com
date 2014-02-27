Feature: Hackety Blog

  As an admin, I can post to the hackety blog.
  
  Background:
    Given "Mac" user agent
    
  Scenario: Read the blog
    Given a blog post exists
    When I visit the blog
    Then I should see the title of that post
    And I should see the content of that post

  Scenario: Read a post
    Given a blog post exists
    When I visit a blog post
    Then I should see the title of that post
    And I should see the content of that post

  Scenario: Post to the blog
    Given I'm logged in as someone who can post to the blog
    When I visit the blog admin page
    And I fill out the new blog form
    And I press "Create Blog post"
    Then I should see that my post has been created
