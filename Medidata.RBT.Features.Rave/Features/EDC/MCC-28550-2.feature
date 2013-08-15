@FT_MCC-28550-2



Feature: MCC-28550-2 Signatures on the data page and in the audit trail are handled in one transaction. End-user signature functionality should remain the same. 


Background:
	
	Given study "MCC-28550" is assigned to Site "Site1"
	Given xml Lab Configuration "Lab_MCC-28550.xml" is uploaded
    Given role "SUPER ROLE 1" exists
    Given xml draft "MCC-28550.xml" is Uploaded
    Given following Project assignments exist
    | User         | Project   | Environment | Role         | Site  | SecurityRole          |
    | SUPER USER 1 | MCC-28550 | Live: Prod  | SUPER ROLE 1 | Site1 | Project Admin Default | 
    Given I publish and push eCRF "MCC-28550.xml" to "Version 1"
   

@Release_2013.1.0
@PB_MCC28550-021
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-021 Verify Signature is succeeded in Audit when a mixed form is signed in grid view and resigned after modify data point.



	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num21>(4)} |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
      	| Audit Type          | User                               | Time                 |
      	| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |   
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num21)}"
    And I select link "Mixed Form"
	And I add a new log line
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field     | Data | Control Type |
   		| Freeze    | 20   | textbox      |
   		| TRANSLATE | TEST | textbox      |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |   
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num21)}"
    And I select link "Grid View" 
	And I select link "Mixed Form" in "Grid View"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
	And I select link "Calendar View"
	And I select link "Mixed Form"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-022
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-022 Verify Signature is succeeded in Audit when a mixed form with default value is signed in grid view and resigned after modify data point.



	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num22>(4)} |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
      	| Audit Type          | User                               | Time                 |
      	| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num22)}"
    And I select link "Mixed Form 1"
    And I take a screenshot 
    And I save the CRF page		
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num22)}"
    And I select link "Grid View"
	And I select link "Mixed Form 1" in "Grid View"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
	And I select link "Calendar View"
	And I select link "Mixed Form 1"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-023
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-023 Verify Signature is succeeded in Audit when a lab form is signed in grid view and resigned after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num23>(4)} |
	And I take a screenshot
	And I select link "Lab Demographics"
	And I enter data in CRF and save
   		| Field | Data | Control Type |
   		| Age   | 22   | textbox      |
	And I navigate to "Home"
	And I select a Subject "{Var(num23)}"	
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot	
	And I wait for signature to be applied
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
      	| Audit Type          | User                               | Time                 |
      	| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num23)}"
    And I select link "Lab Form"
	And I select Lab "LocalLab_MCC-28550"	
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field       | Data | Control Type |
   		| WBC         | 15   | textbox      |
   		| Neutrophils | 15   | textbox      |	
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num23)}"
    And I select link "Grid View" 
	And I select link "Lab Form" in "Grid View"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
	And I select link "Calendar View"
	And I select link "Lab Form"
	And I click audit on form level
	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-024
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-024 Verify Signature is succeeded in Audit when a lab form with defualt value is signed in grid view and resigned after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num24>(4)} |
	And I take a screenshot
	And I select link "Lab Demographics"
	And I enter data in CRF and save
   		| Field | Data | Control Type |
   		| Age   | 22   | textbox      |
	And I navigate to "Home"
	And I select a Subject "{Var(num24)}"	
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |   
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num24)}"
    And I select link "Lab Form 1"
	And I select Lab "LocalLab_MCC-28550"	
    And I take a screenshot 
	And I save the CRF page	
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num24)}"
    And I select link "Grid View"
	And I select link "Lab Form 1" in "Grid View"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
	And I select link "Calendar View"
	And I select link "Lab Form 1"
	And I click audit on form level
	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-025
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-025 Verify Signature is succeeded in Audit when a standard form is signed after modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num25>(4)} |
	And I take a screenshot
	And I select link "Standard Form"
	And I enter data in CRF and save
   		| Field     | Data         | Control Type |
   		| Text      | TEST1        | dropdown     |
   		| Signature | SUPER USER 1 | Signature    |	
   	And I verify text "Default User" exists 
	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num25)}"
    And I select link "Standard Form"
    And I enter data in CRF and save
   		| Field        | Data       | Control Type |
   		| Action Taken | None Taken | dropdown     |
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num25)}"
    And I select link "Grid View"
    And I select link "Standard Form" in "Grid View"
    And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
    And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num25)} SUB"
	And I choose "DataPage - Standard Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
	

