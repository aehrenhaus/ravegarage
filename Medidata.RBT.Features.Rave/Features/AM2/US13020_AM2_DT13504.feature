#DT13504: AM2 audit text needs to be corrected. The audit text "Amendment Manager: Query is closed during migration process, because it no longer exists in target version" should be updated to "Amendment Manager: Query closed during migration process because the edit check no longer exists in target version."

#The scenarios described in this feature file go under the assumption that there is at least the following:
# 1. One CRF version has been published to an environment
# 2. One subject has been created in the environment 
# 3. One form with a query has been created

Feature: When an edit check has been removed from a target CRF version in Architect, and a subject is migrated to the target CRF version and a query closed then the audit trail says "Amendment Manager: Query closed during migration process because check no longer exists in target version.".


Background:
Given xml draft "DT13504_1.xml" is Uploaded
Given xml draft "DT13504_2.xml" is Uploaded
Given study "DT13504" is assigned to Site "Site_001"
Given following Project assignments exist
| User         | Project | Environment | Role         | Site     | SecurityRole          |
| SUPER USER 1 | DT13504 | Live: Prod  | SUPER ROLE 1 | Site_001 | Project Admin Default |
| locuser      | DT13504 | Live: Prod  | SUPER ROLE 1 | Site_001 | Project Admin Default |
Given I publish and push eCRF "DT13504_1.xml" to "Version 1"
Given following Report assignments exist
| User         | Report                           |
| SUPER USER 1 | Audit Trail - Audit Trail Report |

#Given "SUPER USER 1" has access to "Architect"
#And "SUPER USER 1" has access to Amendment Manager
#And form "Form A" has the following fields from the table below
#|Field Name	|VarOID	|Control Type	|Format	|Auto-Query for required data entry|
#|Field A	|FIELDA	|Text			|$10	|Unchecked |
#|Field B	|FIELDB	|Text			|$10	|Unchecked |
#|Field C	|FIELDC	|Text			|$10	|Unchecked |
#|Field D	|FIELDD	|Text			|$10	|Checked   |
#And "Form A" has the following Edit check "DT13504_1" where the "Bypass in migration" property is unchecked
#If "Field A" is empty and "Field B" is not empty fire query "Test Query DT13504 1" on "Field B".
#And "Form A" has the following Edit check "DT13504_2" where the "Bypass in migration" property is unchecked
#If "Field B" is not empty and "Field C" is not empty fire query "Test Query DT13504 2" on "Field C".
#And in Draft 2 Edit check "DT13504_1" is inactivated
#And Edit check "DT13504_2" is updated as follows
#If "Field A" is empty and "Field C" is empty fire query "Test Query DT13504 2" on "Field C".

@release_2012.1.0
@DT13504_10
@VAL
Scenario:  When a user navigates to Publish Checks, selects the noted source version and the noted target version, clicks create plan, checks the 'Show field edit check' box, selects "Form A" from the Form dropdown, checks the 'Inactivate' box for the "SYS_REQ_FIELDD_FORMA" edit check, clicks 'Publish', and navigates to created subject in EDC then the system will show an audit trail message of "Amendment Manager: Query closed during migration process because the edit check no longer exists in target version." in "Field D"

Given I login to Rave with user "SUPER USER 1"
And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num1>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num1)}   |textbox      |
And I select Form "Form A"
And I enter data in CRF and save
    |Field   |Data |Control Type |
    |Field B |1234 |textbox      |
    |Field C |5678 |textbox      |
And I verify Query is displayed
	| Field   | Query Message        | 
	| Field B | Test Query DT13504 1 |
	| Field C | Test Query DT13504 2 | 		
	| Field D | (no message)         | 		
And I take a screenshot
Given I publish and push eCRF "DT13504_2.xml" to "Version 2"
And I go to Publish Checks for study "DT13504"
And I select Current CRF version "Version 1"
And I select Reference CRF version "Version 2"
And I click button "Create Plan"
And I check "Show Field Edit Checks"
And I select "Form A" from Forms in Edit Checks
And I select search icon in Edit Checks
And I check "Inactivate" for "SYS_REQ_FIELDD|FRMA" in Edit Checks
And I select link "Save"
And I take a screenshot
And I select link "Publish"
And I select link "Migration Results"
And I verify Job Status is set to Complete
And I take a screenshot
And I navigate to "Home"
And I select a Subject "{Var(num1)}"
And I select form "Form A"
When I click audit on Field "Field D"
Then I verify Audits exist
	| Audit Type        | Query Message                                                                                    | User   | Time                 |
	| Amendment Manager | Query closed during migration process because the edit check no longer exists in target version. | System | dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I navigate to "Home"
And I navigate to "Reporter"
And I select Report "Audit Trail"
And I set report parameter "Study" with "DT13504"
And I set report parameter "Sites" with "Site_001"
And I set report parameter "Subjects" with "SUB {Var(num1)}"
When I click button "Submit Report"
And I switch to "ReportViewer" window
Then I verify rows exist in table
| Site     | Site Group | Subject         | Folder        | Form   | Page Rpt Number | Field   | Log# | Audit Action                                                                                                        | Audit User | Audit Role | Audit ActionType | Audit Time (GMT)     |
| Site_001 | World      | SUB {Var(num1)} | Subject Level | Form A | 0               | Field D | 0    | Amendment Manager: Query closed during migration process because the edit check no longer exists in target version. | S.User     | SYSTEM     | MigQueryClosed   | dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I switch to "Reports" window


@release_2012.1.0
@DT13504_20
@VAL
Scenario:  When a user navigates to Amendment Manager, selects the noted source version and the noted target version, clicks create plan, and executes the plan on created subject, and the user navigates to EDC  then the system will show an audit trail message of "Amendment Manager: Query closed during migration process because the edit check no longer exists in target version." in "Field B"

Given I publish and push eCRF "DT13504_1.xml" to "Version 3"
And I login to Rave with user "SUPER USER 1"
And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num1>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num1)}   |textbox      |
And I select Form "Form A"
And I enter data in CRF and save
    |Field   |Data |Control Type |
    |Field B |1234 |textbox      |
    |Field C |5678 |textbox      |
And I verify Query is displayed
	| Field   | Query Message        | 
	| Field B | Test Query DT13504 1 |
	| Field C | Test Query DT13504 2 | 		
	| Field D | (no message)         |  		
And I take a screenshot
Given I publish and push eCRF "DT13504_2.xml" to "Version 2"
And I go to Amendment Manager for study "DT13504"
And I select Source CRF version "Version 3"
And I select Target CRF version "Version 2"
And I create migration plan
And I take a screenshot
And I execute plan for subject "{Var(num1)}"
And I select link "Migration Results"
And I verify Job Status is set to Complete
And I take a screenshot
And I navigate to "Home"
And I select a Subject "{Var(num1)}"
And I select form "Form A"
When I click audit on Field "Field B"
Then I verify Audits exist
	| Audit Type        | Query Message                                                                                    | User   | Time                 |
	| Amendment Manager | Query closed during migration process because the edit check no longer exists in target version. | System | dd MMM yyyy HH:mm:ss |
And I take a screenshot
And I login to Rave with user "locuser"
And I select a Subject "{Var(num1)}"
#And I select form "LForm A" - this will not work in CI since this localized string will not exist on clean DB
And I select form "Form A"
When I click audit on Field "LField B"
Then I verify Audits exist
	| Audit Type         | Query Message                                                                                     | User    | Time                  |
	| LAmendment Manager | LQuery closed during migration process because the edit check no longer exists in target version. | LSystem | dd LMMM yyyy HH:mm:ss |
And I take a screenshot