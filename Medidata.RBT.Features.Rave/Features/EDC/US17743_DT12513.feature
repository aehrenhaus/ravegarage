	# When a time of 12:00 PM is saved into a date time field with a format of dd MMM yyyy hh:nn rr, that data can be correctly viewed through the Clinical Views.

@ignore
Feature: US17743_DT12513
	A time of 12:00 PM can be saved into a date time field with a format of dd MMM yyyy hh:nn rr, and that data can be correctly viewed through the Clinical Views
	As a Rave user
	When I enter a time of 12:00 PM into a date time field
	Then I am able to correctly view the data in the Clinical Views

Background:
	Given xml draft "US17743_DT12513.xml" is Uploaded
	Given Site "Site 1" exists
	Given study "US17743_DT12513" is assigned to Site "Site 1" with study environment "Live: Prod"
	Given I publish and push eCRF "US17743_DT12513.xml" to "Version 1" with study environment "Prod"
	Given Clinical Views exist for project "US17743_DT12513"
	Given following Project assignments exist
	| User 		   | Project 		 | Environment| Role         | Site  | SecurityRole 		 |
	| SUPER USER 1 | US17743_DT12513 | Live: Prod | SUPER ROLE 1 | Site 1| Project Admin Default |
	Given following Report assignments exist
	| User			| Report								|
	| SUPER USER 1	| Data Listing - Data Listing Report	|


@release_564_2012.1.0				
@PB_US17743_DT12513_01
@Validation
Scenario: @PB_US17743_DT12513_01 As a Study Coordinator, when I enter a time of 12:00 PM, I am able to correctly view the data through the Clinical Views.
	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject number   | {RndNum<num1>(3)} |
	And I take a screenshot
	And I select link "Visit Date"
	And I enter data in CRF and save
	| Field      | Data                 |
	| Visit Date | 10 Jan 2012 12 00 PM |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I wait for Clinical View refresh to complete for project "US17743_DT12513"
	And I wait for 1 minute
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name            | Environment |
		| US17743_DT12513 | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "Visit Date (VIS)" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject			| DataPageName | VISDT					|
	| SUB{Var(num1)}	| Visit Date   | 1/10/2012 12:00:00 PM	|
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "US17743_DT12513" and Site "Site 1"
	And I select a Subject "SUB{Var(num1)}"
	And I select link "Visit Date"
	And column "c2_std" in Reporting Records propagates to "2012-01-10 12:00:00"


@release_564_2012.1.0				
@PB_US17743_DT12513_02
@Validation
Scenario: @PB_US17743_DT12513_02 As a Study Coordinator, when I change a time to 12:00 PM, I am able to correctly view the data through the Clinical Views.
	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject number   | {RndNum<num1>(3)} |
	And I take a screenshot
	And I select link "Visit Date"
	And I enter data in CRF and save
	| Field      | Data                 |
	| Visit Date | 20 Jan 2012 12 00 PM |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I wait for Clinical View refresh to complete for project "US17743_DT12513"
	And I wait for 1 minute
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name            | Environment |
		| US17743_DT12513 | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "Visit Date (VIS)" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject			| DataPageName | VISDT					|
	| SUB{Var(num1)}	| Visit Date   | 1/20/2012 12:00:00 PM	|
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "US17743_DT12513" and Site "Site 1"
	And I select a Subject "SUB{Var(num1)}"
	And I select link "Visit Date"
	And I enter data in CRF and save
	| Field      | Data                 |
	| Visit Date | 20 Jan 2012 12 00 AM |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I wait for Clinical View refresh to complete for project "US17743_DT12513"
	And I wait for 1 minute
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name            | Environment |
		| US17743_DT12513 | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "Visit Date (VIS)" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject			| DataPageName | VISDT					|
	| SUB{Var(num1)}	| Visit Date   | 1/20/2012 12:00:00 AM	|
	And I switch to "Reports" window
	And I navigate to "Home"
	And I select Study "US17743_DT12513" and Site "Site 1"
	And I select a Subject "SUB{Var(num1)}"
	And I select link "Visit Date"
	And column "c2_std" in Reporting Records propagates to "2012-01-20 00:00:00"