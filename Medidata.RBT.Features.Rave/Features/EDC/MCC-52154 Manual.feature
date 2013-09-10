@MCC-52154 Manual
@ignore
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

#NOTE: This Feature file need to be executed only on browsers google chrome or IE. This Feature file should not be executed on browser firefox as the issue doesn't exist on Firefox.

#Note: 1) Unscheduled Visit Matrix Max value is set to 1, unassigned to multiple folders on subject level.
#Note: 2) Base Matrix Max value is set to 1, assigned to multiple folders on subject level.
#Note: 3) Second Visit Matrix Max value is set to 2, unassigned to multiple folders on subject level.

@Release_2013.4.0
@PB_MCC-52154-01A
@RR09.SEP.2013
@Manual
@Draft
Scenario: MCC-52154-01A As a EDC user, On subject calendar view page, when I add Matrix with Max value set to 1, then the matrix should be added only once, and matrix should not be available for selection in the list.

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
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I choose "Unscheduled Visit" from "Add Event"
And I take a screenshot
When I quickly click button "Add" 10 times
Then I should see folders added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (1) |
And I take a screenshot
And I should not see folders added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (2) |
 |Unscheduled Visit (3) |
 |Unscheduled Visit (4) |
 |Unscheduled Visit (5) |
 |Unscheduled Visit (6) |
 |Unscheduled Visit (7) |
 |Unscheduled Visit (8) |
 |Unscheduled Visit (9) |
 |Unscheduled Visit (10)|
And I take a screenshot
And I click drop button on "Add Event"
And I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I take a screenshot 

@Release_2013.4.0
@PB_MCC-52154-02A
@RR09.SEP.2013
@Manual
@Draft
Scenario: MCC-52154-02A As a EDC user, On subject grid view page, when I add Matrix with Max value set to 1, then the matrix should be added only once, and matrix should not be available for selection in the list.

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-52154" and Site "Site_A"
And I create a Subject
 |Field              |Data              |Control Type |
 |Subject Initials   |SUB               |textbox      |
 |Subject Number     |{RndNum<num2>(3)} |textbox      |
 |Subject ID 	     |SUB {Var(num2)}   |textbox      |
And I select link "Grid View"
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I choose "Unscheduled Visit" from "Add Event"
And I take a screenshot
When I quickly click button "Add" 10 times
Then I should see folders added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (1) |
And I take a screenshot 
And I should not see folders added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (2) |
 |Unscheduled Visit (3) |
 |Unscheduled Visit (4) |
 |Unscheduled Visit (5) |
 |Unscheduled Visit (6) |
 |Unscheduled Visit (7) |
 |Unscheduled Visit (8) |
 |Unscheduled Visit (9) |
 |Unscheduled Visit (10)|
And I take a screenshot 
And I click drop button on "Add Event"
And I verify option "Unscheduled Visit" does not exist in "Add Event" dropdown
And I take a screenshot

@Release_2013.4.0
@PB_MCC-52154-03A
@RR09.SEP.2013
@Manual
@Draft
Scenario: MCC-52154-03A As a EDC user, On subject calendar view page, when I add Matrix with Max value set to 2, then the matrix should be added only twice, and matrix should not be available for selection in the list.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-52154" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Matrices"
And I verify data on Matrices
 |Name     |OID     |Allow Add  |Max |
 |Second   |SECOND  |checked    |2   |
And I take a screenshot 
And I click on icon "Folder Forms" for Matrices "Second"
And I verify data on Matrices details page
 |Forms        |Subject   |Unscheduled Visit |Screening |Baseline |
 |Primary form |uncheck   |uncheck           |uncheck   |uncheck  |
 |Form1        |uncheck   |uncheck           |uncheck   |uncheck  |
 |Form2        |uncheck   |check             |uncheck   |uncheck  |
 |Form3        |uncheck   |uncheck           |uncheck   |uncheck  |
And I take a screenshot 
And I navigate to "Home"
And I select Study "MCC-52154" and Site "Site_A"
And I create a Subject
 |Field              |Data              |Control Type |
 |Subject Initials   |SUB               |textbox      |
 |Subject Number     |{RndNum<num3>(3)} |textbox      |
 |Subject ID 	     |SUB {Var(num3)}   |textbox      |
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I choose "Second" from "Add Event"
And I take a screenshot
And I click button "Add"
And I should see folders added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (1) |
And I take a screenshot
And I choose "Second" from "Add Event"
When I quickly click button "Add" 10 times
Then I should see folders added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (1) |
 |Unscheduled Visit (2) |
And I take a screenshot 
And I should not see folders added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (3) |
 |Unscheduled Visit (4) |
 |Unscheduled Visit (5) |
 |Unscheduled Visit (6) |
 |Unscheduled Visit (7) |
 |Unscheduled Visit (8) |
 |Unscheduled Visit (9) |
 |Unscheduled Visit (10)|
And I take a screenshot 
And I click drop button on "Add Event"
And I verify option "Second" does not exist in "Add Event" dropdown
And I take a screenshot

@Release_2013.4.0
@PB_MCC-52154-04A
@RR09.SEP.2013
@Manual
@Draft
Scenario: MCC-52154-04A As a EDC user, On subject grid view page, when I add Matrix with Max value set to 2, then the matrix should be added only twice, and matrix should not be available for selection in the list.

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-52154" and Site "Site_A"
And I create a Subject
 |Field              |Data              |Control Type |
 |Subject Initials   |SUB               |textbox      |
 |Subject Number     |{RndNum<num4>(3)} |textbox      |
 |Subject ID 	     |SUB {Var(num4)}   |textbox      |
