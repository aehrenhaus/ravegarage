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
	|User	 |Project	    	|Environment	|Role |Site	  |Site Number	|
	|defuser |US12999_DT13977_SJ|Prod			|cdm1 |Site 1 |S100			|
    And Role "cdm1" has Action "Query"
	And Role "cdm1" has Missing Code "ND"
	And Project "US12999_DT13977_SJ" has Draft "<Draft1>"
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "DT13977 SJ " for Enviroment "Prod"
	And the Local Lab "US15417_DT13905_LocalLab" exists
	And the following Lab assignment exists
	|Project	        |Environment	|Site	|Lab				     |
	|US12999_DT13977_SJ |Prod			|Site 1	|US15417_DT13905_LocalLab|
	And Lab analyte fields should have "Prompt for Clinical Significance" checked in Architect
	And I select Study "US12999_DT13977_SJ" and Site "Site 1"	

		
@PB-DT13977-01
Scenario: As an EDC user, when I change an out of range value to be a missing code, then I should still see the clinical significance information.
	When I create a Subject

	| Field            | Data               |
	| Subject Initials | SUB                |
	| Subject number   | {RndNum<num1>(3)}  |
	| Age              | 20                 |
	| Sex              | MaleREGAQT         |
	| Pregancy Status  | NoREGAQT           |
	| Subject Date     | 01 Feb 2011        |	
	And I take a screenshot
	And I select Form "Hematology"
	
	And I choose "US15417_DT13905_LocalLab" for "Lab"
	And I enter data in CRF and save
	| Field | Data | Unit   |
	| WBC   | 30   | 10^9/L |
	
	And I choose "Code 1REG_ECPV11" for "Clinical Significance"
	And I take a screenshot
	And I enter data in CRF and save
	| Field | Data | Unit   |
	| WBC   | ND   | 10^9/L |
	Then I should verify Clinical Significance does not exist in CRF for field "WBC"
	|Field							|Data   			|
	|Clinical Significance prompt	|Code 1REG_ECPV11	|
	And I take a screenshot



