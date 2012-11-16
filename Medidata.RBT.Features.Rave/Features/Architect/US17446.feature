# When saving Low and High ranges for Field Edit Check, an incorrect Invalid* error message is displayed even though the data is correctly saved to the database.
@ignore
Feature: US17446 
	When Low and High ranges for Field Edit Check are saved, an incorrect Invalid* error message is displayed even though the data is correctly saved to the database.
 	As a Study Developer
	When I enter Low and High ranges for Field Edit Check
	Then an Invalid* error message is displayed

Background:

Given xml draft "US17446_SJ.xml" is Uploaded
Given study "US17446_SJ" is assigned to Site "Site 1"
Given following Project assignments exist
| User         | Project    | Environment | Role         | Site   | SecurityRole          |
| SUPER USER 1 | US17446_SJ | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
Given I publish and push eCRF "US17446_SJ.xml" to "Version 1"
 
	#Given I login to Rave with user "defuser" and password "password"
	#And the following User permissions exist
		#| Module       | Project         | Role | Security Group | Deny Access |
		#| All Projects | Study Developer |      |                |             |
	#And the following Project assignments exist
		#| User    | Project    | Environment | Role | Site   | Site Number |
		#| defuser | US17446_SJ | Prod        | cdm1 | Site 1 | S100        |
	#And "Field Edit Checks" are set in "Configurion", "Other Settings", "Field Edit Checks"
		#|Type	|Marking Group ID	|Require Response	|Require Manual Close	|
		#|Required Field Checks	|Site	|True	|True	| 
		#|NonConformant Checks	|Site	|True	|False	|
		#|DateTime Checks	|Site	|False	|True	| 
		#|Out Of Range Checks |Site	|True	|True	|
	#And Role "cdm1" has Action "Entry"
	#And Project "US17446_SJ" has Draft "Orginal Draft"
	#And Volume "US17446_SJ" has Draft "Orginal Draft"	
	#And Draft "Orginal Draft" has Form "TEXT" with fields
		#| FieldOID | Field Label| Format| Control Type |
		#| TEXT1	| Text 1     | 5     | Text         |
		#| TEXT2    | Text 2     | 5     | Text         |
		#| TEXT3    | Text 3     | 10    | Text         |
		#| TEXT4	| Text 4     | 10    | Text         |
		#| TEXT5    | Text 5     | 10    | Text         |
		#| TEXT6    | Text 6     | 5     | Text         |
	#And I login to Rave with user "defuser" and password "password"

@release_2012.1.0
@PB_US17446_01
@Validation

Scenario: @PB_US17446_01 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Projects" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT1"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                      | Low | High |
		| Auto-Query for data out of range      | 5   | 8    |
		| Mark non-conformant data out of range | 7   | 9    |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I edit Field "TEXT1"
	And I should see ranges for Field Edit Checks
	| Field Edit Check                      | Low | High |
	| Auto-Query for data out of range      | 5   | 8    |
	| Mark non-conformant data out of range | 7   | 9    |
	And I take a screenshot

@release_2012.1.0
@PB_US17446_02
@Validation


Scenario: @PB_US17446_02 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Projects" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT2"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                      | Low | High |
		| Auto-Query for data out of range      | 8   | 5    |
		| Mark non-conformant data out of range | 9   | 7    |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I verify text "Auto query edit check ranges are not valid" exists
	And I verify text "Non-conformant edit check ranges are not valid" exists
	And I edit Field "TEXT2"
	And I should not see ranges for Field Edit Checks
	| Field Edit Check                      | Low | High |
	| Auto-Query for data out of range      | 8   | 5    |
	| Mark non-conformant data out of range | 9   | 7    |
	And I take a screenshot

@release_2012.1.0
@PB_US17446_03
@Validation

Scenario: @PB_US17446_03 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Projects" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT3"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
	| Field Edit Check                      | Low        | High       |
	| Auto-Query for data out of range      | 1111111111 | 2222222222 |
	| Mark non-conformant data out of range | 3333333333 | 4444444444 |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I edit Field "TEXT3"
	And I should see ranges for Field Edit Checks
	| Field Edit Check                      | Low        | High       |
	| Auto-Query for data out of range      | 1111111111 | 2222222222 |
	| Mark non-conformant data out of range | 3333333333 | 4444444444 |
	And I take a screenshot

@release_2012.1.0
@PB_US17446_04
@Validation

