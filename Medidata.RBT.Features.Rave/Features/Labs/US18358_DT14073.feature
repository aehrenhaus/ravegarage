# When user enters a name with more than 80 characters for Lab Unit Dictionaries and Global Variables that are greater than 80 characters, the application throws an exception error. The error says that names must be less than 255 character.
Feature: US18358_DT14073 An exception is thrown when entering a name with more than 80 characters for Lab Unit Dictionary.
	When user enters names with more than 80 characters for Lab Unit Dictionary and Global Variables, the application throws an exception error.
 	As a Study Developer
	When I enter more than 80 characters in Lab Unit Dictionary and Global Variables
	Then an exception error message is displayed

Background:
Given xml draft "US18358_DT14073.xml" is Uploaded
Given study "US18358_DT14073" is assigned to Site "Site 1"
Given following Project assignments exist
| User         | Project         | Environment | Role         | Site   | SecurityRole          |
| SUPER USER 1 | US18358_DT14073 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |

Given I publish and push eCRF "US18358_DT14073.xml" to "Version 1"
	#Given I login to Rave with user "defuser" and password "password"
	#And the following Project assignments exist
	#| User		| Project		      | Environment	| Role			| Site		| Site Number |
	#| defuser	| US18358_DT14073_SJ  | Prod		| cdm1			| Site 1	| S100		  |
    #And Role "cdm1" has Action "Entry"
	#And Project "US18358_DT14073_SJ" has Draft "Original Draft"	
	#And All Upper Case box is checked
	#And I login to Rave with user "defuser" and password "password"

@release_2012.1.0
@PB_US18358_DT14073_01
@Validation
Scenario: PB_US18358_DT14073_01 As a Lab Administrator, when I upload Lab Loader draft with Global Data Dictionaries name that is greater than 80 characters, I do not see exception error message displayed
	
	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Lab Administration"
	And literal xml Lab Configuration "All_Exact255Char.xml" is uploaded
	And I take a screenshot
	And I navigate to "Global Data Dictionaries"
	#It has 255 characters
	Then I verify Global Data Dictionary names exist
	|Name                                                                                                                                                                                                                                                           |
	|255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests|
	And I take a screenshot
	And I delete Global Data Dictionaries
	|Name                                                                                                                                                                                                                                                           |
	|255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests|
	And I navigate to "Global Unit Dictionaries"
	#It has 255 characters
	Then I verify Global Unit Dictionary names exist
	|Name                                                                                                                                                                                                                                                           |
	|255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests|
	And I take a screenshot
	And I delete Global Unit Dictionaries
	|Name                                                                                                                                                                                                                                                           |
	|255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests|
	And I navigate to "Global Variables"
	#It has 50 characters
	Then I verify Global Variable OIDs exist  
	|OID                                               |
	|1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN|
	And I take a screenshot
	And I delete Global Variables
	|OID                                               |
	|1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN|
	And I navigate to "Lab Unit Dictionaries"
	#It has 255 characters
	Then I verify Lab Unit Dictionary names exist
	| Name                                                                                                                                                                                                                                                          |
	|255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests|
	And I take a screenshot
	And I delete Lab Unit Dictionaries
	| Name                                                                                                                                                                                                                                                          |
	|255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests|
	And literal xml Lab Configuration "All_MoreThan255Char.xml" is uploaded
	And I take a screenshot
	And I verify text "Upload successful." does not exist
	And I verify text "Row 26 - Name cannot exceed 255 characters." exists
	And I verify text "Row 7 - Name cannot exceed 255 characters." exists
	And I verify text "Row 30 - OID cannot exceed 50 characters." exists
	And I verify text "Row 33 - Name cannot exceed 255 characters." exists
	And I take a screenshot

