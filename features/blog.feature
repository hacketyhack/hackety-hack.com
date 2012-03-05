Feature: Hackety Blog

  As an admin, I can post to the hackety blog.

  Scenario: Read the blog
    Given a blog post exists
    When I visit the blog
    Then I should see the content of that post
    And I should see the title of that post
