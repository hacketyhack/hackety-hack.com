Feature: The Hackety Forum
  Scenario: Can't make replies when logged out
    Given I'm not logged in
    And there's a discussion named "I need help" in "learning_ruby" with a reply
    And I go to the forums
    And I follow "Learning Ruby"
    When I follow "I need help"
    Then I should not see "Reply"
  Scenario: Breadcrumbs
    Given there's a discussion
    When I go to the discussion
    Then I should see "Hackety Forums"
    Then I should see the discussion's forum name
