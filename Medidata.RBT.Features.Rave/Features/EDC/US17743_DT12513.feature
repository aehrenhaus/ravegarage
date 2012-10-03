# When a time of 12:00 PM is saved into a date time field with a format of dd MMM yyyy hh:nn rr, that data can be correctly viewed through the Clinical Views.

Feature: US17743_DT12513
	A time of 12:00 PM can be saved into a date time field with a format of dd MMM yyyy hh:nn rr, and that data can be correctly viewed through the Clinical Views
	As a Rave user
	When I enter a time of 12:00 PM into a date time field
	Then I am able to correctly view the data in the Clinical Views

Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	#And the following Project assignments exist
	#	| User    | Project			   | Environment | Role |Site  |Site Number|
	#	| defuser | US17743_DT12513_SJ | Prod        | cdm1 |Site 1|S100	   |
	#And Role "cdm1" has Action "Entry"
	#And Project "US17743_DT12513_SJ" has Draft1
	#And Draft "Draft 1" has Form "Visit Date" with fields
	#	| Field OID | Data Format		   | Control Type | Field Label       | Log data entry |
	#	| MISSING   | 1					   | CheckBox     | Visit is missing? | False          |
	#	| VISDT		| dd MMM yyyy hh:nn rr | DateTime     | Visit Date        | False          |
	#	| AGE       | 3                    | Text         | Age               | False          |



@release_564_2012.1.0				
@PB_US17743_DT12513_01
@Draft
Scenario: @PB_US17743_DT12513_01 As a Study Coordinator, when I enter a time of 12:00 PM, I am able to correctly view the data through the Clinical Views.
	When I select Study "US17743_DT12513_SJ" and Site "Site 01"
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
	And I wait for Clinical View refresh to complete for project "US17743_DT12513_SJ"
	And I wait for 1 minute
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name               | Environment |
		| US17743_DT12513_SJ | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "Visit Date (VIS)" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject              | Site    | DataPageName | VISDT                  |
	| SUB{RndNum<num1>(3)} | Site 01 | Visit Date   | 10/01/2012 12:00:00 PM |
	And I switch to "Reports" window
	And "c1_std" propagates correctly


@release_564_2012.1.0				
@PB_US17743_DT12513_02
@Draft
Scenario: @PB_US17743_DT12513_02 As a Study Coordinator, when I change a time to 12:00 PM, I am able to correctly view the data through the Clinical Views.
	
	When I select Study "US17743_DT12513_SJ" and Site "Site 1"
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject number   | {RndNum<num1>(3)} |
	And I take a screenshot
	And I select link "Visit Date"
	And I enter data in CRF and save
	| Field      | Data                 |
	| Visit Date | 20 Jan 2012 12 00 AM |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Configuration"
	And I navigate to "Clinical Views"
	And I select Rebuild Views for Project "US17743_DT12513_SJ"
	And I wait for Clinical View refresh to complete for project "US17743_DT12513_SJ"
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I wait for Clinical View refresh to complete for project "US17743_DT12513_SJ"
	And I wait for 1 minute
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name               | Environment |
		| US17743_DT12513_SJ | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "Visit Date (VIS)" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject              | Site    | DataPageName | VISDT                  |
	| SUB{RndNum<num1>(3)} | Site 01 | Visit Date   | 20/01/2012 12:00:00 AM |
	And I navigate to "Home"
	And I select Study "US17743_DT12513_SJ"
	And I select subject "SUB{Var(num1)}"
	And I select link "Visit Date"
	And I enter data in CRF and save
	| Field      | Data                 |
	| Visit Date | 20 Jan 2012 12 00 PM |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I wait for Clinical View refresh to complete for project "US17743_DT12513_SJ"
	And I wait for 1 minute
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name               | Environment |
		| US17743_DT12513_SJ | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "Visit Date (VIS)" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject              | Site    | DataPageName | VISDT                  |
	| SUB{RndNum<num1>(3)} | Site 01 | Visit Date   | 10/01/2012 12:00:00 PM |
	And I switch to "Reports" window
	And "c1_std" propagates correctly