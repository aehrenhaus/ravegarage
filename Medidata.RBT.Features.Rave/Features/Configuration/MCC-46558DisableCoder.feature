@FT_MCC-46558DisableCoder
@ignore

Feature: MCC-46558 Rave Architect Coder Configuration Security Issue

Background:
#Replacing “Settings.aspx” with “Coderconfiguration.aspx” on a URL where Coder is not enabled will show an error message. 



@Release_2013.1.0
@PB_MCC-46558DisableCoder_01
@SJ15.FEB.2013
@Validation
Scenario: PB_MCC-46558DisableCoder_01 Coder Configuration page cannot be accessed on a URL, where Coder is not enabled.


	Given I login to Rave with user "defuser"
	And I navigate to "Configuration"	
	And I navigate to "Other Settings"
	And I verify link "Coder Configuration" does not exist
	And I take a screenshot
	And I replace current page with "CoderConfiguration.aspx" and append following copied fields to query string
		| Data |
		|      |	
	Then I verify text "Coder is not enabled on this URL, this page is not accessible" exists
	And I take a screenshot