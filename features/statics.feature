Feature: Detect user's platform and provide download link

  As a fresh Hackety user, I want to download software for my current OS

  Scenario: MacOS User
    Given "Mac" user agent
    Then I should be able to download "mac" software

  Scenario: Windows User
    Given "Windows" user agent
    Then I should be able to download "windows" software

  Scenario: Linux User
    Given "Linux" user agent
    Then I should be able to download "linux" software

  Scenario: Android User
    Given "android" user agent
    Then I should be able to download "android" software
