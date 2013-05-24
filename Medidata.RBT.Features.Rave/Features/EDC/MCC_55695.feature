@FT_MCC_55695
@ignore
#Disable input controls on all forms for subject during the signature process (Parent MCC-55695)

Feature: MCC_55695_MCC_59261 Disable input controls on all forms for subject during the signature process.
	As a Rave user
	When I do Batch Sign
	Then controls for subject during the signature process are disabled

Background:
	Given xml Lab Configuration "Lab_MCC-55695.xml" is uploaded
	Given xml draft "MCC-55695.xml" is Uploaded
	Given Site "Site 1" exists
	Given study "MCC-55695" is assigned to Site "Site 1"
	Given following Project assignments exist
		| User         | Project    | Environment | Role        	 | Site   | SecurityRole          | GlobalLibraryRole            |
		| SUPER USER 1 | MCC-55695  | Live: Prod  | SUPER ROLE 1	 | Site 1 | Project Admin Default | Global Library Admin Default |
	Given I publish and push eCRF "MCC-55695.xml" to "Version 1"
	Given I login to Rave with user "SUPER USER 1"

#Batch Sign on Subject Calendar Page	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_01
@Validation	
Scenario: MCC_55695_MCC_59261_01 As an Investigator, when I do batch sign on Subject Calendar page, then I verify text "Your signature is being applied. You may continue working on other subjects.".
	
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	Then I verify text "Your signature is being applied. You may continue working on other subjects." exists
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_02
@Validation	
Scenario: MCC_55695_MCC_59261_02 As an Investigator, when I do batch sign on Subject Calendar page, then I verify 'Add Events' input controls are disabled during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I take a screenshot		
	Then I verify Subject Calendar controls are disabled
		| name       |
		| Add Event  |
		| Add        |
		| Enabled    |
		| Disabled   |
	And I take a screenshot
	
	And I wait for signature to be applied
	And I navigate to "Home"
	When I select a Subject "SUB {Var(num1)}"
	Then I verify Subject Calendar controls are enabled
		| name       |
		| Add Event  |
		| Add        |
		| Enabled    |
		| Disabled   |
	And I take a screenshot		
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_03
@Validation	
Scenario: MCC_55695_MCC_59261_03 As an Investigator, when I do batch sign on Subject Calendar page, then I verify 'Add Form', 'Add Folder' input controls are not available on Subject Administration during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I select link "Subject Administration"
	Then I verify Subject Administration controls are disabled
		| name       |
		| Add Form   |
		| Add Folder |
		| Save       |
	And I take a screenshot
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select link "Subject Administration"	
	Then I verify Subject Administration controls are enabled
		| name       |
		| Add Form   |
		| Add Folder |
		| Save       |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_04
