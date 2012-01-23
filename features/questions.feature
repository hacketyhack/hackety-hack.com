Feature: CRUD actions for question

  As a user of the site, I can perform standard CRUD actions on questions
  
  Scenario: Create a question
    When I create a new question
    Then I should be told the question was created
    And I should be able to see the new question
    And I should be able to see the question on my profile page

  Scenario: Update a question
    Given I am a user that has created a question
    When I edit that question
    Then I should be told the question was updated
    And I should see that the question was updated
