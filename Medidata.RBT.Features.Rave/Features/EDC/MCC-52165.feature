@FT_MCC-52165

Feature: MCC-52165 Answered query incorrectly linked to user action and not System action.
	As a Rave user
	I want to change data on the step field
	So I can close queries on action field
	
Background:
    Given the following Range Types exist
		| Range Type Name |
		| StandardREG_STD |
	Given xml Lab Configuration "All_STD.xml" is uploaded
	Given role "MCC_52165 Role" exists
 	Given xml draft "Edit_Check_Study_3_Draft_2.xml" is Uploaded
 	Given xml draft "Edit_Check_Study_3_Draft_4.xml" is Uploaded
  	Given xml draft "Standard_Study_Draft_2.xml" is Uploaded	
	Given xml draft "Standard_Study_Draft_3.xml" is Uploaded
 	Given xml draft "Standard_Study_Draft_4.xml" is Uploaded
 	Given xml draft "Standard_Study_Draft_6.xml" is Uploaded
	Given Site "Site 2" exists
	Given Site "Site 3" exists
	Given Site "Site 4" exists
	Given Site "Site 6" exists
	Given Site "Edit Check Site 2" exists
	Given Site "Edit Check Site 4" exists
	Given study "Standard Study" is assigned to Site "Site 2"
	Given study "Standard Study" is assigned to Site "Site 3"
	Given study "Standard Study" is assigned to Site "Site 4"
	Given study "Standard Study" is assigned to Site "Site 6"
	Given study "Edit Check Study 3" is assigned to Site "Edit Check Site 2"
	Given study "Edit Check Study 3" is assigned to Site "Edit Check Site 4"
	Given I publish and push eCRF "Edit_Check_Study_3_Draft_2.xml" to "Version1" with study environment "Prod" for site "Edit Check Site 2"
	Given I publish and push eCRF "Edit_Check_Study_3_Draft_4.xml" to "Version2" with study environment "Prod" for site "Edit Check Site 4"
	Given I publish and push eCRF "Standard_Study_Draft_2.xml" to "Version3" with study environment "Prod" for site "Site 2"	
	Given I publish and push eCRF "Standard_Study_Draft_3.xml" to "Version4" with study environment "Prod" for site "Site 3"
	Given I publish and push eCRF "Standard_Study_Draft_4.xml" to "Version5" with study environment "Prod" for site "Site 4"
	Given I publish and push eCRF "Standard_Study_Draft_6.xml" to "Version6" with study environment "Prod" for site "Site 6"
	Given following Project assignments exist
		| User         | Project            | Environment | Role           | Site              | SecurityRole          |
		| SUPER USER 1 | Edit Check Study 3 | Live: Prod  | MCC_52165 Role | Edit Check Site 2 | Project Admin Default |
		| SUPER USER 1 | Edit Check Study 3 | Live: Prod  | MCC_52165 Role | Edit Check Site 4 | Project Admin Default |
		| SUPER USER 1 | Standard Study     | Live: Prod  | MCC_52165 Role | Site 2            | Project Admin Default |
		| SUPER USER 1 | Standard Study     | Live: Prod  | MCC_52165 Role | Site 3            | Project Admin Default |
		| SUPER USER 1 | Standard Study     | Live: Prod  | MCC_52165 Role | Site 4            | Project Admin Default |
		| SUPER USER 1 | Standard Study     | Live: Prod  | MCC_52165 Role | Site 6            | Project Admin Default |

#----------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PB_MCC_52165_01
@Validation
Scenario: PB_MCC_52165_01 As an EDC user, On a Cross Forms - Standard form to log form, when a query has been auto answered and auto closed with the same data, then queries are not displayed. 
#Query with requires response = false and requires manual close = False.
	
	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 2"	
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Informed Consent" in Folder "Screening" 
	And I enter data in CRF and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 09 Jan 2000 |
	    | End Date                     | 10 Jan 2000 |
	    | Original Distribution Number | 10          |
	    | Current Distribution Number  | 19          |
	And I take a screenshot
	And I select Form "Concomitant Medications" in Folder "Screening"
    And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 08 Jan 2000 |
	    | End Date             | 11 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 20          |
	And I open log line 1
	And I verify Not Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I select Form "Informed Consent" in Folder "Screening"	
	When I enter data in CRF and save
		| Field               			| Data        |
		| Date Informed Consent Signed  | 07 Jan 2000 |
		| Current Distribution Number  	| 20          |
	And I select Form "Concomitant Medications" in Folder "Screening"		
	And I open log line 1
	Then I verify Query is not displayed
      | Field      | Query Message                                             | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                                                                                 | Answered | Closed |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12_CMP
