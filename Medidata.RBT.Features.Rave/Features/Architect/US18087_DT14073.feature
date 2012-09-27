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




1. space before link names ONLY in Lab	
2. make methods DESCRIPTIVE.  not "Edit", but "I edit/modfiy global data dictionary".  language to be discussed with vikas
3. I verify global data dictionary with OID .... exists.  be specific.  
4. I delete... what?  Or I select link "delete"???

@release_2012.1.0
@PB_US18087_DT14073_01
@Draft
Scenario: @xxxxxxxxxxxxxxxxxxPB_US18087_DT14073_01 As a Lab Administrator, when I create a name that is greater than 80 characters in Lab Admin, I do not see exception error message displayed.

	When I navigate to "Lab Administration"
	And I select link " Global Data Dictionaries"
	And I select link "Add New"

	And I enter name for Name and save #It has 255 characters
	| Name                      																		   |	
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name|
	Then I verify Global Data Dictionaries name "1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name" exist    
	And I take a screenshot

	Then I verify Global Daictionarhy with OID exist where???
	| OID												 |
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN | 	
	And I Edit "1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name"
	And I enter name for Name and save #It has 255 characters
	| Name     																							   |
	| 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test|
	Then I verify Global Data Dictionaries name "1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID												 | 
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN |
	And I Delete "1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test"
	And I select link "Add New"
	And I enter name for Name and save #It has 41 characters
	| Name  																							    |
	| abc123 abc123 abc123 abc123 abc123 abc123 |
	Then I verify Global Data Dictionaries name "abc123 abc123 abc123 abc123 abc123 abc123" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID                                  |
	| ABC123ABC123ABC123ABC123ABC123ABC123 |
	And I Delete "abc123 abc123 abc123 abc123 abc123 abc123"
	And I select link "Add New"
	And I enter name for Name and save #It has 33 characters
	| Name 																									|
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	Then I verify Global Data Dictionaries name "!@#$%^&*()abc123 !@#$%^&*()abc123" exist
	And I take a screenshot	
	Then I verify OID exist 
	| OID|
	| ABC123ABC123 						|
	And I Delete "!@#$%^&*()abc123 !@#$%^&*()abc123" 
	And I select link "Add New"
	And I enter name for Name and save #It has 86 characters
	| Name  																								|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa				|
	Then I verify Global Data Dictionaries name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID|
	| AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |
	And I Edit "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	And I enter name for Name and save #It has 86 characters
	| Name 																									|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz				|
	Then I verify Global Data Dictionaries name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz" exist
	And I take a screenshot
	And I select link "Add New"
	And I enter name for Name and save #It has 86 characters
	| Name  																								|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa				|
	Then I verify Global Data Dictionaries name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" exist
	And I take a screenshot
	Then I verify Global Data Dictionaries does not have duplicate IOD
	And I Delete "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz"
	And I Delete "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	And I take a screenshot



@release_2012.1.0
@PB_US18087_DT14073_02
@Draft
Scenario: @PB_US18087_DT14073_02 As a Lab Administrator, when I create a name that is greater than 80 characters in Lab Admin, I do not see exception error message displayed.

	When I navigate to "Lab Administration"
	And I select link "Global Unit Dictionaries"
	And I select link "Add New"
	And I enter name for Name and save #It has 255 characters
	| Name                      																		   |	
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name|
	Then I verify Global Unit Dictionaries name "1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name" exist    
	And I take a screenshot
	Then I verify OID exist 
	| OID												 |
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN | 	
	And I Edit "1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name"
	And I enter name for Name and save #It has 255 characters
	| Name     																							   |
	| 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test|
	Then I verify Global Unit Dictionaries name "1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID												 | 
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN |
	And I Delete "1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test"
	And I select link "Add New"
	And I enter name for Name and save #It has 41 characters
	| Name  																							    |
	| abc123 abc123 abc123 abc123 abc123 abc123 |
	Then I verify Global Unit Dictionaries name "abc123 abc123 abc123 abc123 abc123 abc123" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID |
	| ABC123ABC123ABC123ABC123ABC123ABC123 | 
	And I Delete "abc123 abc123 abc123 abc123 abc123 abc123"
	And I select link "Add New"
	And I enter name for Name and save #It has 33 characters
	| Name 																									|
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	Then I verify Global Unit Dictionaries name "!@#$%^&*()abc123 !@#$%^&*()abc123" exist
	And I take a screenshot	
	Then I verify OID exist 
	| OID|
	| ABC123ABC123 						|
	And I Delete "!@#$%^&*()abc123 !@#$%^&*()abc123" 
	And I select link "Add New"
	And I enter name for Name and save #It has 86 characters
	| Name  																								|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa				|
	Then I verify Global Unit Dictionaries name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID|
	| AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |
	And I Edit "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	And I enter name for Name and save #It has 86 characters
	| Name 																									|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz				|
	Then I verify Global Unit Dictionaries name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz" exist
	And I take a screenshot
	And I select link "Add New"
	And I enter name for Name and save #It has 86 characters
	| Name  																								|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa				|
	Then I verify Global Unit Dictionaries name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" exist
	And I take a screenshot
	Then I verify Global Unit Dictionaries does not have duplicate IOD
	And I Delete "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz"
	And I Delete "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	And I take a screenshot



