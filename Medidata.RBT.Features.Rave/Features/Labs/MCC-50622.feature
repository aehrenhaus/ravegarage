
@FT_MCC-50622



Feature: MCC-50622 Audit Trail contains extra activity and Normalized Lab View populated with NULLs for Alert and Ref ranges in case if “Units Only” is selected on Lab Form 
		and “Units” are populated before “Data” and then submitted.(Page Refresh updates View Values with correct ones but Audit Trail still contains incorrect records.)

Background:
	
	Given study "MCC-50622" is assigned to Site "Site 1"
	Given xml Lab Configuration "Lab_MCC-50622.xml" is uploaded
    Given role "SUPER ROLE 1" exists
    Given xml draft "MCC-50622.xml" is Uploaded
	Given Clinical Views exist for project "MCC-50622"
	Given Site "Site 1" is Units-Only-enabled
	And following Report assignments exist
		| Role         | Report                             |
		| SUPER ROLE 1 | Data Listing - Data Listing Report |
	Given Site "Site 1" is Units-Only-enabled
    Given following Project assignments exist
		| User         | Project   | Environment | Role         | Site   | SecurityRole          |
		| SUPER USER 1 | MCC-50622 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
    Given I publish and push eCRF "MCC-50622.xml" to "Version 1"
	

@Release_2013.1.0
@PBMCC50622-001
@SJ04.MAR.2013
@Validation

Scenario: PBMCC50622-001 verify audit Trail does not contain extra activity when Units Only is selected on a lab form.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(4)} |
	And I take a screenshot
	And I select link "Default Lab Folder"
	And I select link "Default Lab Demographics Form"
	And I enter data in CRF and save
   		| Field      | Data        | Control Type |
   		| Visit Date | 01 Jan 2013 | Datetime     |
   		| AGE        | 26          | textbox      |
   		| SEX        | Male        | dropdown     |
   		| Pregnant   | No          | dropdown     |
	And I take a screenshot
	And I select link "Default Lab Form"
	And I select Lab "Units Only"
	And I enter data in CRF 
   		| Field       | Data | Control Type |
   		| WBC         | 12   | textbox      |
   		| Neutrophils | 20   | textbox      |
   		| Weight      | 50   | textbox      |
   		| Height      | 8    | textbox      |
	And I select Unit
		| Field       | Unit              | 
		| WBC         | *10E6/ulMCC-50622 | 
	    | Neutrophils | FractionMCC-50622 | 
	    | Weight      | LbsMCC-50622      | 
	    | Height      | ftMCC-50622       | 
	And I save the CRF page
	And I take a screenshot
	When I click audit on Field "WBC"
	Then I verify exact Audit texts exist
		| Audit                                                   | User                               | Time                 |
		| User entered '12'                                       | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Property 'Lab Unit' set to '*10E6/ulMCC-50622'.         | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Property 'Entered Lab Unit' set to '*10E6/ulMCC-50622'. | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num1)}"
	And I select link "Default Lab Folder"
	And I select link "Default Lab Form"
	When I click audit on Field "Neutrophils"
	Then I verify exact Audit texts exist
		| Audit                                                   | User                               | Time                 |
		| Clinical significance prompt created.                   | System                             | dd MMM yyyy HH:mm:ss |
		| User entered '20'                                       | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Data entry of 20 is Below the Alert Range of 35.        | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Lab Range Status Changed from InRange to AlertLow.      | System                             | dd MMM yyyy HH:mm:ss |
		| Property 'Lab Unit' set to 'FractionMCC-50622'.         | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Property 'Entered Lab Unit' set to 'FractionMCC-50622'. | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num1)}"
	And I select link "Default Lab Folder"
	And I select link "Default Lab Form"
	When I click audit on Field "Weight"
	Then I verify exact Audit texts exist
		| Audit                                              | User                               | Time                 |
		| Clinical significance prompt created.              | System                             | dd MMM yyyy HH:mm:ss |
		| User entered '50'                                  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Data entry of 50 is Below the Alert Range of 160.  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Lab Range Status Changed from InRange to AlertLow. | System                             | dd MMM yyyy HH:mm:ss |
		| Property 'Lab Unit' set to 'LbsMCC-50622'.         | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Property 'Entered Lab Unit' set to 'LbsMCC-50622'. | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num1)}"
	And I select link "Default Lab Folder"
	And I select link "Default Lab Form"
	When I click audit on Field "Height"
	Then I verify exact Audit texts exist
		| Audit                                               | User                               | Time                 |
		| Clinical significance prompt created.               | System                             | dd MMM yyyy HH:mm:ss |
		| User entered '8'                                    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Data entry of 8 is Above the Alert Range of 7.      | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Lab Range Status Changed from InRange to AlertHigh. | System                             | dd MMM yyyy HH:mm:ss |
		| Property 'Lab Unit' set to 'ftMCC-50622'.           | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Property 'Entered Lab Unit' set to 'ftMCC-50622'.   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot


@Release_2013.1.0
@PBMCC50622-002
@SJ04.MAR.2013
@Validation

Scenario: PBMCC50622-002 verify Data Listing Report does not contain NULL values when Units Only is selected on a lab form and data enterd in fields.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num2>(4)} |
	And I take a screenshot
	And I select link "Default Lab Folder"
	And I select link "Default Lab Demographics Form"
	And I enter data in CRF and save
   		| Field      | Data        | Control Type |
   		| Visit Date | 01 Jan 2013 | Datetime     |
   		| AGE        | 26          | textbox      |
   		| SEX        | Male        | dropdown     |
   		| Pregnant   | No          | dropdown     |
	And I take a screenshot
	And I select link "Default Lab Form"
	And I select Lab "Units Only"
	And I enter data in CRF 
   		| Field       | Data | Control Type |
   		| WBC         | 12   | textbox      |
   		| Neutrophils | 20   | textbox      |
   		| Weight      | 50   | textbox      |
   		| Height      | 8    | textbox      |
	And I select Unit
		| Field       | Unit              | 
		| WBC         | *10E6/ulMCC-50622 | 
	    | Neutrophils | FractionMCC-50622 | 
	    | Weight      | LbsMCC-50622      | 
	    | Height      | ftMCC-50622       | 
	And I save the CRF page
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I wait for Clinical View refresh to complete for project "MCC-50622"
	And I select Report "Data Listing"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-50622 | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "Lab" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject        | DataPageName     | RefLow | RefHigh | RefFlag | AlertLow | AlertHigh | AlertFlag |
	| SUB{Var(num2)} | Default Lab Form | 10     | 20      | 0       | 10       | 20        | 0         |
	| SUB{Var(num2)} | Default Lab Form | 35     | 48      | -       | 35       | 48        | -         |
	| SUB{Var(num2)} | Default Lab Form | 160    | 200     | -       | 160      | 200       | -         |
	| SUB{Var(num2)} | Default Lab Form | 3      | 7       | +       | 3        | 7         | +         |
	And I take a screenshot


@Release_2013.1.0
@PBMCC50622-003
@SJ04.MAR.2013
@Validation

Scenario: PBMCC50622-003 verify audit Trail does not contain extra activity and Data Listing Report does not contain NULL values when Units Only is selected and data entered than select units for each fields.

	When I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num3>(4)} |
	And I take a screenshot
	And I select link "Default Lab Folder"
	And I select link "Default Lab Demographics Form"
	And I enter data in CRF and save
   		| Field      | Data        | Control Type |
   		| Visit Date | 01 Jan 2013 | Datetime     |
   		| AGE        | 26          | textbox      |
   		| SEX        | Male        | dropdown     |
   		| Pregnant   | No          | dropdown     |
	And I take a screenshot
	And I select link "Default Lab Form"
	And I select Lab "Units Only"
	And I enter data in CRF 
   		| Field       | Data | Control Type |
   		| WBC         | 12   | textbox      |
   		| Neutrophils | 20   | textbox      |
   		| Weight      | 50   | textbox      |
   		| Height      | 8    | textbox      |
   	And I save the CRF page
   	And I take a screenshot
	And I select Unit
		| Field       | Unit              | 
		| WBC         | *10E6/ulMCC-50622 | 
	    | Neutrophils | FractionMCC-50622 | 
	    | Weight      | LbsMCC-50622      | 
	    | Height      | ftMCC-50622       | 
	And I save the CRF page
	And I take a screenshot
	When I click audit on Field "WBC"
	Then I verify exact Audit texts exist
		| Audit                                                   | User                               | Time                 |
		| Property 'Lab Unit' set to '*10E6/ulMCC-50622'.         | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Property 'Entered Lab Unit' set to '*10E6/ulMCC-50622'. | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| User entered '12'                                       | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num3)}"
	And I select link "Default Lab Folder"
	And I select link "Default Lab Form"
	When I click audit on Field "Neutrophils"
	Then I verify exact Audit texts exist
		| Audit                                                   | User                               | Time                 |
		| Clinical significance prompt created.                   | System                             | dd MMM yyyy HH:mm:ss |
		| Lab Range Status Changed from InRange to AlertLow.      | System                             | dd MMM yyyy HH:mm:ss |
		| Property 'Lab Unit' set to 'FractionMCC-50622'.         | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Property 'Entered Lab Unit' set to 'FractionMCC-50622'. | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| User entered '20'                                       | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num3)}"
	And I select link "Default Lab Folder"
	And I select link "Default Lab Form"
	When I click audit on Field "Weight"
	Then I verify exact Audit texts exist
		| Audit                                              | User                               | Time                 |
		| Clinical significance prompt created.              | System                             | dd MMM yyyy HH:mm:ss |
		| Lab Range Status Changed from InRange to AlertLow. | System                             | dd MMM yyyy HH:mm:ss |
		| Property 'Lab Unit' set to 'LbsMCC-50622'.         | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Property 'Entered Lab Unit' set to 'LbsMCC-50622'. | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| User entered '50'                                  | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num3)}"
	And I select link "Default Lab Folder"
	And I select link "Default Lab Form"
	When I click audit on Field "Height"
	Then I verify exact Audit texts exist
		| Audit                                               | User                               | Time                 |
		| Clinical significance prompt created.               | System                             | dd MMM yyyy HH:mm:ss |
		| Lab Range Status Changed from InRange to AlertHigh. | System                             | dd MMM yyyy HH:mm:ss |
		| Property 'Lab Unit' set to 'ftMCC-50622'.           | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| Property 'Entered Lab Unit' set to 'ftMCC-50622'.   | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
		| User entered '8'                                    | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	And I wait for Clinical View refresh to complete for project "MCC-50622"
	And I select Report "Data Listing"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-50622 | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I choose "Clinical Views" from "Data Source"
	And I choose "Lab" from "Form"	
	And I click button "Run"
	Then I verify rows exist in "Result" table
	| Subject        | DataPageName     | RefLow | RefHigh | RefFlag | AlertLow | AlertHigh | AlertFlag |
	| SUB{Var(num2)} | Default Lab Form | 10     | 20      | 0       | 10       | 20        | 0         |
	| SUB{Var(num2)} | Default Lab Form | 35     | 48      | -       | 35       | 48        | -         |
	| SUB{Var(num2)} | Default Lab Form | 160    | 200     | -       | 160      | 200       | -         |
	| SUB{Var(num2)} | Default Lab Form | 3      | 7       | +       | 3        | 7         | +         |
	And I take a screenshot