Scenario: @PB_US17446_04 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Projects" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT4"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
	| Field Edit Check                      | Low        | High       |
	| Auto-Query for data out of range      | 2222222222 | 1111111111 |
	| Mark non-conformant data out of range | 4444444444 | 3333333333 |
	Then I verify text "Invalid*" does not exist
	And I verify text "Auto query edit check ranges are not valid" exists
	And I verify text "Non-conformant edit check ranges are not valid" exists
	And I edit Field "TEXT4"
	And I should not see ranges for Field Edit Checks
	| Field Edit Check                      | Low        | High       |
	| Auto-Query for data out of range      | 2222222222 | 1111111111 |
	| Mark non-conformant data out of range | 4444444444 | 3333333333 |
	And I take a screenshot


@release_2012.1.0
@PB_US17446_05
@Validation

Scenario: @PB_US17446_05 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Projects" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT5"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
	| Field Edit Check                      | Low        | High       |
	| Auto-Query for data out of range      | aaaaaaaaaa | bbbbbbbbbb |
	| Mark non-conformant data out of range | cccccccccc | dddddddddd |
	And I take a screenshot
	Then I verify text "Invalid*" exists
	And I edit Field "TEXT5"
	And I should not see ranges for Field Edit Checks
	| Field Edit Check                      | Low        | High       |
	| Auto-Query for data out of range      | aaaaaaaaaa | bbbbbbbbbb |
	| Mark non-conformant data out of range | cccccccccc | dddddddddd |
	And I take a screenshot

		

@release_2012.1.0
@PB_US17446_06
@Validation

Scenario: @PB_US17446_06 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Projects" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT6"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
	| Field Edit Check                      | Low | High |
	| Auto-Query for data out of range      | 150 | 170  |
	| Mark non-conformant data out of range | 250 | 270  |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I edit Field "TEXT6"
	And I should see ranges for Field Edit Checks
	| Field Edit Check                      | Low | High |
	| Auto-Query for data out of range      | 150 | 170  |
	| Mark non-conformant data out of range | 250 | 270  |
	And I take a screenshot
	
	

@release_2012.1.0
@PB_US17446_07
@Validation

Scenario: @PB_US17446_07 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Projects" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT5"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
	| Field Edit Check                 | Low | High |
	| Auto-Query for data out of range | 150 | 170  |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I edit Field "TEXT5"
	And I should see ranges for Field Edit Checks
	| Field Edit Check                 | Low | High |
	| Auto-Query for data out of range | 150 | 170  |
	And I take a screenshot


@release_2012.1.0
@PB_US17446_08
@Validation

Scenario: @PB_US17446_08 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Projects" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT5"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
	| Field Edit Check                      | Low | High |
	| Mark non-conformant data out of range | 250 | 270  |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I edit Field "TEXT5"
	And I should see ranges for Field Edit Checks
	| Field Edit Check                      | Low | High |
	| Mark non-conformant data out of range | 250 | 270  |
	And I take a screenshot



#Check for Global Library Volumes

@release_2012.1.0
@PB_US17446_09
@Draft
Scenario: @PB_US17446_09 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.

	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Global Library Volumes" 	
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT1"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                      | Low | High |
		| Auto-Query for data out of range      | 5   | 8    |
		| Mark non-conformant data out of range | 7   | 9    |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I edit Field "TEXT1"
	And I should see ranges for Field Edit Checks
		| Field Edit Check                      | Low | High |
		| Auto-Query for data out of range      | 5   | 8    |
		| Mark non-conformant data out of range | 7   | 9    |
	And I take a screenshot

@release_2012.1.0
@PB_US17446_010
@Draft
Scenario: @PB_US17446_010 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Global Library Volumes"  
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT2"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                      | Low | High |
		| Auto-Query for data out of range      | 8   | 5    |
		| Mark non-conformant data out of range | 9   | 7    |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I verify text "Auto query edit check ranges are not valid" exists
	And I verify text "Non-conformant edit check ranges are not valid" exists
	And I edit Field "TEXT2"
	And I should not see ranges for Field Edit Checks
		| Field Edit Check                      | Low | High |
		| Auto-Query for data out of range      | 8   | 5    |
		| Mark non-conformant data out of range | 9   | 7    |
	And I take a screenshot

@release_2012.1.0
@PB_US17446_011
@Draft
Scenario: @PB_US17446_011 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Global Library Volumes" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT3"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                      | Low        | High       |
		| Auto-Query for data out of range      | 1111111111 | 2222222222 |
		| Mark non-conformant data out of range | 3333333333 | 4444444444 |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I edit Field "TEXT3"
	And I should see ranges for Field Edit Checks
		| Field Edit Check                      | Low        | High       |
		| Auto-Query for data out of range      | 1111111111 | 2222222222 |
		| Mark non-conformant data out of range | 3333333333 | 4444444444 |
	And I take a screenshot

