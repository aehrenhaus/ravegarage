@FT_MCC41785
Feature: (DT13823) Error message appears when adding a new lab from within a lab form
	As a Rave user
	Given my Role has UseLabMaintainance permission
	And my UserGroup has access to LabAdmin module
	When I Add new Lab on Datapage
	Then I expect to see new lab page
	So that I can use the Rave lab features

Background:
	Given xml User Group Configuration "MCC41785_UserGroup.xml" is uploaded
	And I login to Rave with user "MCC41785_User"
	And Site "MCC41785_Site" exists
	And study "MCC41785" is assigned to Site "MCC41785_Site"
	And xml Lab Configuration "MCC41785_Lab.xml" is uploaded
	And xml draft "MCC41785_Version1.xml" is Uploaded
	And following Project assignments exist
	| User          | Project  | Environment | Role          | Site          | SecurityRole          |
	| MCC41785_User | MCC41785 | Live: Prod  | MCC41785_Role | MCC41785_Site | Project Admin Default |
	And I publish and push eCRF "MCC41785_Version1.xml" to "SourceVersion1"

@release_2013.2.0 
@PB_MCC41785_01
@Validation
Scenario: User should be able to add new lab when its Role has UseLabMaintainance permission and UserGroup has Lab Administration module assigned
	When I create a Subject
	| Field            | Data               |
	| Subject Initials | SUB                |
	| Subject number   | {RndNum<num1>(3)}  |
	| Age              | 20                 |
	| Subject Date     | 01 Feb 2011        |	
	And I take a screenshot
	And I select link "Hematology"
	And I choose lab "Add New" from "Lab"
	Then I verify link "Add New Lab" exists

