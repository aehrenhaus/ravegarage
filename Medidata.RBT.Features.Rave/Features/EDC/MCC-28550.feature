@FT_MCC-28550
@ignore

Feature: 


Background:

	Given xml Lab Configuration "Lab_MCC-28550.xml" is uploaded
    Given role "SUPER ROLE 1" exists
    Given xml draft "MCC-28550.xml" is Uploaded
    Given Site "Site1" exists
    Given study "MCC-28550" is assigned to Site "Site 1"
    Given following Project assignments exist
    | User         | Project   | Environment | Role        | Site   | SecurityRole          |
    | SUPER USER 1 | MCC-28550 | Live: Prod  | SUPER ROLE 1| Site 1 | Project Admin Default | 
    Given I publish and push eCRF "MCC-28550.xml" to "Version 1"


@Release_2013.1.0
@PBMCC28550-001
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when Primary form is signed and data entered in a Standard form.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type 		  | User 							   | Time 				  |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot 	        
    And I navigate to "Home"	
	And I select a Subject "{Var(num1)}"
    And I select link "Standard Form"
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Text          | TEST1     | dropdown	   |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num1)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num1)} SUB"
	And I choose "DataPage - Standard Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-002
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when Primary form is signed and data entered in a Standard form with default value.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num2>(4)}  |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type 		  | User 							   | Time 				  |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot 	        
    And I navigate to "Home"	
	And I select a Subject "{Var(num2)}"
    And I select link "Standard Form 1"
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field 		| Data 	| Control Type |
   		| Height        | 70    | Text 		   |
   		| Height        | IN    | dropdown	   |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num2)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num2)} SUB"
	And I choose "DataPage - Standard Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-003
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when Primary form is signed and a new log line is entered in a log form.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num3>(4)}  |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type 		  | User 							   | Time 				  |
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
   		| Field 		| Data  	| Control Type |
   		| Text          | TEST1     | Text 		   |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num3)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num3)} SUB"
	And I choose "DataPage - Log Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PBMCC28550-004
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when Primary form is signed and data entered in a log form with default value.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num4>(4)}  |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type 		  | User 							   | Time 				  |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |   
    And I take a screenshot 	        
    And I navigate to "Home"	
	And I select a Subject "{Var(num4)}"
    And I select link "Log Form 1"
    And I take a screenshot
    And I enter data in CRF and save
   		| Field 		| Data 	| Control Type |
   		| Height        | 70    | Text 		   |
   		| Height        | IN    | dropdown	   |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num4)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num4)} SUB"
	And I choose "DataPage - Log Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PBMCC28550-005
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when Primary form is signed and data entered in a mixed form.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num5>(4)}  |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type 		  | User 							   | Time 				  |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |   
    And I take a screenshot 	        
    And I navigate to "Home"	
	And I select a Subject "{Var(num5)}"
    And I select link "Mixed Form"
    And I take a screenshot
    And I add a new log line 
    And I take a screenshot
    And I enter data in CRF and save
   		| Field 		| Data 	| Control Type |
   		| Missing Code  | 20    | Text 		   |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num5)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num5)} SUB"
	And I choose "DataPage - Mixed Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-006
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when Primary form is signed and data entered in a mixed form with default value.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num6>(4)}  |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type 		  | User 							   | Time 				  |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot 	        
    And I navigate to "Home"	
	And I select a Subject "{Var(num6)}"
    And I select link "Mixed Form 1"
    And I take a screenshot
    And I enter data in CRF and save
   		| Field  | Data | Control Type |
   		| QUERY  | 20   | Text 		   |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num6)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num6)} SUB"
	And I choose "DataPage - Mixed Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PBMCC28550-007
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when Primary form is signed and data entered in a lab form.


	When I login to Rave with user "SUPER USER 1"
	And I navigate to "Site Administration" module
	And I search for site "Site 1"
	And I select Site Details for Site "Site 1"
	And I select "Lab Maintenance" for Study "MCC-28550" in Environment "Prod"
	And I create lab
		| Type      | Name                        | Range Type        |
		| Local Lab | Local Lab {RndNum<num1>(5)} | RtStandardMCC28550|
	And I select Ranges for "Local Lab {Var(num1)}" for "Local Lab" lab
	And I select "Add New Range"
	And I create range
		| Analyte                | From Date   | To Date     | From Age        | To Age          | Sex          | Low Value | High Value | Units            | Dictionary | Comments | Edit | New Version |
| AnNeutrophilsMCC-28550 | 01 Jan 2000 | 01 Jan 2020 | 15 YearMCC28550 | 99 YearMCC28550 | maleMCC28550 | 15        | 25         | FractionMCC28550 |            |          |      |             |
| AnWBCMCC-28550         | 01 Jan 2000 | 01 Jan 2020 | 15 YearMCC28550 | 99 YearMCC28550 | maleMCC28550 | 15        | 25         | *10E6/ulMCC28550 |            |          |      |             |

	And I take a screenshot
	And I navigate to "Home"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num7>(4)}  |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type 		  | User 							   | Time 				  |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot 	        
    And I navigate to "Home"	
	And I select a Subject "{Var(num7)}"
    And I select link "Lab Form"
    And I choose "Lab" "Local_Lab_MCC28550" from "Lab"
    And I enter data in CRF and save
   		| Field  	 | Data | Control Type |
   		| WBC  		 | 20   | Text 		   |
   		| Neutrophils| 20 	| Text 		   |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num7)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num7)} SUB"
	And I choose "DataPage - Lab Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PBMCC28550-008
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when Primary form is signed and data saved in a lab form with default value.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num7>(4)}  |
	And I take a screenshot
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type 		  | User 							   | Time 				  |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot 	        
    And I navigate to "Home"	
	And I select a Subject "{Var(num7)}"
    And I select link "Lab Form 1"
    And I choose "Lab" "Local_Lab_MCC28550" from "Lab"
    And I take a screenshot
    And I enter data in CRF and save
   		| Field  	 | Data | Control Type |
   		| WBC  		 |    	| Text 		   |
   		| Neutrophils| 		| Text 		   |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num7)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num7)} SUB"
	And I choose "DataPage - Lab Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PBMCC28550-009
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when a Standard Form is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Standard Form" 
    And I enter data in CRF and save
   		| Field 		| Data  	   | Control Type  |
   		| Text          | TEST1        | dropdown	   |
   		| User Name:    | SUPER USER 1 | Signature     |
   		| Password: 	| password     | Text 		   |
   	And I verify text "Signature attempt was successful" exists 
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num9)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num9)} SUB"
	And I choose "DataPage - Standard Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 		  | User 							   | Time 				  |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num9)}"
	And I select link "Standard Form"
	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Action Taken	| None Taken| dropdown	   |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot 
   	And I navigate to "Home"	
	And I select a Subject "{Var(num9)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num9)} SUB"
	And I choose "DataPage - Standard Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-010
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when a Standard Form with default value is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Standard Form 1" 
	And I take a screenshot
    And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Action Taken  | None Taken| dropdown	   |
   	And I click button "Sign and Save"
   	And I sign the form with username "SUPER USER 1"
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num10)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num10)} SUB"
	And I choose "DataPage - Standard Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 		  | User 							   | Time 				  |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num10)}"
	And I select link "Standard Form 1"
	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Action Taken	| Medication| dropdown	   |
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
   	And I select link "Subject - {Var(num9)} SUB"
	And I choose "DataPage - Standard Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot



@Release_2013.1.0
@PBMCC28550-011
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when a log Form is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Log Form" 
	And I take a screenshot
    And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Text          | TEST1     | Text 		   |
   		| User Name:    | SUPER USER 1 | Signature |
   		| Password: 	| password  | Text 		   |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num11)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num11)} SUB"
	And I choose "DataPage - Log Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num11)}"
	And I select link "Log Form"
	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Action Taken	| Medication| dropdown	   |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot 
    And I navigate to "Home"
    And I select a Subject "{Var(num11)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num11)} SUB"
	And I choose "DataPage - Log Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-012
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when a log Form wwith default vlaue is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Log Form 1" 
	And I click button "Sign and Save"
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num12)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num12)} SUB"
	And I choose "DataPage - Log Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num12)}"
	And I select link "Log Form"
	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Action Taken	| Medication| dropdown	   |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot 
    And I navigate to "Home"
    And I select a Subject "{Var(num12)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num12)} SUB"
	And I choose "DataPage - Log Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot

