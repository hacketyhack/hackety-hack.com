Feature: CRUD actions for question

  As a user of the site, I can perform standard CRUD actions on questions
  
  Background: I am logged into the site
    Given I am a user with username "test" and password "password"
    And I sign in as "test/password"
    And I am on the questions index
  
  Scenario: Create a question
    When I follow "Ask a Question"
    And I fill in the following:
      | Title | My Question |
      | Description | My Description |
    And I press "Ask Everyone"
    Then I should see "Question Asked!"
    When I follow "Show" within "table"
    Then I should see "My Question" within ".title"
    And I should see "Created by test"
    
  Scenario: Edit an existing question
    Given I have created a question