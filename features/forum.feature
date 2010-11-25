Feature: The Hackety Forum
  Scenario: View replies to a discussion
    Given I'm logged in
    And there's a discussion named "I need help" in "learning_ruby" with a reply
    When I go to the discussion "i_need_help" in "learning_ruby"
    Then I should see "I need help"
    And I should see "I'm here to help!"
  Scenario: Make a new reply
    Given I'm logged in as "steve"
    And there's a discussion named "I need help" in "learning_ruby" with a reply
    And I go to the forums
    And I follow "Learning Ruby"
    And I follow "I need help"
    When I follow "Reply"
    And I fill in "Body" with "I'll help you!"
    And I press "Create Reply"
    Then I should be on the discussion "i_need_help" in "learning_ruby" 
    And I should see "Replied!"
    And I should see "I'll help you"
    And I should see "steve says:"
  Scenario: Make a new discussion
    Given I'm logged in as "some_hacker"
    And I go to the forums
    And I follow "Learning Ruby"
    When I follow "New Discussion"
    And I fill in "Title" with "HALP!"
    And I fill in "Body" with "I'm really unsure as to how to do something."
    And I press "Submit"
    Then I should be on the discussion "halp" in "learning_ruby"
    And I should see "Discussion created!"
    And I should see "HALP!"
    And I should see "By some_hacker"
  Scenario: Can't make discussions when logged out
    Given I'm not logged in
    And I go to the forums
    When I follow "Learning Ruby"
    Then I should not see "New Discussion"
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
