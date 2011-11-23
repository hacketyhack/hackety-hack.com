Feature: Manage account
  
  As a user of this site, I can view and update my profile

  Background: The user is logged in
    Given a logged in user

  Scenario: View my profile
    When I go to look at my profile page
    Then it should have the right information
   
  Scenario: Edit my profile
    When I go to change my settings
    And fill in the following
      | About            | New users love editing their page |
      | Current password | foobar                            |
    And submit the form
    Then I should be notified that my profile was updated
    When I look at my page
    Then I should see my changes reflected
