Feature: CRUD actions for answers

  As a user of the site, I can perform standard CRUD actions on answers
  
  Scenario: Create an answer
    And a question exists
    And I answer that question
    Then I should be notified that my answer was submitted
    And an email should be sent to the author
    And I should be able to see my answer
    And my answer should show on my profile page

  Scenario: Edit an answer
    And a question exists
    And I answer that question
    When I edit that answer
    Then I should see the updated answer

