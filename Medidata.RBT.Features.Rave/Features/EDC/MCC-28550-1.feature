@FT_MCC-28550-1



Feature: MCC-28550-1 Signatures on the data page and in the audit trail are handled in one transaction. End-user signature functionality should remain the same. 


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
@PB_MCC28550-001
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-001 Verify Signature is broken in Audit when Primary form is signed and data entered in a Standard form.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(4)} |
	And I take a screenshot
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
	And I select a Subject "{Var(num1)}"
    And I select link "Standard Form"
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field | Data  | Control Type |
   		| Text  | TEST1 | dropdown     |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num1)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num1)} SUB"
	And I choose "DataPage - Standard Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-002
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-002 Verify Signature is broken in Audit when Primary form is signed and data entered in a Standard form with default value.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num2>(4)} |
	And I take a screenshot
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
	And I select a Subject "{Var(num2)}"
    And I select link "Standard Form 1"
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field  | Data | Control Type |
   		| Height | 70   | textbox      |
   		| Height | IN   | dropdown     |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num2)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num2)} SUB"
	And I choose "DataPage - Standard Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-003
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-003 Verify Signature is broken in Audit when Primary form is signed and a new log line is entered in a log form.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num3>(4)} |
	And I take a screenshot
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
    And I take a screenshot 	        
    And I navigate to "Home"	
	And I select a Subject "{Var(num3)}"
    And I select link "Log Form"
    And I take a screenshot
    And I add a new log line 
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field | Data  | Control Type |
   		| Text  | TEST1 | textbox      |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num3)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num3)} SUB"
	And I choose "DataPage - Log Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-004
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-004 Verify Signature is broken in Audit when Primary form is signed and data entered in a log form with default value.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num4>(4)} |
	And I take a screenshot
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
	And I select a Subject "{Var(num4)}"
    And I select link "Log Form 1"
    And I take a screenshot
    And I enter data in CRF and save
   		| Field  | Data | Control Type |
   		| Height | 70   | textbox      |
   		| Height | IN   | dropdown     |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num4)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num4)} SUB"
	And I choose "DataPage - Log Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-005
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-005 Verify Signature is broken in Audit when Primary form is signed and data entered in a mixed form.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num5>(4)} |
	And I take a screenshot
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
	And I select a Subject "{Var(num5)}"
    And I select link "Mixed Form"
    And I take a screenshot
    And I add a new log line 
    And I take a screenshot
    And I enter data in CRF and save
   		| Field        | Data | Control Type |
   		| Missing Code | 20   | textbox      |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num5)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num5)} SUB"
	And I choose "DataPage - Mixed Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-006
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-006 Verify Signature is broken in Audit when Primary form is signed and data entered in a mixed form with default value.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num6>(4)} |
	And I take a screenshot
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
	And I select a Subject "{Var(num6)}"
    And I select link "Mixed Form 1"
    And I take a screenshot
    And I enter data in CRF and save
   		| Field | Data | Control Type |
   		| QUERY | 20   | textbox      |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num6)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num6)} SUB"
	And I choose "DataPage - Mixed Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-007
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-007 Verify Signature is broken in Audit when Primary form is signed and data entered in a lab form.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num7>(4)} |
	And I take a screenshot
	And I select link "Lab Demographics"
	And I enter data in CRF and save
   		| Field | Data | Control Type |
   		| Age   | 22   | textbox      |
	And I navigate to "Home"
	And I select a Subject "{Var(num7)}"	
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
	And I select a Subject "{Var(num7)}"
    And I select link "Lab Form"
	And I select Lab "LocalLab_MCC-28550"
    And I enter data in CRF and save
   		| Field       | Data | Control Type |
   		| WBC         | 20   | textbox      |
   		| Neutrophils | 20   | textbox      |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num7)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num7)} SUB"
	And I choose "DataPage - Lab Form" from "Children" 
	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-008
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-008 Verify Signature is broken in Audit when Primary form is signed and data saved in a lab form with default value.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num8>(4)} |
	And I take a screenshot
	And I select link "Lab Demographics"
	And I enter data in CRF and save
   		| Field | Data | Control Type |
   		| Age   | 22   | textbox      |
	And I navigate to "Home"
	And I select a Subject "{Var(num8)}"	
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
	And I select a Subject "{Var(num8)}"
    And I select link "Lab Form 1"
    And I select Lab "LocalLab_MCC-28550"
    And I take a screenshot
    And I save the CRF page
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num8)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num8)} SUB"
	And I choose "DataPage - Lab Form 1" from "Children" 
	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-009
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-009 Verify Signature is broken in Audit when a Standard Form is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num9>(4)} |
	And I take a screenshot
	And I select link "Standard Form" 
    And I enter data in CRF and save
   		| Field     | Data         | Control Type |
   		| Text      | TEST1        | dropdown     |
   		| Signature | SUPER USER 1 | Signature    | 
   	And I verify text "Default User" exists 
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num9)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num9)} SUB"
	And I choose "DataPage - Standard Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num9)}"
	And I select link "Standard Form"
	And I enter data in CRF and save
   		| Field        | Data       | Control Type |
   		| Action Taken | None Taken | dropdown     |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot 
   	And I navigate to "Home"	
	And I select a Subject "{Var(num9)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num9)} SUB"
	And I choose "DataPage - Standard Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-010
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-010 Verify Signature is broken in Audit when a Standard Form with default value is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num10>(4)} |
	And I take a screenshot
	And I select link "Standard Form 1" 
	And I take a screenshot
    And I enter data in CRF and save
   		| Field        | Data       | Control Type |
   		| Action Taken | None Taken | dropdown     |
   	And I click button "Sign and Save"
   	And I sign the form with username "SUPER USER 1"
   	And I verify text "Please Sign the Data Page - Default User" exists 
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num10)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num10)} SUB"
	And I choose "DataPage - Standard Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num10)}"
	And I select link "Standard Form 1"
	And I enter data in CRF and save
   		| Field        | Data       | Control Type |
   		| Action Taken | Medication | dropdown     |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot 
    And I navigate to "Home"
    And I select a Subject "{Var(num10)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num10)} SUB"
	And I choose "DataPage - Standard Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-011
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-011 Verify Signature is broken in Audit when a log Form is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num11>(4)} |
	And I take a screenshot
	And I select link "Log Form" 
	And I take a screenshot
    And I enter data in CRF and save
   		| Field     | Data         | Control Type |
   		| Text      | TEST1        | textbox      |
   		| Signature | SUPER USER 1 | Signature    |
   	And I verify text "Default User" exists
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num11)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num11)} SUB"
	And I choose "DataPage - Log Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num11)}"
	And I select link "Log Form"
	And I add a new log line
	And I take a screenshot
	And I enter data in CRF and save
   		| Field        | Data       | Control Type |
   		| Action Taken | Medication | dropdown     |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot 
    And I navigate to "Home"
    And I select a Subject "{Var(num11)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num11)} SUB"
	And I choose "DataPage - Log Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-012
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-012 Verify Signature is broken in Audit when a log Form wwith default vlaue is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num12>(4)} |
	And I take a screenshot
	And I select link "Log Form 1" 
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Please Sign the Data Page - Default User " exists
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num12)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num12)} SUB"
	And I choose "DataPage - Log Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num12)}"
	And I select link "Log Form 1"
	And I add a new log line
	And I enter data in CRF and save
   		| Field        | Data       | Control Type |
   		| Action Taken | Medication | dropdown     |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot 
    And I navigate to "Home"
    And I select a Subject "{Var(num12)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num12)} SUB"
	And I choose "DataPage - Log Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot

@Release_2013.1.0
@PB_MCC28550-013
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-013 Verify Signature is broken in Audit when a mixed Form is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num13>(4)} |
	And I take a screenshot
	And I select link "Mixed Form" 
	And I take a screenshot
    And I enter data in CRF and save
   		| Field  | Data         | Control Type |
   		| Freeze | TEST1        | textbox      |
   		| DATA   | 20           | textbox      |
   		| SIGN   | SUPER USER 1 | Signature    |
   	And I verify text "Default User" exists
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num13)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num13)} SUB"
	And I choose "DataPage - Mixed Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num13)}"
	And I select link "Mixed Form"
	And I enter data in CRF and save
   		| Field     | Data | Control Type |
   		| TRANSLATE | 20   | textbox      |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot 
    And I navigate to "Home"
    And I select a Subject "{Var(num13)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num13)} SUB"
	And I choose "DataPage - Mixed Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-014
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-014 Verify Signature is broken in Audit when a Mixed Form with default value is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num14>(4)} |
	And I take a screenshot
	And I select link "Mixed Form 1" 
	And I take a screenshot
    And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Please Sign the Data Page - Default User" exists
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num14)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num14)} SUB"
	And I choose "DataPage - Mixed Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num14)}"
	And I select link "Mixed Form 1"
	And I enter data in CRF and save
   		| Field     | Data | Control Type |
   		| TRANSLATE | 20   | textbox      |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I navigate to "Home"
    And I select a Subject "{Var(num14)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num14)} SUB"
	And I choose "DataPage - Mixed Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot

@Release_2013.1.0
@PB_MCC28550-015
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-015 Verify Signature is broken in Audit when a lab Form is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num15>(4)} |
	And I take a screenshot
	And I select link "Lab Demographics"
	And I enter data in CRF and save
   		| Field | Data | Control Type |
   		| Age   | 22   | textbox      |	
	And I select link "Lab Form" 
    And I select Lab "LocalLab_MCC-28550"
    And I enter data in CRF and save
   		| Field       | Data         | Control Type |
   		| WBC         | 20           | textbox      |
   		| Neutrophils | 20           | textbox      |
   		| Signature   | SUPER USER 1 | Signature    |	
   	And I verify text "Default User" exists 
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num15)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num15)} SUB"
	And I choose "DataPage - Lab Form" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num15)}"
	And I select link "Lab Form"
	And I enter data in CRF and save
   		| Field  | Data | Control Type |
   		| Weight | 20   | textbox      |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot 
    And I navigate to "Home"
    And I select a Subject "{Var(num15)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num15)} SUB"
	And I choose "DataPage - Lab Form" from "Children" 
	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-016
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-016 Verify Signature is broken in Audit when a lab Form with default value is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num16>(4)} |
	And I take a screenshot
	And I select link "Lab Demographics"
	And I enter data in CRF and save
   		| Field | Data | Control Type |
   		| Age   | 22   | textbox      |	
	And I select link "Lab Form 1" 
	And I take a screenshot
	And I select Lab "LocalLab_MCC-28550"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Please Sign the Data Page - Default User " exists
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num16)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num16)} SUB"
	And I choose "DataPage - Lab Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I navigate to "Home"	
	And I select a Subject "{Var(num16)}"
	And I select link "Lab Form 1"
	And I enter data in CRF and save
   		| Field | Data | Control Type |
   		| WBC   | 20   | textbox      |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I navigate to "Home"
    And I select a Subject "{Var(num16)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num16)} SUB"
	And I choose "DataPage - Lab Form 1" from "Children" 
	Then I verify last audit exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-017
@SJ05.FEB.2013
@Validation

Scenario:  PBMCC28550-017 Verify Signature is succeeded in Audit when a standard Form is signed in grid view and resigned after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num17>(4)} |
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
    And I select a Subject "{Var(num17)}"
    And I select link "Standard Form"
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field        | Data       | Control Type |
   		| Action Taken | None Taken | dropdown     |	
   	And I take a screenshot
   	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num17)}"
    And I select link "Grid View"
	And I select link "Standard Form" in "Grid View"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
	And I select link "Calendar View"
	And I select link "Standard Form"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-018
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-018 Verify Signature is succeeded in Audit when a standard Form with default value is signed in grid view and resigned after modify data point.



	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num18>(4)} |
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
    And I select a Subject "{Var(num18)}"
    And I select link "Standard Form 1"
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
    And I select a Subject "{Var(num18)}"
    And I select link "Grid View"
	And I select link "Standard Form 1" in "Grid View"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
	And I select link "Calendar View"
	And I select link "Standard Form 1"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot



@Release_2013.1.0
@PB_MCC28550-019
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-019 Verify Signature is succeeded in Audit when a log form is signed in grid view and resigned after modify data point.



	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num19>(4)} |
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
    And I select a Subject "{Var(num19)}"
    And I select link "Log Form"
    And I take a screenshot 
	And I add a new log line
    And I enter data in CRF and save
   		| Field | Data  | Control Type |
   		| Text  | TEST1 | textbox      |	
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num19)}"
    And I select link "Grid View"
	And I select link "Log Form" in "Grid View"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
	And I select link "Calendar View"
	And I select link "Log Form"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type          | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PB_MCC28550-020
@SJ05.FEB.2013
@Validation

Scenario: PBMCC28550-020 Verify Signature is succeeded in Audit when a log form with default value is signed in grid view and resigned after modify data point.



	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
		| Subject Initials | SUB                |
		| Subject Number   | {RndNum<num20>(4)} |
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
    And I select a Subject "{Var(num20)}"
    And I select link "Log Form 1"
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
    And I select a Subject "{Var(num20)}"
    And I select link "Grid View"
	And I select link "Log Form 1" in "Grid View"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Your signature is being applied. You may continue working on other subjects." exists 
	And I take a screenshot
	And I wait for signature to be applied
	And I select link "Calendar View"
	And I select link "Log Form 1"
	And I click audit on form level
	Then I verify Audits exist
	| Audit Type          | User                               | Time                 |
	| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot

