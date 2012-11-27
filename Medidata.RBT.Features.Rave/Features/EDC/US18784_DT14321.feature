# US 18784 Frozen status is not propagated to the standard field on a log line
@ignore
Feature: US18784_DT14321 Frozen status is not propagated to the standard field on a log line
	When I Verify and Freeze a standard field on a mixed form at the same time at the form level, the frozen status should progagate to the standard field on the log line.
	As a Rave Administrator
	When I have a mixed form that contains standard and log fields
	And I Verify and Freeze the standard field at the same time at the form level
	Then the frozen status will propagate to the standard field on the log line

 Background:
 	Given xml draft "US18784_DT14321_Draft_1.xml" is Uploaded
	Given Site "Site 1" exists
	Given study "US18784_DT14321" is assigned to Site "Site 1"
	Given I publish and push eCRF "US18784_DT14321_Draft_1.xml" to "Version 1"
	Given following Project assignments exist
		| User                | Project         | Environment | Role                | Site   | SecurityRole          |
		| US18784_DT14321user | US18784_DT14321 | Live: Prod  | US18784_DT14321role | Site 1 | Project Admin Default |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US18784_DT14321_01
@Validation	
Scenario: PB_US18784_DT14321_01 As a Data Manager, when I Verify and Freeze a mixed form at the form level, then the frozen status will propagate to the standard field on the log line.

	Given I login to Rave with user "US18784_DT14321user"
	And I create a Subject
		| Field      | Data                  | Control Type |
		| Subject ID | SUB {RndNum<num1>(5)} | textbox      |
	And I select link "Demography"
	And I enter data in CRF and save
		| Field            | Data | Control Type |
		| Sex              | Male | dropdownlist |
		| Pregnancy Status | No   | dropdownlist |
		| Age              | 55   | textbox      |
	And I check "Verify" in "form level"
	And I check "Freeze" in "form level"
	When I save the CRF page
	And I take a screenshot
	Then I verify "isfrozen" status for field "Sex" has been propaged on logline
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US18784_DT14321_02
@Validation	
Scenario: PB_US18784_DT14321_02 As a Data Manager, when I Verify and Freeze a mixed form at the form level, then the frozen status will propagate to the standard field on all log lines.

	Given I login to Rave with user "US18784_DT14321user"
	And I create a Subject
		| Field      | Data                  | Control Type |
		| Subject ID | SUB {RndNum<num1>(5)} | textbox      |
	And I select link "Demography"
	And I enter data in CRF and save
		| Field            | Data | Control Type |
		| Sex              | Male | dropdownlist |
		| Pregnancy Status | No   | dropdownlist |
		| Age              | 55   | textbox      |
	And I add a new log line
	And I enter data in CRF and save
		| Field            | Data | Control Type |
		| Pregnancy Status | No   | dropdownlist |
		| Age              | 55   | textbox      |
	And I take a screenshot
	And I check "Verify" in "form level"
	And I check "Freeze" in "form level"
	When I save the CRF page
	And I take a screenshot
	Then I verify "isfrozen" status for field "Sex" has been propaged on logline
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------