@PB_MCC_52165_02
@Validation
Scenario: PB_MCC_52165_02 As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, then queries are not displayed.
#requires response = false and requires manual close = true

 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 4" 	
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
		  |Field		|Data	 |
		  |Age 4		|17		 |
   	And I verify Query is displayed
		  | Field | Query Message                                                                        |
		  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I take a screenshot	  	  
	When I enter data in CRF and save
		  |Field		|Data  	|
		  |Age 4		|20		|
	And I save the CRF page
	Then I verify Query is not displayed
		  | Field | Query Message                                                                        | Answered | Closed |
		  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true     | true   |
	And I take a screenshot			  
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12_CMP
@PB_MCC_52165_03
@Validation
Scenario: PB_MCC_52165_03 As an EDC user, On a Cross Folders - Standard form to log form, when a query has been auto answered and auto closed with the same data, then queries are not displayed.
#Query with requires response = false and requires manual close = False.

    Given I login to Rave with user "SUPER USER 1"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 2"		
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Informed Consent" in Folder "Screening"
	And I enter data in CRF and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 10 Jan 2000 |
	    | End Date                     | 10 Feb 2000 |
	    | Original Distribution Number | 100         |
	    | Current Distribution Number  | 200         |
	And I take a screenshot
	And I select Form "Concomitant Medications" in Folder "Week 1"
    And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 09 Jan 2000 |
	    | End Date             | 11 Feb 2000 |
	    | Original Axis Number | 100         |
	    | Current Axis Number  | 99          |
	And I open log line 1
	And I verify Not Requires Response Query with message "'Date Informed Consent Signed' can not be greater than Start Date." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I select Form "Informed Consent" in Folder "Screening"
	When I enter data in CRF and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 08 Jan 2000 |
	    | Current Distribution Number  | 99	         |
	And I take a screenshot
	And I select Form "Concomitant Medications" in Folder "Week 1"
	And I open log line 1	
	Then I verify Query is not displayed
      | Field      | Query Message                                                      | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' can not be greater than Start Date. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                                     | Answered | Closed |
      | Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | true     | true   |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12_CMP
@PB_MCC_52165_04
@Validation
Scenario: PB_MCC_52165_04 As an EDC user, On a Cross Forms - log form, when a query has been auto answered and auto closed with the same data, then queries are not displayed. 
#Query with requires response = false and requires manual close = False.
    
	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 2"		
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Concomitant Medications" in Folder "Week 1" 
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 12 Jan 2000 |
	    | End Date             | 11 Jan 2000 |
	    | Original Axis Number | 100         |
	    | Current Axis Number  | 101         |
	And I open log line 1
	And I verify Not Requires Response Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot
	When I enter data in CRF and save
		| Field               	| Data        |
		| Start Date          	| 11 Jan 2000 |
		| Original Axis Number 	| 101         |
	And I open log line 1
	Then I verify Query is not displayed
      | Field    | Query Message                                | Answered | Closed |
      | End Date | Start Date can not be greater than End Date. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                                                    | Answered | Closed |
      | Current Axis Number | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | true     | true   |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12_CMP
