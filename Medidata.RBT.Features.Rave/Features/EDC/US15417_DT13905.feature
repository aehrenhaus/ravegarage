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
	#And following Project assignments exist
	#|User	 |Project	    |Environment	|Role |Site	  |Site Number	|
	#|defuser |Mediflex_SJ	|Prod			|cdm1 |Site 1 |S100			|
    #And Role "cdm1" has Action "Entry"
	#And Project "Mediflex_SJ" has Draft "<Draft1>"
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Project "Mediflex_SJ" for Enviroment "Prod"
	#And the Local Lab "Local Lab DT13905" exists
	#And the following Lab assignment exists
	#|Project		|Environment	|Site	|Lab				|
	#|Mediflex_SJ	|Prod			|Site 1	|Local Lab DT13905	|
	And I select Study "Mediflex_SJ" and Site "Site 1"
@release_2012.1.0 
@PB_DT13905_01
@Draft
Scenario: As an EDC user, when I create a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit, then I should see the standard value and standard units in Clinical Views.
	When I create a Subject
	| Field            | Data               |
	| Subject Initials | SUB                |
	| Subject number   | {RndNum<num1>(3)}  |
	| Age              | 20                 |
	| Sex              | MaleREGAQT         |
	#| Pregancy Status  | NoREGAQT           |
	#| Subject Date     | 01 FEB 2011        |	
	#And I am on CRF page "Visit Date" in Folder "Visit 1" in Subject "SUB{Var(num1)}" in Site "Site 1" in Study "Mediflex_SJ"
	#And I enter data in CRF
	#|Field		|Value		|
	#|Visit Date	|01 FEB 2011|
	#|Age		|20			|
	#And I save the CRF page
	And I select Form "Hematology"
	#And I am on CRF page "Visit Date" in Folder "Visit 1" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex"
	#And I am on CRF page "{formName}" in Folder "{folderName}" in Subject "{subjectName}" in Site "{siteName}" in Study "{studyName}"
	#And I select Lab "Local Lab DT13905"
	And I enter data in CRF and save
	| Field       | Data       | Unit   |
	#| Sample Date | 02 FEB 2011 |        |
	| WBC         | 1           | 10^9/L |
	#And I save the CRF page
#Need Step Def for "Mediflex_SJ Central Lab"
	And I select "Home"
	And I navigate to "Lab Administration"
	And I navigate to "Unit Conversions"
	
	#And I go to Unit Conversions page in the Lab Admin module
	And I add new unit conversion data
	| From   | To | Analyte | A | B | C | D |
	| 10^9/L | %  |         | 2 | 1 | 0 | 0 |
	And I go to the Reporter module
#Need Step Def for "Reporter"
	And I run the Data Listings Report for Study "Mediflex_SJ"
#Need Step Def for "Data Listings Report"
	And I select the Lab view
#Need Step Def for "Lab view"
	Then I should see lab data
	| Form       | Analyte | Value | Units  | Standard Value | Standard Units |
	| Hematology | WBC     | 10    | 10^9/L | 20             | %              |

@release_2012.1.0 
@PB_DT13905_02
@Draft
Scenario: As an EDC user, when I create a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit for a specific analyte, then I should see the standard value and standard units in Clinical Views.
	When I create a Subject
	| Field				|Value	|
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(3)} |
	| Age              | 20                |
	| Sex              | MaleREGAQT        |
	| Pregancy Status  | NoREGAQT          |
	| Subject Date     | 01 FEB 2011       |
	And I save the CRF page	
	#And I am on CRF page "Visit Date" in Folder "Visit 1" in Subject "SUB{Var(num1)}" in Site "Site 1" in Study "Mediflex_SJ"
	#And I enter data in CRF
	#|Field		|Value		|
	#|Visit Date	|01 FEB 2011|
	#|Age		|20			|
	#And I save the CRF
	And I am on CRF page "Hematology" on subject level in Subject "SUB{Var(num1)}" in Site "Site 1" in Study "Mediflex_SJ"
	And I select Lab "Local Lab DT13905"
	And I enter data in CRF page
	| Field       | Value       | Unit   |
	#| Sample Date | 02 FEB 2011 |        |
	| WBC         | 1           | 10^9/L |
	And I save the CRF page 
	And I go to Unit Conversions page in the Lab Admin module
	And I enter unit conversion data
	| From Unit | To Unit | Analyte | A | B | C | D |
	| 10^9/L    | %       | WBC     | 4 | 1 | 0 | 0 |
	And I go to the Reporter module
	And I run the Data Listings Report for Study "Mediflex_SJ"
	And I select the Lab view
	Then I should see lab data
	| Form       | Analyte | Value | Units  | Standard Value | Standard Units |
	| Hematology | WBC     | 10    | 10^9/L | 40             | %              |

