Feature: Moderate questions

  As a moderator, I should be able to delete questions from the site.

  Background:
    Given there is a question from someone else

  Scenario: Delete a question
    Given I am a moderator
    Then I can delete that question

  Scenario: Normal users cannot moderate
    Given I am not a moderator
    Then I cannot delete that question

