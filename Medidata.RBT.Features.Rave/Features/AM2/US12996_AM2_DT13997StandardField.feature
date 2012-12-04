#DT13997:  AM2 blanks out the default values populated by coded values in the data dictionary if the datapoint has a blank entrylocale
#AM2 will blank out submitted default values for a log field, that been populated by coded values of data dictionary, if the order of data dictionary entries was changed and coded values updated even when everything was properly mapped in the migration plan for data dictionary entries.
#Unless other wise stated in this feature file it is assumed that this study has at least one subject which as submitted default values.  The forms #needs to be submitted by a role who has entry resitrctions for the field with default values.
Feature: US12996_DT13997 For a standard field. Submitted default values will remain present on the eCRF when the coded values of the data dictionary have been change or reordered.

Background:
Given xml draft "DT13997 Upload Sixth AM SJ_1.6.13.xml" is Uploaded
Given xml draft "DT13997 Upload Seventh AM SJ_1.6.15.xml" is Uploaded
Given xml draft "DT13997 Upload Ninth AM SJ_1.6.19.xml" is Uploaded
Given study "AM SJ" is assigned to Site "Site_001"
Given following Project assignments exist
| User         | Project | Environment | Role         | Site     | SecurityRole          |
| SUPER USER 1 | AM SJ   | Live: Prod  | SUPER ROLE 1 | Site_001 | Project Admin Default |
Given I publish and push eCRF "DT13997 Upload Sixth AM SJ_1.6.13.xml" to "Version 6"

#And "SUPER USER 1" has access to "Architect"
#And "SUPER USER 1" has access to Amendment Manager
#And Coded Data exists in Dictionary "Medical History"
#And Coded Data is assigned to Default value for log field "Field A" 

@release_2012.1.0
@PB_US12996_DT13997_80
@Validation
Scenario:  PB_US12996_DT13997_80 For a standard field. When a user navigates to Architect, removes one default value of the coded values of a data dictionary, creates a new CRF version, creates a migration plan with the new CRF version as the Target CRF version, in object mapping maps the data dictionary, and migrates the subject, then user navigate to EDC and sees that the defaulted values for the subject are present and the removed one is disabled.

Given I login to Rave with user "SUPER USER 1"
Given I create a Subject
	| Field                        | Data              |
	| Subject Number (3 digits)    | {RndNum<num1>(3)} |
	| Subject Initials             | SUB               |
	| Derivation Migration Testing | {RndNum<num1>(3)} |
And I submit the form "Form A"
And I take a screenshot
And I publish and push eCRF "DT13997 Upload Seventh AM SJ_1.6.15.xml" to "Version 7"
And I go to Amendment Manager for study "AM SJ"
And I select Source CRF version "Version 6"
And I select Target CRF version "Version 7"
And I create migration plan
And I take a screenshot
And I execute plan for subject "{Var(num1)}"
And I select link "Migration Results"
And I take a screenshot
And I verify Job Status is set to Complete
And I navigate to "Home"
And I select a Subject "{Var(num1)}"
When I select form "Form A"
And I verify data on Fields in CRF
| Field   | Data             | Inactive |
| Field A | Gastrointestinal | False    |
And I take a screenshot

@release_2012.1.0
@PB_US12996_DT13997_90
@Validation
Scenario:  PB_US12996_DT13997_90 Moving from a standard to a log field, the user removes a default value. Leaves original stard value and adds new default log values after.

Given I login to Rave with user "SUPER USER 1"
Given I create a Subject
	| Field                        | Data              |
	| Subject Number (3 digits)    | {RndNum<num1>(3)} |
	| Subject Initials             | SUB               |
	| Derivation Migration Testing | {RndNum<num1>(3)} |
And I submit the form "Form A"
And I take a screenshot
And I publish and push eCRF "DT13997 Upload Ninth AM SJ_1.6.19.xml" to "Version 9"
And I go to Amendment Manager for study "AM SJ"
And I select Source CRF version "Version 6"
And I select Target CRF version "Version 9"
And I create migration plan
And I take a screenshot
And I execute plan for subject "{Var(num1)}"
And I select link "Migration Results"
And I take a screenshot
And I verify Job Status is set to Complete
And I navigate to "Home"
And I select a Subject "{Var(num1)}"
And I submit the form "Form A"
Then "Field A" has "<Values>" in order
	| Values              |
	| Gastrointestinal    |
	| Abdomen and Viscera |
And I verify data on Fields in CRF
| Field   | Data                | Inactive |
| Field A | Gastrointestinal    | False    |
| Field A | Abdomen and Viscera | False    |
And I take a screenshot