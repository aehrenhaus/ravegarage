@FT_MCC-46640

Feature: MCC-46640 As a TSDV user, Study Designer is unable to update a draft tier with new fields. 
		When modifying the plan, the added field is automatically de-selected when attempting to save.

Background:

	Given TSDV is enabled
	Given I perform cache flush of "Medidata.Core.Objects.Configuration"
	Given xml draft "MCC-46640A.xml" is Uploaded with Environments
		| Name |
		| Prod |
	Given study "MCC-46640" is assigned to Site "Site 1" with study environment "Live: Prod"
	Given following Project assignments exist
	| User         | Project   | Environment | Role         | Site   | SecurityRole          |
	| SUPER USER 1 | MCC-46640 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
	Given I publish and push eCRF "MCC-46640A.xml" to "Version 1"
	Given following Report assignments exist
	| User         | Report                                                  |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration |
	


@Release_2013.2.0
@PBMCC-46640-001
@SJ22.APR.2013
@Validation

Scenario: MCC46640-001 When a draft tier with a new field is added, the newely added field is added to TSDV Block plan. 

	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-46640 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC46640 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 1             |  
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 1" and description "Custom Tier 1" with table
		| Form           | Selected |
		| MCC (SCENARIO1)| True     |
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I navigate to "Architect"
	And xml draft "MCC-46640B.xml" is Uploaded without redirecting
	And I verify text "Save successful" exists
	And I take a screenshot
	And I login to Rave with user "SUPER USER 1"
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-46640 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I select link "Tiers"
	And I select link "Create New Draft"
	And I select link "Custom Tier 1 (Draft)"
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier and save
		| Form            | Field  | Selected |
		| MCC (SCENARIO1) | NEWFLD | True     |
    And I select link "Custom Tier 1" 
	And I select link "Selected Form and Fields"
	And I verify Custom Tier Field
		| Form            | Field  | Selected |
		| MCC (SCENARIO1) | NEWFLD | True     |
	And I take a screenshot
	


