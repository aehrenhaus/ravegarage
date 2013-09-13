# When a Lab Unit Conversion is newly created or updated, Lab Admin will save this Lab Unit Conversion into Lab Queue, then Lab Queue service will refresh Range Status for datapoints. Right now Lab Queue stored procedure spLabCascadeChangeToUnitConversion only cascade the change for Alert Lab.
# It is partially correct because if this Lab Unit Conversion is not used by Alert Lab (which means only Standard Units Group or Standard Units Group/Reference Lab is being defined in Lab Setting of study), the range status should not be changed. But the problem is that, even the range status is same as before, the standard value should be updated accordingly. So in above stored procedure, for the datapoints using lab unit in the Lab Unit Conversion and the study using the Standard Units Group of the Lab Unit Conversion, we need to set NeedsCVRefresh on. 
# This DT covered the DT 10086 that the description is not clear enough.
@ignore
@FT_US15417_DT13905
Feature: US15417_DT13905 NeedsCVRefresh is not set to On for all datapoints related when Lab Unit Conversion is created or updated.
	NeedsCVRefresh is not set to On for all datapoints related when Lab Unit Conversion is created or updated
	As a Rave user
	Given I enter lab data in non-standard units
	And I do not use Alert or Reference Labs for the lab data
	When I update or create a lab unit conversion formula to convert the lab data to standard units
	Then I should see the lab data converted to standard values in the standard units in Clinical Views

Background:

	And Site "Site 01" exists
	And study "US15417_DT13905" is assigned to Site "Site 01"
	And xml Lab Configuration "Lab_US15417_DT13905.xml" is uploaded
	And xml draft "US15417_DT13905_Version1.xml" is Uploaded
	And following Project assignments exist
		| User         | Project         | Environment | Role         | Site    | SecurityRole          |
		| SUPER USER 1 | US15417_DT13905 | Live: Prod  | SUPER ROLE 1 | Site 01 | Project Admin Default |
	And Role "SUPER ROLE 1" has Action "Entry" in ActionGroup "Entry" with Status "Checked"
	And I publish and push eCRF "US15417_DT13905_Version1.xml" to "SourceVersion1"
	And Clinical Views exist for project "US15417_DT13905"
	And following Report assignments exist
		| Role         | Report                             |
		| SUPER ROLE 1 | Data Listing - Data Listing Report |
	And following Configuration Settings Exist
	|Checkbox|Parameter               |Value       |
	|True    |Normalized Lab View Name|Lab         |
	Given I login to Rave with user "SUPER USER 1"

@release_2012.1.0 
@PB_US15417_DT13905_01
@Validation
Scenario: PB_US15417_DT13905_01 As an EDC user, when I create a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit, then I should see the standard value and standard units in Clinical Views.
	
	When I create a Subject
	| Field            | Data               |
	| Subject Initials | SUB                |
	| Subject number   | {RndNum<num1>(3)}  |
	| Age              | 20                 |
	| Sex              | maleUS15417_DT13905|
	| Pregancy Status  | NoUS15417_DT13905  |
	| Subject Date     | 01 Feb 2011        |	
	And I take a screenshot
	And I select link "Hematology"
	And I choose "Lab" "LocalLab_1US15417_DT13905" from "Lab"
	And I enter data in CRF and save
	| Field | Data  | Unit                    |
	| WBC   | 10    | *10E6/ulUS15417_DT13905 |
	And I take a screenshot
	And I select link "Home"
	And I navigate to "Lab Administration"
	And I navigate to "Unit Conversions"
	And I add new unit conversion data
	| From                    | To                       | Analyte | A | B | C | D |
	| *10E6/ulUS15417_DT13905 | FractionUS15417_DT13905  | ...     | 2 | 1 | 0 | 0 |
	And I take a screenshot
	And I wait for lab update queue to be processed 
	And I wait for Clinical View refresh to complete for project "US15417_DT13905"
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I wait for 1 minute
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name               | Environment |
		| US15417_DT13905    | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject        | FormName   | AnalyteName          | AnalyteValue | LabUnits                  | StdValue | StdUnits               |
	| SUB{Var(num1)} | Hematology | AnWBCUS15417_DT13905 | 10           | *10E6/ulUS15417_DT13905   | 20       | FractionUS15417_DT13905|
	And I take a screenshot
	
