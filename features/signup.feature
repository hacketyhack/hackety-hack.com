Feature: Sign up for an account

  As a new Hackety user, I want to create a new account and log in with it
  
  Background:
    Given "Mac" user agent

  Scenario: Create an account via the signup form
    When I register a new account
    Then I should be logged in with my new account

  Scenario: Try to sign up using existing user name
    When I register a duplicate account
    Then I should see validation errors
