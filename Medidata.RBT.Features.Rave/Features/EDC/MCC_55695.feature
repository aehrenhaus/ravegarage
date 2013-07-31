@FT_MCC_55695
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
		| User         | Project    | Environment | Role        	 | Site   | SecurityRole          |
		| SUPER USER 1 | MCC-55695  | Live: Prod  | SUPER ROLE 1	 | Site 1 | Project Admin Default |
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
Scenario: MCC_55695_MCC_59261_02 As an Investigator, when I do batch sign on Subject Calendar page, then I verify controls are disabled during the signature process.
	
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |

	And I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	And I enter data in CRF and save
		| Field   | Data        | Control Type |
		| Field 1 | Sick        | textbox      |
		| Field 2 | 12 Jan 2012 | datetime     |
		| Field 3 | female      | Dropdown     |
	And I add a new log line
	And I enter data in CRF and save
		| Field   | Data        | Control Type |
		| Field 1 | Sick        | textbox      |
		| Field 2 | 12 Jan 2012 | datetime     |
		| Field 3 | female      | Dropdown     |
	And I select link "Inactivate"	
	And I choose "2" from "Inactivate"
	And I click button "Inactivate"
	And I take a screenshot	

	And I select link "SUB {Var(num1)}" in "Header"		
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
	And I take a screenshot	
	
	And I set subject to disable controls
	
	Then I verify Subject Calendar controls are disabled
		| name       |
		| Add Event  |
		| Add        |
		| Enabled    |
		| Disabled   |
	And I take a screenshot

	And I select link "Subject Administration"
	Then I verify Subject Administration controls are disabled
		| name       |
		| Add Form   |
		| Add Folder |
		| Save       |
	And I take a screenshot	
	
	And I select link "SUB {Var(num1)}" in "Header"		
	And I select link "Grid View"
	And I select link "All"
	Then I verify Grid View controls are disabled
		| name       |
		| Save       |
	And I take a screenshot		

	And I select link "SUB {Var(num1)}" in "Header"		
	And I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	Then I verify EDC controls are disabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
		| Save  			 |
	And I take a screenshot		
	
	And I select link "SUB {Var(num1)}" in "Header"	
	And I select Form "Form1"
	Then I cannot enter data in CRF and save
		| Field    | Data   | Control Type |
		| Field 1A | 123    | textbox      |
	And I take a screenshot
	And I click audit on Field "Field 1A"
	Then I verify Audit controls are disabled	
		| name   |
		| Submit |
	And I take a screenshot

	And I select link "SUB {Var(num1)}" in "Header"	
	And I select Form "Lab Form"
	Then I verify EDC controls are disabled	
		| name |
		| Lab  |
	And I take a screenshot	
	
	And I select link "SUB {Var(num1)}" in "Header"	
	And I select Form "Template Form" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are disabled	
		| name    			|
		| Modify Templates	|
	And I take a screenshot	

	And I select link "SUB {Var(num1)}" in "Header"	
	And I select Form "Landscape" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are disabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
	And I take a screenshot	

	And I set subject to enable controls

	And I select link "SUB {Var(num1)}" in "Header"	
	Then I verify Subject Calendar controls are enabled
		| name       |
		| Add Event  |
		| Add        |
		| Enabled    |
		| Disabled   |
	And I take a screenshot	

	And I select link "SUB {Var(num1)}" in "Header"	
	When I select link "Subject Administration"	
	Then I verify Subject Administration controls are enabled
		| name       |
		| Add Form   |
		| Add Folder |
		| Save       |
	And I take a screenshot

	And I select link "SUB {Var(num1)}" in "Header"	
	When I select link "Grid View"
	And I select link "All"
	Then I verify Grid View controls are enabled
		| name       |
		| Save       |
	And I take a screenshot		
	
	And I select link "SUB {Var(num1)}" in "Header"	
	When I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	Then I verify EDC controls are enabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
		| Save  			 |
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot	
	
	And I select link "SUB {Var(num1)}" in "Header"	
	When I select Form "Form1"
	Then I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
	And I take a screenshot
	And I enter data in CRF and save
		| Field    | Data   | Control Type |
		| Field 1A | 123    | textbox      |
	And I take a screenshot	
	And I click audit on Field "Field 1A"
	Then I verify Audit controls are enabled	
		| name   |
		| Submit |
	And I take a screenshot
	
	And I select link "SUB {Var(num1)}" in "Header"		
	When I select Form "Lab Form"
	Then I verify EDC controls are enabled	
		| name |
		| Lab  |
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot		

	And I select link "SUB {Var(num1)}" in "Header"	
	And I select Form "Template Form" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are enabled	
		| name    			|
		| Modify Templates	|
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot		

	And I select link "SUB {Var(num1)}" in "Header"		
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
@PB_MCC_55695_MCC_59261_03
@Validation	
Scenario: MCC_55695_MCC_59261_03 As an Investigator, when I sign a CRF page and I do batch sign on Subject Calendar page with password, then I verify text "Your signature is being applied. You may continue working on other subjects.".

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
	And I take a screenshot		
	And I select link "SUB {Var(num1)}" in "Header"
	When I click button "Sign and Save"
	Then I verify field "Username" does not exist
	And I take a screenshot		
	When I sign the subject with username "SUPER USER 1"
	Then I verify text "Your signature is being applied. You may continue working on other subjects." exists
	And I take a screenshot	
					
