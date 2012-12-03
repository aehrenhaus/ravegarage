# If there is a datapoint which currently has a value in it that is outside the normal ranges, and therefore has a clinical significance prompt or value, re-submitting the datapoint to have a ND code will not remove clinical significance prompts.
@ignore
Feature: US12999_DT13977 If Datapoint with Clinical Significance is edited again to be a ND code, Clinical Significance does not get removed.
	If Datapoint with Clinical Significance is edited again to be a ND code, Clinical Significance does not get removed
	As a Rave user
	Given I enter a lab value that is out of range
	And I provide clinical significance information
	When I change the lab value to be a valid missing code value
	Then I should not see the clinical significance information

Background:
Given xml draft "US12999_DT13977.xml" is Uploaded
Given study "US12999_DT13977" is assigned to Site "Site 1"
Given following Project assignments exist
	| User         | Project         | Environment | Role         | Site   | SecurityRole          |
	| SUPER USER 1 | US12999_DT13977 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
Given I publish and push eCRF "US17446_SJ.xml" to "Version 1"

#    Given I am logged in to Rave with username "defuser" and password "password"
#	And following Project assignments exist
#	|User	 |Project	    	|Environment	|Role |Site	  |Site Number	|
#	|defuser |US12999_DT13977|Prod			|cdm1 |Site 1 |S100			|
#    And Role "cdm1" has Action "Query"
#	And Role "cdm1" has Missing Code "ND"
#	And Project "US12999_DT13977" has Draft "<Draft1>"
#	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "DT13977 SJ " for Enviroment "Prod"
#	And the Local Lab "US15417_DT13905_LocalLab" exists
#	And the following Lab assignment exists
#	|Project	        |Environment	|Site	|Lab				     |
#	|US12999_DT13977 |Prod			|Site 1	|US15417_DT13905_LocalLab|
#	And Lab analyte fields should have "Prompt for Clinical Significance" checked in Architect
	#And I select Study "US12999_DT13977" and Site "Site 1"	

@release_2012.1.0 		
@PB_US12999_DT13977_01
@Validation
Scenario: PB_US12999_DT13977_01 As an EDC user, when I change an out of range value to be a missing code, then I should still see the clinical significance information.
	
	Given I login to Rave with user "SUPER USER 1"
	When I create a Subject
	| Field            | Data               |
	| Subject Initials | SUB                |
	| Subject number   | {RndNum<num1>(3)}  |
	| Age              | 20                 |
	| Sex              | MaleREGAQT         |
	| Pregancy Status  | NoREGAQT           |
	| Subject Date     | 01 Feb 2011        |	
	And I take a screenshot
	And I select link "Hematology"
	And I choose "US15417_DT13905_LocalLab" from "Lab"
	And I enter data in CRF and save
	| Field | Data | Unit   |
	| WBC   | 30   | 10^9/L |
	And I choose "Code 1REG_ECPV11" from "Clinical Significance"
	And I click button "Save"
	And I take a screenshot
	And I enter data in CRF and save
	| Field | Data | Unit   |
	| WBC   | ND   | 10^9/L |
	Then I should not see Clinical Significance "Code 1REG_ECPV11" on Field "WBC"
	And I take a screenshot
