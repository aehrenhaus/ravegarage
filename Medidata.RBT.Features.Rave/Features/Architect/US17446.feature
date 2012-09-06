# When saving Low and High ranges for Field Edit Check, an incorrect Invalid* error message is displayed even though the data is correctly saved to the database.

Feature: US17446 
	When Low and High ranges for Field Edit Check are saved, an incorrect Invalid* error message is displayed even though the data is correctly saved to the database.
 	As a Study Developer
	When I enter Low and High ranges for Field Edit Check
	Then an Invalid* error message is displayed

 Background:
	#Given I am logged in to Rave with username "defuser" and password "password"
	#And the following User permissions exist
	#| Module       | Project         | Role | Security Group | Deny Access |
	#| All Projects | Study Developer |      |                |             |
	#And the following Project assignments exist
	#| User    | Project    | Environment | Role | Site   | Site Number |
	#| defuser | US17446_SJ | Prod        | cdm1 | Site 1 | S100        |
	#And Role "cdm1" has Action "Entry"
	#And Project "US17446_SJ" has Draft "Orginal Draft"
	#And Draft "Orginal Draft" has Form "TEXT" with fields
	#| FieldOID | Field Label| Format| Control Type |
	#| TEXT1	| Text 1     | 5     | Text         |
	#| TEXT2    | Text 2     | 5     | Text         |
	#| TEXT3    | Text 3     | 10    | Text         |
	#| TEXT4	| Text 4     | 10    | Text         |
	#| TEXT5    | Text 5     | 10    | Text         |
	#| TEXT6    | Text 6     | 5     | Text         |

	And I am logged in to Rave with username "defuser" and password "password"

@release_2012.1.0
@PB_US17446_01
@Validation

Scenario: @PB_US17446_01 As Study Developer, when I save Low and High ranges for Field Edit Check, I do not see an Invalid* error message displayed.
	When I navigate to "Architect"
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
	Then I verify text "Invalid*" does not exist
	And I edit Field "TEXT5"
	And I should see ranges for Field Edit Checks
	| Field Edit Check                      | Low | High |
	| Mark non-conformant data out of range | 250 | 270  |
	And I take a screenshot
