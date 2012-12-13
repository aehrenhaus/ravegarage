# When user enters a name with more than 80 characters for Lab Unit Dictionaries and Global Variables that are greater than 80 characters, the application throws an exception error. The error says that names must be less than 255 character.
@FT_US18087_DT14073
Feature: US18087_DT14073 An exception is thrown when entering a name with more than 80 characters for Lab Unit Dictionary.
	When user enters names with more than 80 characters for Lab Unit Dictionary and Global Variables, the application throws an exception error.
 	As a Study Developer
	When I enter more than 80 characters in Lab Unit Dictionary and Global Variables
	Then an exception error message is displayed

Background:
Given xml draft "US18087_DT14073.xml" is Uploaded
Given study "US18087_DT14073" is assigned to Site "Site 1"
Given I publish and push eCRF "US18087_DT14073.xml" to "Version 1"
Given following Project assignments exist
| User         | Project         | Environment | Role         | Site   | SecurityRole          |
| SUPER USER 1 | US18087_DT14073 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |

	#Given I login to Rave with user "defuser" and password "password"
	#And the following Project assignments exist
	#| User		| Project		      | Environment	| Role			| Site		| Site Number |
	#| defuser	| US18087_DT14073_SJ  | Prod		| cdm1			| Site 1	| S100		  |
    #And Role "cdm1" has Action "Entry"
	#And Project "US18087_DT14073_SJ" has Draft "Original Draft"	
	#And All Upper Case box is checked
	#And I login to Rave with user "defuser" and password "password"
	
@release_2012.1.0
@PB_US18087_DT14073_01
@Validation
Scenario: PB_US18087_DT14073_01 As a Lab Administrator, when I create a name that is greater than 80 characters in Lab Admin, I do not see exception error message displayed.
	
	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Lab Administration"
	And I navigate to "Global Data Dictionaries"
	And I add new Global Data Dictionaries
	#It has 255 characters
	| Name |
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name|
	Then I verify Global Data Dictionary names exist
	| Name |                                                                                                                                                                                                                                                     
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name |  
	And I take a screenshot 
	And I verify Global Data Dictionaries with OID exist
	| OID |                                                
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN | 	
	And I edit Global Data Dictionaries
	| From                                                                                                                                                                                                                                                            | To                                                                                                                                                                                                                                                              |
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name | 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test |
	Then I verify Global Data Dictionary names exist
	|Name |
	| 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test|
	And I take a screenshot
	Then I verify Global Data Dictionaries with OID exist 
	| OID | 
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN |
	And I delete Global Data Dictionaries
	| Name |
	| 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test|
	And I add new Global Data Dictionaries
	#It has 41 characters
	| Name |
	| abc123 abc123 abc123 abc123 abc123 abc123 |
	Then I verify Global Data Dictionary names exist
	| Name |
	| abc123 abc123 abc123 abc123 abc123 abc123 |
	And I take a screenshot
	Then I verify Global Data Dictionaries with OID exist
	| OID |
	| ABC123ABC123ABC123ABC123ABC123ABC123 | 
	And I delete Global Data Dictionaries
	| Name |
	| abc123 abc123 abc123 abc123 abc123 abc123|
	And I add new Global Data Dictionaries
	#It has 33 characters
	| Name | 									
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	Then I verify Global Data Dictionary names exist
	| Name |																								
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	And I take a screenshot	
	Then I verify Global Data Dictionaries with OID exist 
	| OID |
	| ABC123ABC123 						|
	And I delete Global Data Dictionaries
	| Name |
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	And I add new Global Data Dictionaries
	#It has 86 characters
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	Then I verify Global Data Dictionary names exist
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	And I take a screenshot
	Then I verify Global Data Dictionaries with OID exist
	| OID |
	| AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |
	And I edit Global Data Dictionaries
	| From |To|
	|aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	Then I verify Global Data Dictionary names exist 
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	And I take a screenshot
	And I add new Global Data Dictionaries
	#It has 86 characters
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	Then I verify Global Data Dictionary names exist
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	And I take a screenshot
	Then I verify Global Data Dictionaries do not have duplicate OIDs
	And I delete Global Data Dictionaries
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	And I delete Global Data Dictionaries
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	And I take a screenshot



@release_2012.1.0
@PB_US18087_DT14073_02
@Validation
Scenario: PB_US18087_DT14073_02 As a Lab Administrator, when I create a name that is greater than 80 characters in Lab Admin, I do not see exception error message displayed.

	When I navigate to "Lab Administration"
	And I navigate to "Global Unit Dictionaries"
	And I add new Global Unit Dictionaries
	#It has 255 characters
	| Name |
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name|
	Then I verify Global Unit Dictionary names exist
	| Name |                                                                                                                                                                                                                                                     
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name |  
	And I take a screenshot 
	And I verify Global Unit Dictionaries with OID exist
	| OID |                                                
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN | 	
	And I edit Global Unit Dictionaries
	| From                                                                                                                                                                                                                                                            | To                                                                                                                                                                                                                                                              |
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name | 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test |
	Then I verify Global Unit Dictionary names exist
	|Name |
	| 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test|
	And I take a screenshot
	Then I verify Global Unit Dictionaries with OID exist 
	| OID | 
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN |
	And I delete Global Unit Dictionaries
	| Name |
	| 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test|
	And I add new Global Unit Dictionaries
	#It has 41 characters
	| Name |
	| abc123 abc123 abc123 abc123 abc123 abc123 |
	Then I verify Global Unit Dictionary names exist
	| Name |
	| abc123 abc123 abc123 abc123 abc123 abc123 |
	And I take a screenshot
	Then I verify Global Unit Dictionaries with OID exist
	| OID |
	| ABC123ABC123ABC123ABC123ABC123ABC123 | 
	And I delete Global Unit Dictionaries
	| Name |
	| abc123 abc123 abc123 abc123 abc123 abc123|
	And I add new Global Unit Dictionaries
	#It has 33 characters
	| Name | 									
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	Then I verify Global Unit Dictionary names exist
	| Name |																								
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	And I take a screenshot	
	Then I verify Global Unit Dictionaries with OID exist 
	| OID |
	| ABC123ABC123 						|
	And I delete Global Unit Dictionaries
	| Name |
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	And I add new Global Unit Dictionaries
	#It has 86 characters
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	Then I verify Global Unit Dictionary names exist
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	And I take a screenshot
	Then I verify Global Unit Dictionaries with OID exist
	| OID |
	| AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |
	And I edit Global Unit Dictionaries
	| From |To|
	|aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	Then I verify Global Unit Dictionary names exist 
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	And I take a screenshot
	And I add new Global Unit Dictionaries
	#It has 86 characters
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	Then I verify Global Unit Dictionary names exist
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	And I take a screenshot
	Then I verify Global Unit Dictionaries do not have duplicate OIDs
	And I delete Global Unit Dictionaries
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	And I delete Global Unit Dictionaries
	| Name |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	And I take a screenshot



