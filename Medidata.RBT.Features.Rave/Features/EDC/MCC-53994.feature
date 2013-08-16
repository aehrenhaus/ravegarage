@FT_MCC-53994



Feature: MCC-53994 Users with Entry/See Entry permissions to a form that is not a part of the Default Matrix are able to add a form using Add Events


Background:
	Given role "SUPER ROLE 1" exists
	Given role "MCC-53994_SUPERROLE" exists
	Given xml draft "MCC-53994.xml" is Uploaded
	Given study "MCC-53994" is assigned to Site "Site 1"
    Given following Project assignments exist
    | User         	| Project   | Environment | Role         		| Site   | SecurityRole          |
    | SUPER USER 1 	| MCC-53994 | Live: Prod  | SUPER ROLE 1 		| Site 1 | Project Admin Default | 
    | MCC-53994_USER| MCC-53994 | Live: Prod  | MCC-53994_SUPERROLE | Site 1 | Project Admin Default |
    Given I publish and push eCRF "MCC-53994.xml" to "Version 1"


@Release_2013.2.0
@PB_MCC-53994-001
@SJ22.MAY.2013
@Validation


Scenario: PBMCC-53994-001 Entry permissions to a form that is not a part of the Default Matrix are able to add a form using Add Events


	Given I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject initials | SUB               |
		| Subject Number   | {RndNum<num1>(3)} |
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	And I log out of Rave
	And I login to Rave with user "MCC-53994_USER"
	And I select a Subject "{Var(num1)}"
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I choose "MCC53994" from "Add Event"
   	And I click button "Add"
   	And I take a screenshot
	And I select link "EditChecks1 (2)"
   	And I select link "Form2"
    And I take a screenshot 


