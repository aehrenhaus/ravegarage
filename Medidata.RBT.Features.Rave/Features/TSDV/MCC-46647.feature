@FT_MCC-46647

Feature: MCC-46647 As a TSDV user, If a Block Subject Count is changed after subjects are entered in a DEV, UAT, AUX or any non Prod Environment, changes should be effected and new subject should be assigned per updated block count


Background:

	Given TSDV is enabled
	Given I perform cache flush of "Medidata.Core.Objects.Configuration"
	Given xml draft "MCC-46647.xml" is Uploaded with Environments
	| Name |
	| Dev  |
	Given study "MCC-46647" is assigned to Site "Site 1" with study environment "Aux: Dev"
	Given following Project assignments exist
	| User         | Project   | Environment | Role         | Site   | SecurityRole         |
	| SUPER USER 1 | MCC-46647 | Aux: Dev    | SUPER ROLE 1 | Site 1 | Project Admin Default|
	Given I publish and push eCRF "MCC-46647.xml" to "Version 1" with study environment "Dev"
	Given following Report assignments exist
	| User         | Report                                                  		 |
	| SUPER USER 1 | Targeted SDV Configuration - Targeted SDV Configuration 		 |
	| SUPER USER 1 | Targeted SDV Subject Management - Targeted SDV Subject Managemen|



@Release_2013.2.0
@PB_MCC-46647-001
@SJ15.MAY.2013
@Validation

Scenario: MCC46647-001 Block Subject Count changes can be made to non-Production environments, and new subjects are assigned to Blocks/Tiers per the new Subject Counts.

	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-46647 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I create a new block plan named "MCC46647 (Dev) Block Plan 1" with Data entry Role "SUPER ROLE 1"
	And I delete the tier "Architect Defined" from plan
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 4             |
	And I select link "Tiers"
	And I create a custom tier named "Custom Tier 1" and description "Form 1 (MX)" with table
		| Form           | Selected |
		| Form 1 (MX)    | True     |
	And I select link "Study Block Plan"
	And I select the tier "All Forms" and Subject Count "4"
	And I create a new block and save
		| Name         | Subject Count | Repeated |
		| Block Plan 1 | 2             | False    |
	And I select the tier "Custom Tier 1" and Subject Count "2" for "Block Plan 1"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(4)} |
	And I take a screenshot
	And I navigate to "Home"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num2>(4)} |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-46647 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	Then I verify that Tiers in subject override table are in the following order
		| Subject       | Current Tier  		  | 
		| SUB{Var(num1)}| All Forms (Default Tier)| 
		| SUB{Var(num2)}| All Forms (Default Tier)|  
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Configuration"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-46647 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Study Plan" window
	And I inactivate the plan
	And I edit Blocks 
		| Name              | Subject Count |
		| Architect Defined | 2             |
	And I update the tier "All Forms" and Subject Count "2" for "Architect Defined"
	And I activate the plan
	And I take a screenshot
	And I switch to "Reports" window
	And I navigate to "Home"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num3>(4)} |
	And I take a screenshot
	And I navigate to "Home"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num4>(4)} |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Targeted SDV Subject Management"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-46647 | Dev         |
	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window 
	Then I verify that Tiers in subject override table are in the following order
		| Subject       | Current Tier            	  | 
		| SUB{Var(num1)}| All Forms (Default Tier)	  | 
		| SUB{Var(num2)}| All Forms (Default Tier)	  |
		| SUB{Var(num3)}| Custom Tier 1 (Custom Tier) | 
		| SUB{Var(num4)}| Custom Tier 1 (Custom Tier) | 
	And I take a screenshot

