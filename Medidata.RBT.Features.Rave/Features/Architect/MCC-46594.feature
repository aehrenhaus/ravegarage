#@ignore
@FT_MCC-46594
Feature: MCC-46594 When I Save a new check using Quick Edit, it brought to the Check Steps for the new check.

Background:

 	Given role "SUPER ROLE 1" exists
	Given xml draft "MCC-46594AL.xml" is Uploaded
	Given xml draft "MCC-46594GL.xml" is Uploaded
    Given study "MCC-46594AL" is assigned to Site "Site 1"
    Given following Project assignments exist
    | User         | Project     | Environment | Role         | Site   | SecurityRole          | GlobalLibraryRole            |
    | SUPER USER 1 | MCC-46594AL | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | Global Library Admin Default |
   
	

@Release_2013.2.0
@PBMCC46594-001
@SJ4.APR.2013
@Validation

Scenario: PBMCC46594-001 When I Save a new check using Quick Edit in Architect Draft, I am brought to the Check Steps for the new check.

	When I login to Rave with user "SUPER USER 1"
	And I navigate to "Architect"
	And I select "Project" link "MCC-46594AL" in "Active Projects" 
	And I select Draft "Draft 1"
	And I navigate to "Edit Checks"
	And I select link "Add Check"
	And I create Edit Check
	| Name           | Bypass During Migration | Active |
	| QuickEditCheck | False                   | True   |
	And I click on icon "Check Steps" for Edit Check "QuickEditCheck"
	Then I verify tab name "QuickEditCheck"
	And I take a screenshot
	And I select link "Quick Edit"
	And I enter into Quick Edit "|QuickEditCheck_1|True|False"
	And I take a screenshot
	And I click button "Save"
	Then I verify tab name "QuickEditCheck_1"
	And I take a screenshot



@Release_2013.2.0
@PBMCC46594-002
@SJ4.APR.2013
@Validation
Scenario: PBMCC46594-002 When I Save an existing edit check using Quick Edit in Architect Draft, I am brought to the Check Steps for the existing check.



	When I login to Rave with user "SUPER USER 1"
	And I navigate to "Architect"
	And I select "Project" link "MCC-46594AL" in "Active Projects" 
	And I select Draft "Draft 1"
	And I navigate to "Edit Checks"
	And I click on icon "Check Steps" for Edit Check "Set Subject Status"
	Then I verify tab name "Set Subject Status"
	And I take a screenshot
	And I select link "Quick Edit"
	And I enter into Quick Edit "|Set Subject Status 1|True|False"
	And I take a screenshot
	And I click button "Save"
	Then I verify tab name "Set Subject Status 1"
	And I take a screenshot



@Release_2013.2.0
@PBMCC46594-003
@SJ4.APR.2013
@Validation

Scenario: PBMCC46594-003 When I Save a new check using Quick Edit in Global Library Volumes Draft, I am brought to the Check Steps for the new check.

	When I login to Rave with user "SUPER USER 1"
	And I navigate to "Architect"
	And I select "Project" link "MCC-46594GL" in "Active Global Library Volumes" 
	And I select Draft "Draft 1"
	And I navigate to "Edit Checks"
	And I select link "Add Check"
	And I create Edit Check
	| Name           | Bypass During Migration | Active |
	| QuickEditCheck | False                   | True   |
	And I click on icon "Check Steps" for Edit Check "QuickEditCheck"
	Then I verify tab name "QuickEditCheck"
	And I take a screenshot
	And I select link "Quick Edit"
	And I enter into Quick Edit "|QuickEditCheck_1|True|False"
	And I take a screenshot
	And I click button "Save"
	Then I verify tab name "QuickEditCheck_1"
	And I take a screenshot



@Release_2013.2.0
@PBMCC46594-004
@SJ4.APR.2013
@Validation
Scenario: PBMCC46594-004 When I Save an existing edit check using Quick Edit in Global Library Volumes Draft, I am brought to the Check Steps for the existing check.


	When I login to Rave with user "SUPER USER 1"
	And I navigate to "Architect"
	And I select "Project" link "MCC-46594GL" in "Active Global Library Volumes" 
	And I select Draft "Draft 1"
	And I navigate to "Edit Checks"
	And I click on icon "Check Steps" for Edit Check "Set Subject Status"
	Then I verify tab name "Set Subject Status"
	And I take a screenshot
	And I select link "Quick Edit"
	And I enter into Quick Edit "|Set Subject Status 1|True|False"
	And I take a screenshot
	And I click button "Save"
	Then I verify tab name "Set Subject Status 1"
	And I take a screenshot