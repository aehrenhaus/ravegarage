#DT13997:  AM2 blanks out the default values populated by coded values in the data dictionary if the datapoint has a blank entrylocale
#AM2 will blank out submitted default values for a log field, that been populated by coded values of data dictionary, if the order of data dictionary entries was changed and coded values updated even when everything was properly mapped in the migration plan for data dictionary entries.
#Unless other wise stated in this feature file it is assumed that this study has at least one subject which as submitted default values.  The forms #needs to be submitted by a role who has entry resitrctions for the field with default values.

Feature: Submitted default values will remain present on the eCRF when the coded values of the data dictionary have been change or reordered.


Background:

Given xml draft "DT13997 Upload First AM SJ_1.6.3.xml" is Uploaded
Given xml draft "DT13997 Upload Second AM SJ_1.6.5.xml" is Uploaded
Given xml draft "DT13997 Upload Third AM SJ_1.6.7.xml" is Uploaded
Given xml draft "DT13997 Upload Fourth AM SJ_1.6.9.xml" is Uploaded
Given xml draft "DT13997 Upload Fifth AM SJ_1.6.11.xml" is Uploaded
Given study "AM SJ" is assigned to Site "Site_001"
Given following Project assignments exist
| User         | Project | Environment | Role         | Site     | SecurityRole          |
| SUPER USER 1 | AM SJ   | Live: Prod  | SUPER ROLE 1 | Site_001 | Project Admin Default |
| SUPER USER 2 | AM SJ   | Live: Prod  | SUPER ROLE 2 | Site_001 | Project Admin Default |
Given I publish and push eCRF "DT13997 Upload First AM SJ_1.6.3.xml" to "Version 1"

#Given Entry Restricted is set for role "SUPER ROLE 2" in
#| Project | Draft | Form   | Field   |
#| AM SJ   | 1.6.3 | Form A | Field A |
#| AM SJ   | 1.6.5 | Form A | Field A |
#| AM SJ   | 1.6.7 | Form A | Field A |
#And "SUPER USER 1" has access to "Architect"
#And "SUPER USER 1" has access to Amendment Manager
#And "SUPER USER 2" has access to "Architect"
#And "SUPER USER 2" has access to Amendment Manager
#And Entry Restricted is set for user "SUPER USER 2" on field "Field A" on form "Form A" 
#And Coded Data exists in Dictionary "Medical History"
#And Coded Data is assigned to Default value for log field "Field A" 
	
@release_2012.1.0
@DT13997_10
@WIP
Scenario:  When a user navigates to Architect, changes the coded values of a data dictionary, creates a new CRF version, creates a migration plan with the new CRF version as the Target CRF version, in object mapping maps the data dictionary, and migrates the subject, then user navigate to EDC and sees that the defaulted values for the subject are present.

Given I login to Rave with user "SUPER USER 1"
Given I create a Subject
	| Field                        | Data              |
	| Subject Number (3 digits)    | {RndNum<num1>(3)} |
	| Subject Initials             | SUB               |
	| Derivation Migration Testing | {RndNum<num1>(3)} |
And I submit the form "Form A"
And I take a screenshot
Given I publish and push eCRF "DT13997 Upload Second AM SJ_1.6.5.xml" to "Version 2"
And I go to Amendment Manager for study "AM SJ"
And I select Source CRF version "Version 1"
And I select Target CRF version "Version 2"
And I create migration plan
And I set up a "Data Dictionary" object mapping
| Source          | Target          |
| Medical History | Medical History |
And I set up a mapping for source "Data Dictionary" "Medical History"
| Source                    | Target                    |
| Abdomen and Viscera       | Abdomen and Viscera       |
| Affect                    | Affect                    |
| Arteriogram               | Arteriogram               |
| Cardiovascular            | Cardiovascular            |
| Dermatologic              | Dermatologic              |
| Endocrine/Metabolic       | Endocrine/Metabolic       |
| Gastrointestinal          | Gastrointestinal          |
| Genitouriary/Reproductive | Genitouriary/Reproductive |
| Hematologic/Lymphatic     | Hematologic/Lymphatic     |
| Hepatic/Bilary            | Hepatic/Bilary            |
| Immunologic               | Immunologic               |
| Musculoskeletal           | Musculoskeletal           |
| Neurologic/Psychiatric    | Neurologic/Psychiatric    |
| Renal                     | Renal                     |
| Respiratory               | Respiratory               |
| Special Senses            | Special Senses            |
And I take a screenshot
And I execute plan for subject "{Var(num1)}"
And I select link "Migration Results"
And I take a screenshot
And I verify Job Status is set to Complete
And I navigate to "Home"
And I select a Subject "{Var(num1)}"
When I select form "Form A"
Then "Field A" has "<Values>" in order
	| Values                    |
	| Special Senses            |
	| Cardiovascular            |
	| Respiratory               |
	| Gastrointestinal          |
	| Hepatic/Bilary            |
	| Abdomen and Viscera       |
	| Genitouriary/Reproductive |
	| Renal                     |
	| Endocrine/Metabolic       |
