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
#Note: 3) Second Visit Matrix Max value is set to 2, unassigned to multiple folders on subject level.

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
And I verify data on Matrices
 |Name             |OID     |Allow Add  |Max |
 |Unscheduled Visit|UNSCHVS |checked    |1   |
And I take a screenshot
And I click on icon "Folder Forms" for Matrices "Unscheduled Visit"
And I verify data on Matrices details page
 |Forms        |Subject |Unscheduled Visit |Screening |Baseline |
 |Primary form |uncheck |uncheck           |uncheck   |uncheck  |
 |Form1        |uncheck |check             |uncheck   |uncheck  |
 |Form2        |uncheck |uncheck           |uncheck   |uncheck  |
 |Form3        |uncheck |uncheck           |uncheck   |uncheck  |
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
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "2" 
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "3"
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "1" 
And I choose "Unscheduled Visit" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I should see folder added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (1) |
And I take a screenshot 
And I click drop button on "Add Event"
And I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "2"
And I select link "SUB {Var(num1)}"
When I click drop button on "Add Event"
Then I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "3"
And I select link "SUB {Var(num1)}" 
When I click drop button on "Add Event"
Then I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
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
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "2"
And I select link "Grid View" 
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "3"
And I select link "Grid View" 
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "1" 
And I choose "Unscheduled Visit" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I should see folder added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (1) |
And I take a screenshot 
And I click drop button on "Add Event"
And I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "2"
And I select link "SUB {Var(num1)}" 
When I click drop button on "Add Event"
Then I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "3"
And I select link "SUB {Var(num1)}" 
When I click drop button on "Add Event"
Then I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
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
And I verify data on Matrices
 |Name |OID  |Allow Add  |Max |
 |Base |BASE |checked    |1   |
And I take a screenshot 
And I click on icon "Folder Forms" for Matrices "Base"
And I verify data on Matrices details page
 |Forms        |Subject   |Unscheduled Visit |Screening |Baseline |
 |Primary form |uncheck   |uncheck           |uncheck   |uncheck  |
 |Form1        |uncheck   |check             |check     |check    |
 |Form2        |uncheck   |uncheck           |uncheck   |uncheck  |
 |Form3        |uncheck   |uncheck           |uncheck   |uncheck  |
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
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "2" 
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "3"
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "1" 
And I choose "Base" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I should see folder added under subject "SUB {Var(num1)}"
 |Folders                |
 |Folders                |
 |Unscheduled Visit (1)  |
 |Screening (1)          |
 |Baseline (1)           |
And I take a screenshot 
And I click drop button on "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "2"
And I click drop button on "Add Event"
And I verify option "Base" exist in "Add Event" dropdown
And I take a screenshot
And I choose "Base" from "Add Event"
When I click button "Add"
Then I should not see folder added under subject "SUB {Var(num1)}"
 |Folders                |
 |Folders                |
 |Unscheduled Visit (2)  |
 |Screening (2)          |
 |Baseline (2)           |
And I take a screenshot
And I click drop button on "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "3"
And I click drop button on "Add Event"
And I verify option "Base" exist in "Add Event" dropdown
And I take a screenshot
And I choose "Base" from "Add Event"
When I click button "Add"
Then I should not see folder added under subject "SUB {Var(num1)}"
 |Folders                |
  |Folders               |
 |Unscheduled Visit (3)  |
 |Screening (3)          |
 |Baseline (3)           |
And I take a screenshot
And I click drop button on "Add Event"
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
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "2"
And I select link "Grid View" 
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "3"
And I select link "Grid View" 
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I switch to tab "1" 
And I choose "Base" from "Add Event"
And I take a screenshot
When I click button "Add"
Then I should see folder added under subject "SUB {Var(num1)}"
 |Folders                |
 |Folders                |
 |Unscheduled Visit (1)  |
 |Screening (1)          |
 |Baseline (1)           |
And I take a screenshot 
And I click drop button on "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "2"
And I click drop button on "Add Event"
And I verify option "Base" exist in "Add Event" dropdown
And I take a screenshot
And I choose "Base" from "Add Event"
When I click button "Add"
Then I should not see folder added under subject "SUB {Var(num1)}"
 |Folders                |
 |Folders                |
 |Unscheduled Visit (2)  |
 |Screening (2)          |
 |Baseline (2)           |
And I take a screenshot
And I click drop button on "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot
And I switch to tab "3"
And I click drop button on "Add Event"
And I verify option "Base" exist in "Add Event" dropdown
And I take a screenshot
And I choose "Base" from "Add Event"
When I click button "Add"
Then I should not see folder added under subject "SUB {Var(num1)}"
 |Folders                |
 |Folders                |
 |Unscheduled Visit (3)  |
 |Screening (3)          |
 |Baseline (3)           |
And I take a screenshot
And I click drop button on "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot