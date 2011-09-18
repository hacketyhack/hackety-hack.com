Feature: CRUD actions for question

  As a user of the site, I can perform standard CRUD actions on questions
  
  Background: I am logged into the site and questions exist
    Given there are existing questions
    And I am a user with username "test" and password "password"
    And I sign in as "test/password"
    And I am on the questions index
    And show me the page
    And I follow "Title"
  
  Scenario: Create an answer
    When I fill in the following:
      | Answer | My Answer |
    And I press "Post Answer"
    Then I should see "Answer Posted!"
    And I should see "test says" within ".answer"
    And I should see "My Answer" within ".answers"


  Scenario: Select an answer
    Given I have created a question with title "My Title" and description "My Description"
    And that someone has provided "Some solution" as an answer for my question
    And I am on the questions index
    And I follow "My Title"
    And I press "This answers my question!"
    Then I should see "Okay! We've selected that answer"
    And I should see "Some solution" within ".selected-answer"

    
