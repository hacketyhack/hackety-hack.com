Feature: CRUD actions for answers

  As a user of the site, I can perform standard CRUD actions on answers

  Scenario: Create an answer
    Given a question exists
    And I answer that question
    Then I should be notified that my answer was submitted
    And I should be able to see my answer
  
  Scenario: Accept an answer