And I select link "Grid View"
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I choose "Second" from "Add Event"
And I take a screenshot
And I click button "Add"
And I should see folders added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (1) |
And I take a screenshot 
And I choose "Second" from "Add Event"
When I quickly click button "Add" 10 times
Then I should see folders added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (1) |
 |Unscheduled Visit (2) |
And I take a screenshot 
And I should not see folders added under subject "SUB {Var(num1)}"
 |Folders               |
 |Unscheduled Visit (3) |
 |Unscheduled Visit (4) |
 |Unscheduled Visit (5) |
 |Unscheduled Visit (6) |
 |Unscheduled Visit (7) |
 |Unscheduled Visit (8) |
 |Unscheduled Visit (9) |
 |Unscheduled Visit (10)|
And I take a screenshot 
And I click drop button on "Add Event"
And I verify option "Second" does not exist in "Add Event" dropdown
And I take a screenshot

@Release_2013.4.0
@PB_MCC-52154-05A
@RR09.SEP.2013
@Manual
@Draft
Scenario: MCC-52154-05A As a EDC user, On subject calendar view page, when I add Matrix with Max value set to 1, and matrix is assigned to multiple folders, then the matrix folders should be added only once, and matrix should not be available for selection in the list.

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
 |Subject Number     |{RndNum<num5>(3)} |textbox      |
 |Subject ID 	     |SUB {Var(num5)}   |textbox      |
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I verify folder "Screening" does not exists under subject "SUB {Var(num1)}"
And I verify folder "Baseline" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I choose "Base" from "Add Event"
And I take a screenshot
When I quickly click button "Add" 10 times
Then I should see folders added under subject "SUB {Var(num1)}"
 |Folders                |
 |Unscheduled Visit (1)  |
 |Screening (1)          |
 |Baseline (1)           |
And I take a screenshot 
And I should not see folders added under subject "SUB {Var(num1)}"
 |Folders                |
 |Unscheduled Visit (2)  |
 |Screening (2)          |
 |Baseline (2)           |
 |Unscheduled Visit (3)  |
 |Screening (3)          |
 |Baseline (3)           |
 |Unscheduled Visit (4)  |
 |Screening (4)          |
 |Baseline (4)           |
 |Unscheduled Visit (5)  |
 |Screening (5)          |
 |Baseline (5)           |
 |Unscheduled Visit (6)  |
 |Screening (6)          |
 |Baseline (6)           |
 |Unscheduled Visit (7)  |
 |Screening (7)          |
 |Baseline (7)           |
 |Unscheduled Visit (8)  |
 |Screening (8)          |
 |Baseline (8)           |
 |Unscheduled Visit (9)  |
 |Screening (9)          |
 |Baseline (9)           |
 |Unscheduled Visit (10) |
 |Screening (10)         |
 |Baseline (10)          |
And I take a screenshot 
And I click drop button on "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot

@Release_2013.4.0
@PB_MCC-52154-06A
@RR09.SEP.2013
@Manual
@Draft
Scenario: MCC-52154-06A As a EDC user, On subject grid view page, when I add Matrix with Max value set to 1, and matrix is assigned to multiple folders, then the matrix folders should be added only once, and matrix should not be available for selection in the list.

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-52154" and Site "Site_A"
And I create a Subject
 |Field              |Data              |Control Type |
 |Subject Initials   |SUB               |textbox      |
 |Subject Number     |{RndNum<num6>(3)} |textbox      |
 |Subject ID 	     |SUB {Var(num6)}   |textbox      |
And I select link "Grid View"
And I verify folder "Unscheduled Visit" does not exists under subject "SUB {Var(num1)}"
And I verify folder "Screening" does not exists under subject "SUB {Var(num1)}"
And I verify folder "Baseline" does not exists under subject "SUB {Var(num1)}"
And I take a screenshot
And I choose "Base" from "Add Event"
And I take a screenshot
When I quickly click button "Add" 10 times
Then I should see folders added under subject "SUB {Var(num1)}"
 |Folders                |
 |Unscheduled Visit (1)  |
 |Screening (1)          |
 |Baseline (1)           |
And I take a screenshot 
And I should not see folders added under subject "SUB {Var(num1)}"
 |Folders                |
 |Unscheduled Visit (2)  |
 |Screening (2)          |
 |Baseline (2)           |
 |Unscheduled Visit (3)  |
 |Screening (3)          |
 |Baseline (3)           |
 |Unscheduled Visit (4)  |
 |Screening (4)          |
 |Baseline (4)           |
 |Unscheduled Visit (5)  |
 |Screening (5)          |
 |Baseline (5)           |
 |Unscheduled Visit (6)  |
 |Screening (6)          |
 |Baseline (6)           |
 |Unscheduled Visit (7)  |
 |Screening (7)          |
 |Baseline (7)           |
 |Unscheduled Visit (8)  |
 |Screening (8)          |
 |Baseline (8)           |
 |Unscheduled Visit (9)  |
 |Screening (9)          |
 |Baseline (9)           |
 |Unscheduled Visit (10) |
 |Screening (10)         |
 |Baseline (10)          |
And I take a screenshot 
And I click drop button on "Add Event"
And I verify option "Base" does not exist in "Add Event" dropdown
And I take a screenshot
