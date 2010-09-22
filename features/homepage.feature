Feature: Homepage looks correct
  Scenario: We should see a download link
    Given I go to the homepage
    Then I should see "Click the Shoes logo"
  Scenario: We should be able to get help
    Given I go to the homepage
    When I follow "Help"
    Then I should be on the help page