And I take a screenshot
	
@release_2012.1.0
@DT13997_20
@WIP
Scenario:  When a user navigates to Architect, reorders the coded values of a data dictionary, creates a new CRF version, creates a migration plan with the new CRF version as the Target CRF version, in object mapping maps the data dictionary, and migrates the subject, then user navigate to EDC and sees that the defaulted values for the subject are present.

Given I login to Rave with user "SUPER USER 1"
Given I create a Subject
	| Field                        | Data              |
	| Subject Number (3 digits)    | {RndNum<num1>(3)} |
	| Subject Initials             | SUB               |
	| Derivation Migration Testing | {RndNum<num1>(3)} |
And I submit the form "Form A"
And I take a screenshot
And I publish and push eCRF "DT13997 Upload Third AM SJ_1.6.7.xml" to "Version 3"
And I take a screenshot
And I go to Amendment Manager for study "AM SJ"
And I select Source CRF version "Version 1"
And I select Target CRF version "Version 3"
And I create migration plan
And I take a screenshot
And I execute plan for subject "{Var(num1)}"
And I select link "Migration Results"
And I verify Job Status is set to Complete
And I take a screenshot
And I navigate to "Home"
And I select a Subject "{Var(num1)}"
When I select form "Form A"
Then "Field A" has "<Values>" in order
| Values                    |
| Special Senses            |
| Cardiovascular            |
| Respiratory               |
| Gastrointestinal          |
| Hepatic/Bilary            |
| Abdomen and Viscera       |
| Genitouriary/Reproductive |
| Renal                     |
| Endocrine/Metabolic       |
And I take a screenshot
	
@release_2012.1.0
@DT13997_30
@WIP
Scenario:  When a user navigates to Architect, changes the coded values of a data dictionary, creates a new CRF version, creates a migration plan with the new CRF version as the Target CRF version, in object mapping maps the data dictionary, and migrates a subject that has been submitted by a user with role permissions to edit a field with defaulted values, then user navigate to EDC and sees that the defaulted values for the subject are present.

Given I log in to Rave with user "SUPER USER 2"
Given I create a Subject
| Field                        | Data              |
| Subject Number (3 digits)    | {RndNum<num1>(3)} |
| Subject Initials             | SUB               |
| Derivation Migration Testing | {RndNum<num1>(3)} |
And I take a screenshot
And I submit the form "Form A"
And I take a screenshot
And I publish and push eCRF "DT13997 Upload Second AM SJ_1.6.5.xml" to "Version 2"
And I take a screenshot
And I go to Amendment Manager for study "AM SJ"
And I select Source CRF version "Version 1"
And I select Target CRF version "Version 2"
And I create migration plan
And I set up a "Data Dictionary" object mapping
| Source          | Target          |
| Medical History | Medical History |
And I set up a mapping for source "Data Dictionary" "Medical History"
| Source                    | Target                    |
| Abdomen and Viscera       | Abdomen and Viscera       |
| Affect                    | Affect                    |
| Arteriogram               | Arteriogram               |
| Cardiovascular            | Cardiovascular            |
| Dermatologic              | Dermatologic              |
| Endocrine/Metabolic       | Endocrine/Metabolic       |
| Gastrointestinal          | Gastrointestinal          |
| Genitouriary/Reproductive | Genitouriary/Reproductive |
| Hematologic/Lymphatic     | Hematologic/Lymphatic     |
| Hepatic/Bilary            | Hepatic/Bilary            |
| Immunologic               | Immunologic               |
| Musculoskeletal           | Musculoskeletal           |
| Neurologic/Psychiatric    | Neurologic/Psychiatric    |
| Renal                     | Renal                     |
| Respiratory               | Respiratory               |
| Special Senses            | Special Senses            |
And I take a screenshot
And I execute plan for subject "{Var(num1)}"
And I select link "Migration Results"
And I verify Job Status is set to Complete
And I take a screenshot
And I navigate to "Home"
And I select a Subject "{Var(num1)}"
When I select form "Form A"
Then "Field A" has "<Values>" in order
| Values                    |
| Special Senses            |
| Cardiovascular            |
| Respiratory               |
| Gastrointestinal          |
| Hepatic/Bilary            |
| Abdomen and Viscera       |
| Genitouriary/Reproductive |
| Renal                     |
| Endocrine/Metabolic       |
And I take a screenshot

@release_2012.1.0
@DT13997_40
@WIP
Scenario:  When a user navigates to Architect, reorders the coded values of a data dictionary, creates a new CRF version, creates a migration plan with the new CRF version as the Target CRF version, in object mapping maps the data dictionary, and migrates a subject that has been submitted by a user with role permissions to edit a field with defaulted values, then user navigate to EDC and sees that the defaulted values for the subject are present.