@release_2012.1.0
@PB_US18087_DT14073_03
@Validation
Scenario: PB_US18087_DT14073_03 As a Lab Administrator, when I create a name that is greater than 80 characters in Lab Admin, I do not see exception error message displayed.

	When I navigate to "Lab Administration"
	And I navigate to "Global Variables"
	And I add new Global Variables
	#It has 50 characters
	| OID                                                | Format |
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN | $5     |
	Then I verify Global Variable OIDs exist
	| OID                                                | 
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN |    
	And I take a screenshot 
	And I edit Global Variables 
	| From                                               | To                                                 |
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN | 1TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTT |
	                   
	Then I verify Global Variable OIDs exist  
	| OID                                                | 
	| 1TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTT |
	And I take a screenshot
	And I delete Global Variables 
	| OID                                                |
	| 1TESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTTESTT |
	And I add new Global Variables
	#It has 33 characters
	| OID                               | Format |
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |        |    
	Then I verify text "Format must be specified" exists
	And I verify text "Enter valid data format" exists
	And I navigate to "Global Variables"
	And I add new Global Variables
	#It has 33 characters
	| OID                               | Format |
	| !@#$%^&*()abc123 !@#$%^&*()abc123 | $5     |     
	Then I verify Global Variable OIDs exist
	| OID                               |
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	And I take a screenshot
	And I delete Global Variables
	| OID                               |
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	And I navigate to "Global Variables"
	#It has 50 characters
	And I add new Global Variables
	| OID                                                | Format |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz | $5     |              
	Then I verify Global Variable OIDs exist 
	| OID                                                |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	And I take a screenshot
	And I add new Global Variables
	#It has 86 characters
	| OID                                                | Format |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz | $5     |
	Then I verify text "Variable OID must be unique" exists
	And I take a screenshot
	And I delete Global Variables
	| OID                                                |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	And I take a screenshot


@release_2012.1.0
@PB_US18087_DT14073_04
@Validation
Scenario: PB_US18087_DT14073_04 As a Lab Administrator, when I create a name that is greater than 80 characters in Lab Admin, I do not see exception error message displayed.

	When I navigate to "Lab Administration"
	And I navigate to "Lab Unit Dictionaries"
	And I add new Lab Unit Dictionaries
	#It has 255 characters
	| Name                                                                                                                                                                                                                                                            |
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name |
	Then I verify Lab Unit Dictionary names exist
	| Name                                                                                                                                                                                                                                                            |
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name |
	And I take a screenshot 
	And I edit Lab Unit Dictionaries
	| From                                                                                                                                                                                                                                                            | To                                                                                                                                                                                                                                                              |
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name | 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test |
	Then I verify Lab Unit Dictionary names exist
	| Name                                                                                                                                                                                                                                                            |
	| 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test |
	And I take a screenshot
	And I delete Lab Unit Dictionaries
	| Name                                                                                                                                                                                                                                                            |
	| 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test |
	And I add new Lab Unit Dictionaries
	#It has 41 characters
	| Name                                      |
	| abc123 abc123 abc123 abc123 abc123 abc123 |
	Then I verify Lab Unit Dictionary names exist
	| Name                                      |
	| abc123 abc123 abc123 abc123 abc123 abc123 |
	And I take a screenshot
	And I delete Lab Unit Dictionaries
	| Name                                      |
	| abc123 abc123 abc123 abc123 abc123 abc123 |
	And I add new Lab Unit Dictionaries
	#It has 33 characters
	| Name                              |
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	Then I verify Lab Unit Dictionary names exist
	| Name                              |
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	And I take a screenshot	
	And I delete Lab Unit Dictionaries
	| Name                              |
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	And I add new Lab Unit Dictionaries
	#It has 86 characters
	| Name                                                                                   |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	Then I verify Lab Unit Dictionary names exist
	| Name                                                                                   |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa |
	And I take a screenshot
	And I edit Lab Unit Dictionaries
	| From                                                                                   | To                                                                                     |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa | aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	Then I verify Lab Unit Dictionary names exist 
	| Name                                                                                   |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	And I take a screenshot
	And I add new Lab Unit Dictionaries
	#It has 86 characters
	| Name                                                                                   |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	And I verify text "Lab Unit Dictionary Name is not unique" exists
	And I take a screenshot
	And I navigate to "Lab Unit Dictionaries"
	And I delete Lab Unit Dictionaries
	| Name                                                                                   |
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz |
	And I take a screenshot