@PB_MCC_52165_05
@Validation
Scenario: PB_MCC_52165_05 As and EDC user, On a Cross Forms - log form to log form, when a query has been auto answered and auto closed with the same data, then queries are not displayed. 
#Query with requires response = false and requires manual close = False.
			  
    Given I login to Rave with user "SUPER USER 1"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 2"		
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 10 Jan 2000 |
	    | End Date             | 10 Feb 2000 |
	    | Original Axis Number | 100         |
	    | Current Axis Number  | 66          |
	And I take a screenshot
	And I select Form "Adverse Events"
    And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 11 Jan 2000 |
	    | End Date   | 09 Feb 2000 |
	    | AE Number  | 101         |
	    | Duration   | 66          |
	And I take a screenshot
    And I select Form "Concomitant Medications"	
	And I open log line 1
	And I verify Not Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Not Requires Response Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I select Form "Adverse Events"
	And I open log line 1
	When I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 10 Jan 2000 |
	    | End Date   | 11 Feb 2000 |
	    | AE Number  | 99          |
	    | Duration   | 65          |
	And I take a screenshot
    And I select Form "Concomitant Medications"			
	And I open log line 1
	Then I verify Query is not displayed
      | Field      | Query Message              |Answered | Closed |
      | Start Date | Date can not be less than. |true     | true   |
	And I verify Query is not displayed
      | Field    | Query Message                                 | Answered | Closed |
      | End Date | Date is Less Than Date on the first log form. | true     | true   |
	And I verify Query is not displayed
      | Field                | Query Message                                                          | Answered | Closed |
      | Original Axis Number | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                      | Answered | Closed |
      | Current Axis Number | 'Duration' and 'Current Axis Number' cannot equal. | true     | true   |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PB_MCC_52165_06
@Validation
Scenario: PB_MCC_52165_06 As an EDC user, On a Cross Forms Standard form to log form, when a query has been auto answered and closed with the same data, then queries are not displayed.
#Query with requires response = false and requires manual close = True.

	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 4"		
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Informed Consent" in Folder "Screening"
	And I enter data in CRF and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 09 Jan 2000 |
	    | End Date                     | 10 Jan 2000 |
	    | Original Distribution Number | 10          |
	    | Current Distribution Number  | 19          |
	And I take a screenshot
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 08 Jan 2000 |
	    | End Date             | 11 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 20          |
	And I open log line 1
	And I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I select Form "Informed Consent" in Folder "Screening"	
	When I enter data in CRF and save
		| Field               			| Data        |
		| Date Informed Consent Signed  | 07 Jan 2000 |
		| Current Distribution Number 	| 20          |
	And I take a screenshot
	And I select Form "Concomitant Medications" in Folder "Screening"		
	And I open log line 1
	Then I verify Query is not displayed
      | Field               | Query Message                                                                                                 | Answered | Closed |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I verify Query is not displayed
      | Field      | Query Message                                             | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | true     | true   |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12_CMP
@PB_MCC_52165_07
@Validation
Scenario: PB_MCC_52165_07 As an EDC user, On a Cross Folders - Standard form to log form, when a query has been auto answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Query with requires response = false and requires manual close = True.

	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 4"	
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Informed Consent" in Folder "Screening"
	And I enter data in CRF and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 10 Jan 2000 |
	    | End Date                     | 10 Feb 2000 |
	    | Original Distribution Number | 100         |
	    | Current Distribution Number  | 200         |
	And I take a screenshot
	And I select Form "Concomitant Medications" in Folder "Week 1"
    And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 09 Jan 2000 |
	    | End Date             | 11 Feb 2000 |
	    | Original Axis Number | 100         |
	    | Current Axis Number  | 99          |
	And I open log line 1
	And I verify Not Requires Response Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I select Form "Informed Consent" in Folder "Screening"	
    When I enter data in CRF and save	
		| Field                        | Data        |
		| Date Informed Consent Signed | 07 Jan 2000 |
		| Current Distribution Number  | 99          |
	And I take a screenshot
	And I select Form "Concomitant Medications" in Folder "Week 1"	
	And I open log line 1
	Then I verify Query is not displayed
      | Field      | Query Message                                           | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' can not be greater than. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                                     | Answered | Closed |
      | Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | true     | true   |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12_CMP
