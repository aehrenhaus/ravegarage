#DT13626: Amendment Manager inserts duplicate log records for soft deleted datapages

Feature: When records are soft deleted by an edit check, duplicate records should not show up in the database after migration.

Background: 
Given xml draft "DT13626.xml" is Uploaded
Given study "DT13626" is assigned to site "Site_001"
Given following Project assignments exist
| User         | Project | Environment | Role         | Site     | SecurityRole          |
| SUPER USER 1 | DT13626 | Live: Prod  | SUPER ROLE 1 | Site_001 | Project Admin Default |
Given I publish and push eCRF "DT13626.xml" to "Version 1"
Given following Report assignments exist
| User         | Report      |
| SUPER USER 1 | Audit Trail |

	
#And mixed form "Form A" exists
#And form "Form A" has the following fields from the table below
#	|Field Name	|VarOID	|Log Data	|Control Type	|Format	|Dictionary |
#	|Field A	|FIELDA	|			|DropDownList	|$5 	|Yes/No     |
#	|Field B	|FIELDB	|Checked	|LongText		|$100	|           |
#	|Field C	|FIELDC	|Checked	|LongText		|$100	|           |
#And mixed form "Form B" exists
#And form "Form B" has the following fields from the table below
#	|Field Name	|VarOID	|Log Data	|Control Type	|Format	|
#	|FIELDE 	|FIELDE	|			|Text       	|$5 	|
#	|FIELDF		|FIELDF	|Checked	|LongText		|$100	|
#	|FIELDG 	|FIELDG	|Checked	|LongText		|$100	|
#And matrix "Merge Matrix" with "Form B" on subject level exists
#And "Form A" has the following Edit check "DT13626" where the "Bypass in migration" property is unchecked
#If field "Field A" in Form "Form A" is equal to "Y" then merge the "Merge Matrix" matrix
#And report "Audit Trail" exists

	

@release_2012.1.0
@DT13626_10
@WIP
Scenario:  When the data is soft deleted and subject is migrated, then extra records should not be created

Given I login to Rave with user "SUPER USER 1"
And I select Study "DT13626" and Site "Site_001"
And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num1>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num1)}   |textbox      |	
And I navigate to form "Form A"
And I enter data in CRF and save
    | Field   | Data | Control Type |
    | Field A | Yes  | Drop Down    |
    | Field B | 1234 | textbox      |
    | Field C | 5678 | textbox      |
And I verify Form "Form B" is displayed
And I take a screenshot
And I enter data in CRF and save
    | Field   | Data | Control Type |
    | Field A | No   | Drop Down    |
And I verify Form "Form B" is not displayed
And I take a screenshot
Given I publish and push eCRF "DT13626.xml" to "Version 2"
And I go to Amendment Manager for study "DT13626"
And I select Source CRF version "Version 1"
And I select Target CRF version "Version 2"
And I create migration plan
And I take a screenshot
And I execute plan for subject "{Var(num1)}"
And I select link "Migration Results"
And I verify Job Status is set to Complete
And I take a screenshot
And I navigate to "Home"
And I navigate to "Reporter"
And I select Report "Audit Trail"
And I select Report Parameters
| Study   | Site     | Subjects      |
| DT13626 | Site_001 | "{Var(num1)}" |
When I click button "Submit Report"
Then I verify duplicate records are not displayed
And I take a screenshot

