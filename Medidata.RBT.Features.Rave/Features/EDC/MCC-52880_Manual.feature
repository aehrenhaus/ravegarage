@ignore
@FT_MCC-52880_Manual


Feature: MCC-52880 When a rave user enters an incorrect username/password, "Incorrect Username and/or Password" message will show without causing the page hangs with no response.

Background:

URL has large User Groups (around 20) and each User Group has around thousand users. 
Email server is active and verify user has correct email address assigned under My Profile and User Administration Module. 
Number Failed Logon Attempts is checked and value set to "1"
Send Failed Login Alert is checked



@Release_2013.2.0
@PB_MCC-52880_01
@SJ29.MAR.2013
@Validation

Scenario: PB_MCC-52880_01 Incorrect Username and/or Password message exists when rave user enters an incorrect username.

When I login to Rave with user "Error" and password "password"
And I verify text "Incorrect Username and/or Password" exists
And I login to Rave with user "Error" and password "password"
Then I verify text "Incorrect Username and/or Password" exists
And I take a screenshot
Then I verify email notification is sent to appropriate email account  
And I take a screenshot

@Release_2013.2.0
@PB_MCC-52880_02
@SJ29.MAR.2013
@Validation

Scenario: PB_MCC-52880_02 Incorrect Username and/or Password message exists when rave user enters an incorrect Username and password.


When I login to Rave with user "SUPER USER 1 error" and password "Error"
And I verify text "Incorrect Username and/or Password" exists
And I login to Rave with user "SUPER USER 1 error" and password "Error"
Then I verify text "Incorrect Username and/or Password" exists
And I take a screenshot
Then I verify email notification is sent to appropriate email account 
And I take a screenshot
