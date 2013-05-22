@FT_MCC_59886

Feature: MCC_59886_US17446_DT14276_DT12566 When saving Low and High ranges for Field Edit Check, an incorrect Invalid* error message is displayed even though the data is correctly saved to the database.
    When Low and High ranges for Field Edit Check are saved, an incorrect Invalid* error message is displayed even though the data is correctly saved to the database.
     As a Study Developer
    When I enter Low and High ranges for Field Edit Check
    Then an Invalid* error message is displayed

Background:
Given role "MCC-59886_SUPERROLE" exists
Given xml draft "MCC-59886_GL.xml" is Uploaded
Given xml draft "MCC-59886.xml" is Uploaded
Given study "MCC-59886" is assigned to Site "Site 1"
Given following Project assignments exist
| User         | Project    | Environment | Role            | Site   | SecurityRole          | GlobalLibraryRole            |
| SUPER USER 1 | MCC-59886  | Live: Prod  | MCC-59886_SUPERROLE    | Site 1 | Project Admin Default | Global Library Admin Default |
Given I publish and push eCRF "MCC-59886.xml" to "Version 1"

@release_2013.2.0
@PB_MCC_59886_US17446_DT14276_DT12566_01
@Validation

Scenario: PB_MCC_59886_US17446_DT14276_DT12566_01 As Study Developer, when I save Low and High ranges for Field Edit Check on a new field, I do not see an Invalid* error message.

	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Architect"
	And I select "Project" link "MCC-59886" in "Active Projects"
	And I select Draft "Original Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I select link "Add New"
	And I expand "Field Edit Checks"
	And I enter data in Architect Field
		| Field       | Data  | ControlType |
		| VarOID      | Test1 | textbox     |
		| Format      | 3     | textbox     |
		| Field Name  | Test1 | textbox     |
		| Field OID   | Test1 | textbox     |
		| Field Label | Test1 | textarea    |
	And I check "Auto-Query for non-conformant data"
	And I enter ranges for Field Edit Checks and save
	    | Field Edit Check                      | Low | High |
	    | Auto-Query for data out of range      | 5   | 8    |
	    
	Then I verify text "Invalid*" does not exist    
	And I take a screenshot   

@release_2013.2.0
@PB_MCC_59886_US17446_DT14276_DT12566_02
@Validation


Scenario: PB_MCC_59886_US17446_DT14276_DT12566_02 As Study Developer, when I save Low and High ranges for Field Edit Check on a new field, I do not see an Invalid* error message.

	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Architect"
	And I select "Project" link "MCC-59886" in "Active Projects"
	And I select Draft "Original Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"	
	And I select link "Add New"
	And I expand "Field Edit Checks"
	And I enter data in Architect Field
		| Field       | Data  | ControlType |
		| VarOID      | Test2 | textbox     |
		| Format      | 3     | textbox     |
		| Field Name  | Test2 | textbox     |
		| Field OID   | Test2 | textbox     |
		| Field Label | Test2 | textarea    |
	And I check "Auto-Query for non-conformant data"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                      | Low | High |
		| Mark non-conformant data out of range | 700 | 900  |
	Then I verify text "Invalid*" does not exist    
	And I take a screenshot  

	
@release_2013.2.0
@PB_MCC_59886_US17446_DT14276_DT12566_03
@Validation



Scenario: PB_MCC_59886_US17446_DT14276_DT12566_03 As Study Developer, when I save Low and High ranges for Field Edit Check on a new field, I do not see an Invalid* error message.

	Given I login to Rave with user "SUPER USER 1"	
	And I navigate to "Architect"
	And I select "Project" link "MCC-59886_GL" in "Active Global Library Volumes" 
	And I select Draft "Original Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I select link "Add New"
	And I expand "Field Edit Checks"
	And I enter data in Architect Field
		| Field       | Data  | ControlType |
		| VarOID      | Test3 | textbox     |
		| Format      | 15    | textbox     |
		| Field Name  | Test3 | textbox     |
		| Field OID   | Test3 | textbox     |
		| Field Label | Test3 | textarea    |
	And I check "Auto-Query for non-conformant data"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                 | Low    | High   |
		| Auto-Query for data out of range | 555555 | 888888 |
	Then I verify text "Invalid*" does not exist    
	And I take a screenshot 




@release_2013.2.0
@PB_MCC_59886_US17446_DT14276_DT12566_04
@Validation



Scenario: PB_MCC_59886_US17446_DT14276_DT12566_04 As Study Developer, when I save Low and High ranges for Field Edit Check on a new field, I do not see an Invalid* error message.



	Given I login to Rave with user "SUPER USER 1"	
	And I navigate to "Architect"
	And I select "Project" link "MCC-59886_GL" in "Active Global Library Volumes" 
	And I select Draft "Original Draft"
	And I navigate to "Forms"
	And I select Fields for Form "TEXT"
	And I select link "Add New"
	And I expand "Field Edit Checks"
	And I enter data in Architect Field
		| Field       | Data  | ControlType |
		| VarOID      | Test4 | textbox     |
		| Format      | 3     | textbox     |
		| Field Name  | Test4 | textbox     |
		| Field OID   | Test4 | textbox     |
		| Field Label | Test4 | textarea    |
	And I check "Auto-Query for non-conformant data"
	And I enter ranges for Field Edit Checks and save
		| Field Edit Check                      | Low | High |
		| Mark non-conformant data out of range | 7   | 9    |
	Then I verify text "Invalid*" does not exist    
	And I take a screenshot
	

	