# If there is a datapoint which currently has a value in it that is outside the normal ranges, and therefore has a clinical significance prompt or value, 
# re-submitting the datapoint to have a ND code will not remove clinical significance prompts.
@ignore
Feature: US12999_DT13977 
	If Datapoint with Clinical Significance is edited again to be a ND code, Clinical Significance does not get removed
	As a Rave user
	Given I enter a lab value that is out of range
	And I provide clinical significance information
	When I change the lab value to be a valid missing code value
	Then I should not see the clinical significance information

Background:
Given I login to Rave with user "US12999_SUPERUSER"
And Site "Site_001" exists
And  study "US12999_DT13977" is assigned to Site "Site_001"
And the following Range Types exist
  | Range Type Name         |
  | StandardUS12999_DT13977 |
And xml Lab Configuration "Lab_US12999_DT13977.xml" is uploaded
And xml draft "US12999_DT13977.xml" is Uploaded
And following Project assignments exist
  | User              | Project         | Environment | Role              | Site     | SecurityRole          |
  | US12999_SUPERUSER | US12999_DT13977 | Live: Prod  | US12999_SUPERROLE | Site_001 | Project Admin Default |
And I publish and push eCRF "US12999_DT13977.xml" to "Version 1" with study environment "Prod"


@release_2012.1.0 		
@PB-DT13977-01
@Validation
Scenario: @PB-DT13977-01 As an EDC user, when I change an out of range value to be a missing code, then I should still see the clinical significance information.
	When I login to Rave with user "US12999_SUPERUSER"
	And I create a Subject
	  | Field            | Data               |
	  | Subject Initials | SUB                |
	  | Subject number   | {RndNum<num1>(3)}  |
	  | Age              | 20                 |
	  | Sex              | MaleREGAQT         |
	  | Pregancy Status  | NoREGAQT           |
	  | Subject Date     | 01 Feb 2011        |	
	And I take a screenshot
	And I select link "Hematology"
	And I choose "LocalLab_1US12999_DT13977" from "Lab"
	And I enter data in CRF and save
	  | Field | Data | Unit   |
	  | WBC   | 30   | 10^9/L |
	And I choose "Code 1US12999_DT13977" from "Clinical Significance"
	And I click button "Save"
	And I take a screenshot
	And I enter data in CRF and save
	  | Field | Data | Unit   |
	  | WBC   | ND   | 10^9/L |
	Then I should not see Clinical Significance "Code 1US12999_DT13977" on Field "WBC"
	And I take a screenshot
