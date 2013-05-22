@FT_MCC-46648

Feature: MCC-46648 As a TSDV user, multiple forms that share the same fieldOID for some of the fields, and check one field on one form to have TSDV in the custom tier configuration, it will only perform operations on that one shared fieldOIDs in different forms as selected.

Background:

	Given TSDV is enabled
	Given I perform cache flush of "Medidata.Core.Objects.Configuration"
	Given xml draft "MCC-46648.xml" is Uploaded with Environments
	| Name |
	| Prod |
	Given study "MCC-46648" is assigned to Site "Site 1" with study environment "Live: Prod"
	Given following Project assignments exist
	| User         | Project   | Environment | Role         | Site   | SecurityRole          |
	| SUPER USER 1 | MCC-46648 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
	Given I publish and push eCRF "MCC-46648.xml" to "Version 1"
	Given following Report assignments exist
	| User         | Report                                                  |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration |
	


@Release_2013.2.0
@PBMCC-46648-001
@SJ22.MAY.2013
@Validation	

Scenario: MCC46648-001 When fields with same OID are in use in multiple forms and excluded from one form, Field with same OID will still be seelcted for other forms.

	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-46648 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC46648 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan 
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 1" and description "Custom Tier 1" with table
		| Form               | Selected |
		| Form 1 (MX)        | True     |
		| Form 2 (SCENARIO1) | True     |
	And I take a screenshot
	And I select link "Create New Draft"
	And I select link "Custom Tier 1 (Draft)"
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form               | Field      | Selected |
		| Form 2 (SCENARIO1) | Standard 1 | False    |
	And I click the "Difference Report" button to download 
	Then I verify "Summary" spreadsheet data
		| Project   | Tier Name     | Summary          |
		| MCC-46648 | Custom Tier 1 | 1 Fields Deleted |
	And I select link "Selected Form and Fields"
	Then I verify Custom Tier Field
		| Form        | Field      | Selected |
		| Form 1 (MX) | Standard 1 | True     |
	And I take a screenshot
	Then I verify Custom Tier Field
		| Form               | Field      | Selected |
		| Form 2 (SCENARIO1) | Standard 1 | False    |
	And I take a screenshot



@Release_2013.2.0
@PBMCC-46648-002
@SJ22.MAY.2013
@Validation	


Scenario: MCC46648-002 When fields with same OID are in use in multiple forms and included in one form, Field with same OID will not be seelcted for other forms.



	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-46648 | Prod        |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC46648 Block Plan" with Data entry Role "SUPER ROLE 1"
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 2" and description "Custom Tier 2" with table
		| Form               | Selected |
		| Form 1 (MX)        | True     |
		| Form 2 (SCENARIO1) | True     |
	And I take a screenshot
	And I select link "Create New Draft"
	And I select link "Custom Tier 2 (Draft)"
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier and save 
		| Form               | Field      | Selected |
		| Form 1 (MX)        | Standard 1 | False    |
	And I select link "Create New Draft"
	And I select link "Custom Tier 2 (Draft)"
	And I select link "Selected Form and Fields"
	And I select fields in Custom Tier 
		| Form        | Field      | Selected |
		| Form 1 (MX) | Standard 1 | True     |
	And I click the "Difference Report" button to download 
	Then I verify "Summary" spreadsheet data
		| Project   | Tier Name     | Summary        |
		| MCC-46648 | Custom Tier 2 | 1 Fields Added |
	And I select link "Selected Form and Fields"
	Then I verify Custom Tier Field
		| Form        | Field      | Selected |
		| Form 1 (MX) | Standard 1 | True     |
	And I take a screenshot
	Then I verify Custom Tier Field
		| Form               | Field      | Selected |
		| Form 2 (SCENARIO1) | Standard 1 | True     |
	And I take a screenshot