@PB_MCC_52165_08
@Validation
Scenario: PB_MCC_52165_08 As an EDC user, Cross Forms - log form to log form , when a query has been auto answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Query with requires response = false and requires manual close = True.

	Given I login to Rave with user "SUPER USER 1"	
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 4"	
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 10 Jan 2000 |
	    | End Date             | 10 Feb 2000 |
	    | Original Axis Number | 100         |
	    | Current Axis Number  | 66          |
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
    And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 11 Jan 2000 |
	    | End Date   | 09 Feb 2000 |
	    | AE Number  | 101         |
	    | Duration   | 66          |
	And I take a screenshot
    And I select Form "Concomitant Medications"		
	And I open log line 1
	And I verify Not Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Not Requires Response Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
	And I open log line 1	
	When I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 10 Jan 2000 |
	    | End Date   | 10 Feb 2000 |
	    | AE Number  | 100         |
	    | Duration   | 66          |	
	And I take a screenshot		
	And I select Form "Concomitant Medications"				
	And I open log line 1
	Then I verify Query is not displayed
      | Field      | Query Message              | Answered | Closed |
      | Start Date | Date can not be less than. | true     | true   |
	And I verify Query is not displayed
      | Field    | Query Message                                                                    | Answered | Closed |
      | End Date | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | true     | true   |
	And I verify Query is not displayed
      | Field                | Query Message                                                          | Answered | Closed |
      | Original Axis Number | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                      | Answered | Closed |
      | Current Axis Number | 'Duration' and 'Current Axis Number' cannot equal. | true     | true   |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12_CMP
@PPB_MCC_52165_09
@Validation
Scenario: PB_MCC_52165_09 As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I changed the data in log field A to another bad data, if I entered good data in log field A, then query is not displayed on log field B. 
#Query with requires response = false and requires manual close = false.

	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 3"	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB               |
	  | Subject ID       | SUB {Var(num1)}   |                                         
	And I select Form "Form 9"
	And I enter data in CRF	
      | Field       | Data |
      | Log Field 3 | 5    |
      | Log Field 4 | 4    |
	When I save the CRF page
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | 
	And I take a screenshot 	  	
	When I enter data in CRF  
      | Field       | Data |
      | Log Field 3 | 3    |
	And I save the CRF page
	And I open log line 1	
	Then I verify Query is displayed	   
	  | Field       | Message                                                  |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. |
	And I take a screenshot 		  
	And  I enter data in CRF	  
      | Field       | Data |
      | Log Field 3 | 4    |
	When I save the CRF page
	And I open log line 1		
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | true     | true   | 
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12_CMP
@PPB_MCC_52165_010
@Validation
Scenario: PPB_MCC_52165_010	As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I changed the data in log field A to another bad data, if I entered good data in log field A, then query is not displayed on log field B.
#Query with requires response = false and requires manual close = false.
	
	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 3"	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9002B          |
	  | Subject ID       | SUB {Var(num1)}   |  
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 3 | 5    |
      | Log Field 4 | 4    |                                        
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. |                                                      
	And I take a screenshot 
	When I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 4 | 3    |		  
	And I save the CRF page 
	And I open log line 1	  
    Then I verify Query is displayed
      | Field       | Message                                                  |
      | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. |
	When I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 4 | 5    |		  
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is not displayed
      | Field       | Message                                                  | Answered | Closed |
      | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | true     | true   | 	  
	And I take a screenshot				
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12_CMP
@PPB_MCC_52165_011
@Validation
Scenario: PPB_MCC_52165_011 As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I changed the data in log field A to another bad data, if I entered good data in log field A, then query is not displayed on log field B.
#Query with requires response = false and requires manual close = false.
	
	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 3"	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9002B          |
	  | Subject ID       | SUB {Var(num1)}   |  
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 3 | 5    |
      | Log Field 4 | 4    |                                        
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. |                                                      
	And I take a screenshot 
	When I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 3 | 3    |		  
	And I save the CRF page 
	And I open log line 1	  
    Then I verify Query is displayed
      | Field       | Message                                                  |
      | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. |
	When I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 3 | 4    |		  
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is not displayed
      | Field       | Message                                                  | Answered | Closed |
      | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | true     | true   | 	  
	And I take a screenshot		 	  	


#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12_CMP
@PPB_MCC_52165_012
@Validation
Scenario: PPB_MCC_52165_012 As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I entered good data in field A, then the system should not fire a query on field A. 
#Query with requires response = false and requires manual close = false.
    
	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 4"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
		  |Field		|Data	 |
		  |Age 2		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I take a screenshot	  		  
	When I enter data in CRF and save
		  |Field		|Data  	|
		  |Age 2		|20		|
	Then I verify Query is not displayed
	  | Field |Query Message                                                                        | Closed | Answered |
	  | Age 2 |Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12_CMP
