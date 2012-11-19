#When a non-visible (View Restricted) field, that does not require signature, on a form with other fields that do require signature and have already been signed, is made visible (View Restriction is removed), the signature on the visible fields is not broken.
<<<<<<< HEAD
@ignore
Feature: US17415_DT14115 When a non-visible (View Restricted) field, that does not require signature, on a form with other fields that do require signature and have already been signed, is made visible (View Restriction is removed), then the signature on the visible fields should not break.
=======
#@ignore
Feature: US17415_DT14115 
>>>>>>> 65caaec... using seeding by draft upload for feature tests.
	When a non-visible (View Restricted) field, that does not require signature, on a form with other fields that do require signature and have already been signed, is made visible (View Restriction is removed), then the signature on the visible fields should not break.
	As a Rave Administrator
	When I have a form that has visible and non-visible fields
	And the visible fields require signature
	And the non-visible fields do not require signature
	And the visible fields are signed
	When the non-visible fields are made visible
	Then the signature on the visible fields is not broken

Background:
	Given xml draft "US17415_DT14115_Source_Draft.xml" is Uploaded
	And xml draft "US17415_DT14115_Target_Draft.xml" is Uploaded
	And study "**US17415_DT14115" is assigned to Site "Site 01"
	And following Project assignments exist
		| User          | Project             | Environment | Role        | Site    | SecurityRole          |
		| SUPER USER 1  | **US17415_DT14115   | Live: Prod  | SUPER ROLE 1| Site 01 | Project Admin Default |
	And Role "SUPER ROLE" has Action "Sign"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17415_DT14115_01
@Validation	
Scenario: @PB_US17415_DT14115_01 As an Investigator, when I sign the "Adverse Events" log form, the form level signature does not break when the "Added 1 For Extra Review" field is made visible.

	Given I publish and push eCRF "US17415_DT14115_Source_Draft.xml" to "SourceVersion1"
	And I login to Rave with user "SUPER USER 1"

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Adverse Events"
	And I enter data in CRF and save
		| Field                         | Data      | Control Type |
		| AE Number                     | 01JAN2012 | textbox      |
		| Description of Adverse Events | Cramps    | textbox      |
		| Ready for Extra Review        | False     | checkbox     |
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I wait for 5 seconds
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	And I verify text "Please Sign - Default User  (" exists
	And I take a screenshot
	And I open log line 1 for edit

	When I enter data in CRF and save
		| Field                  | Data | Control Type |
		| Ready for Extra Review | True | checkbox     |
	#Then I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I take a screenshot
	And I open log line 1 for edit
	And I verify text "Added 1 For Extra Review" exists
	And I verify text "Added 2 For Extra Review" exists
	And I take a screenshot
	And I click audit on Field "AE Number"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	  
	And I select link "Record - Adverse Events (1)"
	And I select link "DataPage - Adverse Events"
	And I verify Audits exist
		| Audit Type          |
		| Signature Succeeded |
	And I take a screenshot
	And I select link "SUB{Var(num1)}" in "Header"
	And I select link "Adverse Events"
	And I open log line 1 for edit

	When I enter data in CRF and save
		| Field                  | Data  | Control Type |
		| Ready for Extra Review | False | checkbox     |
	And I open log line 1 for edit
	#Then I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I verify text "Added 1 For Extra Review" does not exist
	And I verify text "Added 2 For Extra Review" does not exist
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17415_DT14115_02
@Validation	
Scenario: @PB_US17415_DT14115_02 As an Investigator, when I sign the "Serious Adverse Events" log form, the form level signature does not break when the "Added 1 For Extra Review" field is made visible.

	Given I publish and push eCRF "US17415_DT14115_Source_Draft.xml" to "SourceVersion1"
	And I login to Rave with user "SUPER USER 1"

	When I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Serious Adverse Events"
	And I enter data in CRF and save
		| Field                         | Data      | Control Type |
		| AE Number                     | 01JAN2012 | textbox      |
		| Description of Adverse Events | Cramps    | textbox      |
		| Ready for Extra Review        | False     | checkbox     |
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I wait for 5 seconds
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I take a screenshot
	And I open log line 1 for edit

	When I enter data in CRF and save
		| Field                  | Data | Control Type |
		| Ready for Extra Review | True | checkbox     |
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" does not exist
	Then I verify text "Please Sign - Default User  (" does not exist
	And I take a screenshot
	And I open log line 1 for edit
	And I verify text "Added 1 For Extra Review" exists
	And I verify text "Added 2 For Extra Review" exists
	And I take a screenshot
	And I click audit on Field "AE Number"
	And I select link "Record - Serious Adverse Events (1)"
	And I select link "DataPage - Serious Adverse Events"
	And I verify Audits exist
		| Audit Type       |
		| Signature Broken |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17415_DT14115_03
@Validation	
<<<<<<< HEAD
Scenario: @PB_US17415_DT14115_03 As an Investigator, when I sign the "Demographics" form, the form level signature does not break when the ICDTAGE field is made visible.
	
	And I navigate to "Architect"
	And I select "Study" link "**US17415_DT14115" in "Active Projects"
	And I select link "Source Draft" in "CRF Drafts"
	And I publish CRF Version "Source {RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion1#"
	And I select "Study" link "**US17415_DT14115" in "Header"
	And I push CRF Version "{Var(newversion1#)}" to "All Sites"
	And I navigate to "Home"
=======
Scenario: @PB_US17415_03 As an Investigator, when I sign the "Demographics" form, the form level signature does not break when the ICDTAGE field is made visible.

	Given I publish and push eCRF "US17415_DT14115_Source_Draft.xml" to "SourceVersion1"
	And I login to Rave with user "SUPER USER 1"

	When I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I note down "crfversion" to "ver#"
	And I select link "Demographics"
	And I enter data in CRF and save
		| Field                 | Data        | Control Type |
		| Gender                | Male        | dropdownlist |
		| Ethnicity             | Asian       | dropdownlist |
		| Country               | Canada      | dropdownlist |
		| Informed Consent Date | 12 Jul 2012 | dateTime     |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I wait for 5 seconds
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I take a screenshot

	Given I publish and push eCRF "US17415_DT14115_Target_Draft.xml" to "TargetVersion1"
	
	When I go to Amendment Manager for study "**US17415_DT14115"
	And I select Source CRF version "SourceVersion1"
	And I select Target CRF version "TargetVersion1"
	And I create migration plan
	And I take a screenshot
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select link "Migration Results"
	And I take a screenshot
	Then I verify Job Status is set to Complete
	And I take a screenshot	
	And I navigate to "Home"
	And I select a Subject "SUB{Var(num1)}"
	And I select link "Demographics"
	And I verify text "Derived Age" exists
	And I take a screenshot	
	And I click audit on Field "Gender"
	And I verify Audits exist
		| Audit Type          |
		| Signature Succeeded |
	And I take a screenshot	  
	And I select link "Demographics" in "Header"
	And I click audit on Field "Ethnicity"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Demographics" in "Header"
	And I click audit on Field "Country"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Demographics" in "Header"
	And I click audit on Field "Informed Consent Date"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Record - Demographics"
	And I select link "DataPage - Demographics"
	And I verify Audits exist
		| Audit Type          |
		| Signature Succeeded |
	And I take a screenshot
	When I select link "SUB{Var(num1)}" in "Header"
	And I select link "Demographics"
	And I enter data in CRF and save
		| Field       | Data | Control Type |
		| Derived Age | 30   | textbox      |
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I take a screenshot
					
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17415_DT14115_04
@Validation	
<<<<<<< HEAD
Scenario: @PB_US17415_DT14115_04 As an Investigator, when I sign the "Test Demographics" form, the form level signature does not break when the ICDTAGE field is made invisible.
	
	And I navigate to "Architect"
	And I select "Study" link "**US17415_DT14115" in "Active Projects"
	And I select link "Source Draft" in "CRF Drafts"
	And I publish CRF Version "Source {RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion1#"
	And I select "Study" link "**US17415_DT14115" in "Header"
	And I push CRF Version "{Var(newversion1#)}" to "All Sites"
	And I navigate to "Home"
=======
Scenario: @PB_US17415_04 As an Investigator, when I sign the "Test Demographics" form, the form level signature does not break when the ICDTAGE field is made invisible.

	Given I publish and push eCRF "US17415_DT14115_Source_Draft.xml" to "SourceVersion1"
	And I login to Rave with user "SUPER USER 1"

	When I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Test Demographics"
	And I enter data in CRF and save
		| Field                 | Data        | Control Type |
		| Gender                | Male        | dropdownlist |
		| Ethnicity             | Asian       | dropdownlist |
		| Country               | Canada      | dropdownlist |
		| Informed Consent Date | 12 Jul 2012 | dateTime     |
		| Derived Age           | 30          | textbox      |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I wait for 5 seconds
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I take a screenshot

	Given I publish and push eCRF "US17415_DT14115_Target_Draft.xml" to "TargetVersion1"
	When I go to Amendment Manager for study "**US17415_DT14115"
	And I select Source CRF version "SourceVersion1"
	And I select Target CRF version "TargetVersion1"
	And I create migration plan
	And I take a screenshot
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select link "Migration Results"
	And I take a screenshot
	Then I verify Job Status is set to Complete
	And I take a screenshot	
	And I navigate to "Home"
	#And I select Study "**US17415_DT14115" and Site "Site 01"
	And I select a Subject "SUB{Var(num1)}"
	And I select link "Test Demographics"
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	And I verify text "Please Sign - Default User  (" exists
	And I take a screenshot
	And I verify text "Derived Age" does not exist
	And I take a screenshot	
	And I click audit on Field "Gender"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot
	And I select link "Test Demographics" in "Header"
	And I click audit on Field "Ethnicity"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Test Demographics" in "Header"
	And I click audit on Field "Country"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Test Demographics" in "Header"
	And I click audit on Field "Informed Consent Date"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Record - Test Demographics"
	And I select link "DataPage - Test Demographics"
	And I verify Audits exist
		| Audit Type          |
		| Signature Succeeded |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17415_DT14115_05
@Validation	
<<<<<<< HEAD
Scenario: @PB_US17415_DT14115_05 As an Investigator, when I sign the "Demographics" form and "Field Visibility Changed" is checked in Amendment Manager>Configure Plan, the form level signature does not break when the ICDTAGE field is made visible.
	
	And I navigate to "Architect"
	And I select "Study" link "**US17415_DT14115" in "Active Projects"
	And I select link "Source Draft" in "CRF Drafts"
	And I publish CRF Version "Source {RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion1#"
	And I select "Study" link "**US17415_DT14115" in "Header"
	And I push CRF Version "{Var(newversion1#)}" to "All Sites"
	And I navigate to "Home"
=======
Scenario: @PB_US17415_05 As an Investigator, when I sign the "Demographics" form and "Field Visibility Changed" is checked in Amendment Manager>Configure Plan, the form level signature does not break when the ICDTAGE field is made visible.

	Given I publish and push eCRF "US17415_DT14115_Source_Draft.xml" to "SourceVersion1"
	And I login to Rave with user "SUPER USER 1"

	When I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Demographics"
	And I enter data in CRF and save
		| Field                 | Data        | Control Type |
		| Gender                | Male        | dropdownlist |
		| Ethnicity             | Asian       | dropdownlist |
		| Country               | Canada      | dropdownlist |
		| Informed Consent Date | 12 Jul 2012 | dateTime     |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I wait for 5 seconds
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I take a screenshot

	Given I publish and push eCRF "US17415_DT14115_Target_Draft.xml" to "TargetVersion1"
	When I go to Amendment Manager for study "**US17415_DT14115"
	And I select Source CRF version "SourceVersion1"
	And I select Target CRF version "TargetVersion1"
	And I create migration plan
	And I take a screenshot

	And I navigate to "Configure Plan"
	And I check "Field visibility changed"
	And I select link "Update"
	And I take a screenshot

	And I go to Amendment Manager for study "**US17415_DT14115"
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select link "Migration Results"
	And I take a screenshot
	Then I verify Job Status is set to Complete
	And I take a screenshot	
	And I navigate to "Home"
	And I select a Subject "SUB{Var(num1)}"
	And I select link "Demographics"
	And I verify text "Derived Age" exists
	And I take a screenshot	
	And I click audit on Field "Gender"
	And I verify Audits exist
		| Audit Type          |
		| Signature Succeeded |
	And I take a screenshot	  
	And I select link "Demographics" in "Header"
	And I click audit on Field "Ethnicity"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Demographics" in "Header"
	And I click audit on Field "Country"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Demographics" in "Header"
	And I click audit on Field "Informed Consent Date"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Record - Demographics"
	And I select link "DataPage - Demographics"
	And I verify Audits exist
		| Audit Type          |
		| Signature Succeeded |
	And I take a screenshot
	When I select link "SUB{Var(num1)}" in "Header"
	And I select link "Demographics"
	And I enter data in CRF and save
		| Field       | Data | Control Type |
		| Derived Age | 30   | textbox      |
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I take a screenshot
					
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17415_DT14115_06
@Validation	
<<<<<<< HEAD
Scenario: @PB_US17415_DT14115_06 As an Investigator, when I sign the "Test Demographics" form and "Field Visibility Changed" is checked in Amendment Manager>Configure Plan, the form level signature does not break when the ICDTAGE field is made invisible.
	
	And I navigate to "Architect"
	And I select "Study" link "**US17415_DT14115" in "Active Projects"
	And I select link "Source Draft" in "CRF Drafts"
	And I publish CRF Version "Source {RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion1#"
	And I select "Study" link "**US17415_DT14115" in "Header"
	And I push CRF Version "{Var(newversion1#)}" to "All Sites"
	And I navigate to "Home"
=======
Scenario: @PB_US17415_06 As an Investigator, when I sign the "Test Demographics" form and "Field Visibility Changed" is checked in Amendment Manager>Configure Plan, the form level signature does not break when the ICDTAGE field is made invisible.

	Given I publish and push eCRF "US17415_DT14115_Source_Draft.xml" to "SourceVersion1"
	And I login to Rave with user "SUPER USER 1"

	When I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Test Demographics"
	And I enter data in CRF and save
		| Field                 | Data        | Control Type |
		| Gender                | Male        | dropdownlist |
		| Ethnicity             | Asian       | dropdownlist |
		| Country               | Canada      | dropdownlist |
		| Informed Consent Date | 12 Jul 2012 | dateTime     |
		| Derived Age           | 30          | textbox      |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I wait for 5 seconds
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I take a screenshot

	Given I publish and push eCRF "US17415_DT14115_Target_Draft.xml" to "TargetVersion1"
	When I go to Amendment Manager for study "**US17415_DT14115"
	And I select Source CRF version "SourceVersion1"
	And I select Target CRF version "TargetVersion1"
	And I create migration plan
	And I take a screenshot

	And I navigate to "Configure Plan"
	And I check "Field visibility changed"
	And I select link "Update"
	And I take a screenshot

	And I go to Amendment Manager for study "**US17415_DT14115"
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select link "Migration Results"
	And I take a screenshot
	Then I verify Job Status is set to Complete
	And I take a screenshot	
	And I navigate to "Home"
	And I select a Subject "SUB{Var(num1)}"
	And I select link "Test Demographics"
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	And I verify text "Please Sign - Default User  (" exists
	And I take a screenshot
	And I verify text "Derived Age" does not exist
	And I take a screenshot	
	And I click audit on Field "Gender"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot
	And I select link "Test Demographics" in "Header"
	And I click audit on Field "Ethnicity"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Test Demographics" in "Header"
	And I click audit on Field "Country"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Test Demographics" in "Header"
	And I click audit on Field "Informed Consent Date"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	
	And I select link "Record - Test Demographics"
	And I select link "DataPage - Test Demographics"
	And I verify Audits exist
		| Audit Type          |
		| Signature Succeeded |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17415_DT14115_07
@Validation	
Scenario: @PB_US17415_DT14115_07 As an Investigator, when I sign the "Adverse Events 1" standard form, the form level signature does not break when the "Added 1 For Extra Review" field is made visible.

	Given I publish and push eCRF "US17415_DT14115_Source_Draft.xml" to "SourceVersion1"
	And I login to Rave with user "SUPER USER 1"

	When I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Adverse Events 1"
	And I enter data in CRF and save
		| Field                         | Data      | Control Type |
		| AE Number                     | 01JAN2012 | textbox      |
		| Description of Adverse Events | Cramps    | textbox      |
		| Ready for Extra Review        | False     | checkbox     |
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I wait for 5 seconds
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I take a screenshot

	When I enter data in CRF and save
		| Field                  | Data | Control Type |
		| Ready for Extra Review | True | checkbox     |
	#Then I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I take a screenshot
	And I verify text "Added 1 For Extra Review" exists
	And I verify text "Added 2 For Extra Review" exists
	And I take a screenshot
	And I click audit on Field "AE Number"
	And I verify Audits exist
		| Audit Type          |  
		| Signature Succeeded |
	And I take a screenshot	 
	And I select link "Record - Adverse Events 1"
	And I select link "DataPage - Adverse Events 1"
	And I verify Audits exist
		| Audit Type          |
		| Signature Succeeded |
	And I take a screenshot
	And I select link "SUB{Var(num1)}" in "Header"
	And I select link "Adverse Events 1"

	When I enter data in CRF and save
		| Field                  | Data  | Control Type |
		| Ready for Extra Review | False | checkbox     |
	#Then I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I verify text "Added 1 For Extra Review" does not exist
	And I verify text "Added 2 For Extra Review" does not exist
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17415_DT14115_08
@Validation	
Scenario: @PB_US17415_DT14115_08 As an Investigator, when I sign the "Serious Adverse Events 1" standard form, the form level signature does not break when the "Added 1 For Extra Review" field is made visible.

	Given I publish and push eCRF "US17415_DT14115_Source_Draft.xml" to "SourceVersion1"
	And I login to Rave with user "SUPER USER 1"

	When I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Serious Adverse Events 1"
	And I enter data in CRF and save
		| Field                         | Data      | Control Type |
		| AE Number                     | 01JAN2012 | textbox      |
		| Description of Adverse Events | Cramps    | textbox      |
		| Ready for Extra Review        | False     | checkbox     |
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I wait for 5 seconds
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" exists
	Then I verify text "Please Sign - Default User  (" exists
	And I take a screenshot

	When I enter data in CRF and save
		| Field                  | Data | Control Type |
		| Ready for Extra Review | True | checkbox     |
	#And I verify text "Please Sign - Default User  (SUPER USER 1)" does not exist
	Then I verify text "Please Sign - Default User  (" does not exist
	And I take a screenshot
	And I verify text "Added 1 For Extra Review" exists
	And I verify text "Added 2 For Extra Review" exists
	And I take a screenshot
	And I click audit on Field "AE Number"
	And I select link "Record - Serious Adverse Events 1"
	And I select link "DataPage - Serious Adverse Events 1"
	And I verify Audits exist
		| Audit Type       |
		| Signature Broken |
	And I take a screenshot