@MCC-65923
@ignore

Feature: MCC-65923 User who previously had their cookies disabled and got an error on login page, cannot log in to the existing session once they have enabled cookies.


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
And the error is displayed "In order to log in, cookies should be allowed by your browser. Click the Help icon for more information."
And I take a screenshot
And I enable cookies
And I reload login page
And the error is not displayed "In order to log in, cookies should be allowed by your browser. Click the Help icon for more information."
And I take a screenshot
And I enter "defuser" in field User Name 
And I enter "password" in field Password
When I click "Enter" button
Then I should see the Rave home page
And I take a screenshot


@Release_2013.2.0
@PBMCC65923-002
@VY12.JUN.2013
@Manual
@Validation
Scenario: MCC65923-002 Verify that a user gets an error message if they open the login page than disable cookies and try to log in

Given I open my browser
And I open the Rave login page
And I take a screenshot
And I disable cookies
And I enter "defuser" in field User Name 
And I enter "password" in field Password
When I click "Enter" button
Then I should see the Rave login page with error message "In order to log in, cookies should be allowed by your browser. Click the Help icon for more information." displayed
And I take a screenshot