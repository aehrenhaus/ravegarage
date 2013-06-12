@MCC-65923
@ignore

Feature: MCC-65923 User who previously had their cookies disabled and got the error on login page, cannot log in to the existing session once they have enabled cookies.


@Release_2013.2.0
@PBMCC65923-001
@VY12.JUN.2013
@Manual
@Validation
Scenario: MCC65923-001 Verify that a user is able to log in to the existing session once they have enabled cookies

Given I open my browser
And I disable cookies
And I delete all existing cookies
And I restart my browser
And I open the Rave login page
And the error is displayed "In orded to log in, cookies should be allowed by your browser. Click the Help icon for more information."
And I take a screenshot
And I enable cookies
And I reload login page
And the error is not displayed "In orded to log in, cookies should be allowed by your browser. Click the Help icon for more information."
And I take a screenshot
And I enter "defuser" in field User Name 
And I enter "password" in field Password
When I click "Enter" button
Then I should see the Rave home page
And I take a screenshot
