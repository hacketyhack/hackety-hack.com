Feature: Manage account

	As a user of this site, I can view and update my profile
	
	Background: I am logged into the site
	  Given I am a user with username "newbie" and password "password"
    And I sign in as "newbie/password"
    And I follow "newbie" within ".topbar"
    
	Scenario: View my profile
    I should see "newbie's page"
    And I should see "About newbie"
    
  Scenario: Edit my profile
    When I follow "Change My Settings"
    And I fill in the following:
      | About | Newbie likes to edit his profile|
      | Current password|password|
    And I press "Update"
    Then I should see "You updated your account successfully"
    When I follow "newbie" within ".topbar"
    Then I should see "Newbie likes to edit his profile"
    