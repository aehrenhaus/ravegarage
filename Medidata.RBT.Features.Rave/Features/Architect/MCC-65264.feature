@MCC-65264
Feature: MCC-65264 ARC Rename ActionString column in CheckActions tab of AL spreadsheet

Background:

Given xml draft "MCC-65264-001.xml" is Uploaded
Given xml draft "MCC-65264-003.xml" is Uploaded
Given Site "Site_A" exists
Given study "MCC-65264-001" is assigned to Site "Site_A"
Given study "MCC-65264-003" is assigned to Site "Site_A"
Given role "SUPER ROLE 1" exists
Given I publish and push eCRF "MCC-65264-001.xml" to "Version 1"
Given I publish and push eCRF "MCC-65264-003.xml" to "Version 1"
Given following Project assignments exist
| User          | Project       | Environment | Role         | Site   | SecurityRole          |
| SUPER USER 1  | MCC-65264-001 | Live: Prod  | SUPER ROLE 1 | Site_A | Project Admin Default |
| SUPER USER 1  | MCC-65264-003 | Live: Prod  | SUPER ROLE 1 | Site_A | Project Admin Default |

@Release_2013.4.0
@PB_MCC-65264-01
@RR09.AUG.2013
@Validation
Scenario: MCC-65264-01 On UI, When I put the cursor on Quick Edit page on message, then "ActionString" should display. When architect spreadsheet is downloaded on CRF draft page, then in CheckActions tab the column name is displayed as "ActionString".

And I navigate to "Architect"
And I select "Project" link "MCC-65264-001" in "Active Projects"
And I select Draft "Draft1"
And I navigate to "Edit Checks"
And I click on icon "Check Steps" for Edit Check "Edit Check1"
And I edit "1st" Check Action
And I verify option "Open Query" is selected in "Action Type" dropdown
And I verify text "Message" exists in "Action"
And I take a screenshot
And I select link "Edit Check1"
And I select link "Quick Edit"
And I position cursor at message "Open Query on fieldA" in "Quick Edit"
And I verify text "CheckActions : ActionString" exists
And I take a screenshot
And I navigate to "Home"
And I navigate to "Architect"
And I select "Project" link "MCC-65264-001" in "Active Projects"
And I select Draft "Draft1"
And I click the "Download" button to download
Then I verify "CheckActions" spreadsheet data
  |CheckName      |FolderOID |FormOID |FieldOID |VariableOID |RecordPosition |PageRepeatNumber|InstanceRepeatNumber|LogicalRecordPosition|Scope|OrderBy|ActionType    |ActionString         |ActionOptions|ActionScript|
  |SetSubjectName |          |PRIMARY |SUBJ_ID  |SUBJ_ID     |               |                |                    |                     |     |       |SetSubjectName|                     |             |            |
  |Edit Check1    |          |FORM1   |FIELDA   |FIELDA      |               |                |                    |                     |     |       |OpenQuery     |Open Query on fieldA |Site         |            |
And I take a screenshot	

@Release_2013.4.0
@PB_MCC-65264-02
@RR09.AUG.2013
@Validation
Scenario: MCC-65264-02 On UI, When I put the cursor on Quick Edit page on message, then "ActionString" should display. When architect spreadsheet is downloaded on CRF version page, then in CheckActions tab the column name is displayed as "ActionString".

And I navigate to "Architect"
And I select "Project" link "MCC-65264-001" in "Active Projects"
And I select Draft "Draft1"
And I navigate to "Edit Checks"
And I click on icon "Check Steps" for Edit Check "Edit Check1"
And I edit "1st" Check Action
And I verify option "Open Query" is selected in "Action Type" dropdown
And I verify text "Message" exists in "Action"
And I take a screenshot
And I select link "Edit Check1"
And I select link "Quick Edit"
And I position cursor at message "Open Query on fieldA" in "Quick Edit"
And I verify text "CheckActions : ActionString" exists
And I take a screenshot
And I navigate to "Home"
And I navigate to "Architect"
And I select "Project" link "MCC-65264-001" in "Active Projects"
And I select CRF version "Version 1"
And I click the "Download" button to download
Then I verify "CheckActions" spreadsheet data
  |CheckName      |FolderOID |FormOID |FieldOID |VariableOID |RecordPosition |PageRepeatNumber|InstanceRepeatNumber|LogicalRecordPosition|Scope|OrderBy|ActionType    |ActionString         |ActionOptions|ActionScript|
  |SetSubjectName |          |PRIMARY |SUBJ_ID  |SUBJ_ID     |               |                |                    |                     |     |       |SetSubjectName|                     |             |            |
  |Edit Check1    |          |FORM1   |FIELDA   |FIELDA      |               |                |                    |                     |     |       |OpenQuery     |Open Query on fieldA |Site         |            |
And I take a screenshot

@Release_2013.4.0
@PB_MCC-65264-03
@RR09.AUG.2013
@Validation
Scenario: MCC-65264-03 When architect spreadsheet is uploaded with column "ActionString", then the upload will be successful and "ActionString" is displayed on Quick Edit page in UI.