@Release_2013.1.0
@PB_MCC28550-026
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-026 Verify Signature is succeeded in Audit when a standard form with default value is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num26>(4)} |
	And I take a screenshot
	And I select link "Standard Form 1"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Please Sign the Data Page - Default User" exists
	And I take a screenshot	
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I navigate to "Home"
    And I select a Subject "{Var(num26)}"
    And I select link "Standard Form 1"
    And I enter data in CRF and save
   		| Field        | Data       | Control Type |
   		| Action Taken | None Taken | dropdown     |
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num26)}"
    And I select link "Grid View"
    And I select link "Standard Form 1" in "Grid View"
    And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
    And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num26)} SUB"
	And I choose "DataPage - Standard Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-027
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-027 Verify Signature is succeeded in Audit when a log form is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num27>(4)} |
	And I take a screenshot
	And I select link "Log Form"
	And I enter data in CRF and save
		| Field     | Data         | Control Type |
		| Text      | TEST1        | textbox      |
		| Signature | SUPER USER 1 | Signature    |	
	And I verify text "Default User" exists
	And I take a screenshot	
   	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |	
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num27)}"
    And I select link "Log Form"
    And I add a new log line
    And I enter data in CRF and save
		| Field | Data | Control Type |
		| Text3 | Text | text         |
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I navigate to "Home"
    And I select a Subject "{Var(num27)}"
    And I select link "Grid View"
    And I select link "Log Form" in "Grid View"
    And I click button "Sign and Save"
    And I sign the form with username "SUPER USER 1"
    And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num27)} SUB"
	And I choose "DataPage - Log Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |


@Release_2013.1.0
@PB_MCC28550-028
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-028 Verify Signature is succeeded in Audit when a log form with default value is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num28>(4)} |
	And I take a screenshot
	And I select link "Log Form 1"
	And I save the CRF page
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Please Sign the Data Page - Default User" exists
	And I take a screenshot	
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |	
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num28)}"
    And I select link "Log Form 1"
	And I add a new log line
    And I enter data in CRF and save
		| Field        | Data       | Control Type |
		| Action Taken | None Taken | dropdown     |
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num28)}"
    And I select link "Grid View"
    And I select link "Log Form 1" in "Grid View"
    And I click button "Sign and Save"
    And I sign the form with username "SUPER USER 1"
    And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num28)} SUB"
	And I choose "DataPage - Log Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-029
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-029 Verify Signature is succeeded in Audit when a mixed form is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num29>(4)} |
	And I take a screenshot
	And I select link "Mixed Form"
	And I enter data in CRF and save
   		| Field  | Data         | Control Type |
   		| Freeze | TEST1        | textbox      |
   		| DATA   | 20           | textbox      |
   		| SIGN   | SUPER USER 1 | Signature    |
	And I verify text "Default User" exists
	And I take a screenshot	
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num29)}"
    And I select link "Mixed Form"
    And I add a new log line
	And I save the CRF page
   	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num29)}"
    And I select link "Grid View"
    And I select link "Mixed Form" in "Grid View"
    And I click button "Sign and Save"
    And I sign the form with username "SUPER USER 1"
    And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num29)} SUB"
	And I choose "DataPage - Mixed Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


	
@Release_2013.1.0
@PB_MCC28550-030
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-030 Verify Signature is succeeded in Audit when a mixed form with default value is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num30>(4)} |
	And I take a screenshot
	And I select link "Mixed Form 1"
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Please Sign the Data Page - Default User" exists 
	And I take a screenshot	
   	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |	
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num30)}"
    And I select link "Mixed Form 1"
    And I enter data in CRF and save
		| Field | Data  | Control Type |
		| CODE  | TEST2 | textbox      |
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num30)}"
    And I select link "Grid View"
    And I select link "Mixed Form 1" in "Grid View"
    And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
    And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num30)} SUB"
	And I choose "DataPage - Mixed Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-031
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-031 Verify Signature is succeeded in Audit when a lab form is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num31>(4)} |
	And I take a screenshot
	And I select link "Lab Demographics"
	And I enter data in CRF and save
   		| Field | Data | Control Type |
   		| Age   | 22   | textbox      |
	And I select link "Lab Form"
	And I select Lab "LocalLab_MCC-28550"
	And I enter data in CRF and save
   		| Field       | Data         | Control Type |
   		| WBC         | 15           | textbox      |
   		| Neutrophils | 15           | textbox      |
   		| Signature   | SUPER USER 1 | Signature    |	
	And I verify text "Default User" exists
	And I take a screenshot	
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num31)}"
    And I select link "Lab Form"
    And I enter data in CRF and save
		| Field     | Data         | Control Type |
		| Weight    | 50           | textbox      |
   	And I click audit on form level
   	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num31)}"
    And I select link "Grid View"
    And I select link "Lab Form" in "Grid View"
    And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
    And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num31)} SUB"
	And I choose "DataPage - Lab Form" from "Children" 
	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-032
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-032 Verify Signature is succeeded in Audit when a lab form with default value is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num32>(4)} |
	And I take a screenshot
	And I select link "Lab Demographics"
	And I enter data in CRF and save
   		| Field | Data | Control Type |
   		| Age   | 22   | textbox      |
	And I select link "Lab Form 1"
	And I select Lab "LocalLab_MCC-28550"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
    And I verify text "Please Sign the Data Page - Default User" exists 
	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |	 
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num32)}"
    And I select link "Lab Form 1"
   	And I enter data in CRF and save
   		| Field | Data | Control Type |
   		| WBC   | 20   | textbox      |
   	And I click audit on form level
   	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num32)}"
    And I select link "Grid View"
    And I select link "Lab Form 1" in "Grid View"
    And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
    And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num32)} SUB"
	And I choose "DataPage - Lab Form 1" from "Children" 
	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot




@Release_2013.1.0
@PB_MCC28550-033
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-033 Verify Signature is icon exists and audit is broken when a field is modified.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num33>(4)} |
	And I take a screenshot	        
	And I select link "MCC28550"
	And I enter data in CRF and save
   		| Field     | Data    | Control Type |
   		| Field One | TestOne | textbox      |
	And I verify data on Fields in CRF
		| Field     | Data    | Status Icon        |
		| Field One | TestOne | Requires Signature |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Please Sign the Data Page - Default User" exists
	And I wait for 1 minute
	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |	
	And I take a screenshot
	And I navigate to "Home"
    And I select a Subject "{Var(num33)}"
	And I select link "MCC28550"
	And I enter data in CRF and save
   		| Field     | Data    | Control Type |
   		| Field One | TestTwo | textbox      |
	And I verify data on Fields in CRF
		| Field     | Data    | Requires Signature |
		| Field One | TestTwo | True               |
	And I take a screenshot
	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
	And I navigate to "Home"
    And I select a Subject "{Var(num33)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num33)} SUB"
	And I choose "DataPage - MCC28550" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |	
	And I take a screenshot
	

@Release_2013.1.0
@PB_MCC28550-034
@SJ05.FEB.2013
@Validation


Scenario: PBMCC28550-034 Verify Signature is not broken in audit when a field has "Does not participate in Signature" checked.



	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num34>(4)} |
	And I take a screenshot
    And I select link "Demographics"
    And I enter data in CRF and save
   		| Field         | Data        | Control Type |
   		| Date of Birth | 01 Jan 2000 | Datetime     |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num34)}"	
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
	And I select link "Demographics"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |	
    And I take a screenshot
	And I navigate to "Home"
    And I select a Subject "{Var(num34)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num34)} SUB"
	And I choose "DataPage - Demographics" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |	
	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num34)}"
	And I select link "Demographics"
    And I enter data in CRF and save
   		| Field         | Data        | Control Type |
   		| Date of Birth | 02 Feb 2010 | Datetime     |
	And I verify text "eSigSubject - Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |	
	And I take a screenshot
	And I navigate to "Home"
    And I select a Subject "{Var(num34)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num34)} SUB"
	And I choose "DataPage - Demographics" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |	
	And I take a screenshot