Given I log in to Rave with user "SUPER USER 2"
Given I create a Subject
| Field                        | Data              |
| Subject Number (3 digits)    | {RndNum<num1>(3)} |
| Subject Initials             | SUB               |
| Derivation Migration Testing | {RndNum<num1>(3)} |
And I take a screenshot
And I submit the form "Form A"
And I take a screenshot
And I publish and push eCRF "DT13997 Upload Third AM SJ_1.6.7.xml" to "Version 3"
And I take a screenshot
And I go to Amendment Manager for study "AM SJ"
And I select Source CRF version "Version 1"
And I select Target CRF version "Version 3"
And I create migration plan
And I take a screenshot
And I execute plan for subject "{Var(num1)}"
And I select link "Migration Results"
And I verify Job Status is set to Complete
And I take a screenshot
And I navigate to "Home"
And I select a Subject "{Var(num1)}"
When I select form "Form A"
Then "Field A" has "<Values>" in order
| Values                    |
| Special Senses            |
| Cardiovascular            |
| Respiratory               |
| Gastrointestinal          |
| Hepatic/Bilary            |
| Abdomen and Viscera       |
| Genitouriary/Reproductive |
| Renal                     |
| Endocrine/Metabolic       |
And I take a screenshot

@release_2012.1.0
@DT13997_50
@WIP
Scenario:  When a user navigates to Architect, changes the order of the coded values of a data dictionary, creates a new CRF version, creates a migration plan with the new CRF version as the Target CRF version, in object mapping maps the data dictionary, and migrates the subject, then user navigate to EDC and sees that the defaulted values for the subject are present.

Given I login to Rave with user "SUPER USER 1"
Given I create a Subject
	| Field                        | Data              |
	| Subject Number (3 digits)    | {RndNum<num1>(3)} |
	| Subject Initials             | SUB               |
	| Derivation Migration Testing | {RndNum<num1>(3)} |
And I submit the form "Form A"
And I take a screenshot
And I publish and push eCRF "DT13997 Upload Fourth AM SJ_1.6.9.xml" to "Version 4"
And I go to Amendment Manager for study "AM SJ"
And I select Source CRF version "Version 1"
And I select Target CRF version "Version 4"
And I create migration plan
And I take a screenshot
And I execute plan for subject "{Var(num1)}"
And I select link "Migration Results"
And I take a screenshot
And I verify Job Status is set to Complete
And I navigate to "Home"
And I select a Subject "{Var(num1)}"
When I select form "Form A"
Then "Field A" has "<Values>" in order
	| Values                    |
	| Special Senses            |
	| Cardiovascular            |
	| Respiratory               |
	| Gastrointestinal          |
	| Hepatic/Bilary            |
	| Abdomen and Viscera       |
	| Genitouriary/Reproductive |
	| Renal                     |
	| Endocrine/Metabolic       |
And I take a screenshot

@release_2012.1.0
@DT13997_60
@WIP
Scenario:  When a user navigates to Architect, removes one default value of the coded values of a data dictionary, creates a new CRF version, creates a migration plan with the new CRF version as the Target CRF version, in object mapping maps the data dictionary, and migrates the subject, then user navigate to EDC and sees that the defaulted values for the subject are present and the removed one is disabled.

Given I login to Rave with user "SUPER USER 2"
Given I create a Subject
	| Field                        | Data              |
	| Subject Number (3 digits)    | {RndNum<num1>(3)} |
	| Subject Initials             | SUB               |
	| Derivation Migration Testing | {RndNum<num1>(3)} |
And I submit the form "Form A"
And I take a screenshot
And I publish and push eCRF "DT13997 Upload Fifth AM SJ_1.6.11.xml" to "Version 5"
And I go to Amendment Manager for study "AM SJ"
And I select Source CRF version "Version 1"
And I select Target CRF version "Version 5"
And I create migration plan
And I take a screenshot
And I execute plan for subject "{Var(num1)}"
And I select link "Migration Results"
And I take a screenshot
And I verify Job Status is set to Complete
And I navigate to "Home"
And I select a Subject "{Var(num1)}"
When I select form "Form A"
Then "Field A" has "<Values>" in order
	| Values                    |
	| Special Senses            |
	| Cardiovascular            |
	| Respiratory               |
	| Gastrointestinal          |
	| Hepatic/Bilary            |
	| Abdomen and Viscera       |
	| Genitouriary/Reproductive |
	| Renal                     |
	| Endocrine/Metabolic       |
And I verify data on Fields in CRF
| Field   | Data             | Inactive |
| Field A | Gastrointestinal | True     |
And I take a screenshot
And I click audit on Field "Field A"
And I verify Audits exist
	| Audit Type | Query Message | User   | Time                 |
	| Record     | Inactivated.  | System | dd MMM yyyy hh:mm:ss |
And I take a screenshot