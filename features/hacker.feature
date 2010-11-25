Feature: Hacker management
  Scenario: Unfollowing a Hacker
    Given I'm logged in as "steve"
    And there's a hacker with the username "fela"
    And the hacker "steve" is following the hacker "fela"
    When I go to the hacker page for "fela"
    And I follow "Unfollow fela"
    Then I should be on the hacker page for "steve"
    And I should see "No longer following fela."
    And I should see "Following: 0"