#Batch Sign on Grid View Page
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_04
@Validation	
Scenario: MCC_55695_MCC_59261_04 As an Investigator, when I do batch sign on Grid View page, then I verify text "Your signature is being applied. You may continue working on other subjects.".
	
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |
	And I select link "Grid View"		
	And I select link "All"
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"
	Then I verify text "Your signature is being applied. You may continue working on other subjects." exists
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_55695_MCC_59261_05
@Validation	
Scenario: MCC_55695_MCC_59261_05 As an Investigator, when I do batch sign on Subject Calendar page, then I verify controls are disabled during the signature process.
	
	And I create a Subject
		| Field          | Data              | Control Type |
		| Subject Name   | SUB               | textbox      |
		| Subject Number | {RndNum<num1>(5)} | textbox      |

	And I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	And I enter data in CRF and save
		| Field   | Data        | Control Type |
		| Field 1 | Sick        | textbox      |
		| Field 2 | 12 Jan 2012 | datetime     |
		| Field 3 | female      | Dropdown     |
	And I add a new log line
	And I enter data in CRF and save
		| Field   | Data        | Control Type |
		| Field 1 | Sick        | textbox      |
		| Field 2 | 12 Jan 2012 | datetime     |
		| Field 3 | female      | Dropdown     |
	And I select link "Inactivate"	
	And I choose "2" from "Inactivate"
	And I click button "Inactivate"
	And I take a screenshot	

	And I select link "SUB {Var(num1)}" in "Header"		
	And I select Form "Landscape" in Folder "Folder Miscellaneous" 	
	And I save the CRF page	 
	And I add a new log line
	And I save the CRF page	
	And I select link "Inactivate"	
	And I choose "2" from "Inactivate"
	And I click button "Inactivate"
	And I take a screenshot

	And I select link "SUB {Var(num1)}" in "Header"	
	And I select link "Grid View"		
	And I select link "All"	
	And I click button "Sign and Save"
	When I sign the subject with username "SUPER USER 1"	
	And I take a screenshot	
	
	And I set subject to disable controls

	And I select link "SUB {Var(num1)}" in "Header"	
	And I select link "Grid View"
	And I select link "All"
	Then I verify Grid View controls are disabled
		| name       |
		| Save       |
	And I take a screenshot		
	
	And I select link "SUB {Var(num1)}" in "Header"		
	Then I verify Subject Calendar controls are disabled
		| name       |
		| Add Event  |
		| Add        |
		| Enabled    |
		| Disabled   |
	And I take a screenshot

	And I select link "Subject Administration"
	Then I verify Subject Administration controls are disabled
		| name       |
		| Add Form   |
		| Add Folder |
		| Save       |
	And I take a screenshot	
	
	And I select link "SUB {Var(num1)}" in "Header"		
	And I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	Then I verify EDC controls are disabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
		| Save  			 |	
	And I take a screenshot		
	
	And I select link "SUB {Var(num1)}" in "Header"	
	And I select Form "Form1"
	Then I cannot enter data in CRF and save
		| Field    | Data   | Control Type |
		| Field 1A | 123    | textbox      |
	And I take a screenshot
	And I click audit on Field "Field 1A"
	Then I verify Audit controls are disabled	
		| name   |
		| Submit |
	And I take a screenshot

	And I select link "SUB {Var(num1)}" in "Header"	
	And I select Form "Lab Form"
	Then I verify EDC controls are disabled	
		| name |
		| Lab  |
	And I take a screenshot	
	
	And I select link "SUB {Var(num1)}" in "Header"	
	And I select Form "Template Form" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are disabled	
		| name    			|
		| Modify Templates	|
	And I take a screenshot	

	And I select link "SUB {Var(num1)}" in "Header"	
	And I select Form "Landscape" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are disabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
	And I take a screenshot	

	And I set subject to enable controls

	And I select link "SUB {Var(num1)}" in "Header"	
	Then I verify Subject Calendar controls are enabled
		| name       |
		| Add Event  |
		| Add        |
		| Enabled    |
		| Disabled   |
	And I take a screenshot	

	And I select link "SUB {Var(num1)}" in "Header"	
	When I select link "Subject Administration"	
	Then I verify Subject Administration controls are enabled
		| name       |
		| Add Form   |
		| Add Folder |
		| Save       |
	And I take a screenshot

	And I select link "SUB {Var(num1)}" in "Header"	
	When I select link "Grid View"
	And I select link "All"
	Then I verify Grid View controls are enabled
		| name       |
		| Save       |
	And I take a screenshot		
	
	And I select link "SUB {Var(num1)}" in "Header"	
	When I select Form "Portrait" in Folder "Folder Miscellaneous" 	
	Then I verify EDC controls are enabled
		| name               |
		| Inactivate Link    |
		| Reactivate Link    |
		| Add a new Log line |
		| Save  			 |	
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot	
	
	And I select link "SUB {Var(num1)}" in "Header"	
	When I select Form "Form1"
	Then I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists
	And I take a screenshot
	And I enter data in CRF and save
		| Field    | Data   | Control Type |
		| Field 1A | 123    | textbox      |
	And I take a screenshot	
	And I click audit on Field "Field 1A"
	Then I verify Audit controls are enabled	
		| name   |
		| Submit |
	And I take a screenshot
	
	And I select link "SUB {Var(num1)}" in "Header"		
	When I select Form "Lab Form"
	Then I verify EDC controls are enabled	
		| name |
		| Lab  |
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot		

	And I select link "SUB {Var(num1)}" in "Header"	
	And I select Form "Template Form" in Folder "Folder Miscellaneous" 
	Then I verify EDC controls are enabled	
		| name    			|
		| Modify Templates	|
	And I verify text "Please Sign - Default User  (SUPER USER 1)" with username "SUPER USER 1" exists	
	And I take a screenshot		

	And I select link "SUB {Var(num1)}" in "Header"		
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
@PB_MCC_55695_MCC_59261_06
@Validation	
Scenario: MCC_55695_MCC_59261_06 As an Investigator, when I sign a CRF page and I do batch sign on Grid View page with password, then I verify text "Your signature is being applied. You may continue working on other subjects.".

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
	And I take a screenshot		
	And I select link "SUB {Var(num1)}" in "Header"
	And I select link "Grid View"		
	And I select link "All"		
	When I click button "Sign and Save"
	Then I verify field "Username" does not exist
	And I take a screenshot		
	And I sign the subject with username "SUPER USER 1"
	Then I verify text "Your signature is being applied. You may continue working on other subjects." exists
	And I take a screenshot		