@Release_2013.1.0
@PBMCC28550-013
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when a mixed Form is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Mixed Form" 
	And I take a screenshot
    And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Freeze        | TEST1     | Text 		   |
   		| DATA 			| 20 		| Text 		   |
   		| User Name:    | SUPER USER 1 | Signature |
   		| Password: 	| password  | Text 		   |
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num13)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num13)} SUB"
	And I choose "DataPage - Mixed Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num13)}"
	And I select link "Mixed Form"
	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| TRANSLATE 	| 20        | Text  	   |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot 
    And I navigate to "Home"
    And I select a Subject "{Var(num13)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num13)} SUB"
	And I choose "DataPage - Mixed Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-014
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when a Mixed Form with default value is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Mixed Form 1" 
	And I take a screenshot
    And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| User Name:    | SUPER USER 1 | Signature |
   		| Password: 	| password  | Text 		   |
   	And I take a screenshot
   	And I click button "Sign and Save"
   	And I verify text "Please Sign - Default User  (defuser)" exists 
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num14)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num14)} SUB"
	And I choose "DataPage - Mixed Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num14)}"
	And I select link "Mixed Form 1"
	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| TRANSLATE 	| 20        | Text  	   |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I navigate to "Home"
    And I select a Subject "{Var(num14)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num14)} SUB"
	And I choose "DataPage - Mixed Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot

@Release_2013.1.0
@PBMCC28550-015
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when a lab Form is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Lab Form" 
    And I choose "Lab" "Local_Lab_MCC28550" from "Lab"
    And I enter data in CRF and save
   		| Field  	 | Data         | Control Type |
   		| WBC  		 | 20           | Text 		   |
   		| Neutrophils| 20	        | Text 		   |
   		| User Name: | SUPER USER 1 | Signature    |
   		| Password:  | password     | Text 		   |
   	And I verify text "Default User  (defuser)" exists 
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num15)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num15)} SUB"
	And I choose "DataPage - Lab Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num15)}"
	And I select link "Lab Form"
	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Weight 	 	| 20        | Text  	   |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot 
    And I navigate to "Home"
    And I select a Subject "{Var(num15)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num15)} SUB"
	And I choose "DataPage - Lab Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-016
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is broken in Audit when a lab Form with default value is signed and modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Lab Form 1" 
	And I take a screenshot
	And I choose "Lab" "Local_Lab_MCC28550" from "Lab"
    And I enter data in CRF and save
   		| Field  	 | Data         | Control Type |
   		| WBC  		 |              | Text 		   |
   		| Neutrophils| 	            | Text 		   |
   		| User Name: | SUPER USER 1 | Signature    |
   		| Password:  | password     | Text 		   |
   	And I verify text "Default User  (defuser)" exists 
	And I choose "Lab" "LocalLab_MCC28550" from "Lab"
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Please Sign - Default User  (defuser)" exists 
   	And I take a screenshot
   	And I navigate to "Home"	
	And I select a Subject "{Var(num16)}"	
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num16)} SUB"
	And I choose "DataPage - Lab Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I navigate to "Home"	
	And I select a Subject "{Var(num16)}"
	And I select link "Lab Form 1"
	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| WBC 	 	 	| 20        | Text  	   |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I navigate to "Home"
    And I select a Subject "{Var(num16)}"	
	And I select primary record form
	And I click audit on form level
   	And I select link "Subject - {Var(num16)} SUB"
	And I choose "DataPage - Lab Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 	     | User 							  | Time 				 |
		| Signature Broken   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded| Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |  
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-017
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a standard Form is signed in grid view and resigned after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
      	| Audit Type| Query Message            | User                      | Time                 |  
     	| 			| User signature succeeded.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num17)}"
    And I select link "Standard Form"
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Missing Code 	| 10    	| textbox	   |
   		| Action Taken  | None Taken| dropdown 	   |	
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num17)}"
    And I select link "Grid View"
	And I select link "Standard Form"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
	And I select link "Calendar View"
	And I select link "Standard Form"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-018
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a standard Form with default value is signed in grid view and resigned after modify data point.



	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
      	| Audit Type| Query Message            | User                      | Time                 |  
     	| 			| User signature succeeded.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num18)}"
    And I select link "Standard Form 1"
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Action Taken  | 			| dropdown 	   |	
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num18)}"
    And I select link "Grid View"
	And I select link "Standard Form 1"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
	And I select link "Calendar View"
	And I select link "Standard Form 1"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
    And I take a screenshot