@PPB_MCC_52165_013
@Validation
Scenario: PPB_MCC_52165_013 As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, if I then entered new bad data in field A, then the system should not fire a query on field A. 
#Query with requires response = false and requires manual close = false.
 
 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 4"   
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 1"
	And I enter data in CRF and save
		  |Field		|Data	 |
		  |Age 2		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I take a screenshot	  
	When I enter data in CRF and save
		  |Field		|Data  	|
		  |Age 2		|20		|
	Then I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PPB_MCC_52165_014
@Validation
Scenario: PPB_MCC_52165_014 As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I entered good data in lab field A, then the system should not display a query on lab field B. 
#Query with requires response = false and requires manual close = false.

 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 2"   
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                        |Query Message  												|
      |Lab Field 4 - WBC - rr = F ; rmc = F	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|2		|
	Then I verify Query is not displayed
      |Field		                        |Query Message  												| Answered | Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F	|Lab Field 4 must be greater than Lab Field 3. Please verify.	| true     | true   |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PPB_MCC_52165_015
@Validation
Scenario: PPB_MCC_52165_015 As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I entered good data in lab field A, then the system should not display a query on lab field B.
#Query with requires response = false and requires manual close = false. 
	
 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 2"  
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |6		|
	Then I verify Query is not displayed
      |Field		                                |Query Message  												| Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	| true    |true    |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PPB_MCC_52165_016
@Validation
Scenario: PPB_MCC_52165_016 As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I entered good data in log field A, then the system should not display a query on lab field B.
#Query with requires response = false and requires manual close = false.

 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 6" 
    And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 4 |       |
      | Log Field 5 | data5 |
      | Log Field 6 | data6 | 
	And I open log line 1  
	And I verify Query is displayed
      | Field       | Query Message                           |
      | Log Field 6 | Answer must be provided. Please review. |
	And I take a screenshot
	When I enter data in CRF and save
      | Field       | Data  |
      |Log Field 4	|data4	|
	And I open log line 1
	Then I verify Query is not displayed
      | Field       | Query Message                           |
      | Log Field 6 | Answer must be provided. Please review. |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PPB_MCC_52165_017
@Validation
Scenario: PPB_MCC_52165_017 As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I entered good data in log field A, then the system should is display a query on log field B.
#Query with requires response = false and requires manual close = true.
	
 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 6" 
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field        | Data   |
      | Log Field 10 | data10 |
      | Log Field 11 | data11 |
      | Log Field 12 |        |	 
	And I open log line 1  
	And I verify Query is displayed
      | Field        | Query Message                           | 
      | Log Field 12 | Answer must be provided. Please review. | 
	And I take a screenshot	    	    
	When I enter data in CRF and save
      | Field        | Data   |
      | Log Field 10 | data10 |
      | Log Field 11 | data11 |
      | Log Field 12 | data12 |  
	And I open log line 1	   
	And I verify Query is not displayed
      | Field        | Query Message                           |
      | Log Field 12 | Answer must be provided. Please review. |	
	And I take a screenshot	 

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PPB_MCC_52165_018
@Validation
Scenario: PPB_MCC_52165_018 As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I entered good data in lab field A, then the system should not display a query on lab field B.
#Query with requires response = false and requires manual close = true.

 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 2"  	
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
		  |Field		                               |Data    |
		  |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
		  |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
		  |Field		                       |Query Message  												|
		  |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|
	And I take a screenshot
	When I enter data in CRF and save
		  | Field                                        | Data |
		  | Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T | 2    |
	Then I verify Query is not displayed
		  | Field                                | Query Message                                                |
		  | Lab Field 8 - WBC - rr = F ; rmc = T | Lab Field 8 must be greater than Lab Field 7. Please verify. |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PPB_MCC_52165_019
@Validation
Scenario: PPB_MCC_52165_019 As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I entered good data in lab field A, then the system should not display a query on lab field B.
#Query with requires response = true and requires manual close = true.

 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 2"  	
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
		  |Field		                                |Data   |
		  |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
		  |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
		  |Field		                                |Query Message  												|
		  |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	And I take a screenshot
	When I enter data in CRF and save
		  | Field                                        | Data |
		  | Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T | 2    |
	Then I verify Query is not displayed
		  |Field		                                |Query Message  												|
		  |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PPB_MCC_52165_020
