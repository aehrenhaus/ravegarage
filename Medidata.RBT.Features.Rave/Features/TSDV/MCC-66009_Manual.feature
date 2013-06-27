@FT_MCC-66009_Manual 
@ignore

Feature: MCC-66009_Manual As a TSDV user when “All Folders” in a customer tier is deselected and click on cancel button during publishing a tier does not populate Difference Report. 


Background:

	Given TSDV is enabled
	Given I perform cache flush of "Medidata.Core.Objects.Configuration"
	Given xml draft "MCC-66009.xml" is Uploaded
	Given study "MCC-66009" is assigned to Site "Site 1"
	Given role "SUPER ROLE 1" exists
	Given following Project assignments exist
	| User         | Project   | Environment | Role         | Site   | SecurityRole          |
	| SUPER USER 1 | MCC-66009 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
	Given I publish and push eCRF "MCC-66009.xml" to "Version 1"
	Given following Report assignments exist
	| User         | Report                                                  |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration |
	
	


@release_2013.2.0 
@PB_MCC-66009_01
@SJ26.JUN.2013
@Validation
Scenario: PB_MCC-66009_01 when “All Folders” in a customer tier is deselected and click on cancel button during publishing a tier does not populate Difference Report. 


	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name     | Environment |
		| MCC-66009 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC-66009 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 1" and description "Custom Tier 1" with table
		| Form               | Selected |
		| Form 1 (MX)        | True     |
		| Form 2 (SCENARIO1) | True     |
	And I select link "Create New Draft"
	And I select link "Custom Tier 1 (Draft)"
	And I select link "Select Folders"
	And I select Check box and save
		|All  | Form | [SUBJECT]|
		|False|      |          |
	And I click button "Save Folders"
	When I click the "Difference Report" button to download 
	And I click button "Cancel"
	And I click button "Publish Draft"
	And I click button "Cancel"
	And I click button "Publish Draft"
	And I click button "Cancel"
	Then I verify button "Publish Draft" is active
	And I take a screenshot