@Validation	
Scenario:  MCC_55695_MCC_59261_04 As an Investigator, when I do batch sign on Subject Calendar page, then I verify 'Save', 'Cancel' buttons are not available on Subject Administration during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I select link "Subject Administration"
	Then I verify Subject Administration controls are disabled
		| name   |
		| Save   |
		| Cancel |
	And I take a screenshot	

	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select link "Subject Administration"
	Then I verify Subject Administration controls are enabled
		| name   |
		| Save   |
		| Cancel |
	And I take a screenshot		
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_05
@Validation	
Scenario: MCC_55695_MCC_59261_05 As an Investigator, when I do batch sign on Subject Calendar page, then I verify 'Save' button is disabled on Grid View during the signature process.
		
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot	
	And I select link "Grid View"
	And I select link "All"
	Then I verify Grid View controls are disabled
		| name       |
		| Save       |
		| Cancel     |
	And I take a screenshot	
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select link "Grid View"
	And I select link "All"
	Then I verify Grid View controls are enabled
		| name       |
		| Save       |
		| Cancel     |
	And I take a screenshot		
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_06
@Validation	
Scenario: MCC_55695_MCC_59261_06 As an Investigator, when I do batch sign on Subject Calendar page, then I verify 'Save' button is disabled on CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I take a screenshot	
	And I wait for 1 seconds
	And I select Form "Form3" in Folder "Folder A" 	
	Then I verify EDC controls are disabled
		| name             |
		| Save             |
	And I take a screenshot

	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select Form "Form3" in Folder "Folder A" 	
	Then I verify EDC controls are enabled
		| name             |
		| Save             |
		| Cancel           |
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_07
@Validation	
Scenario: MCC_55695_MCC_59261_07 As an Investigator, when I do batch sign on Subject Calendar page, then I verify 'Add a new Log line', 'Inactivate', 'Reactivate' links are disabled on log CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	And I enter data in CRF and save
		| Field   | Data        | Control Type |
		| Field 1 | Sick        | textbox      |
		| Field 2 | 12 Jan 2012 | datetime     |
		| Field 3 | female      | dropdownlist |
	And I add a new log line
	And I enter data in CRF and save
		| Field     | Data      	| Control Type |
		| Field 1   | Sick     		| textbox      |
		| Field 2  	| 12 Jan 2012	| datetime     |	
		| Field 3   | female   		| dropdownlist |	
	And I select link "Inactivate"	
	And I choose "2" from "Inactivate"
	And I click button "Inactivate"
	And I take a screenshot
	And I select link "SUB {Var(num1)}" in "Header"
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I take a screenshot	
	And I wait for 1 seconds
	And I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	Then I verify EDC controls are disabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
	And I take a screenshot	
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	Then I verify EDC controls are enabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_08
@Validation	
Scenario: MCC_55695_MCC_59261_08 As an Investigator, when I do batch sign on Subject Calendar page, then I verify 'CRF Page' and 'Fields' are not editable on CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I select Form "Form1"
	Then I cannot enter data in CRF and save
		| Field    | Data   | Control Type |
		| Field 1A | 123    | textbox      |
	And I take a screenshot
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select Form "Form1"
	Then I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot
	And I enter data in CRF and save
		| Field    | Data   | Control Type |
		| Field 1A | 123    | textbox      |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_09
@Validation	
Scenario: MCC_55695_MCC_59261_09 As an Investigator, when I do batch sign on Subject Calendar page, then I verify 'Audit', icon is disabled on CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I select Form "Form1"
	And I click audit on Field "Field 1A"
	Then I verify Audit controls are disabled	
		| name   |
		| Submit |
	And I take a screenshot
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select Form "Form1"
	Then I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
	And I take a screenshot	
	And I click audit on Field "Field 1A"
	Then I verify Audit controls are enabled	
		| name   |
		| Submit |
	And I take a screenshot		
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_10
@Validation	
Scenario: MCC_55695_MCC_59261_10 As an Investigator, when I do batch sign on Subject Calendar page, then I verify 'Lab' dropdown is disabled on CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I select Form "Lab Form"
	Then I verify EDC controls are disabled	
		| name |
		| Lab  |
	And I take a screenshot	
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select Form "Lab Form"
	Then I verify EDC controls are enabled	
		| name |
		| Lab  |
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot		

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_11
@Validation	
Scenario: MCC_55695_MCC_59261_11 As an Investigator, when I do batch sign on Subject Calendar page, then I verify 'Template'dropdown and 'Modify Templates' link are disabled on CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I select Form "Template Form" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are disabled	
		| name    			|
		| Modify Templates	|
	And I take a screenshot	
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select Form "Template Form" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are enabled	
		| name    			|
		| Modify Templates	|
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot			

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_12
@Validation	
Scenario: MCC_55695_MCC_59261_12 As an Investigator, when I do batch sign on Subject Calendar page, then I verify 'Add a new Log line', 'Inactivate', 'Reactivate' links are disabled on Landscape CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select Form "Landscape" in Folder "Folder Miscellaneous" 	
	And I save the CRF page	 
	And I add a new log line
	And I save the CRF page	
	And I select link "Inactivate"	
	And I choose "2" from "Inactivate"
	And I click button "Inactivate"
	And I take a screenshot
	And I select link "SUB {Var(num1)}" in "Header"
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I select Form "Landscape" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are disabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
	And I take a screenshot	
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"	
	When I select Form "Landscape" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are enabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot		

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_13
@Validation	
Scenario: MCC_55695_MCC_59261_13 As an Investigator, when I sign a CRF page and I do batch sign on Subject Calendar page, then I verify text "Your signature is being applied. You may continue working on other subjects.".

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select Form "Form1"
	And I enter data in CRF and save
		| Field     | Data   | Control Type |
		| Field 1A  | Sick   | textbox      |
		| Field 2A 	| Sick	 | textbox      |
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I select link "SUB {Var(num1)}" in "Header"
	When I click button "Sign and Save"
	Then I verify field "Username" does not exist
	And I take a screenshot		
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	Then I verify text "Your signature is being applied. You may continue working on other subjects." exists
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
#Batch Sign on Grid View Page	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_14
@Validation	
Scenario: MCC_55695_MCC_59261_14 As an Investigator, when I do batch sign on Grid View page, then I verify text "Your signature is being applied. You may continue working on other subjects.".
	
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Grid View"		
	And I select link "All"
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	Then I verify text "Your signature is being applied. You may continue working on other subjects." exists
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_15
@Validation	
Scenario: MCC_55695_MCC_59261_15 As an Investigator, when I do batch sign on Grid View page, then I verify 'Add Events' input controls are disabled during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Grid View"		
	And I select link "All"		
	And I click button "Sign and Save"	
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot	
	Then I verify Grid View controls are disabled
		| name       |
		| Add Event  |
		| Add        |
		| Enabled    |
		| Disabled   |
	And I take a screenshot

	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select link "Grid View"	
	Then I verify Grid View controls are enabled
		| name       |
		| Add Event  |
		| Add        |
		| Enabled    |
		| Disabled   |
	And I take a screenshot		
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_16
@Validation	
Scenario: MCC_55695_MCC_59261_16 As an Investigator, when I do batch sign on Grid View page, then I verify 'Add Form', 'Add Folder' input controls are not available on Subject Administration during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Grid View"		
	And I select link "All"				
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot	
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select link "Subject Administration"
	Then I verify Subject Administration controls are disabled
		| name       |
		| Add Form   |
		| Add Folder |
		| Save       |
	And I take a screenshot	

	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select link "Subject Administration"	
	Then I verify Subject Administration controls are enabled
		| name       |
		| Add Form   |
		| Add Folder |
		| Save       |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_17