@release_2012.1.0
@PB_US17446_012
@Draft
Scenario: @PB_US17446_012 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Global Library Volumes"  
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT4"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                      | Low        | High       |
		| Auto-Query for data out of range      | 2222222222 | 1111111111 |
		| Mark non-conformant data out of range | 4444444444 | 3333333333 |
	Then I verify text "Invalid*" does not exist
	And I verify text "Auto query edit check ranges are not valid" exists
	And I verify text "Non-conformant edit check ranges are not valid" exists
	And I edit Field "TEXT4"
	And I should not see ranges for Field Edit Checks
		| Field Edit Check                      | Low        | High       |
		| Auto-Query for data out of range      | 2222222222 | 1111111111 |
		| Mark non-conformant data out of range | 4444444444 | 3333333333 |
	And I take a screenshot

@release_2012.1.0
@PB_US17446_013
@Draft
Scenario: @PB_US17446_013 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Global Library Volumes" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT5"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                      | Low        | High       |
		| Auto-Query for data out of range      | aaaaaaaaaa | bbbbbbbbbb |
		| Mark non-conformant data out of range | cccccccccc | dddddddddd |
	And I take a screenshot
	Then I verify text "Invalid*" exists
	And I edit Field "TEXT5"
	And I should not see ranges for Field Edit Checks
		| Field Edit Check                      | Low        | High       |
		| Auto-Query for data out of range      | aaaaaaaaaa | bbbbbbbbbb |
		| Mark non-conformant data out of range | cccccccccc | dddddddddd |
	And I take a screenshot

@release_2012.1.0
@PB_US17446_014
@Draft
Scenario: @PB_US17446_014 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Global Library Volumes" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT6"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                      | Low | High |
		| Auto-Query for data out of range      | 150 | 170  |
		| Mark non-conformant data out of range | 250 | 270  |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I edit Field "TEXT6"
	And I should see ranges for Field Edit Checks
		| Field Edit Check                      | Low | High |
		| Auto-Query for data out of range      | 150 | 170  |
		| Mark non-conformant data out of range | 250 | 270  |
	And I take a screenshot
	
@release_2012.1.0
@PB_US17446_015
@Draft
Scenario: @PB_US17446_015 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Global Library Volumes" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT5"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                 | Low | High |
		| Auto-Query for data out of range | 150 | 170  |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I edit Field "TEXT5"
	And I should see ranges for Field Edit Checks
		| Field Edit Check                 | Low | High |
		| Auto-Query for data out of range | 150 | 170  |
	And I take a screenshot

@release_2012.1.0
@PB_US17446_016
@Draft
Scenario: @PB_US17446_016 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	
	When I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Global Library Volumes" 
	And I select Draft "Orginal Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I edit Field "TEXT5"
	And I expand "Field Edit Checks"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                      | Low | High |
		| Mark non-conformant data out of range | 250 | 270  |
	And I take a screenshot
	Then I verify text "Invalid*" does not exist
	And I edit Field "TEXT5"
	And I should see ranges for Field Edit Checks
		| Field Edit Check                      | Low | High |
		| Mark non-conformant data out of range | 250 | 270  |
	And I take a screenshot	

@release_2012.1.0
@PB_US17446_017
@Draft
Scenario: @PB_US17446_017 As an EDC user, when I enter out of range data and save the form, then I should see queries for field edit checks.
	
	And I navigate to "Architect"
	And I select link "US17446_SJ" in "Active Projects"
	And I select link "Orginal Draft" in "CRF Drafts"
	And I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion1#"
	And I select link "US17446_SJ" in "Header"
	And I push CRF Version "{Var(newversion1#)}" to "All Sites"
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |		
		| Subject Number   | {RndNum<num1>(3)} |
	And I select Form "TEXT"
	When I enter data in CRF and save
	    |Field  |Data 	|
        |TEXT 1 |4    	|
	    |TEXT 3 |1111   |
	    |TEXT 6 |180    |
	Then I verify Query is displayed
		| Field  | Query Message               | 
		| TEXT 1 | Out of Range Checks Message |
		| TEXT 3 | Out of Range Checks Message | 		
		| TEXT 6 | Out of Range Checks Message | 		
	And I take a screenshot
	When I enter data in CRF and save
	    |Field  |Data 	|
        |TEXT 1 |10    	|
	    |TEXT 3 |3333   |
	    |TEXT 6 |240    |
	Then I verify Query is displayed
		| Field  | Query Message               | 
		| TEXT 1 | Out of Range Checks Message |
		| TEXT 3 | Out of Range Checks Message | 		
		| TEXT 6 | Out of Range Checks Message | 		
	And I take a screenshot		
	When I enter data in CRF and save
	    |Field  |Data 	|
        |TEXT 1 |6    	|
	Then I verify Query is displayed
		| Field  | Query Message               | 
		| TEXT 1 | Out of Range Checks Message |
	And I take a screenshot	