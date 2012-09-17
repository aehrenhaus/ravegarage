# When a time of 12:00 PM is saved into a date time field with a format of dd MMM yyyy hh:nn rr, that data can be correctly viewed through the Clinical Views.

Feature: US17743_DT12513
	A time of 12:00 PM can be saved into a date time field with a format of dd MMM yyyy hh:nn rr, and that data can be correctly viewed through the Clinical Views
	As a Rave user
	When I enter a time of 12:00 PM into a date time field
	Then I am able to correctly view the data in the Clinical Views

Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	#And the following Project assignments exist
	#	| User    | Project    | Environment | Role |
	#	| defuser | Jennicilin | Prod        | cdm1 |
	#And Role "cdm1" has Action "Entry"
	#And Project "Jennicilin" has Draft1
	#And Draft "<Draft1>" has Form "Vital Signs" with fields
	#	| Field OID | Data Format          | Control Type | Field Label           | Log data entry |
	#	| VSDTC     | dd MMM yyyy hh:nn rr | DateTime     | Date of Measurements: | False          |
	#	| VSORRESHT | 4.1                  | Text         | Height:               | False          |
	#	| WEIGHT    | 4.1                  | Text         | Weight:               | False          |


#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0				
@PB_US17743_01
@Draft
Scenario: As a Study Coordinator, when I enter a time of 12:00 PM, I am able to correctly view the data through the Clinical Views.
	When I create a subject
	| Field						| Value			|
	| Subject Number			| 101			|
	| Subject Initials			| SUBJ			|	
	And I am in Subject "101SUBJ" at "Site 1" in Study "Jennicilin"
	And I am on CRF page "Vital Signs"
	And I enter data in CRF
	| Field     | Value                |
	| VSDTC     | 22 Mar 2010 12:00 PM |
	| VSORRESHT | 72                   |
	| WEIGHT    | 186                  |
	And I save the CRF page
	And I take a screenshot
	And I rebuild the Clinical Views for Study "Jennicilin"	
	And I run Report "Data Listing" for Study "Jennicilin" for CRF page "Vital Signs"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17743_02
@Draft	
Scenario: As a Study Coordinator, when I change a time to 12:00 PM, I am able to correctly view the data through the Clinical Views.
	When I create a subject
	| Field						| Value			|
	| Subject Number			| 101			|
	| Subject Initials			| SUBJ			|	
	And I am in Subject "101SUBJ" at "Site 1" in Study "Jennicilin"
	And I am on CRF page "Vital Signs"
	And I enter data in CRF
	| Field     | Value                |
	| VSDTC     | 22 Mar 2010 11:00 PM |
	| VSORRESHT | 72                   |
	| WEIGHT    | 186                  |
	And I save the CRF page
	And I take a screenshot
	And I rebuild the Clinical Views for Study "Jennicilin"	
	And I run Report "Data Listing" for Study "Jennicilin" for CRF page "Vital Signs"
	And I take a screenshot
	And I am on CRF page "Vital Signs"
	And I edit the data in CRF
	| Field     | Value                |
	| VSDTC     | 22 Mar 2010 12:00 PM |
	| VSORRESHT | 72                   |
	| WEIGHT    | 186                  |
	And I save the CRF page
	And I take a screenshot
	And I rebuild the Clinical Views for Study "Jennicilin"	
	And I run Report "Data Listing" for Study "Jennicilin" for CRF page "Vital Signs"
	And I take a screenshot