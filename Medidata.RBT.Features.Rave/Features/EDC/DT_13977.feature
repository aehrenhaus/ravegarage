# If there is a datapoint which currently has a value in it that is outside the normal ranges, and therefore has a clinical significance prompt or value, re-submitting the datapoint to have a ND code will not remove clinical significance prompts.

Feature: DT 13977 If Datapoint with Clinical Significance is edited again to be a ND code, Clinical Significance does not get removed
	As a Rave user
	Given I enter a lab value that is out of range
	And I provide clinical significance information
	When I change the lab value to be a valid missing code value
	Then I should not see the clinical significance information

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Project assignments exist
	|User	|Project	|Environment	|Role |Site	  |Site Number	|
	|User 1 |Mediflex	|Prod			|cdm1 |Site 1 |S100			|
    And Role "cdm1" has Action "Query"
	And Role "cdm1" has Missing Code "ND"
	And Project "Mediflex" has Draft "<Draft1>"
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "Mediflex" for Enviroment "Prod"
	And the Central Lab "Mediflex Central Lab" exists
	And the following Lab assignment exists
	|Project	|Environment	|Site	|Lab					|
	|Mediflex	|Prod			|Site 1	|Mediflex Central Lab	|

# Lab analyte fields should have "Prompt for Clinical Significance" checked in Architect
		
@PB-DT13977-01
Scenario: As an EDC user, when I change an out of range value to be a missing code, then I should still see the clinical significance information.
	When I create a Subject
	| Field				|Value	|
	| Subject Number	|101	|
	| Subject Initials	|SUBJ	|	
	And I am on CRF page "Visit Date" in Folder "Visit 1" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I enter data in CRF
	|Field		|Value		|
	|Visit Date	|01 FEB 2011|
	|Age		|20			|
	And I save the CRF
	And I am on CRF page "Hematology" on subject level in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	And I select Lab "Mediflex Central Lab"
	And I enter data in CRF
	|Field		|Value		|
	|Sample Date|02 FEB 2011|
	|WBC		|1			|
	And I save the CRF
	And I enter data in CRF for field "Sample Date"
	|Field							|Value					|
	|Clinical Significance prompt	|Clinically Significant	|
	|Comments						|test comment			|
	And I save the CRF
	And I enter data in CRF
	|Field		|Value		|
	|WBC		|ND			|
	Then I should not see data in CRF for field "Sample Date"
	|Field							|Value					|
	|Clinical Significance prompt	|Clinically Significant	|
	|Comments						|test comment			|