@Release_2013.1.0
@PBMCC28550-019
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a log form is signed in grid view and resigned after modify data point.



	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
      	| Audit Type| Query Message            | User                      | Time                 |  
     	| 			| User signature succeeded.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num19)}"
    And I select link "Log Form"
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field | Data 	| Control Type |
   		| Text  | TEST1	| Text  	   |	
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num19)}"
    And I select link "Grid View"
	And I select link "Log Form"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
	And I select link "Calendar View"
	And I select link "Log Form"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-020
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a log form with default value is signed in grid view and resigned after modify data point.



	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
      	| Audit Type| Query Message            | User                      | Time                 |  
     	| 			| User signature succeeded.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num20)}"
    And I select link "Log Form 1"
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field | Data 	| Control Type |
   		| Text  |   	| Text  	   |	
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num20)}"
    And I select link "Grid View"
	And I select link "Log Form 1"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
	And I select link "Calendar View"
	And I select link "Log Form 1"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
    And I take a screenshot

@Release_2013.1.0
@PBMCC28550-021
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a mixed form is signed in grid view and resigned after modify data point.



	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
      	| Audit Type| Query Message            | User                      | Time                 |  
     	| 			| User signature succeeded.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num21)}"
    And I select link "Mixed Form"
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field		| Data 	| Control Type |
   		| Freeze	| 20  	| Text  	   |	
   		| TRANSLATE | TEST  | Text 		   |
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num21)}"
    And I select link "Grid View"
	And I select link "Mixed Form"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
	And I select link "Calendar View"
	And I select link "Mixed Form"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-022
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a mixed form with default value is signed in grid view and resigned after modify data point.



	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
      	| Audit Type| Query Message            | User                      | Time                 |  
     	| 			| User signature succeeded.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num22)}"
    And I select link "Mixed Form 1"
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field		| Data 	| Control Type |
   		| Freeze	|   	| Text  	   |	
   		
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num22)}"
    And I select link "Grid View"
	And I select link "Mixed Form 1"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
	And I select link "Calendar View"
	And I select link "Mixed Form 1"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-023
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a lab form is signed in grid view and resigned after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
      	| Audit Type| Query Message            | User                      | Time                 |  
     	| 			| User signature succeeded.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num23)}"
    And I select link "Log Form"
    And I choose "Lab" "LocalLab_MCC28550" from "Lab"	
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field		  | Data | Control Type|
   		| WBC		  | 15   | Text  	   |
   		| Neutrophils | 15   | Text  	   |	
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num23)}"
    And I select link "Grid View"
	And I select link "Log Form"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
	And I select link "Calendar View"
	And I select link "Log Form"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-024
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a lab form with defualt value is signed in grid view and resigned after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Grid View"
	And I select link "All"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot	
	And I select primary record form
	And I click audit on form level
	Then I verify Audits exist
      	| Audit Type| Query Message            | User                      | Time                 |  
     	| 			| User signature succeeded.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot 	
    And I navigate to "Home"
    And I select a Subject "{Var(num24)}"
    And I select link "Log Form 1"
    And I choose "Lab" "LocalLab_MCC28550" from "Lab"	
    And I take a screenshot 
    And I enter data in CRF and save
   		| Field		  | Data | Control Type|
   		| WBC		  | 	 | Text  	   |
   		| Neutrophils |    	 | Text  	   |	
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |  
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num24)}"
    And I select link "Grid View"
	And I select link "Log Form 1"
	And I click button "Sign and Save"
	And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
	And I select link "Calendar View"
	And I select link "Log Form 1"
	And I click audit on form level
	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
    And I take a screenshot