@release_2012.1.0
@PB_US18087_DT14073_03
@Draft
Scenario: @PB_US18087_DT14073_03 As a Lab Administrator, when I create a name that is greater than 80 characters in Lab Admin, I do not see exception error message displayed
	
	When I navigate to "Lab Administration"
	And I select link "Global Variables"
	And I select link "Add New"
	And I enter name for Name and save #It has 255 characters
	| Name                      																		   |	
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name|
	Then I verify Global Variables name "1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name" exist    
	And I take a screenshot
	Then I verify OID exist 
	| OID												 |
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN | 	
	And I Edit "1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name"
	And I enter name for Name and save #It has 255 characters
	| Name     																							   |
	| 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test|
	Then I verify Global Variables name "1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID												 | 
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN |
	And I Delete "1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test"
	And I select link "Add New"
	And I enter name for Name and save #It has 41 characters
	| Name  																							    |
	| abc123 abc123 abc123 abc123 abc123 abc123 |
	Then I verify Global Variables name "abc123 abc123 abc123 abc123 abc123 abc123" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID |
	| ABC123ABC123ABC123ABC123ABC123ABC123 | 
	And I Delete "abc123 abc123 abc123 abc123 abc123 abc123"
	And I select link "Add New"
	And I enter name for Name and save #It has 33 characters
	| Name 																									|
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	Then I verify Global Variables name "!@#$%^&*()abc123 !@#$%^&*()abc123" exist
	And I take a screenshot	
	Then I verify OID exist 
	| OID|
	| ABC123ABC123 						|
	And I Delete "!@#$%^&*()abc123 !@#$%^&*()abc123" 
	And I select link "Add New"
	And I enter name for Name and save #It has 86 characters
	| Name  																								|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa				|
	Then I verify Global Variables name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID|
	| AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |
	And I Edit "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	And I enter name for Name and save #It has 86 characters
	| Name 																									|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz				|
	Then I verify Global Variables name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz" exist
	And I take a screenshot
	And I select link "Add New"
	And I enter name for Name and save #It has 86 characters
	| Name  																								|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa				|
	Then I verify Global Variables name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" exist
	And I take a screenshot
	Then I verify Global Variables does not have duplicate IOD
	And I Delete "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz"
	And I Delete "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	And I take a screenshot



@release_2012.1.0
@PB_US18087_DT14073_04
@Draft
Scenario: @PB_US18087_DT14073_04 As a Lab Administrator, when I create a name that is greater than 80 characters in Lab Admin, I do not see exception error message displayed
	
	When I navigate to "Lab Administration"
	And I select link "Lab Unit Dictionaries"
	And I select link "Add New"
	And I enter name for Name and save #It has 255 characters
	| Name                      																		   |	
	| 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name|
	Then I verify Lab Unit Dictionaries name "1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name" exist    
	And I take a screenshot
	Then I verify OID exist 
	| OID												 |
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN | 	
	And I Edit "1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name Name 1 Name Name Name Name Name Name Name Name Name Name"
	And I enter name for Name and save #It has 255 characters
	| Name     																							   |
	| 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test|
	Then I verify Lab Unit Dictionaries name "1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID												 | 
	| 1NAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMENAMEN |
	And I Delete "1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test Test 1 Test Test Test Test Test Test Test Test Test Test"
	And I select link "Add New"
	And I enter name for Name and save #It has 41 characters
	| Name  																							    |
	| abc123 abc123 abc123 abc123 abc123 abc123 |
	Then I verify Lab Unit Dictionaries name "abc123 abc123 abc123 abc123 abc123 abc123" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID |
	| ABC123ABC123ABC123ABC123ABC123ABC123 | 
	And I Delete "abc123 abc123 abc123 abc123 abc123 abc123"
	And I select link "Add New"
	And I enter name for Name and save #It has 33 characters
	| Name 																									|
	| !@#$%^&*()abc123 !@#$%^&*()abc123 |
	Then I verify Lab Unit Dictionaries name "!@#$%^&*()abc123 !@#$%^&*()abc123" exist
	And I take a screenshot	
	Then I verify OID exist 
	| OID|
	| ABC123ABC123 						|
	And I Delete "!@#$%^&*()abc123 !@#$%^&*()abc123" 
	And I select link "Add New"
	And I enter name for Name and save #It has 86 characters
	| Name  																								|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa				|
	Then I verify Lab Unit Dictionaries name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" exist
	And I take a screenshot
	Then I verify OID exist 
	| OID|
	| AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA |
	And I Edit "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	And I enter name for Name and save #It has 86 characters
	| Name 																									|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz				|
	Then I verify Lab Unit Dictionaries name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz" exist
	And I take a screenshot
	And I select link "Add New"
	And I enter name for Name and save #It has 86 characters
	| Name  																								|
	| aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa				|
	Then I verify Lab Unit Dictionaries name "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa" exist
	And I take a screenshot
	Then I verify Lab Unit Dictionaries does not have duplicate IOD
	And I Delete "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaz"
	And I Delete "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
	And I take a screenshot