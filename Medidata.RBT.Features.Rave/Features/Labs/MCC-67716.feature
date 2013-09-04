﻿@MCC-67716
Feature: MCC-67716 spSubjectCopy does not handle cases where units only labs have to be copied

Background: 
Given xml Lab Configuration "Lab_MCC-67716.xml" is uploaded
Given xml draft "MCC-67716.xml" is Uploaded with Environments
| Name |
| Dev  |
Given study "MCC-67716" is assigned to Site "Site 1" with study environment "Live: Prod"
Given study "MCC-67716" is assigned to Site "Site 2" with study environment "Aux: Dev"
Given I publish and push eCRF "MCC-67716.xml" to "Version 1"
Given I publish and push eCRF "MCC-67716.xml" to "Version 2"
Given Site "Site 1" is Units-Only-enabled
Given Site "Site 2" is Units-Only-enabled
Given role "SUPER ROLE 1" exists
Given following Project assignments exist
	| User         | Project   | Environment | Role         | Site   | SecurityRole          |
	| SUPER USER 1 | MCC-67716 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
	| SUPER USER 1 | MCC-67716 | Aux: Dev    | SUPER ROLE 1 | Site 2 | Project Admin Default |
Given following Report assignments exist
	| User         | Report                                          |
	| SUPER USER 1 | Script Utility - Script Utility (9)             |
	| SUPER USER 1 | Script Utility Manager - Script Utility Manager |
Given I install script utility script "SubjectCopyV56X.xml"
Given I login to Rave with user "SUPER USER 1"
Given I select Study "MCC-67716" and Site "Site 1"
Given I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(4)} |
Given I select link "Default Lab Folder"
Given I select link "Default Lab Demographics Form"
Given I enter data in CRF and save
	| Field      | Data        | Control Type |
	| Visit Date | 01 Jan 2013 | Datetime     |
	| AGE        | 26          | textbox      |
	| SEX        | Male        | dropdown     |
	| Pregnant   | No          | dropdown     |
Given I select link "Default Lab Form"
Given I select Lab "Units Only"
Given I enter data in CRF 
   	| Field       | Data | Control Type |
   	| WBC         | 12   | textbox      |
   	| Neutrophils | 20   | textbox      |
   	| Weight      | 50   | textbox      |
   	| Height      | 8    | textbox      |
Given I select Unit
	| Field       | Unit              | 
	| WBC         | *10E6/ulMCC-67716 | 
	| Neutrophils | FractionMCC-67716 | 
	| Weight      | LbsMCC-67716      | 
	| Height      | ftMCC-67716       | 
Given I save the CRF page
Given I take a screenshot

@Release_2013.4.0
@PB_MCC67716-001
@PS29.AUG.2013
@Draft
Scenario: PB_MCC67716-001 As a study builder, when I copy a subject that has units only labs to my dev studysite, I should see that the units only labs for the subject have been copied.
Given I login to Rave with user "SUPER USER 1"
And I open Script Utility for study "MCC-67716"
And I select link "Subject Copy"
And I choose "Site 1" from "Source"
And I choose "Site 2" from "Destination"
And I select option "SUB"
And I click button "Execute"
And I accept alert window
And I select "Live Update" checkbox
And I wait for 10 seconds
And I take a screenshot
And I navigate to "Home"
And I select Study "MCC-67716" with environment "Dev"
And I select a Subject "SUB{Var(num1)}"
And I select link "Default Lab Folder"
And I select link "Default Lab Form"
Then I verify lab "Units Only" is selected for the page
And I take a screenshot