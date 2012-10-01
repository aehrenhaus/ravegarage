# When user enters a name with more than 80 characters for Lab Unit Dictionaries and Global Variables that are greater than 80 characters, the application throws an exception error. The error says that names must be less than 255 character.

Feature: US18087_DT14073
	When user enters names with more than 80 characters for Lab Unit Dictionary and Global Variables, the application throws an exception error.
 	As a Study Developer
	When I enter more than 80 characters in Lab Unit Dictionary and Global Variables
	Then an exception error message is displayed

Background:
	#Given I am logged in to Rave with username "defuser" and password "password"
	#And the following Project assignments exist
	#| User		| Project		      | Environment	| Role			| Site		| Site Number |
	#| defuser	| US18087_DT14073_SJ  | Prod		| cdm1			| Site 1	| S100		  |
    #And Role "cdm1" has Action "Entry"
	#And Project "US18087_DT14073_SJ" has Draft "Original Draft"	
	#And All Upper Case box is checked
	And I am logged in to Rave with username "defuser" and password "password"



	
@release_2012.1.0
@PB_US18087_DT14073_01
@Draft
Scenario: @IN_PROGRESS_PB_US18087_DT14073_01 As a Lab Administrator, when I create a name that is greater than 80 characters in Lab Admin, I do not see exception error message displayed.

	When I navigate to "Lab Administration"
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