@release_2012.1.0
@PB_US18358_DT14073_02
@Validation
Scenario: PB_US18358_DT14073_02 As a Lab Administrator, when I upload Lab Loader draft with Global Data Dictionaries name that is greater than 80 characters, I do not see exception error message displayed

	When I navigate to "Lab Administration"	
	And literal xml Lab Configuration "Global_Data_Dictionaries_Exact255Char.xml" is uploaded
	And I take a screenshot
	And I navigate to "Global Data Dictionaries"
	#It has 255 characters
	Then I verify Global Data Dictionary names exist
	| Name                                                                                                                                                                                                                                                            |
	| 255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests |
	And I take a screenshot
	And I delete Global Data Dictionaries
	| Name                                                                                                                                                                                                                                                            |
	| 255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests |
	And literal xml Lab Configuration "Global_Data_Dictionaries_MoreThan255Char.xml" is uploaded
	And I verify text "Upload successful." does not exist
	And I verify text "Row 4 - Name cannot exceed 255 characters." exists
	And I take a screenshot
	

@release_2012.1.0
@PB_US18358_DT14073_03
@Validation
Scenario: PB_US18358_DT14073_03 As a Lab Administrator, when I upload Lab Loader draft with Global Data Dictionaries name that is greater than 80 characters, I do not see exception error message displayed

	When I navigate to "Lab Administration"	
	And literal xml Lab Configuration "Global_Unit_Dictionaries_Exact255Char.xml" is uploaded
	And I take a screenshot
	And I navigate to "Global Unit Dictionaries"
	#It has 255 characters
	Then I verify Global Unit Dictionary names exist
	| Name                                                                                                                                                                                                                                                            |
	| 255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests |
	And I take a screenshot
	And I delete Global Unit Dictionaries
	| Name                                                                                                                                                                                                                                                            |
	| 255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests |
	And literal xml Lab Configuration "Global_Unit_Dictionaries_MoreThan255Char.xml" is uploaded
	And I verify text "Upload successful." does not exist
	And I verify text "Row 2 - Name cannot exceed 255 characters." exists
	And I take a screenshot
	

@release_2012.1.0
@PB_US18358_DT14073_04
@Validation

Scenario: PB_US18358_DT14073_04 As a Lab Administrator, when I upload Lab Loader draft with Global Data Dictionaries name that is greater than 80 characters, I do not see exception error message displayed

	When I navigate to "Lab Administration"	
	And literal xml Lab Configuration "Lab_Unit_Dictionaries_Exact255Char.xml" is uploaded
	And I take a screenshot
	And I navigate to "Lab Unit Dictionaries"
	#It has 255 characters
	Then I verify Lab Unit Dictionary names exist
	| Name                                                                                                                                                                                                                                                            |
	| 255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests |
	And I take a screenshot
	And I delete Lab Unit Dictionaries
	| Name                                                                                                                                                                                                                                                            |
	| 255 Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Test Characters Characters Test Characters Test Characters Test Characters Test Characters Tests |
	And literal xml Lab Configuration "Lab_Unit_Dictionaries_MoreThan255Char.xml" is uploaded
	And I verify text "Upload successful." does not exist
	And I verify text "Row 18 - Name cannot exceed 255 characters." exists
	And I take a screenshot
	

@release_2012.1.0
@PB_US18358_DT14073_05
@Validation
Scenario: PB_US18358_DT14073_05 As a Lab Administrator, when I upload Lab Loader draft with Global Data Dictionaries name that is greater than 80 characters, I do not see exception error message displayed

	When I navigate to "Lab Administration"	
	And literal xml Lab Configuration "Global_Variables_Exact255Char.xml" is uploaded
	And I take a screenshot
	And I navigate to "Global Variables"
	#It has 255 characters
	Then I verify Global Variable OIDs exist 
	| OID                                                |
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN |
	And I take a screenshot
	And I delete Global Variables
	| OID                                                |
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN |
	And literal xml Lab Configuration "Global_Variables_MoreThan255Char.xml" is uploaded
	And I verify text "Upload successful." does not exist
	And I verify text "Row 10 - OID cannot exceed 50 characters." exists
	And I take a screenshot
	


	