@Validation	
Scenario:  MCC_55695_MCC_59261_17 As an Investigator, when I do batch sign on Grid View page, then I verify 'Save', 'Cancel' buttons are not available on Subject Administration during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Grid View"		
	And I select link "All"			
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot	
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select link "Subject Administration"
	Then I verify Subject Administration controls are disabled
		| name             |
		| Save             |
		| Cancel           |
	And I take a screenshot	

	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select link "Subject Administration"
	Then I verify Subject Administration controls are enabled
		| name             |
		| Save             |
		| Cancel           |
	And I take a screenshot		
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_18
@Validation	
Scenario: MCC_55695_MCC_59261_18 As an Investigator, when I do batch sign on Grid View page, then I verify 'Save' button is disabled on Grid View during the signature process.
	
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Grid View"		
	And I select link "All"			
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot	
	Then I verify Grid View controls are disabled
		| name             |
		| Save             |
		| Cancel           |
	And I take a screenshot

	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select link "Grid View"
	And I select link "All"		
	Then I verify Grid View controls are enabled
		| name             |
		| Save             |
		| Cancel           |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_19
@Validation	
Scenario: MCC_55695_MCC_59261_19 As an Investigator, when I do batch sign on Grid View page, then I verify 'Save' button is disabled on CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Grid View"		
	And I select link "All"		
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select Form "Form3" in Folder "Folder A" 	
	Then I verify EDC controls are disabled
		| name             |
		| Save             |
	And I take a screenshot
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select Form "Form3" in Folder "Folder A" 	
	Then I verify EDC controls are enabled
		| name             |
		| Save             |
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists		
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_20
@Validation	
Scenario: MCC_55695_MCC_59261_20 As an Investigator, when I do batch sign on Grid View page, then I verify 'Add a new Log line', 'Inactivate', 'Reactivate' links are disabled on log CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	And I enter data in CRF and save
		| Field     | Data   | Control Type |
		| Field 1   | Sick     		| textbox      |
		| Field 2  	| 12 Jan 2012	| datetime     |	
		| Field 3   | female   		| dropdownlist |	
	And I add a new log line
	And I enter data in CRF and save
		| Field     | Data      	| Control Type |
		| Field 1   | Sick     		| textbox      |
		| Field 2  	| 12 Jan 2012	| datetime     |	
		| Field 3   | female   		| dropdownlist |	
	And I select link "Inactivate"	
	And I choose "2" from "Inactivate"
	And I click button "Inactivate"
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select link "Grid View"		
	And I select link "All"		
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot	
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	Then I verify EDC controls are disabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
	And I take a screenshot	
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	Then I verify EDC controls are enabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists		
	And I take a screenshot
		
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_21
@Validation	
Scenario: MCC_55695_MCC_59261_21 As an Investigator, when I do batch sign on Grid View page, then I verify 'CRF Page' and 'Fields' are not editable on CRF page during the signature process.
	
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Grid View"		
	And I select link "All"			
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select Form "Form1"
	Then I cannot enter data in CRF and save
		| Field    | Data   | Control Type |
		| Field 1A | 123    | textbox      |	
	And I take a screenshot
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select Form "Form1"
	Then I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I enter data in CRF and save
		| Field    | Data   | Control Type |
		| Field 1A | 123    | textbox      |	
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_22
@Validation	
Scenario: MCC_55695_MCC_59261_22 As an Investigator, when I do batch sign on Grid View page, then I verify 'Audit' icons are disabled on CRF page during the signature process.
	
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select Form "Form1"
	And I enter data in CRF and save
		| Field     | Data   | Control Type |
		| Field 1A  | Sick   | textbox      |
		| Field 2A 	| Sick	 | textbox      |
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select link "Grid View"		
	And I select link "All"			
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select Form "Form1"
	And I click audit on Field "Field 1A"
	Then I verify Audit controls are disabled	
		| name   |
		| Submit |
	And I take a screenshot
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select Form "Form1"
	Then I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
	And I click audit on Field "Field 1A"
	And I verify Audit controls are enabled	
		| name   |
		| Submit |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_23
@Validation	
Scenario: MCC_55695_MCC_59261_23 As an Investigator, when I do batch sign on Grid View page, then I verify 'Lab' dropdown is disabled on CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Grid View"		
	And I select link "All"			
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot	
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select Form "Lab Form"
	Then I verify EDC controls are disabled	
		| name |
		| Lab  |
	And I take a screenshot	
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select Form "Lab Form"
	Then I verify EDC controls are enabled	
		| name |
		| Lab  |
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_24
@Validation	
Scenario: MCC_55695_MCC_59261_24 As an Investigator, when I do batch sign on Grid View page, then I verify 'Template'dropdown and 'Modify Templates' link are disabled on CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Grid View"		
	And I select link "All"			
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select Form "Template Form" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are disabled	
		| name    			|
		| Modify Templates	|
	And I take a screenshot	
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	When I select Form "Template Form" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are enabled	
		| name    			|
		| Modify Templates	|
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_25
@Validation	
Scenario: MCC_55695_MCC_59261_25 As an Investigator, when I do batch sign on Grid View page, then I verify 'Add a new Log line', 'Inactivate', 'Reactivate' links are disabled on Landscape CRF page during the signature process.

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select Form "Landscape" in Folder "Folder Miscellaneous" 	
	And I save the CRF page	 
	And I add a new log line
	And I save the CRF page	
	And I select link "Inactivate"	
	And I choose "2" from "Inactivate"
	And I click button "Inactivate"
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select link "Grid View"		
	And I select link "All"		
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select Form "Landscape" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are disabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line | 
	And I take a screenshot	
	
	And I wait for signature to be applied
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"	
	When I select Form "Landscape" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are enabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_26
@Validation	
Scenario: MCC_55695_MCC_59261_26 As an Investigator, when I sign a CRF page and I do batch sign on Grid View page, then I verify text "Your signature is being applied. You may continue working on other subjects.".

	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select Form "Form1"
	And I enter data in CRF and save
		| Field     | Data   | Control Type |
		| Field 1A  | Sick   | textbox      |
		| Field 2A 	| Sick	 | textbox      |	
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I wait for 1 seconds
	And I take a screenshot		
	And I navigate to "Home"
	And I select a Subject "SUB {Var(num1)}"
	And I select link "Grid View"		
	And I select link "All"		
	When I click button "Sign and Save"
	Then I verify field "Username" does not exist
	And I take a screenshot		
	And I sign the subject with username "SUPER USER 1"
	And I wait for 1 seconds
	Then I verify text "Your signature is being applied. You may continue working on other subjects." exists
	And I take a screenshot	