@Release_2013.1.0
@PB_MCC28550-035
@SJ05.MAR.2013
@Validation


Scenario: PBMCC28550-035 Verify Sign and Save is not visible after Signing on subject level on calendar view.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num35>(4)} |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I verify button "Sign and Save" is not visible
	And I take a screenshot
	And I wait for signature to be applied
	And I select link "Screening"
	And I select link "Medical History"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num35)}"	
	And I select link "Baseline"
	And I select link "Medical History"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-036
@SJ05.MAR.2013
@Validation


Scenario: PBMCC28550-036 Verify Sign and Save is not visible after Signing on subject level on grid view.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num36>(4)} |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I verify button "Sign and Save" is not visible
	And I wait for signature to be applied
	And I select link "Calendar View"
	And I select link "Grid View"
	And I select link "All"
	And I verify button "Sign and Save" is not visible
	And I take a screenshot
	And I select link "Screening"
	And I select link "Medical History"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num36)}"	
	And I verify button "Sign and Save" is not visible
	And I take a screenshot
	And I select link "Baseline"
	And I select link "Medical History"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-037
@SJ05.MAR.2013
@Validation


Scenario: PBMCC28550-037 Verify Signature audit for each form after Signing on subject level on calendar view.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num37>(4)} |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I verify button "Sign and Save" is not visible
	And I wait for signature to be applied
	And I take a screenshot
	And I select link "Screening"
	And I select link "Standard Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Standard Form 1"
	And I verify text "Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Log Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Log Form 1"
	And I verify text "Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Mixed Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Mixed Form 1"
	And I verify text "Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Set Secondary Name"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "LONG"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "SHORT"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "NEWLOG"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Break signature"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Enrollment"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Demographics"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Inclusion and Exclusion Criteria"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Vitals"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Visit Date"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Occlusion"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Screening"
	And I select link "Medical History"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Baseline"
	And I select link "SHORT"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Baseline"
	And I select link "Physical Examination"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Baseline"
	And I select link "Visit Date"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Baseline"
	And I select link "Occlusion"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Baseline"
	And I select link "Medical History"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "MCC28550"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Standard Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Standard Form 1"
	And I verify text "Please Sign the Data Page - Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Log Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Log Form 1"
	And I verify text "Please Sign the Data Page - Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Mixed Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Mixed Form 1"
	And I verify text "Please Sign the Data Page - Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "NEWLOG"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Demographics"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Lab Demographics"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Lab Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num37)}"
	And I select link "Lab Form 1"
	And I verify text "Please Sign the Data Page - Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-038
@SJ05.MAR.2013
@Validation


Scenario: PBMCC28550-038 Verify Signature audit for each form after Signing on subject level on grid view.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num38>(4)} |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I verify button "Sign and Save" is not visible
	And I take a screenshot
	And I wait for signature to be applied
	And I select link "Calendar View"
	And I select link "Grid View"
	And I select link "All"
	And I verify button "Sign and Save" is not visible
	And I take a screenshot
	And I select link "Screening"
	And I select link "Standard Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Standard Form 1"
	And I verify text "Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Log Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Log Form 1"
	And I verify text "Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Mixed Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Mixed Form 1"
	And I verify text "Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Set Secondary Name"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "LONG"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "SHORT"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "NEWLOG"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Break signature"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Enrollment"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Demographics"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Inclusion and Exclusion Criteria"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Vitals"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Visit Date"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Occlusion"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Screening"
	And I select link "Medical History"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Baseline"
	And I select link "SHORT"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Baseline"
	And I select link "Physical Examination"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Baseline"
	And I select link "Visit Date"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Baseline"
	And I select link "Occlusion"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Baseline"
	And I select link "Medical History"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "MCC28550"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Standard Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Standard Form 1"
	And I verify text "Please Sign the Data Page - Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Log Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Log Form 1"
	And I verify text "Please Sign the Data Page - Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Mixed Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Mixed Form 1"
	And I verify text "Please Sign the Data Page - Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "NEWLOG"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Demographics"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Lab Demographics"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Lab Form"
	And I verify text "Default User" exists
	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num38)}"
	And I select link "Lab Form 1"
	And I verify text "Please Sign the Data Page - Default User" exists 
   	And I take a screenshot
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot



