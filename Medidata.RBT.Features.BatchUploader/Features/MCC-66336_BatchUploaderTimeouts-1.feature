Feature: Batch Uploader User Interface (BU UI) Timeouts
As a user of the BU UI
I want the UI to timeout out my session after a configurable amount of time
So that if I am away from my computer for a prolonger period of time 
And I have forgotten to log out of my BU UI session
Then the system will log me out automatically
And no one else will be able to come up to my computer and use BU under my credentials.

***************************************************************************************************

OVERVIEW:
In the most recent version of the Batch Uploader's Requirements Specification, for BU 3.0,
there is a requirement (3.2.1.11) that mentions timeouts, as follows:


"3.2.1.11 The BU UI session will time out if the session is inactive for a period of time exceeding 
the time specified in Rave Core Configuration -> Other Settings -> Password Timeout"


For reference, here is the RS:
https://docushare.mdsol.com/docushare/dsweb/Get/prod_doc-1702/Batch%20Uploader%20v3.0%20Requirement%20Specification%203.0.doc

The document consistently refers to this timeout as being a PASSWORD timeout, and the corresponding
regression script was written with a step assuming that Rave's password timeout will be honored by
the BU UI. 

However, in developing version 3.1.1.1 of the Batch Uploader, we discovered that the BU UI does NOT,
in fact, honor the Rave password timeout. It does, however, honor Rave's INTERACTION timeout.

Rather than revise the aforementioned RS for the BU, which is over four years old at this point,
we decided to write this feature file instead. The feature file will refer to the interaction timeout,
and NOT the password timeout.

Background:

	 Given I am an Rave user "<Rave User>" with username "<Rave User Name>", password "<Rave Password>"
		|Rave User		|Rave User Name		|Rave Password		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|
		
	And there exist "<Rave URL>" 
		|Rave URL		|
		|{Rave URL 1}	|		

Note: The Batch Uploader session will time out after 5 minutes if the Interaction Timeout is set to < 1 minutes or = 0. This is the default behavior if the Interaction Timeout is not set in Rave Configuration Settings. 

***************************************************************************************************


@Scenario MCC66336-01
@Validation
Scenario Outline:  As a Rave user with access to the Configuration Module, I want to set the Interaction Timeout to 1 minute and verify in BU UI that the session times out in 1 minute.

Given I am a Rave user "<Rave User 1>"
And I log in to Rave
And I select the Configuration Module link
And I select Other Settings
And I set the Interaction Timeout to 1 minute "1"
And I check the checkbox next to Interaction Timeout
And I clear the Password Timeout field
And I uncheck the Password Timeout checkbox
And I click the Update link to save changes
And I take a screenshot
And I log out of Rave.
And I login to BU UI
When I do not perform any action for 1 minute
Then the session should time out
And the Batch Uploader login page is displayed
And I should see the message "Session Timed Out"
And I take a screenshot


@Scenario MCC66336-02
@Validation
Scenario Outline:  As a Rave user with access to the Configuration Module, I want to set the Interaction Timeout to 3 minutes and verify in BU UI that the session times out in 3 minutes.

Given I am a Rave user "<Rave User 1>"
And I log in to Rave
And I select the Configuration Module link
And I select Other Settings
And I set the Interaction Timeout to 3 minutes "3"
And I check the checkbox next to Interaction Timeout
And I clear the Password Timeout field
And I uncheck the Password Timeout checkbox
And I click the Update link to save changes
And I take a screenshot
And I log out of Rave.
And I login to BU UI
When I do not perform any action for 3 minutes
Then the session should time out
And the Batch Uploader login page is displayed
And I should see the message "Session Timed Out"
And I take a screenshot


@Scenario MCC66336-03
@Validation
Scenario Outline:  As a Rave user with access to the Configuration Module, I want to set the Interaction Timeout to 5 minutes and verify in BU UI that the session times out in 5 minutes.

Given I am a Rave user "<Rave User 1>"
And I log in to Rave
And I select the Configuration Module link
And I select Other Settings
And I set the Interaction Timeout to 5 minutes "5"
And I check the checkbox next to Interaction Timeout
And I clear the Password Timeout field
And I uncheck the Password Timeout checkbox
And I click the Update link to save changes
And I take a screenshot
And I log out of Rave.
And I login to BU UI
When I do not perform any action for 5 minutes
Then the session should time out
And the Batch Uploader login page is displayed
And I should see the message "Session Timed Out"
And I take a screenshot


@Scenario MCC66336-04
@Validation
Scenario Outline:  As a Rave user with access to the Configuration Module, I want to set the Interaction Timeout to 6 minutes and verify in BU UI that the session times out in 6 minutes.

Given I am a Rave user "<Rave User 1>"
And I log in to Rave
And I select the Configuration Module link
And I select Other Settings
And I set the Interaction Timeout to 6 minute "6"
And I check the checkbox next to Interaction Timeout
And I click the Update link to save changes
And I take a screenshot
And I log out of Rave.
And I login to BU UI
When I do not perform any action for 6 minute
Then the session should time out
And the Batch Uploader login page is displayed
And I should see the message "Session Timed Out"
And I take a screenshot


@Scenario MCC66336-05
@Validation
Scenario Outline:  As a Rave user with access to the Configuration Module, I want to set the Interaction Timeout to 7 minutes and verify in BU UI that the session times out in 7 minutes.

Given I am a Rave user "<Rave User 1>"
And I log in to Rave
And I select the Configuration Module link
And I select Other Settings
And I set the Interaction Timeout to 7 minutes "7"
And I check the checkbox next to Interaction Timeout
And I clear the Password Timeout field
And I uncheck the Password Timeout checkbox
And I click the Update link to save changes
And I take a screenshot
And I log out of Rave.
And I login to BU UI
When I do not perform any action for 7 minutes
Then the session should time out
And the Batch Uploader login page is displayed
And I should see the message "Session Timed Out"
And I take a screenshot


@Scenario MCC66336-06
@Validation
Scenario Outline:  As a Rave user with access to the Configuration Module, I want to clear the Interaction Timeout field and checkbox and verify in BU UI that the session times out in 5 minute.

Given I am a Rave user "<Rave User 1>"
And I log in to Rave
And I select the Configuration Module link
And I select Other Settings
And I clear the Interaction Timeout field
And I uncheck the checkbox next to Interaction Timeout
And I clear the Password Timeout field
And I uncheck the Password Timeout checkbox
And I click the Update link to save changes
And I take a screenshot
And I log out of Rave.
And I login to BU UI
When I do not perform any action for 5 minutes
Then the session should time out
And the Batch Uploader login page is displayed
And I should see the message "Session Timed Out"
And I take a screenshot


@Scenario MCC66336-07
@Validation
Scenario Outline:  As a Rave user with access to the Configuration Module, I want to clear the Interaction Timeout field and check the checkbox and verify that a message is displayed "Value entered is invalid"

Given I am a Rave user "<Rave User 1>"
And I log in to Rave
And I select the Configuration Module link
And I select Other Settings
And I clear the Interaction Timeout field
And I check the checkbox next to Interaction Timeout
And I clear the Password Timeout field
And I uncheck the Password Timeout checkbox
When I click the Update link to save changes
Then I should see the following message displayed "Value entered is invalid"
And I take a screenshot


@Scenario MCC66336-08
@Validation
Scenario Outline:  As a Rave user with access to the Configuration Module, I want to set the Interaction Timeout to 1 minute and uncheck the checkbox next to Interaction Timeout and verify that my changes where not saved.

Given I am a Rave user "<Rave User 1>"
And I log in to Rave
And I select the Configuration Module link
And I select Other Settings
And I set the Interaction Timeout to 1 minute "1"
And I uncheck the checkbox next to Interaction Timeout
And I clear the Password Timeout field
And I uncheck the Password Timeout checkbox
When I click the Update link to save changes
Then I should see the Interaction Timeout field is blank
And I should see that my changes were not saved
And I take a screenshot








