@MCC-52154
Feature: MCC-52154 Matrices can be added multiple times through Add Event even when Max add value is set to 1

Background:

Given xml draft "MCC-52154.xml" is Uploaded
Given Site "Site_A" exists
Given study "MCC-52154" is assigned to Site "Site_A"
Given role "SUPER ROLE 1" exists
Given I publish and push eCRF "MCC-52154.xml" to "Version 1"
Given following Project assignments exist
| User          | Project   | Environment | Role         | Site   | SecurityRole          |
| SUPER USER 1  | MCC-52154 | Live: Prod  | SUPER ROLE 1 | Site_A | Project Admin Default |

#Note: 1) Unscheduled Visit Matrix Max value is set to 1, unassigned to multiple folders on subject level.
#Note: 2) Base Matrix Max value is set to 1, assigned to multiple folders on subject level.

@Release_2013.4.0
@PB_MCC-52154-01B
@RR09.SEP.2013
@Draft
Scenario: MCC-52154-01B As a EDC user, On subject calendar view page, when I add Matrix with Max value set to 1 on tab1, then the matrix should be added only once on tab1, and matrix should not be available for selection in the list on tab1, and the matrix should not be available for selection in the list on tab2 and tab3 when page is refreshed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-52154" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Matrices"
And I verify rows exist in "Matrices" table
 |Name             |OID     |Allow Add  |Max |
 |Unscheduled Visit|UNSCHVS |checked    |1   |
And I take a screenshot
And I select link "Folder Forms" in "Unscheduled Visit"
And I verify rows exist in "FolderForms" table
 |Forms        |Subject   |Unscheduled Visit |Screening |Baseline  |
 |Primary form |unchecked |unchecked         |unchecked |unchecked |
 |Form1        |unchecked |checked           |unchecked |unchecked |
 |Form2        |unchecked |unchecked         |unchecked |unchecked |
 |Form3        |unchecked |unchecked         |unchecked |unchecked |
And I take a screenshot
And I navigate to "Home"
And I select Study "MCC-52154" and Site "Site_A"
And I create a Subject
 |Field              |Data              |Control Type |
 |Subject Initials   |SUB               |textbox      |
 |Subject Number     |{RndNum<num1>(3)} |textbox      |
 |Subject ID 	     |SUB {Var(num1)}   |textbox      |
And I take a screenshot 
And I open link "SUB {Var(num1)}" in new tab
And I open link "SUB {Var(num1)}" in new tab
And I take a screenshot
And I switch to tab "1" 
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "2" 
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "3"
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "1" 
And I choose "Unscheduled Visit" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I verify text "Unscheduled Visit (1)" exists in "Left Navigation List"
And I take a screenshot 
And I expand "dropdown" in area "Add Event"
And I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "2"
And I refresh the current browser window
When I expand "dropdown" in area "Add Event"
Then I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I verify text "Unscheduled Visit (2)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "3"
And I refresh the current browser window 
When I expand "dropdown" in area "Add Event"
Then I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I verify text "Unscheduled Visit (3)" does not exist in "Left Navigation List"
And I take a screenshot

@Release_2013.4.0
@PB_MCC-52154-02B
@RR09.SEP.2013
@Draft
Scenario: MCC-52154-02B As a EDC user, On subject grid view page, when I add Matrix with Max value set to 1 on tab1, then the matrix should be added only once on tab1, and matrix should not be available for selection in the list on tab1, and the matrix should not be available for selection in the list on tab2 and tab3 when page is refreshed.

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-52154" and Site "Site_A"
And I create a Subject
 |Field              |Data              |Control Type |
 |Subject Initials   |SUB               |textbox      |
 |Subject Number     |{RndNum<num1>(3)} |textbox      |
 |Subject ID 	     |SUB {Var(num1)}   |textbox      |
And I take a screenshot
And I open link "SUB {Var(num1)}" in new tab
And I open link "SUB {Var(num1)}" in new tab
And I take a screenshot
And I switch to tab "1" 
And I select link "Grid View"
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "2"
And I select link "Grid View" 
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "3"
And I select link "Grid View" 
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "1" 
And I choose "Unscheduled Visit" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I verify text "Unscheduled Visit (1)" exists in "Left Navigation List"
And I take a screenshot 
And I expand "dropdown" in area "Add Event"
And I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "2"
And I refresh the current browser window
And I select link "Grid View"  
When I expand "dropdown" in area "Add Event"
Then I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I verify text "Unscheduled Visit (2)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "3"
And I refresh the current browser window
And I select link "Grid View"  
When I expand "dropdown" in area "Add Event"
Then I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I verify text "Unscheduled Visit (3)" does not exist in "Left Navigation List"
And I take a screenshot

@Release_2013.4.0
@PB_MCC-52154-03B
@RR09.SEP.2013
@Draft
Scenario: MCC-52154-03B As a EDC user, On subject calendar view page, when I add Matrix with Max value set to 1 on tab1, then the matrix folders should be added only once on tab1, and matrix should not be available for selection in the list on tab1, and the matrix should be available for selection in the list on tab2 and tab3 when try to add matrix on tab2 and tab3 then the matrix should not be added on tab2 and tab3.
 

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-52154" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Matrices"
And I verify rows exist in "Matrices" table
 |Name |OID  |Allow Add  |Max |
 |Base |BASE |checked    |1   |
