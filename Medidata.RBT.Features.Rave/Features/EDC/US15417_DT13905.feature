# When a Lab Unit Conversion is newly created or updated, Lab Admin will save this Lab Unit Conversion into Lab Queue, then Lab Queue service will refresh Range Status for datapoints. Right now Lab Queue stored procedure spLabCascadeChangeToUnitConversion only cascade the change for Alert Lab.
# It is partially correct because if this Lab Unit Conversion is not used by Alert Lab (which means only Standard Units Group or Standard Units Group/Reference Lab is being defined in Lab Setting of study), the range status should not be changed. But the problem is that, even the range status is same as before, the standard value should be updated accordingly. So in above stored procedure, for the datapoints using lab unit in the Lab Unit Conversion and the study using the Standard Units Group of the Lab Unit Conversion, we need to set NeedsCVRefresh on. 
# This DT covered the DT 10086 that the description is not clear enough.

Feature: DT 13905 NeedsCVRefresh is not set to On for all datapoints related when Lab Unit Conversion is created or updated
	As a Rave user
	Given I enter lab data in non-standard units
	And I do not use Alert or Reference Labs for the lab data
	When I update or create a lab unit conversion formula to convert the lab data to standard units
	Then I should see the lab data converted to standard values in the standard units in Clinical Views

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
		
	# And following Project assignments exist
	# |User	  |Project	         |Environment	|Role |Site	  |Site Number	|
	# |defuser|US15417_DT13905_SJ|Prod			|cdm1 |Site 1 |S100			|
    # #And Role "cdm1" has Action "Entry"
	# And the following Lab Units exixt
	# | Lab Unit |
	# | 10^9/L   |
	# | %		 |

	# And the following Lab Unit Dictionary exists
	# | Name        | Units  |
	# | WBC         | %      |
	# | WBC         | 10^9/L |
	# | Neutrophils | %      |
	# | Neutrophils | 10^9/L |


	# And the following Analytes exists
	# | Analytes    | Lab Unit Dictionary |
	# | WBC         | WBC                 |
	# | Neutrophils | Neutrophils         |

	# And the following Standard Group Exists with Entries and their related Analytes and Units
	# | Standard Group					| Analyte    | Units  |
	# | US15417_DT13905_Standard_Groups | Neutrophils| %      |
	# | US15417_DT13905_Standard_Groups | WBC        | %      |

	#And the following Range Types Exists
	#| Range Type                 |
	#| US15417_DT13905_Range_Type |

	#And the following Central Labs Exists
	#| Central Labs       | Range Type				   |
	#| US15417_DT13905_SJ | US15417_DT13905_Range_Type |

	#And the following Reference Lab Exists
	#| Type          | Name                      | Range Type                 |
	#| Reference Lab | US15417_DT13905_SJ_RefLab | US15417_DT13905_Range_Type |

	#And the following Lab Settings Exists 
	#| Standard Units                  | Reference Labs            |
	#| US15417_DT13905_Standard_Groups | US15417_DT13905_SJ_RefLab |

	#And the following Labs Exsits
	#| Type      | Name               | Description        | Range Type                 |
	#| Local Lab | US15417_DT13905_SJ | US15417_DT13905_SJ | US15417_DT13905_Range_Type |

	#And the following Analyte Ranges Exsits
	#| Analyte     | From Date   | To Date     | Low Value | High Value | Units  | Dictionary | Comments |
	#| Neutrophils | 01 Jan 2000 | 01 Jan 2020 | 10        | 20         | 10^9/L | ...        |          |
	#| WBC         | 01 Jan 2000 | 01 Jan 2020 | 10        | 20         | 10^9/L | ...        |          |
	
	# And I Checked box for "Normalized Lab View Name" in Configuration
	# And I Type
	# | Normalized Lab View Name |
	# | AnalytesView             |

	# #And Project "Mediflex_SJ" has Draft "<Draft1>"
	# #And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "Mediflex_SJ" for Enviroment "Prod"
	# #And the Local Lab "Local Lab DT13905" exists
	# #And the following Lab assignment exists
	# #|Project		|Environment	|Site	|Lab				|
	# #|Mediflex_SJ	|Prod			|Site 1	|Local Lab DT13905	|
	# And lab has ranges set for the Analytes
	# | Lab               | Analyte     |
	# | Local Lab DT13905 | WBC         |
	# | Local Lab DT13905 | NEUTROPHILS |
	 #And I select Study "US15417_DT13905_SJ" and Site "Site 1"

@release_2012.1.0 
@PB_DT13905_01
@Draft
Scenario: PB_DT13905_01 As an EDC user, when I create a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit, then I should see the standard value and standard units in Clinical Views.
	And I select Study "US15417_DT13905_SJ" and Site "Site 1"
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
	And I choose "US15417_DT13905_SJ" from "Lab"
	And I enter data in CRF and save

	| Field | Data  | Unit   |
	| WBC   | 10    | 10^9/L |
	And I take a screenshot
	And I select "Home"
	And I navigate to "Lab Administration"
	And I navigate to "Unit Conversions"
	And I add new unit conversion data
	| From   | To | Analyte | A | B | C | D |
	| 10^9/L | %  | ...     | 2 | 1 | 0 | 0 |
	And I take a screenshot


	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name               | Environment |
		| US15417_DT13905_SJ | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"
	Then I should verify row(s) exist in "Result" table
	| Subject        | FormName   | AnalyteName | AnalyteValue | LabUnits | StdValue | StdUnits |
	| SUB{Var(num1)} | Hematology | WBC         | 10           | 10^9/L   | 20       | %        |
	And I take a screenshot

