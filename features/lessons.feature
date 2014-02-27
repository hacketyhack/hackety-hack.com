Feature: Hackety Lessons

  As a user of the site, I can visit lessons page

  Scenario: View the lessons
    When I visit lessons path
    Then I should see the list of lessons

  Scenario: View specific lesson
    When I visit lessons path
    When I click on lesson's title
    Then I should see lesson content