@release_2012.1.0 
@PB_US15417_DT13905_02
@Validation
Scenario: PB_US15417_DT13905_02 As an EDC user, when I update a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit, then I should see the standard value and standard units in Clinical Views.

	When I create a Subject
	| Field			   | Data	            |
	| Subject Initials | SUB                |
	| Subject number   | {RndNum<num1>(3)}  |
	| Age              | 20                 |
	| Sex              | maleUS15417_DT13905|
	| Pregancy Status  | NoUS15417_DT13905  |
	| Subject Date     | 01 Feb 2011        |
	And I take a screenshot
	And I select link "Hematology"
	And I choose "Lab" "LocalLab_1US15417_DT13905" from "Lab"
	And I enter data in CRF and save
	| Field | Data | Unit                    |
	| WBC   | 10   | *10E6/ulUS15417_DT13905 |
	And I take a screenshot
	And I wait for lab update queue to be processed
	And I wait for Clinical View refresh to complete for project "US15417_DT13905"
	And I wait for 1 minute
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name            | Environment |
		| US15417_DT13905 | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject        | FormName   | AnalyteName         | AnalyteValue | LabUnits                  | StdValue | StdUnits               |
	| SUB{Var(num1)} | Hematology | AnWBCUS15417_DT13905| 10           | *10E6/ulUS15417_DT13905   | 20       | FractionUS15417_DT13905|
	And I take a screenshot
	And I switch to "Reports" window
	And I select link "Home"
	And I navigate to "Lab Administration"
	And I navigate to "Unit Conversions"
	And I edit unit conversion data
	| From                    | To                       | Analyte | A | B | C | D |
	| *10E6/ulUS15417_DT13905 | FractionUS15417_DT13905  | ...     | 3 | 1 | 0 | 0 |
	And I take a screenshot
	And I wait for lab update queue to be processed
	And I wait for Clinical View refresh to complete for project "US15417_DT13905"
	And I wait for 1 minute
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name            | Environment |
		| US15417_DT13905 | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject        | FormName   | AnalyteName         | AnalyteValue | LabUnits                  | StdValue | StdUnits               |
	| SUB{Var(num1)} | Hematology | AnWBCUS15417_DT13905| 10           | *10E6/ulUS15417_DT13905   | 30       | FractionUS15417_DT13905|
	And I take a screenshot
	And I switch to "Reports" window
	And I select link "Home"
	And I navigate to "Lab Administration"
	And I navigate to "Unit Conversions"
	And I delete unit conversion data
	| From                    | To                     |
	| *10E6/ulUS15417_DT13905 | FractionUS15417_DT13905|


@release_2012.1.0 
@PB_US15417_DT13905_03
@Validation
Scenario: PB_US15417_DT13905_03 As an EDC user, when I create a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit for a specific analyte, then I should see the standard value and standard units in Clinical Views.
#	When I select Study "US15417_DT13905" and Site "Site 1"
	And I create a Subject
	| Field            | Data               |
	| Subject Initials | SUB                |
	| Subject number   | {RndNum<num1>(3)}  |
	| Age              | 20                 |
	| Sex              | maleUS15417_DT13905|
	| Pregancy Status  | NoUS15417_DT13905  |
	| Subject Date     | 01 Feb 2011        |
	And I take a screenshot
	And I select link "Hematology"
	And I choose "Lab" "LocalLab_1US15417_DT13905" from "Lab"
	And I enter data in CRF and save
	| Field       | Data | Unit   |
	| WBC         | 10   | *10E6/ulUS15417_DT13905 |
	| NEUTROPHILS | 10   | *10E6/ulUS15417_DT13905 |
	And I take a screenshot 
	And I wait for lab update queue to be processed
	And I wait for Clinical View refresh to complete for project "US15417_DT13905"
	And I wait for 1 minute
	And I select link "Home"
	And I navigate to "Lab Administration"
	And I navigate to "Unit Conversions"
	And I add new unit conversion data
	| From                    | To                       | Analyte             | A | B | C | D |
	| *10E6/ulUS15417_DT13905 | FractionUS15417_DT13905  | AnWBCUS15417_DT13905| 4 | 1 | 0 | 0 |
	And I take a screenshot
	And I navigate to "Home"
	And I wait for lab update queue to be processed
	And I wait for Clinical View refresh to complete for project "US15417_DT13905"
	And I wait for 1 minute
	And I navigate to "Reporter"
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name            | Environment |
		| US15417_DT13905 | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject        | FormName   | AnalyteName         | AnalyteValue | LabUnits                  | StdValue | StdUnits               |
	| SUB{Var(num1)} | Hematology | AnWBCUS15417_DT13905| 10           | *10E6/ulUS15417_DT13905   | 40       | FractionUS15417_DT13905|
	And I take a screenshot
	
@release_2012.1.0 
@PB_US15417_DT13905_04
@Validation
Scenario: PB_US15417_DT13905_04 As an EDC user, when I update a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit for a specific analyte, then I should see the standard value and standard units in Clinical Views.
	
#	When I select Study "US15417_DT13905" and Site "Site 1"
	And I create a Subject
	| Field			   | Data	            |
	| Subject Initials | SUB                |
	| Subject number   | {RndNum<num1>(3)}  |
	| Age              | 20                 |
	| Sex              | maleUS15417_DT13905|
	| Pregancy Status  | NoUS15417_DT13905  |
	| Subject Date     | 01 Feb 2011        |
	And I take a screenshot
	And I select link "Hematology"
	And I choose "Lab" "LocalLab_1US15417_DT13905" from "Lab"
	And I enter data in CRF and save
	| Field       | Data | Unit                    |
	| WBC         | 10   | *10E6/ulUS15417_DT13905 |
	| NEUTROPHILS | 10   | *10E6/ulUS15417_DT13905 |
	And I take a screenshot
	And I wait for lab update queue to be processed
	And I wait for Clinical View refresh to complete for project "US15417_DT13905"
	And I wait for 1 minute
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name            | Environment |
		| US15417_DT13905 | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject        | FormName   | AnalyteName         | AnalyteValue | LabUnits                | StdValue | StdUnits               |
	| SUB{Var(num1)} | Hematology | AnWBCUS15417_DT13905| 10           | *10E6/ulUS15417_DT13905 | 40       | FractionUS15417_DT13905|
	And I take a screenshot
	And I switch to "Reports" window
	And I select link "Home"
	And I navigate to "Lab Administration"
	And I navigate to "Unit Conversions"
	And I edit unit conversion data
	| From                    | To                       | Analyte             | A | B | C | D |
	| *10E6/ulUS15417_DT13905 | FractionUS15417_DT13905  | AnWBCUS15417_DT13905| 5 | 1 | 0 | 0 |
	And I take a screenshot
	And I wait for lab update queue to be processed
	And I wait for Clinical View refresh to complete for project "US15417_DT13905"
	And I wait for 1 minute
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name               | Environment |
		| US15417_DT13905 | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject        | FormName   | AnalyteName         | AnalyteValue | LabUnits                  | StdValue | StdUnits               |
	| SUB{Var(num1)} | Hematology | AnWBCUS15417_DT13905| 10           | *10E6/ulUS15417_DT13905   | 50       | FractionUS15417_DT13905|
	And I take a screenshot
	And I wait for lab update queue to be processed
	And I wait for Clinical View refresh to complete for project "US15417_DT13905"
	And I wait for 1 minute
	And I switch to "Reports" window
	And I select link "Home"
	And I navigate to "Lab Administration"
	And I navigate to "Unit Conversions"
	And I delete unit conversion data
	| From                    | Analyte             | To                       |
	| *10E6/ulUS15417_DT13905 | AnWBCUS15417_DT13905| FractionUS15417_DT13905  |