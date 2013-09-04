@MCC-69527
Feature: MCC-69527 Dynamic Search List + CF not working correctly in Rave 2013.1.0

Background:
Given role "SUPER ROLE 1" exists
Given xml draft "MCC-69527.xml" is Uploaded
Given study "MCC-69527" is assigned to Site "Site 1"
Given I publish and push eCRF "MCC-69527.xml" to "Version 1"
Given following Project assignments exist
	| User         | Project   | Environment | Role         | Site   | SecurityRole          |
	| SUPER USER 1 | MCC-69527 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
Given I login to Rave with user "SUPER USER 1"
Given I select Study "MCC-69527" and Site "Site 1"
Given I create a Subject
	| Field            | Data              |
	| Subject ID	   | {RndNum<num1>(3)} |
	| Subject Initials | SUB			   |
Given I select link "Adverse Event"
Given I enter data in CRF and save
	| Field      | Data        | Control Type |
	| AE Term	 | AE Term 001 | textbox      |
	| Start Date | 01 Jul 2013 | Datetime     |
	| End Date   | 02 Jul 2013 | Datetime     |
And I add a new log line
And I enter data in CRF and save
	| Field      | Data        | Control Type |
	| AE Term	 | AE Term 002 | textbox      |
	| Start Date | 01 Jul 2013 | Datetime     |
	| End Date   | 02 Jul 2013 | Datetime     |

@Release_2013.4.0
@PB_MCC69527-001
@PS02.SEP.2013
@Draft
Scenario: PB_MCC69527-001 As a Rave User, If I blank out a dynamic searchlist field on a portrait log form, then I should see it's dependent field blanked out if there is one.
Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-69527" and Site "Site 1"
And I select a Subject "{Var(num1)}"
And I select link "Form B (Log)"
And I enter "001 > 01 Jul 2013 > AE Term 001" on dynamic search list "AE log line, start date, and term"
And I save the CRF page
And I add a new log line
And I enter "002 > 01 Jul 2013 > AE Term 002" on dynamic search list "AE log line, start date, and term"
And I save the CRF page
And I take a screenshot
And I open log line 1
And I start editing page
And I clear dynamic search list "AE log line, start date, and term"
And I take a screenshot
And I save the CRF page
When I open log line 1
Then I verify data on Fields in CRF
	| Field                             | Data |
	| AE log line, start date, and term |      |
	| AE log number                     |      |
And I take a screenshot

@Release_2013.4.0
@PB_MCC69527-002
@PS02.SEP.2013
@Draft
Scenario: PB_MCC69527-002 As a Rave User, If I blank out a dynamic searchlist field on a standard form, then I should see it's dependent field be updated to be consistent with the change.
Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-69527" and Site "Site 1"
And I select a Subject "{Var(num1)}"
And I select link "Form A (Standard)"
And I enter "001 > 01 Jul 2013 > AE Term 001" on dynamic search list "AE log line, start date, and term"
And I save the CRF page
And I take a screenshot
And I start editing page
And I clear dynamic search list "AE log line, start date, and term"
And I take a screenshot
And I save the CRF page
Then I verify data on Fields in CRF
	| Field                             | Data |
	| AE log line, start date, and term |      |
	| AE log number                     |      |
And I take a screenshot

Scenario: PB_MCC69527-003 As a Rave User, If I blank out a dynamic searchlist field on a landscape log form, then I should see it's dependent field be updated to be consistent with the change.
Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-69527" and Site "Site 1"
And I select a Subject "{Var(num1)}"
And I select link "Form C (Landscape)"
And I enter "001 > 01 Jul 2013 > AE Term 001" on dynamic search list "AE log line, start date, and term"
And I save the CRF page
And I take a screenshot
And I start editing page
And I clear dynamic search list "AE log line, start date, and term"
And I take a screenshot
And I save the CRF page
Then I verify data on Fields in CRF
	| Field                             | Data |
	| AE log line, start date, and term |      |
	| AE log number                     |      |
And I take a screenshot

Scenario: PB_MCC69527-004 As a Rave User, If I blank out a dynamic searchlist field on a mixed landscape log form, then I should see it's dependent field be updated to be consistent with the change.
Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-69527" and Site "Site 1"
And I select a Subject "{Var(num1)}"
And I select link "Form D (Mixed)"
And I enter "001 > 01 Jul 2013 > AE Term 001" on dynamic search list "AE log line, start date, and term"
And I save the CRF page
And I take a screenshot
And I start editing page
And I clear dynamic search list "AE log line, start date, and term"
And I take a screenshot
And I save the CRF page
Then I verify data on Fields in CRF
	| Field                             | Data |
	| AE log line, start date, and term |      |
	| AE log number                     |      |
And I take a screenshot