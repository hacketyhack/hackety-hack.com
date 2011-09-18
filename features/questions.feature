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
    When I follow "My Question"
    Then I should see "My Question" within ".title"
    And I should see "Asked by test"
    
  Scenario: Edit an existing question
    Given I have created a question with title "My Title" and description "My Description"
    And I am on the questions index
    When I follow "My Title"
    And I follow "Edit" within "#sidebar"
    And I fill in the following:
      | Title | My Edited Question|
      | Description | My Edited Description|
    And I press "Ask Everyone"
    Then I should see "Question was successfully updated."
    And I should see "My Edited Question" within ".title"
    And I should see "My Edited Description" within ".description"
    