@release_2012.1.0 
@PB_DT13905_03
@Draft
Scenario: As an EDC user, when I update a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit, then I should see the standard value and standard units in Clinical Views.

	When I go to Unit Conversions page in the Lab Admin module
	And I enter unit conversion data
	| From Unit | To Unit | Analyte | A | B | C | D |
	| 10^9/L    | %       |         | 2 | 1 | 0 | 0 |
	And I create a Subject
	| Field				|Value	|
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(3)} |
	| Age              | 20                |
	| Sex              | MaleREGAQT        |
	| Pregancy Status  | NoREGAQT          |
	| Subject Date     | 01 FEB 2011       |
	And I save the CRF page
	#And I am on CRF page "Visit Date" in Folder "Visit 1" in Subject "SUB{Var(num1)}" in Site "Site 1" in Study "Mediflex_SJ"
	#And I enter data in CRF
	#|Field		|Value		|
	#|Visit Date	|01 FEB 2011|
	#|Age		|20			|
	#And I save the CRF page
	And I am on CRF page "Hematology" on subject level in Subject "SUB{Var(num1)}" in Site "Site 1" in Study "Mediflex_SJ"
	And I select Lab "Local Lab DT13905"
	And I enter data in CRF
	| Field       | Value       | Unit   |
	#| Sample Date | 02 FEB 2011 |        |
	| WBC         | 1           | 10^9/L |
	And I save the CRF
	And I go to the Reporter module
	And I run the Data Listings Report for Study "Mediflex_SJ"
	And I select the Lab view
	Then I should see lab data
	| Form       | Analyte | Value | Units  | Standard Value | Standard Units |
	| Hematology | WBC     | 10    | 10^9/L | 20             | %              |
	And I go to Unit Conversions page in the Lab Admin module
	And I enter unit conversion data
	| From Unit | To Unit | Analyte | A | B | C | D |
	| 10^9/L    | %       |         | 3 | 1 | 0 | 0 |
	And I go to the Reporter module
	And I run the Data Listings Report for Study "Mediflex_SJ"
	And I select the Lab view
	Then I should see lab data
	| Form       | Analyte | Value | Units  | Standard Value | Standard Units |
	| Hematology | WBC     | 10    | 10^9/L | 30             | %              |

@release_2012.1.0 
@PB_DT13905_04
@Draft
Scenario: As an EDC user, when I update a unit conversion formula to convert lab data in a non-standard unit to standard values in a standard unit for a specific analyte, then I should see the standard value and standard units in Clinical Views.
	When I go to Unit Conversions page in the Lab Admin module
	And I enter unit conversion data
	| From Unit | To Unit | Analyte | A | B | C | D |
	| 10^9/L    | %       | WBC     | 3 | 1 | 0 | 0 |
	And I create a Subject
	| Field            | Value             |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Age              | 20                |
	| Sex              | MaleREGAQT        |
	| Pregancy Status  | NoREGAQT          |
	| Subject Date     | 01 FEB 2011       |
	#And I am on CRF page "Visit Date" in Folder "Visit 1" in Subject "101SUBJ" in Site "Site 1" in Study "Mediflex_SJ"
	#And I enter data in CRF
	#|Field		|Value		|
	#|Visit Date	|01 FEB 2011|
	#|Age		|20			|
	And I save the CRF page
	And I am on CRF page "Hematology" on subject level in Subject "SUB{Var(num1)}" in Site "Site 1" in Study "Mediflex_SJ"
	And I select Lab "Local Lab DT13905 "
	And I enter data in CRF page
	| Field       | Value       | Unit   |
	#| Sample Date | 02 FEB 2011 |        |
	| WBC         | 1           | 10^9/L |
	And I save the CRF page
	And I go to the Reporter module
	And I run the Data Listings Report for Study "Mediflex_SJ"
	And I select the Lab view
	Then I should see lab data
	| Form       | Analyte | Value | Units  | Standard Value | Standard Units |
	| Hematology | WBC     | 10    | 10^9/L | 30             | %              |
	And I go to Unit Conversions page in the Lab Admin module
	And I enter unit conversion data
	| From Unit | To Unit | Analyte | A | B | C | D |
	| 10^9/L    | %       |         | 5 | 1 | 0 | 0 |
	And I go to the Reporter module
	And I run the Data Listings Report for Study "Mediflex_SJ"
	And I select the Lab view
	Then I should see lab data
	| Form       | Analyte | Value | Units  | Standard Value | Standard Units |
	| Hematology | WBC     | 10    | 10^9/L | 50             | %              |