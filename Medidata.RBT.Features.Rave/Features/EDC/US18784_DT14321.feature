# US 18784 Frozen status is not propagated to the standard field on a log line
@ignore
Feature: US18784_DT14321
	When I Verify and Freeze a standard field on a mixed form at the same time at the form level, the frozen status should progagate to the standard field on the log line.
	As a Rave Administrator
	When I have a mixed form that contains standard and log fields
	And I Verify and Freeze the standard field at the same time at the form level
	Then the frozen status will propagate to the standard field on the log line

 Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	And the following Project assignments exist
	| User    | Project          | Environment | Role | Site   | Site Number |
	| defuser | US18784_DT 14321 | Prod        | CDM1 | Site 1 | 125893      |
	And Role "cdm1" has Action "Entry"
	And Project "US18784_DT 14321" has Draft "Draft 1"
	And Draft "Draft 1" has Form "Demography" with fields
	| FieldOID | Field Label      | Data Dictionary | Control Type | Data Format | Log data entry |
	| SEX      | Sex              | SEX             | DropDownList | $50         | False          |
	| PREG     | Pregnancy Status | PREG            | DropDownList | 2           | True           |
	| AGE22    | Age              |                 | Text         | 4           | True           |
	And Data Dictionary "SEX" has entries
   | User Value   | Coded Value |
   | femaleREGAQT | fREGAQT     |
   | maleREGAQT   | mREGAQT     |
   And Data Dictionary "Race" has entries
   | User Value | Coded Value |
   | YesREGAQT  | YREGAQT     |
   | NoREGAQT   | NREGAQT     |
   And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "US18784_DT 14321" for Enviroment "Prod"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US18784_01
@Draft	
Scenario: B_US18784_01 As a Data Manager, when I Verify and Freeze a mixed form at the form level, then the frozen status will propagate to the standard field on the log line.

	Given I login to Rave with user "SUPER USER 1"
	And I select Study "US19032_DT14205" and Site "Site 1"
	And I create a Subject
		| Field      | Data                  | Control Type |
		| Subject ID | SUB {RndNum<num1>(5)} | textbox      |
	And I select Form "Demography"
	When I enter data in CRF ans save
		| Field            | Data | Control Type |
		| Sex              | Male | dropdownlist |
		| Pregnancy Status | No   | dropdownlist |
		| Age              | 55   | textbox      |



	And I Verify and Freeze the form at the form level
	And I take a screenshot
	Then I verify ""([^""])"" status  ""([^""])"" propagated for field  ""([^""])"" on data page ""([^""])""")
	And I take a screenshot