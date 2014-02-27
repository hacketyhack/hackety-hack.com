Feature: Access Programs

  As a user of the site, I want to access users' programs
  
  Scenario: View a featured program
    Given there is a featured program
    Then I should be able to view a highlighted program

  Scenario: View my programs
    Given a logged in user
    And I have uploaded a program
    Then I should be able to view my programs

  Scenario: View another user's programs
    Given a user has uploaded a program
    Then I should be able to view their programs

  Scenario: View an individual program
    Given a user has uploaded a program
    And I should be able to view their programs
    When I click the first program link
    Then I should see the program source

  Scenario: View a program with a description
    Given a user has uploaded a program
    And they have given their program a description
    And I should be able to view their programs
    When I click the first program link
    Then I should see the description of their program