When xml draft "MCC-65264-002.xml" is Uploaded without redirecting
Then I verify text "Save successful" exists
And I take a screenshot
And I navigate to "Architect"
And I select "Project" link "MCC-65264-002" in "Active Projects"
And I select Draft "Draft1" 
And I navigate to "Edit Checks"
And I click on icon "Check Steps" for Edit Check "SetSubjectName"
And I edit "1st" Check Action
And I verify option "Set Subject Name" is selected in "Action Type" dropdown
And I verify text "Message" does not exists in "Actions"
And I take a screenshot
And I select link "SetSubjectName"
And I select link "Quick Edit"
And I position cursor after message "||SetSubjectName|" in "Quick Edit"
And I verify text "CheckActions : ActionString" exists
And I take a screenshot

@Release_2013.4.0
@PB_MCC-65264-04
@RR09.AUG.2013
@Validation
Scenario: MCC-65264-04 When an architect draft template is downloaded from a URL, then in CheckActions tab the column name is displayed as "ActionString".

When I navigate to "Architect"
And I click the "Get Draft Template" button to download
Then I verify "CheckActions" spreadsheet data
  |CheckName |FolderOID |FormOID |FieldOID |VariableOID |RecordPosition |PageRepeatNumber|InstanceRepeatNumber|LogicalRecordPosition|Scope|OrderBy|ActionType |ActionString |ActionOptions|ActionScript|
  |          |          |        |         |            |               |                |                    |                     |     |       |           |             |             |            |
And I take a screenshot	

@Release_2013.4.0
@PB_MCC-65264-05
@RR09.AUG.2013
@Validation
Scenario: MCC-65264-05 On Edit Checks details page when I select different Action Type, appropriate column name is updated. When I put the cursor on Quick Edit page on message, then "ActionString" should display. When architect spreadsheet is downloaded, then in CheckActions tab the column name is displayed as "ActionString".

And I navigate to "Architect"
And I select "Project" link "MCC-65264-003" in "Active Projects"
And I select Draft "Draft1"
And I navigate to "Edit Checks"
And I click on icon "Check Steps" for Edit Check "Edit Check2"
And I edit "1st" Check Action
And I verify option "Set DataPoint" is selected in "Action Type" dropdown
And I verify text "Value" exists in "Actions"
And I take a screenshot
And I select link "Edit Check2"
And I select link "Quick Edit"
When I position cursor after message "||SetDataPoint|" in "Quick Edit"
Then I verify text "CheckActions : ActionString" exists
And I take a screenshot
And I select link "Edit Checks"
And I click on icon "Check Steps" for Edit Check "Edit Check3"
And I edit "1st" Check Action
And I verify option "Update Folder Name" is selected in "Action Type" dropdown
And I verify text "Name String" exists in "Actions"
And I take a screenshot
And I select link "Edit Check3"
And I select link "Quick Edit"
When I position cursor after message "||UpdateFolderName|" in "Quick Edit"
Then I verify text "CheckActions : ActionString" exists
And I take a screenshot
And I select link "Edit Checks"
And I click on icon "Check Steps" for Edit Check "Edit Check4"
And I edit "1st" Check Action
And I verify option "Update Form Name" is selected in "Action Type" dropdown
And I verify text "Name String" exists in "Actions"
And I take a screenshot
And I select link "Edit Check4"
And I select link "Quick Edit"
When I position cursor after message "||UpdateFormName|" in "Quick Edit"
Then I verify text "CheckActions : ActionString" exists
And I take a screenshot
And I navigate to "Home"
And I navigate to "Architect"
And I select "Project" link "MCC-65264-003" in "Active Projects"
And I select Draft "Draft1"
And I click the "Download" button to download
Then I verify "CheckActions" spreadsheet data
  |CheckName      |FolderOID |FormOID |FieldOID |VariableOID |RecordPosition |PageRepeatNumber|InstanceRepeatNumber|LogicalRecordPosition|Scope|OrderBy|ActionType       |ActionString         |ActionOptions     |ActionScript|
  |SetSubjectName |          |PRIMARY |SUBJ_ID  |SUBJ_ID     |               |                |                    |                     |     |       |SetSubjectName   |                     |                  |            |
  |Edit Check1    |          |FORM1   |FIELDA   |FIELDA      |               |                |                    |                     |     |       |OpenQuery        |Open Query on fieldA |Site              |            |
  |Edit Check2    |          |FORM1   |FIELDA   |FIELDA      |               |                |                    |                     |     |       |SetDataPoint     |                     |EnterEmptyIfFalse |testA       |
  |Edit Check3    |          |FORM1   |FIELDB   |FIELDB      |               |                |                    |                     |     |       |UpdateFolderName |                     |TRUE              |TestB       |  
  |Edit Check4    |          |FORM1   |FIELDC   |FIELDC      |               |                |                    |                     |     |       |UpdateFormName   |                     |TRUE              |TestC       |
And I take a screenshot
