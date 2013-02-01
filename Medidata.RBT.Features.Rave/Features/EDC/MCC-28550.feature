@FT_MCC-28550


Feature: MCC-28550 Signatures on the data page and in the audit trail are handled in one transaction. End-user signature functionality should remain the same. 


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
@PBMCC28550-001
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
@PBMCC28550-002
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
@PBMCC28550-003
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
@PBMCC28550-004
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
@PBMCC28550-005
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
@PBMCC28550-006
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
@PBMCC28550-007
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
@PBMCC28550-008
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
@PBMCC28550-009
@SJ01.FEB.2013
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
@PBMCC28550-010
@SJ01.FEB.2013
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
@PBMCC28550-011
@SJ01.FEB.2013
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
@PBMCC28550-012
@SJ01.FEB.2013
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
@PBMCC28550-013
@SJ01.FEB.2013
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
@PBMCC28550-014
@SJ01.FEB.2013
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
@PBMCC28550-015
@SJ01.FEB.2013
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
@PBMCC28550-016
@SJ01.FEB.2013
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
@PBMCC28550-017
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-018
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-019
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-020
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
	And I select link "Calendar View"
	And I select link "Log Form 1"
	And I click audit on form level
	Then I verify Audits exist
	| Audit Type          | User                               | Time                 |
	| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	| Signature Broken    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot

@Release_2013.1.0
@PBMCC28550-021
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-022
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-023
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-024
@SJ01.FEB.2013
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
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
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-025
@SJ01.FEB.2013
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
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-026
@SJ01.FEB.2013
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
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-027
@SJ01.FEB.2013
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
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-028
@SJ01.FEB.2013
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
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-029
@SJ01.FEB.2013
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
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-030
@SJ01.FEB.2013
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
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-031
@SJ01.FEB.2013
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
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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
@PBMCC28550-032
@SJ01.FEB.2013
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
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
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