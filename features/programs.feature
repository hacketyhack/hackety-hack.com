Feature: Programs
  Scenario: See programs on my page
    Given I'm logged in as "steve"
    And I have some programs
    When I go to the hacker page for "steve"
    Then I should see "Programs"
    And I should see links to my programs