@release_2012.1.0 
@PB_DT13905_02
@Draft
Scenario: PB_DT13905_02 As an EDC user, when I create a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit for a specific analyte, then I should see the standard value and standard units in Clinical Views.
	And I select Study "US15417_DT13905_SJ" and Site "Site 1"
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
	And I choose "US15417_DT13905_SJ" from "Lab"
	And I enter data in CRF and save

	| Field       | Data | Unit   |
	| WBC         | 10   | 10^9/L |
	| NEUTROPHILS | 10   | 10^9/L |
	And I take a screenshot 
	And I select "Home"
	And I navigate to "Lab Administration"
	And I navigate to "Unit Conversions"
	And I add new unit conversion data

	| From   | To | Analyte | A | B | C | D |
	| 10^9/L | %  | WBC     | 4 | 1 | 0 | 0 |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name               | Environment |
		| US15417_DT13905_SJ | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"

	Then I should verify row(s) exist in "Result" table

	| Subject        | FormName   | AnalyteName | AnalyteValue | LabUnits | StdValue | StdUnits |
	| SUB{Var(num1)} | Hematology | WBC         | 10           | 10^9/L   | 40       | %        |
	And I take a screenshot
@release_2012.1.0 
@PB_DT13905_03
@Draft
Scenario: PB_DT13905_03 As an EDC user, when I update a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit, then I should see the standard value and standard units in Clinical Views.

	And I select Study "US15417_DT13905_SJ" and Site "Site 1"
	And I create a Subject

	| Field			   | Data	           |
	| Subject Initials | SUB               |
	| Subject number   | {RndNum<num1>(3)} |
	| Age              | 20                |
	| Sex              | MaleREGAQT        |
	| Pregancy Status  | NoREGAQT          |
	| Subject Date     | 01 Feb 2011       |
	And I take a screenshot
	And I select Form "Hematology"
	And I choose "US15417_DT13905_SJ" from "Lab"
	And I enter data in CRF and save

	| Field | Data | Unit   |
	| WBC   | 10   | 10^9/L |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name               | Environment |
		| US15417_DT13905_SJ | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"

	Then I should verify row(s) exist in "Result" table

	| Subject        | FormName   | AnalyteName | AnalyteValue | LabUnits | StdValue | StdUnits |
	| SUB{Var(num1)} | Hematology | WBC         | 10           | 10^9/L   | 20       | %        |
	And I take a screenshot
	And I select "Home"
	And I navigate to "Lab Administration"
	And I navigate to "Unit Conversions"
	And I add new unit conversion data

	| From   | To | Analyte | A | B | C | D |
	| 10^9/L | %  |         | 3 | 1 | 0 | 0 |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name        | Environment |
		| Mediflex_SJ | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"

	Then I should verify row(s) exist in "Result" table

	| Subject        | FormName   | AnalyteName | AnalyteValue | LabUnits | StdValue | StdUnits |
	| SUB{Var(num1)} | Hematology | WBC         | 10           | 10^9/L   | 30       | %        |
	And I take a screenshot
@release_2012.1.0 
@PB_DT13905_04
@Draft
Scenario: PB_DT13905_04 As an EDC user, when I update a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit for a specific analyte, then I should see the standard value and standard units in Clinical Views.
	
	And I select Study "US15417_DT13905_SJ" and Site "Site 1"
	And I create a Subject

	| Field			   | Data	           |
	| Subject Initials | SUB               |
	| Subject number   | {RndNum<num1>(3)} |
	| Age              | 20                |
	| Sex              | MaleREGAQT        |
	| Pregancy Status  | NoREGAQT          |
	| Subject Date     | 01 Feb 2011       |
	And I take a screenshot
	And I select Form "Hematology"
	And I choose "US15417_DT13905_SJ" from "Lab"
	And I enter data in CRF and save

	| Field       | Data | Unit   |
	| WBC         | 10   | 10^9/L |
	| NEUTROPHILS | 10   | 10^9/L |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name        | Environment |
		| Mediflex_SJ | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"

	Then I should verify row(s) exist in "Result" table

	| Subject        | FormName   | AnalyteName | AnalyteValue | LabUnits | StdValue | StdUnits |
	| SUB{Var(num1)} | Hematology | WBC         | 10           | 10^9/L   | 30       | %        |
	And I take a screenshot
	And I select "Home"
	And I navigate to "Lab Administration"
	And I navigate to "Unit Conversions"
	And I add new unit conversion data

	| From   | To | Analyte | A | B | C | D |
	| 10^9/L | %  |         | 5 | 1 | 0 | 0 |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I select Report "Data Listing" 
	And I set report parameter "Study" with table
		| Name        | Environment |
		| Mediflex_SJ | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "AnalytesView" from "Form"	
	And I click button "Run"

	Then I should verify row(s) exist in "Result" table

	| Subject        | FormName   | AnalyteName | AnalyteValue | LabUnits | StdValue | StdUnits |
	| SUB{Var(num1)} | Hematology | WBC         | 10           | 10^9/L   | 50       | %        |
	#And I take a screenshot