And I take a screenshot 
And I select link "Folder Forms" in "Base"
And I verify rows exist in "FolderForms" table
 |Forms        |Subject   |Unscheduled Visit |Screening |Baseline  |
 |Primary form |unchecked |unchecked         |unchecked |unchecked |
 |Form1        |unchecked |checked           |checked   |checked   |
 |Form2        |unchecked |unchecked         |unchecked |unchecked |
 |Form3        |unchecked |unchecked         |unchecked |unchecked |
And I take a screenshot 
And I navigate to "Home"
And I select Study "MCC-52154" and Site "Site_A"
And I create a Subject
 |Field              |Data              |Control Type |
 |Subject Initials   |SUB               |textbox      |
 |Subject Number     |{RndNum<num1>(3)} |textbox      |
 |Subject ID 	     |SUB {Var(num1)}   |textbox      |
And I take a screenshot 
And I open link "SUB {Var(num1)}" in new tab
And I open link "SUB {Var(num1)}" in new tab
And I take a screenshot
And I switch to tab "1" 
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I verify text "Screening (1)" does not exist in "Left Navigation List"
And I verify text "Baseline (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "2" 
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I verify text "Screening (1)" does not exist in "Left Navigation List"
And I verify text "Baseline (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "3"
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I verify text "Screening (1)" does not exist in "Left Navigation List"
And I verify text "Baseline (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "1" 
And I choose "Base" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I verify text "Unscheduled Visit (1)" exists in "Left Navigation List"
And I verify text "Screening (1)" exists in "Left Navigation List"
And I verify text "Baseline (1)" exists in "Left Navigation List"
And I take a screenshot 
And I expand "dropdown" in area "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "2"
And I verify option "Base" exists in "Add Event" dropdown
And I choose "Base" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I verify text "Unscheduled Visit (2)" does not exist in "Left Navigation List"
And I verify text "Screening (2)" does not exist in "Left Navigation List" 
And I verify text "Baseline (2)" does not exist in "Left Navigation List" 
And I take a screenshot
And I expand "dropdown" in area "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "3"
And I verify option "Base" exists in "Add Event" dropdown
And I choose "Base" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I verify text "Unscheduled Visit (3)" does not exist in "Left Navigation List"
And I verify text "Screening (3)" does not exist in "Left Navigation List" 
And I verify text "Baseline (3)" does not exist in "Left Navigation List" 
And I take a screenshot
And I expand "dropdown" in area "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot

@Release_2013.4.0
@PB_MCC-52154-04B
@RR09.SEP.2013
@Draft
Scenario: MCC-52154-04B As a EDC user, On subject grid view page, when I add Matrix with Max value set to 1 on tab1, then the matrix folders should be added only once on tab1, and matrix should not be available for selection in the list on tab1, and the matrix should be available for selection in the list on tab2 and tab3 when try to add matrix on tab2 and tab3 then the matrix should not be added on tab2 and tab3. 

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-52154" and Site "Site_A"
And I create a Subject
 |Field              |Data              |Control Type |
 |Subject Initials   |SUB               |textbox      |
 |Subject Number     |{RndNum<num1>(3)} |textbox      |
 |Subject ID 	     |SUB {Var(num1)}   |textbox      |
And I take a screenshot
And I open link "SUB {Var(num1)}" in new tab
And I open link "SUB {Var(num1)}" in new tab
And I take a screenshot
And I switch to tab "1" 
And I select link "Grid View"
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I verify text "Screening (1)" does not exist in "Left Navigation List"
And I verify text "Baseline (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "2"
And I select link "Grid View" 
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I verify text "Screening (1)" does not exist in "Left Navigation List"
And I verify text "Baseline (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "3"
And I select link "Grid View" 
And I verify text "Unscheduled Visit (1)" does not exist in "Left Navigation List"
And I verify text "Screening (1)" does not exist in "Left Navigation List"
And I verify text "Baseline (1)" does not exist in "Left Navigation List"
And I take a screenshot
And I switch to tab "1" 
And I choose "Base" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I verify text "Unscheduled Visit (1)" exists in "Left Navigation List"
And I verify text "Screening (1)" exists in "Left Navigation List"
And I verify text "Baseline (1)" exists in "Left Navigation List"
And I take a screenshot 
And I expand "dropdown" in area "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "2"
And I verify option "Base" exists in "Add Event" dropdown
And I choose "Base" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I verify text "Unscheduled Visit (2)" does not exist in "Left Navigation List"
And I verify text "Screening (2)" does not exist in "Left Navigation List" 
And I verify text "Baseline (2)" does not exist in "Left Navigation List" 
And I take a screenshot
And I expand "dropdown" in area "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "3"
And I verify option "Base" exists in "Add Event" dropdown
And I choose "Base" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I verify text "Unscheduled Visit (3)" does not exist in "Left Navigation List"
And I verify text "Screening (3)" does not exist in "Left Navigation List" 
And I verify text "Baseline (3)" does not exist in "Left Navigation List" 
And I take a screenshot
And I expand "dropdown" in area "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot