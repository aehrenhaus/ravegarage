#When a non-visible (View Restricted) field, that does not require signature, on a form with other fields that do require signature and have already been signed, is made visible (View Restriction is removed), the signature on the visible fields is not broken.

Feature: US17415_DT14115 
	When a non-visible (View Restricted) field, that does not require signature, on a form with other fields that do require signature and have already been signed, is made visible (View Restriction is removed), then the signature on the visible fields should not break.
	As a Rave Administrator
	When I have a form that has visible and non-visible fields
	And the visible fields require signature
	And the non-visible fields do not require signature
	And the visible fields are signed
	When the non-visible fields are made visible
	Then the signature on the visible fields is not broken

Background:

	Given I am logged in to Rave with username "defuser" and password "password"
	#And the following Project assignments exist
	#	| User    | Project           | Environment | Role | Site    | Site Number |
	#	| defuser | **US17415_DT14115 | Prod        | CDM1 | Site 01 | S100        |
	#And Role "CDM1" has Action "Sign"
	#And Project "**US17415_DT14115" has Draft "<Source Draft>"
	#And Draft "<Draft1>" has Form "Adverse Events" with fields
	#	| FieldOID 		| Field Label           		| Data Dictionary 	| Control Type 	| Data Format 	| Log data entry	|IsVisible | Does not participate in Signature 	|
	#	| AENUM      	| AE Number                		| N/A              	| Text 			| $10          	| True				|True      | False               				|
	#	| AETERM     	| Description of Adverse Events | N/A            	| LongText		| $350          | True				|True      | False               				|
	#	| EXTRAEV  		| Ready for Extra Review        | N/A       		| Checkbox 		| 1         	| True				|True      | True               				|
	#	| AEMOR1     	| Added 1 For Extra Review 		| N/A             	| Text     		| $10 			| True				|False     | True              				 	|
	#	| AEMOR2  		| Added 2 For Extra Review      | N/A             	| Text         	| $10           | True				|False     | True			              		|	
	#And Draft "<Source Draft>" has Form "Demographics" with fields
	#	| FieldOID | Field Label           | Data Dictionary | Control Type | Data Format | IsVisible | Requires Signature |
	#	| SEX      | Gender                | MF              | DropDownList | $7          | True      | True               |
	#	| RACE     | Ethnicity             | Race            | DropDownList | 2           | True      | True               |
	#	| COUNTRY  | Country               | Countries       | DropDownList | $20         | True      | True               |
	#	| ICDT     | Informed Consent Date | N/A             | DateTime     | dd MMM yyyy | True      | True               |
	#	| ICDTAGE  | Derived Age           | N/A             | Text         | 3           | False     | True	           |
	#And Draft "<Source Draft>" has Form "Serious Adverse Events" with fields
	#	| FieldOID 		| Field Label           		| Data Dictionary 	| Control Type 	| Data Format 	| Log data entry	|IsVisible | Does not participate in Signature 	|
	#	| AENUM      	| AE Number                		| N/A              	| Text 			| $10          	| True				|True      | False               				|
	#	| AETERM     	| Description of Adverse Events | N/A            	| LongText		| $350          | True				|True      | False               				|
	#	| EXTRAEV  		| Ready for Extra Review        | N/A       		| Checkbox 		| 1         	| True				|True      | True               				|
	#	| AEMOR1     	| Added 1 For Extra Review 		| N/A             	| Text     		| $10 			| True				|False     | True              				 	|
	#	| AEMOR2  		| Added 2 For Extra Review      | N/A             	| Text         	| $10           | True				|False     | False			              		|	
	#And Draft "<Source Draft>" has Form "Test Demographics" with fields
	#	| FieldOID | Field Label           | Data Dictionary | Control Type | Data Format | IsVisible | Requires Signature |
	#	| SEX      | Gender                | MF              | DropDownList | $7          | True      | True               |
	#	| RACE     | Ethnicity             | Race            | DropDownList | 2           | True      | True               |
	#	| COUNTRY  | Country               | Countries       | DropDownList | $20         | True      | True               |
	#	| ICDT     | Informed Consent Date | N/A             | DateTime     | dd MMM yyyy | True      | True               |
	#	| ICDTAGE  | Derived Age           | N/A             | Text         | 3           | True	  | True	           |
	#And Project "**US17415_DT14115" has Draft "<Target Draft>"
	#And Draft "<Target Draft1>" has Form "Adverse Events" with fields
	#	| FieldOID 		| Field Label           		| Data Dictionary 	| Control Type 	| Data Format 	| Log data entry	|IsVisible | Does not participate in Signature 	|
	#	| AENUM      	| AE Number                		| N/A              	| Text 			| $10          	| True				|True      | False               				|
	#	| AETERM     	| Description of Adverse Events | N/A            	| LongText		| $350          | True				|True      | False               				|
	#	| EXTRAEV  		| Ready for Extra Review        | N/A       		| Checkbox 		| 1         	| True				|True      | True               				|
	#	| AEMOR1     	| Added 1 For Extra Review 		| N/A             	| Text     		| $10 			| True				|False     | True              				 	|
	#	| AEMOR2  		| Added 2 For Extra Review      | N/A             	| Text         	| $10           | True				|False     | True			              		|	
	#And Draft "<Target Draft>" has Form "Demographics" with fields
	#	| FieldOID | Field Label           | Data Dictionary | Control Type | Data Format | IsVisible | Requires Signature |
	#	| SEX      | Gender                | MF              | DropDownList | $7          | True      | True               |
	#	| RACE     | Ethnicity             | Race            | DropDownList | 2           | True      | True               |
	#	| COUNTRY  | Country               | Countries       | DropDownList | $20         | True      | True               |
	#	| ICDT     | Informed Consent Date | N/A             | DateTime     | dd MMM yyyy | True      | True               |
	#	| ICDTAGE  | Derived Age           | N/A             | Text         | 3           | True	  | True	           |
	#And Draft "<Target Draft>" has Form "Serious Adverse Events" with fields
	#	| FieldOID 		| Field Label           		| Data Dictionary 	| Control Type 	| Data Format 	| Log data entry	|IsVisible | Does not participate in Signature 	|
	#	| AENUM      	| AE Number                		| N/A              	| Text 			| $10          	| True				|True      | False               				|
	#	| AETERM     	| Description of Adverse Events | N/A            	| LongText		| $350          | True				|True      | False               				|
	#	| EXTRAEV  		| Ready for Extra Review        | N/A       		| Checkbox 		| 1         	| True				|True      | True               				|
	#	| AEMOR1     	| Added 1 For Extra Review 		| N/A             	| Text     		| $10 			| True				|False     | True              				 	|
	#	| AEMOR2  		| Added 2 For Extra Review      | N/A             	| Text         	| $10           | True				|False     | False			              		|	
	#And Draft "<Target Draft>" has Form "Test Demographics" with fields
	#	| FieldOID | Field Label           | Data Dictionary | Control Type | Data Format | IsVisible | Requires Signature |
	#	| SEX      | Gender                | MF              | DropDownList | $7          | True      | True               |
	#	| RACE     | Ethnicity             | Race            | DropDownList | 2           | True      | True               |
	#	| COUNTRY  | Country               | Countries       | DropDownList | $20         | True      | True               |
	#	| ICDT     | Informed Consent Date | N/A             | DateTime     | dd MMM yyyy | True      | True               |
	#	| ICDTAGE  | Derived Age           | N/A             | Text         | 3           | False	  | True	           |
	#And Data Dictionary "MF" has entries
	#	| User Value | Coded Value |
	#	| Male       | 1           |
	#And Data Dictionary "Race" has entries
	#   | User Value                | Coded Value |
	#   | Black or African American | 1           |
	#   | Asian                     | 2           |
	#   | White                     | 3           |
	#And Data Dictionary "Countries" has entries
	#   | User Value | Coded Value |
	#   | USA        | 1           |
	#   | Canada     | 2           |
	#And Edit Check "ADD_AE" exists with "Check Steps"
	#	|DataType		|Adverse Events	|EXTRAEV|
	#	|Constant		|1				|1		|
	#	|Check Function	|IsEqualTo		|		|
	#And Edit Check "ADD_AE" exists with "Check Actions"	
	#	|Adverse Events	|AEMOR1	|Set Datapoint Visible: TRUE |
	#	|Adverse Events	|AEMOR2	|Set Datapoint Visible: TRUE |	
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Source Draft>" to site "Site 01" in Project "**US17415_DT14115" for Enviroment "Prod"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17415_01
@Validation	
Scenario: @PB_US17415_01 As an Investigator, when I sign the "Adverse Events" form, the form level signature does not break when the "Added 1 For Extra Review" field is made visible.

	And I select Study "**US17415_DT14115" and Site "Site 01"
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
	And I sign the form with username "defuser" and password "password"
	And I wait for 5 seconds
	And I verify text "Please Sign - Default User  (defuser)" exists
	And I take a screenshot
	And I open log line 1 for edit
	When I enter data in CRF and save
		| Field                  | Data | Control Type |
		| Ready for Extra Review | True | checkbox     |
	Then I verify text "Please Sign - Default User  (defuser)" exists
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
	Then I verify text "Please Sign - Default User  (defuser)" exists
	And I verify text "Added 1 For Extra Review" does not exist
	And I verify text "Added 2 For Extra Review" does not exist
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17415_02
@Validation	
Scenario: @PB_US17415_02 As an Investigator, when I sign the "Serious Adverse Events" form, the form level signature does not break when the "Added 1 For Extra Review" field is made visible.

	And I select Study "**US17415_DT14115" and Site "Site 01"
	And I create a Subject
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
	And I sign the form with username "defuser" and password "password"
	And I wait for 5 seconds
	And I verify text "Please Sign - Default User  (defuser)" exists
	And I take a screenshot
	And I open log line 1 for edit
	When I enter data in CRF and save
		| Field                  | Data | Control Type |
		| Ready for Extra Review | True | checkbox     |
	And I verify text "Please Sign - Default User  (defuser)" does not exist
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
@PB_US17415_03
@Validation	
Scenario: @PB_US17415_03 As an Investigator, when I sign the "Demographics" form, the form level signature does not break when the ICDTAGE field is made visible.
	
	And I select Study "**US17415_DT14115" and Site "Site 01"
	And I create a Subject
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
	And I sign the form with username "defuser" and password "password"
	And I wait for 5 seconds
	And I verify text "Please Sign - Default User  (defuser)" exists
	And I take a screenshot

	And I navigate to "Home"
	And I navigate to "Architect"
	And I select link "**US17415_DT14115" in "Active Projects"
	And I select link "Target Draft" in "CRF Drafts"
	And I publish CRF Version "Target{RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion#"
	And I select link "**US17415_DT14115" in "Header"
	And I navigate to "Amendment Manager"
	And I choose "VS3 ({Var(ver#)})" from "Source CRF"
	And I choose "{Var(newversion#)}" from "Target CRF"
	And I click button "Create Plan"
	And I take a screenshot
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select link "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot	
	And I navigate to "Home"
	And I select Study "**US17415_DT14115" and Site "Site 01"
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
	And I select link "SUB{Var(num1)}" in "Header"
	And I select link "Demographics"
	And I enter data in CRF and save
		| Field       | Data | Control Type |
		| Derived Age | 30   | textbox      |
	And I verify text "Please Sign - Default User  (defuser)" exists
	And I take a screenshot
					
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US17415_04
@Validation	
Scenario: @PB_US17415_04 As an Investigator, when I sign the "Test Demographics" form, the form level signature does not break when the ICDTAGE field is made visible.
	
	And I select Study "**US17415_DT14115" and Site "Site 01"
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num2>(5)} | textbox      |
	And I note down "crfversion" to "ver2#"
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
	And I sign the form with username "defuser" and password "password"
	And I wait for 5 seconds
	And I verify text "Please Sign - Default User  (defuser)" exists
	And I take a screenshot

	And I navigate to "Home"
	And I navigate to "Architect"
	And I select link "**US17415_DT14115" in "Active Projects"
	And I select link "Target Draft" in "CRF Drafts"
	And I publish CRF Version "Target2{RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion2#"
	And I select link "**US17415_DT14115" in "Header"
	And I navigate to "Amendment Manager"
	And I choose "VS3 ({Var(ver2#)})" from "Source CRF"
	And I choose "{Var(newversion2#)}" from "Target CRF"
	And I click button "Create Plan"
	And I take a screenshot
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select link "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot	
	And I navigate to "Home"
	And I select Study "**US17415_DT14115" and Site "Site 01"
    And I select a Subject "SUB{Var(num2)}"
	And I select link "Test Demographics"
	And I verify text "Please Sign - Default User  (defuser)" exists
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