@Validation
Scenario: PPB_MCC_52165_020 As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, if I then entered the differnt bad data in lab field A, and I entered good data in lab field A, then the system should not display a query on lab field B.
#Query with requires response = true and requires manual close = false.

 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 2" 
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
		  |Field		                               |Data    |
		  |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
		  |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
		  |Field		                       |Query Message  												|
		  |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|
	And I take a screenshot
	And I enter data in CRF and save
		  |Field		                               |Data    |
		  |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|7		|
	And I verify Query is displayed
		  |Field		                       |Query Message  												|
		  |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|
	And I take a screenshot
	And I enter data in CRF and save
		  |Field		                               |Data    |
		  |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|2		|
    And I verify Query is not displayed
		  |Field		                       |Query Message  												|Answered| Closed |
		  |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|true    |true    |	
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PPB_MCC_52165_021
@Validation
Scenario: PPB_MCC_52165_021 As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I entered good data in log field A, then the system should not display a query on log field B.
#Query with requires response = true and requires manual close = true.

 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 6" 
    And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 6"
	And I enter data in CRF and save
		  | Field       | Data  |
		  | Log Field 1 |       |
		  | Log Field 2 | data2 |
		  | Log Field 3 | data3 |	
	And I open log line 1  
	And I verify Query is displayed
		  | Field       | Query Message                           |
		  | Log Field 3 | Answer must be provided. Please review. |
	And I take a screenshot
 	When I enter data in CRF and save
		  | Field       | Data  |
		  | Log Field 1 | data1 |
	And I open log line 1 
	Then I verify Query is not displayed
		  | Field       | Message                                 |
		  | Log Field 3 | Answer must be provided. Please review. |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PPB_MCC_52165_022
@Validation
Scenario: PPB_MCC_52165_022 As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I entered good data in log field A, then the system should not display a query on log field B.
#Query with requires response = true and requires manual close = false.

 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 6" 
    And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
		  | Field       | Data  |
		  | Log Field 7 |       |
		  | Log Field 8 | data8 |
		  | Log Field 9 | data9 |	 
	And I open log line 1  
	And I verify Query is displayed
		  | Field       | Query Message                           | 
		  | Log Field 9 | Answer must be provided. Please review. | 
	And I take a screenshot	  
	And I enter data in CRF and save
		  | Field       | Data  |
		  | Log Field 7 | data7 |
	And I open log line 1  
	And I verify Query is not displayed
      | Field       | Query Message                           |
      | Log Field 9 | Answer must be provided. Please review. |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PPB_MCC_52165_023
@Validation
Scenario: PPB_MCC_52165_023 As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I entered good data in field A, then the system should not display a query on field A.
#Query with requires response = true and requires manual close = true.

 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 4" 	
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
		  |Field		|Data	 |
		  |Age 1		|17		 |
   	And I verify Query is displayed
		  | Field | Query Message                                                                        |
		  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I take a screenshot
	When I enter data in CRF and save
		  |Field		|Data  	|
		  |Age 1		|20		|
	Then I verify Query is not displayed
		| Field | Query Message                                                                        | 
		| Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PPB_MCC_52165_024
@Validation
Scenario: PPB_MCC_52165_024 As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I entered different bad data in field A, if I then entered the good data in field A, then the system should not display a query on field A.
#Query with requires response = true and requires manual close = false.

 	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Standard Study" and Site "Site 4" 
    And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
		  |Field		|Data	 |
		  |Age 3		|17		 |
   	And I verify Query is displayed
		  | Field | Query Message                                                                        | 
		  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | 
	And I take a screenshot	
	And I enter data in CRF and save
		  |Field		|Data	 |
		  |Age 3		|16		 |	
   	And I verify Query is displayed
		  | Field | Query Message                                                                        | 
		  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I take a screenshot  
	When I enter data in CRF and save
		  |Field		|Data	 |
		  |Age 3		|22		 |			  
	Then I verify Query is not displayed
		  | Field | Query Message                                                                        | 
		  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I take a screenshot	  