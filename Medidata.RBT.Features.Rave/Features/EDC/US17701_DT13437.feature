# When an analyte range is manually created, the audit information should be captured in the database.

Feature: US17701_DT13437
	Audit information for manually create analyte ranges is captured in the database.
	As a Rave user
	When I manually create an analyte range
	Then the audit information for the analyte I created is captured in the database

Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	And the following Project assignments exist
		| User    | Project    | Environment | Role | Site         | Site Number | Lab Type  | Lab Name      | Description   | Range Type |
		| defuser | Jennicilin | Prod        | cdm1 | ABC Hospital | 12333       | Local Lab | ABC Local Lab | ABC Local Lab | Standard   |
	And the following labs exists
		| Lab Type      | Lab Name          | Description       | Range Type |
		| Local Lab     | ABC Local Lab     | ABC Local Lab     | Standard   |
		| Central Lab   | ABC Central Lab   | ABC Central Lab   | Standard   |
		| Alert Lab     | ABC Alert Lab     | ABC Alert Lab     | Standard   |
		| Reference Lab | ABC Reference Lab | ABC Reference Lab | Standard   |
	#And Role "cdm1" has Action "Entry"
	#And User "defuser" has Module "Site Administration, Lab Administrator"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_01
@Draft
Scenario: PB_US17701_01 As a Lab Administrator, when manually create an analyte range, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Site Administration" module
	And I search for site "ABC Hospital"
	And I select Site Details for Site "ABC Hospital"
	And I select image "Lab Maintenance" for Study "Jennicilin"
	And I select Ranges for "ABC Local Lab"
	And I select "Add New Range"
	And I create range
		| Analyte    | From Date   | To Date     | Low Age  | High Age | Sex  | Low Value | High Value | Units | Dictionary | Comments | Edit | New Version |
		| Hematocrit | 01 Jan 2000 | 01 Jan 2020 | 15 years | 99 years | Male | 2         | 4          | %     |            |          |      |             |
	And I take a screenshot
	And I run SQL Script "SQL US17701_DT13437"
	Then I should see SQL result
		| Property     | Value   | Readble               |
		| AnalyteRange | Created | Analyte Range Created |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_02
@Draft
Scenario: PB_US17701_02 As a Lab Administrator, when manually create an analyte range, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Central Labs" module
	And I select Ranges for "ABC Central Lab"
	And I select "Add New Range"
	And I create range
		| Analyte    | From Date   | To Date     | Low Age  | High Age | Sex  | Low Value | High Value | Units | Dictionary | Comments | Edit | New Version |
		| Hematocrit | 01 Jan 2000 | 01 Jan 2020 | 15 years | 99 years | Male | 2         | 4          | %     |            |          |      |             |
	And I take a screenshot
	And I run SQL Script "SQL US17701_DT13437"
	Then I should see SQL result
		| Property     | Value   | Readble               |
		| AnalyteRange | Created | Analyte Range Created |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_03
@Draft
Scenario: PB_US17701_03 As a Lab Administrator, when manually create an analyte range, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Global Labs" module
	And I select Ranges for "ABC Alert Lab"
	And I select "Add New Range"
	And I create range
		| Analyte    | From Date   | To Date     | Low Age  | High Age | Sex  | Low Value | High Value | Units | Dictionary | Comments | Edit | New Version |
		| Hematocrit | 01 Jan 2000 | 01 Jan 2020 | 15 years | 99 years | Male | 2         | 4          | %     |            |          |      |             |
	And I take a screenshot
	And I run SQL Script "SQL US17701_DT13437"
	Then I should see SQL result
		| Property     | Value   | Readble               |
		| AnalyteRange | Created | Analyte Range Created |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17701_04
@Draft
Scenario: PB_US17701_04 As a Lab Administrator, when manually create an analyte range, then the audit information for the analyte I created is captured in the database.

	And I navigate to "Lab Administration" module
	And I navigate to "Global Labs" module
	And I select Ranges for "ABC Reference Lab"
	And I select "Add New Range"
	And I create range
		| Analyte    | From Date   | To Date     | Low Age  | High Age | Sex  | Low Value | High Value | Units | Dictionary | Comments | Edit | New Version |
		| Hematocrit | 01 Jan 2000 | 01 Jan 2020 | 15 years | 99 years | Male | 2         | 4          | %     |            |          |      |             |
	And I take a screenshot
	And I run SQL Script "SQL US17701_DT13437"
	Then I should see SQL result
		| Property     | Value   | Readble               |
		| AnalyteRange | Created | Analyte Range Created |
