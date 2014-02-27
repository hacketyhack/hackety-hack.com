Feature: Manage account

  As a user of this site, I can view and update my profile, see my followers

  Background:
    Given "Mac" user agent
    And a logged in user

  Scenario: View my profile
    When I go to look at my profile page
    Then it should have the right information

  Scenario: Edit my profile
    When I edit my profile
    Then I should be notified that my profile was updated
    And I should see my changes reflected on my profile page

  Scenario: See my followers
    When I have a follower
    And I click on the number of followers on my profile
    Then I should see my follower

  Scenario: See who I am following
    When I am following someone
    And I click on the number of people I am following on my profile
    Then I should see someone I'm following