@Release_2013.1.0
@PBMCC28550-025
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a standard form is signed after modify data point.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Standard Form"
	And I enter data in CRF and save
   		| Field 	| Data  	| Control Type |
   		| Text		| TEST1   	| dropdown	   |
   		| User Name:| defuser 	| textbox	   |	
   		| Password: | password	| textbox	   | 
   	And I verify text "Default User (defuser)" exists 
	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
    And I take a screenshot
      And I navigate to "Home"
    And I select a Subject "{Var(num25)}"
    And I select link "Standard Form"
    And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Action Taken	| None Taken| dropdown	   |
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num25)}"
    And I select link "Grid View"
    And I select link "Standard Form"
    And I click button "Sign and Save"
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num25)} SUB"
	And I choose "DataPage - Standard Form" from "Children" 
	Then I verify Audits exist
		| Audit Type| Query Message             | User                      | Time                 |  
		| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
		|			| Signature has been broken.| Default User (1 - defuser)| dd MMM yyyy hh:mm:ss |
     	| 			| User signature succeeded. | Default User (1 - defuser)| dd MMM yyyy hh:mm:ss | 
    And I take a screenshot
	

@Release_2013.1.0
@PBMCC28550-026
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a standard form with default value is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Standard Form 1"
	And I click button "Sign and Save"
	And I verify text "Please Sign - Default User  (defuser)" exists
	And I take a screenshot	
   	And I click audit on form level
   	Then I verify Audits exist
		Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	
     And I navigate to "Home"
    And I select a Subject "{Var(num26)}"
    And I select link "Standard Form 1"
    And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Action Taken	| None Taken| dropdown	   |
   	And I click audit on form level
   	Then I verify Audits exist
		Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num26)}"
    And I select link "Grid View"
    And I select link "Standard Form 1"
    And I click button "Sign and Save"
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num26)} SUB"
	And I choose "DataPage - Standard Form 1" from "Children" 
	Then I verify Audits exist
	Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-027
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a log form is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Log Form"
	And I enter data in CRF and save
		| Field | Data  | Control Type |
		| Text  | TEST1 | Text         |
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Please Sign - Default User  (defuser)" exists
	And I take a screenshot	
   	And I click audit on form level
   	Then I verify Audits exist
		Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		
    And I take a screenshot
     And I navigate to "Home"
    And I select a Subject "{Var(num27)}"
    And I select link "Log Form"
    And I add a new log line
    And I enter data in CRF and save
    | Field | Data  | Control Type |
    | Text3 | Text 	| Text 		   |
   	And I click audit on form level
   	Then I verify Audits exist
		Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I navigate to "Home"
    And I select a Subject "{Var(num27)}"
    And I select link "Grid View"
    And I select link "Log Form"
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
	Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |


@Release_2013.1.0
@PBMCC28550-028
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a log form with default value is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Log Form 1"
	And I enter data in CRF and save
		| Field | Data  | Control Type |
		| Text  |       | Text         |
	And I click button "Sign and Save"
	And I sign the form with username "SUPER USER 1"
	And I verify text "Please Sign - Default User  (defuser)" exists
	And I take a screenshot	
   	And I click audit on form level
   	Then I verify Audits exist
		Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		
    And I take a screenshot
     And I navigate to "Home"
    And I select a Subject "{Var(num28)}"
    And I select link "Log Form 1"
    And I add a new log line
    And I enter data in CRF and save
    | Field        | Data      | Control Type |
    | Action Taken | None Taken| dropdown 	  |
   	And I click audit on form level
   	Then I verify Audits exist
		Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num28)}"
    And I select link "Grid View"
    And I select link "Log Form 1"
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
		Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot



@Release_2013.1.0
@PBMCC28550-029
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a mixed form is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Mixed Form"
	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| Freeze        | TEST1     | Text 		   |
   		| DATA 			| 20 		| Text 		   |
   		| User Name:    | SUPER USER 1 | Signature |
   		| Password: 	| password  | Text 		   |
	And I verify text "Default User  (defuser)" exists
	And I take a screenshot	
   	And I click audit on form level
   	Then I verify Audits exist
		Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		
    And I take a screenshot
     And I navigate to "Home"
    And I select a Subject "{Var(num29)}"
    And I select link "Mixed Form"
    And I add a new log line
    And I enter data in CRF and save
    | Field         | Data 	   | Control Type|
    | CODE 			| TEST2    | dropdown 	 |
    | Password: 	| password | Text 		 |
   	And I click audit on form level
   	Then I verify Audits exist
		Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num29)}"
    And I select link "Grid View"
    And I select link "Mixed Form"
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
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


	
@Release_2013.1.0
@PBMCC28550-030
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a mixed form with default value is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Mixed Form 1"
	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| User Name:    | SUPER USER 1 | Signature |
   		| Password: 	| password  | Text 		   |
	And I verify text "Default User  (defuser)" exists
	And I take a screenshot	
   	And I click audit on form level
   	Then I verify Audits exist
		Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		
    And I take a screenshot
     And I navigate to "Home"
    And I select a Subject "{Var(num30)}"
    And I select link "Mixed Form 1"
    And I add a new log line
    And I enter data in CRF and save
    | Field         | Data 	   | Control Type|
    | CODE 			| TEST2    | dropdown 	 |
    | Password: 	| password | Text 		 |
   	And I click audit on form level
   	Then I verify Audits exist
		Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num30)}"
    And I select link "Grid View"
    And I select link "Mixed Form 1"
    And I click button "Sign and Save"
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num30)} SUB"
	And I choose "DataPage - Mixed Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss | 
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-031
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a lab form is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Lab Form"
	And I choose "Lab" "LocalLab_MCC28550" from "Lab"
	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| WBC 			| 15 		| Text 		   |
   		| Neutrophils 	| 15 		| Text 		   |
   		| User Name:    | SUPER USER 1 | Signature |
   		| Password: 	| password  | Text 		   |
	And I verify text "Default User  (defuser)" exists
	And I take a screenshot	
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num31)}"
    And I select link "Lab Form"
    And I enter data in CRF and save
    | Field         | Data 	   | Control Type|
    | Weight		| 50	   | textbox 	 |
    | Password: 	| password | Text 		 |
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num31)}"
    And I select link "Grid View"
    And I select link "Lab Form"
    And I click button "Sign and Save"
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num31)} SUB"
	And I choose "DataPage - Lab Form" from "Children" 
	Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot


@Release_2013.1.0
@PBMCC28550-032
@SJ29.JAN.2013
@Draft

Scenario: Verify Signature is succeeded in Audit when a lab form with default value is signed after modify data point.


	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data               |
	  	| Subject Initials | SUB                |
	  	| Subject Number   | {RndNum<num1>(4)}  |
	And I take a screenshot
	And I select link "Lab Form"
	And I choose "Lab" "LocalLab_MCC28550" from "Lab"
	And I click button "Sign and Save"
	And I verify text "Please Sign - Default User  (defuser)" exists 
   	And I take a screenshot
   	And I click audit on form level
   	Then I verify Audits exist
		 
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num32)}"
    And I select link "Lab Form 1"
    And I enter data in CRF and save
   	And I enter data in CRF and save
   		| Field 		| Data  	| Control Type |
   		| WBC 	 	 	| 20        | Text  	   |
   	And I click audit on form level
   	Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot
    And I navigate to "Home"
    And I select a Subject "{Var(num32)}"
    And I select link "Grid View"
    And I select link "Lab Form 1"
    And I click button "Sign and Save"
    And I verify text "Signature attempt was successful" exists 
	And I take a screenshot
    And I select link "Calendar View"
	And I select primary record form
	And I click audit on form level
	And I select link "Subject - {Var(num32)} SUB"
	And I choose "DataPage - Lab Form 1" from "Children" 
	Then I verify Audits exist
		| Audit Type 		  | User                               | Time                 |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Broken 	  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Signature Succeeded | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
    And I take a screenshot