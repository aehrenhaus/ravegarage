Feature: 564QueryRefiringLogic4
	As a Rave user
	I want to change data
	So I can see refired queries
	
# Query Issue: Edit Checks with no require response and require manual close
# Open a query, change the data and close the query, change it back to previous data query did refire and verify there is no log
# Verifies query firing between cross forms no require response and require manual close.

# Project to be uploaded in excel spreadsheet 'Edit Check Study 3'
	
Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Study assignments exist
		|User		|Study		       	|Role |Site		        	|Site Number|
		|editcheck  |Edit Check Study 3	|CDM1 |Edit Check Site 4	|40001      |
    And Role "cdm1" has Action "Query"
	And Draft "Draft 4" in Study "Edit Check Study 3" has been published to CRF Version "<RANDOMNUMBER>" 
	And CRF Version "<RANDOMNUMBER>" in Study "Edit Check Study 3" has been pushed to Site "Edit Check Site 4" in Environment "Prod"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 4"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_4.1.1
@Validation
Scenario: PB_4.1.1 As an EDC user, On a Cross Forms Standard form to log form, when a query has been auto answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed.

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
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I open log line 1
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page	
	And I open log line 1
	And I verify closed Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify closed Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I verify Query is displayed
      | Field      | Query Message                                             | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | true     | true   |
	Then I verify Query is displayed
      | Field               | Query Message                                                                                                 | Answered | Closed |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 20          |
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I verify Query is displayed
      | Field      | Query Message                                             | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | false    | false  |
	And I verify Query is displayed
      | Field               | Query Message                                                                                                 | Answered | Closed |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
 
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.1.2
@Validation
Scenario: PB_4.1.2 As an EDC user, On a Cross Forms Standard form to log form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are displayed.

    And I select a Subject "SUB{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Screening"
    And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 07 Jan 2000 |
	    | End Date             | 12 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 18          |	
	And I verify Not Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I open log line 1
    And I enter data in CRF 
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |	
	And I cancel the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I cancel the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 2
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                             |
		| Query Canceled | 'Date Informed Consent Signed' is greater. Please revise. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 2
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                                                 |
		| Query Canceled | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header"
	And I open log line 2		
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open log line 2
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I verify Query is displayed
      | Field      | Query Message                                             | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | false    | false  |
	And I verify Query is displayed
      | Field               | Query Message                                                                                                 | Answered | Closed |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.2.1
@Validation
Scenario: PB_4.2.1 As an EDC user, On a Cross Folders - Standard form to log form, when a query has been auto answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed.
#Folder  enter and save data on form "Concomitant Medications"
#"Screening" enter and save data on form "Informed Consent" , Folder "Week 1

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
	And I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| Original Axis Number | 201         |
		| Current Axis Number  | 200         |
	And I open log line 1
	And I close the Query "'Date Informed Consent Signed' can not be greater than." on Field "Start Date"
	And I close the Query "'Current Distribution Number' is not equal 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page	
	And I open log line 1
	And I verify Query is displayed
      | Field      | Query Message                                           | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' can not be greater than. | true     | true   |
	And I verify Query is displayed
      | Field               | Query Message                                                     | Answered | Closed |
      | Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | true     | true   |
	And I take a screenshot
	And I open log line 1
	When I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 09 Jan 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 99          |
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I verify Query is displayed
      | Field      | Query Message                                           | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' can not be greater than. | false    | false  |
	Then I verify Query is displayed
      | Field               | Query Message                                                     | Answered | Closed |
      | Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | false    | false  |
	And I take a screenshot
    
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.2.2
@Validation
Scenario: PB_4.2.2 As an EDC user, On a Cross Folders - Standard form to log form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are displayed.
	
    And I select a Subject "SUB{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Week 1"
    And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 08 Jan 2000 |
	    | End Date             | 12 Feb 2000 |
	    | Original Axis Number | 100         |
	    | Current Axis Number  | 98          |		
	And I verify Not Requires Response Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I enter data in CRF
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| Original Axis Number | 201         |
		| Current Axis Number  | 200         |
	And I cancel the Query "'Date Informed Consent Signed' can not be greater than." on Field "Start Date"
	And I cancel the Query "'Current Distribution Number' is not equal 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 2
	And I verify Query is not displayed
      | Field      | Query Message                                           | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' can not be greater than. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                                     | Answered | Closed |
      | Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | true     | true   |
	And I take a screenshot	
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                           |
		| Query Canceled | 'Date Informed Consent Signed' can not be greater than. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 2	  	
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                     |
		| Query Canceled | 'Current Distribution Number' is not equal 'Current Axis Number'. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 2
	When I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 08 Jan 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 98          |
	And I open log line 2
	Then I verify Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I verify Query is displayed
      | Field      | Query Message                                           | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' can not be greater than. | false    | false  |
	And I verify Query is displayed
      | Field               | Query Message                                                     | Answered | Closed |
      | Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.3.1
@Validation
Scenario: PB_4.3.1 As an EDC user, On a Cross Forms - log form to Standard form, when a query has been auto answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed.
#Folder "Week 1" enter and save data on forms "Concomitant Medications" and "Informed Consent"
  
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
	And I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 12 Jan 2000 |
		| Current Axis Number | 100         |
	And I open log line 1
	And I close the Query "Start Date can not be greater than End Date." on Field "End Date"
	And I close the Query "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 1	
	And I verify Query is displayed
      | Field    | Query Message                                | Answered | Closed |
      | End Date | Start Date can not be greater than End Date. | true     | true   |
	And I verify Query is displayed
      | Field               | Query Message                                                                    | Answered | Closed |
      | Current Axis Number | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | true     | true   |	
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 11 Jan 2000 |
		| Current Axis Number | 101         |
	And I open log line 1
	Then I verify Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I verify Query is displayed
      | Field      | Query Message                                | Answered | Closed |
      | End Date | Start Date can not be greater than End Date. | false    | false  |
	And I verify Query is displayed
      | Field               | Query Message                                                                    | Answered | Closed |
      | Current Axis Number | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | false    | false  |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.3.2
@Validation
Scenario: PB_4.3.2 As an EDC user, On a Cross Forms - log form to Standard form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are displayed.
	
    And I select a Subject "SUB{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Week 1"
    And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 15 Feb 2000 |
	    | End Date             | 14 Feb 2000 |
	    | Original Axis Number | 1999        |
	    | Current Axis Number  | 2000        |
	And I verify Not Requires Response Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I enter data in CRF
		| Field               | Data        |
		| End Date            | 15 Feb 2000 |
		| Current Axis Number | 1999        |
	And I cancel the Query "Start Date can not be greater than End Date." on Field "End Date"
	And I cancel the Query "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 2
	And I take a screenshot
	And I verify Query is not displayed
      | Field    | Query Message                                | Answered | Closed |
      | End Date | Start Date can not be greater than End Date. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                                                    | Answered | Closed |
      | Current Axis Number | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | true     | true   |
	And I click audit on Field "End Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                |
		| Query Canceled | Start Date can not be greater than End Date. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 2	  	
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                    |
		| Query Canceled | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 2
	When I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 14 Feb 2000 |
		| Current Axis Number | 2000        |
	And I open log line 2	
	Then I verify Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot
	 
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.3.3
@Validation
Scenario: PB_4.3.3 As an EDC user, On a Cross Forms - log form to Standard form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are displayed.

    And I select a Subject "SUB{Var(num1)}" 
	And I select Form "Informed Consent" in Folder "Week 1"
	And I enter data in CRF and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 12 Jan 2000 |
	    | End Date                     | 11 Jan 2000 |
	    | Original Distribution Number | 100         |
	    | Current Distribution Number  | 101         |
	And I verify Not Requires Response Query with message "'Date Informed Consent Signed' is not equal to Current Date" is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." is displayed on Field "Current Distribution Number"
	And I take a screenshot
	And I enter data in CRF
	    | Field                       | Data        |
	    | End Date                    | 13 Jan 2000 |
	    | Current Distribution Number | 100         |
	And I cancel the Query "'Date Informed Consent Signed' is not equal to Current Date." on Field "End Date"
	And I cancel the Query "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." on Field "Current Distribution Number"
	And I save the CRF page
	And I verify Query is not displayed
      | Field    | Query Message                                                | Answered | Closed |
      | End Date | 'Date Informed Consent Signed' is not equal to Current Date. | true     | true   |
	And I verify Query is not displayed
      | Field                       | Query Message                                                                          | Answered | Closed |
      | Current Distribution Number | 'Original Distribution Number' and 'Current Distribution Number' fields are not equal. | true     | true   |
	And I click audit on Field "End Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                                |
		| Query Canceled | 'Date Informed Consent Signed' is not equal to Current Date. |
	And I take a screenshot	
	And I select link "Informed Consent" in "Header" 	
	And I click audit on Field "Current Distribution Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                          |
		| Query Canceled | 'Original Distribution Number' and 'Current Distribution Number' fields are not equal. |
	And I take a screenshot	
	And I select link "Informed Consent" in "Header"
	And I take a screenshot
	When I enter data in CRF and save
	    | Field                       | Data        |
	    | End Date                    | 11 Jan 2000 |
	    | Current Distribution Number | 101         |
	Then I verify Query with message "'Date Informed Consent Signed' is not equal to Current Date." is displayed on Field "End Date"
	And I verify Query with message "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." is displayed on Field "Current Distribution Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.4.1
@Validation
Scenario: PB_4.4.1 As an EDC user, Cross Forms - log form to log form , when a query has been auto answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed.
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events"
	  
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
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 11 Jan 2000 |
	    | End Date             | 09 Feb 2000 |
	    | Original Axis Number | 102         |
	    | Current Axis Number  | 65          |	
	And I open log line 1
	And I close the Query "Date can not be less than." on Field "Start Date"
	And I close the Query "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "End Date"
	And I close the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I close the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number"
	And I save the CRF page	
	And I open log line 1
	And I verify Query is displayed
      | Field      | Query Message              | Answered | Closed |
      | Start Date | Date can not be less than. | true     | true   |
	And I verify Query is displayed
      | Field    | Query Message                                                                    | Answered | Closed |
      | End Date | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | true     | true   |
	And I verify Query is displayed
      | Field                | Query Message                                                          | Answered | Closed |
      | Original Axis Number | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. | true     | true   |
	And I verify Query is displayed
      | Field               | Query Message                                      | Answered | Closed |
      | Current Axis Number | 'Duration' and 'Current Axis Number' cannot equal. | true     | true   |
	And I take a screenshot
	When I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| End Date             | 10 Feb 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 66          |
	And I open log line 1
	Then I verify Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I verify Query is displayed
      | Field      | Query Message              | Answered | Closed |
      | Start Date | Date can not be less than. | false    | false  |
	And I verify Query is displayed
      | Field    | Query Message                                                                    | Answered | Closed |
      | End Date | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | false    | false  |
	And I verify Query is displayed
      | Field                | Query Message                                                          | Answered | Closed |
      | Original Axis Number | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. | false    | false  |
	And I verify Query is displayed
      | Field               | Query Message                                      | Answered | Closed |
      | Current Axis Number | 'Duration' and 'Current Axis Number' cannot equal. | false    | false  |
	And I take a screenshot
	   
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.4.2
@Validation
Scenario: PB_4.4.2 As an EDC user, Cross Forms - log form to log form , when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are displayed.

    And I select a Subject "SUB{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Screening"
    And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 10 Feb 2000 |
	    | End Date             | 10 Mar 2000 |
	    | Original Axis Number | 200         |
	    | Current Axis Number  | 77          |
	And I take a screenshot
    And I select Form "Adverse Events" in Folder "Screening"
    And I enter data in CRF on a new log line and save and reopen
	    | Field      | Data        |
	    | Start Date | 11 Feb 2000 |
	    | End Date   | 09 Mar 2000 |
	    | AE Number  | 201         |
	    | Duration   | 77          |	
	And I take a screenshot
	And I select Form "Concomitant Medications"
	And I open log line 2
	And I verify Not Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Not Requires Response Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
    And I enter data in CRF
	    | Field                | Data        |
	    | Start Date           | 11 Feb 2000 |
	    | End Date             | 09 Mar 2000 |
	    | Original Axis Number | 202         |
	    | Current Axis Number  | 76          |		
	And I cancel the Query "Date can not be less than." on Field "Start Date"
	And I cancel the Query "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "End Date"
	And I cancel the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I cancel the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 2
	And I take a screenshot
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message              |
		| Query Canceled | Date can not be less than. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I click audit on Field "End Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                    |
		| Query Canceled | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I click audit on Field "Original Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                          |
		| Query Canceled | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                      |
		| Query Canceled | 'Duration' and 'Current Axis Number' cannot equal. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	When I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 10 Feb 2000 |
		| End Date             | 10 Mar 2000 |
		| Original Axis Number | 200         |
		| Current Axis Number  | 77          |
	And I open log line 2
	Then I verify Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
# Query Issue: Edit Checks with no require response and require manual close 
# Open a query, cancel a query, change the correct data and change it back to previous data query didn't fired and verify the log
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.5.1
@Validation
Scenario: PB_4.5.1 As an EDC user, Cross Forms - Standard form to log form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications"

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
	And I cancel the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I cancel the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 1
	And I take a screenshot
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                             |
		| Query Canceled | 'Date Informed Consent Signed' is greater. Please revise. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                                                 |
		| Query Canceled | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I open log line 1			
	And I verify Field "Start Date" has no Query
	And I verify Field "Current Axis Number" has no Query
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 20          |
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is not displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I take a screenshot
   
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.5.2
@Validation
Scenario: PB_4.5.2 As an EDC user, Cross Forms - Standard form to log form, when a query has been canceled with the different data and I enter the same data that originally opened the query, then queries are displayed.

    And I select a Subject "SUB{Var(num1)}"	
	And I select Form "Concomitant Medications" in Folder "Screening"
    And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 07 Jan 2000 |
	    | End Date             | 12 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 18          |		
	And I verify Not Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I cancel the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I cancel the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 2
	And I take a screenshot
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                             |
		| Query Canceled | 'Date Informed Consent Signed' is greater. Please revise. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                                                 |
		| Query Canceled | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I verify Field "Start Date" has no Query
	And I verify Field "Current Axis Number" has no Query
	And I take a screenshot	
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open log line 2
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.6.1
@Validation
Scenario: PB_4.6.1 As an EDC user, Cross Folders - Standard form to log form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Folder "Screening" enter and save data on form "Informed Consent"
#Folder "Week 1" enter and save data on form "Concomitant Medications"
		  
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
	And I cancel the Query "'Date Informed Consent Signed' can not be greater than." on Field "Start Date"
	And I cancel the Query "'Current Distribution Number' is not equal 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 1
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                           |
		| Query Canceled | 'Date Informed Consent Signed' can not be greater than. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                     |
		| Query Canceled | 'Current Distribution Number' is not equal 'Current Axis Number'. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| Original Axis Number | 201         |
		| Current Axis Number  | 200         |
	And I open log line 1
	And I verify Field "Start Date" has no Query
	And I verify Field "Current Axis Number" has no Query
	And I take a screenshot	
	When I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 09 Jan 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 99          |
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' can not be greater than." is not displayed on Field "Start Date"
	And I verify Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I take a screenshot
    
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.6.2
@Validation
Scenario: PB_4.6.2 As an EDC user, Cross Folders - Standard form to log form, when a query has been canceled with the different data and I enter the same data that originally opened the query, then queries are displayed.

    And I select a Subject "SUB{Var(num1)}"	
	And I select Form "Concomitant Medications" in Folder "Week 1"
    And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 08 Jan 2000 |
	    | End Date             | 12 Feb 2000 |
	    | Original Axis Number | 100         |
	    | Current Axis Number  | 98          |
	And I verify Not Requires Response Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I enter data in CRF
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| Original Axis Number | 201         |
		| Current Axis Number  | 200         |		
	And I cancel the Query "'Date Informed Consent Signed' can not be greater than." on Field "Start Date"
	And I cancel the Query "'Current Distribution Number' is not equal 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 2
	And I take a screenshot
	And I verify Field "Start Date" has no Query
	And I verify Field "Current Axis Number" has no Query
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                           |
		| Query Canceled | 'Date Informed Consent Signed' can not be greater than. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                     |
		| Query Canceled | 'Current Distribution Number' is not equal 'Current Axis Number'. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I take a screenshot
	When I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 08 Jan 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 98          |
	And I open log line 2
	Then I verify Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_4.7.1
@Validation
Scenario: PB_4.7.1 As an EDC user, Cross Forms - log form to Standard form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Folder "Week 1" enter and save data on forms "Concomitant Medications" and "Informed Consent"
	  
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
	And I cancel the Query "Start Date can not be greater than End Date." on Field "End Date"
	And I cancel the Query "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 1
	And I take a screenshot
	And I click audit on Field "End Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                |
		| Query Canceled | Start Date can not be greater than End Date. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                    |
		| Query Canceled | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 12 Jan 2000 |
		| Current Axis Number | 100         |
	And I open log line 1
	And I verify Field "End Date" has no Query
	And I verify Field "Current Axis Number" has no Query
	And I take a screenshot	
	When I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 11 Jan 2000 |
		| Current Axis Number | 101         |
	And I open log line 1
	Then I verify Query with message "Start Date can not be greater than End Date." is not displayed on Field "End Date"
	And I verify Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is not displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.7.2
@Validation
Scenario: PB_4.7.2 As an EDC user, Cross Forms - log form to Standard form, when a query has been canceled with the different data and I enter the same data that originally opened the query, then queries are displayed.

    And I select a Subject "SUB{Var(num1)}"	
	And I select Form "Concomitant Medications" in Folder "Week 1"
	And I add a new log line
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 15 Feb 2000 |
	    | End Date             | 14 Feb 2000 |
	    | Original Axis Number | 1999        |
	    | Current Axis Number  | 2000        |
	And I open log line 2	
	And I verify Not Requires Response Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I enter data in CRF
		| Field               | Data        |
		| End Date            | 15 Feb 2000 |
		| Current Axis Number | 1999        |
	And I cancel the Query "Start Date can not be greater than End Date." on Field "End Date"
	And I cancel the Query "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 2
	And I take a screenshot
	And I click audit on Field "End Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                |
		| Query Canceled | Start Date can not be greater than End Date. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                    |
		| Query Canceled | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I verify Field "End Date" has no Query
	And I verify Field "Current Axis Number" has no Query
	And I take a screenshot	
	When I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 14 Feb 2000 |
		| Current Axis Number | 2000        |
	And I open log line 2
	Then I verify Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.7.3
@Validation
Scenario: PB_4.7.3 As an EDC user, Cross Forms - log form to Standard form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are displayed.

    And I select a Subject "SUB{Var(num1)}"   
	And I select Form "Informed Consent" in Folder "Week 1"
    And I enter data in CRF and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 12 Jan 2000 |
	    | End Date                     | 11 Jan 2000 |
	    | Original Distribution Number | 100         |
	    | Current Distribution Number  | 101         |
	And I verify Not Requires Response Query with message "'Date Informed Consent Signed' is not equal to Current Date." is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." is displayed on Field "Current Distribution Number"
	And I take a screenshot
	And I enter data in CRF
	    | Field                       | Data        |
	    | End Date                    | 13 Jan 2000 |
	    | Current Distribution Number | 100         |		
	And I cancel the Query "'Date Informed Consent Signed' is not equal to Current Date." on Field "End Date"
	And I cancel the Query "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." on Field "Current Distribution Number"
	And I save the CRF page
	And I take a screenshot
	And I click audit on Field "End Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                                |
		| Query Canceled | 'Date Informed Consent Signed' is not equal to Current Date. |
	And I take a screenshot
	And I select link "Informed Consent" in "Header" 
	And I click audit on Field "Current Distribution Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                          |
		| Query Canceled | 'Original Distribution Number' and 'Current Distribution Number' fields are not equal. |
	And I take a screenshot
	And I select link "Informed Consent" in "Header" 
	And I verify Field "End Date" has no Query
	And I verify Field "Current Distribution Number" has no Query
	And I take a screenshot
    When I enter data in CRF and save
	    | Field                       | Data        |
	    | End Date                    | 11 Jan 2000 |
	    | Current Distribution Number | 101         |
	Then I verify Query with message "'Date Informed Consent Signed' is not equal to Current Date." is displayed on Field "End Date"
	And I verify Query with message "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." is displayed on Field "Current Distribution Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_4.8.1
@Validation
Scenario: PB_4.8.1 As an EDC user, Cross Forms - log form to log form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events"
	  
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
	And I cancel the Query "Date can not be less than." on Field "Start Date"
	And I cancel the Query "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "End Date"
	And I cancel the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I cancel the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 1
	And I take a screenshot
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message              |
		| Query Canceled | Date can not be less than. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "End Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                    |
		| Query Canceled | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "Original Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                          |
		| Query Canceled | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                      |
		| Query Canceled | 'Duration' and 'Current Axis Number' cannot equal. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 11 Jan 2000 |
	    | End Date             | 09 Feb 2000 |
	    | Original Axis Number | 102         |
	    | Current Axis Number  | 65          |	
	And I open log line 1
	And I verify Field "Start Date" has no Query
	And I verify Field "End Date" has no Query
	And I verify Field "Original Axis Number" has no Query
	And I verify Field "Current Axis Number" has no Query
	And I take a screenshot	
	When I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| End Date             | 10 Feb 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 66          |
	And I open log line 1
	Then I verify Query with message "Date can not be less than." is not displayed on Field "Start Date"
	And I verify Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is not displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is not displayed on Field "Original Axis Number"
	And I verify Query with message "'Duration' and 'Current Axis Number' cannot equal." is not displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.8.2
@Validation
Scenario: PB_4.8.2 As an EDC user, Cross Forms - log form to log form, when a query has been canceled with the different data and I enter the same data that originally opened the query, then queries are displayed.

    And I select a Subject "SUB{Var(num1)}"   
    And I select Form "Concomitant Medications" in Folder "Screening"
	And I add a new log line
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 10 Feb 2000 |
	    | End Date             | 10 Mar 2000 |
	    | Original Axis Number | 200         |
	    | Current Axis Number  | 77          |
	And I take a screenshot
    And I select Form "Adverse Events" in Folder "Screening"
	And I add a new log line
	And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 11 Feb 2000 |
	    | End Date   | 09 Mar 2000 |
	    | AE Number  | 201         |
	    | Duration   | 77          |
	And I take a screenshot
	And I select Form "Concomitant Medications"
	And I open log line 2
	And I verify Not Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Not Requires Response Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
    And I enter data in CRF
	    | Field                | Data        |
	    | Start Date           | 11 Feb 2000 |
	    | End Date             | 09 Mar 2000 |
	    | Original Axis Number | 202         |
	    | Current Axis Number  | 76          |		
	And I cancel the Query "Date can not be less than." on Field "Start Date"
	And I cancel the Query "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "End Date"
	And I cancel the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I cancel the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 2
	And I take a screenshot
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message              |
		| Query Canceled | Date can not be less than. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I click audit on Field "End Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                    |
		| Query Canceled | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I click audit on Field "Original Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                          |
		| Query Canceled | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                      |
		| Query Canceled | 'Duration' and 'Current Axis Number' cannot equal. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 2
	And I verify Field "Start Date" has no Query
	And I verify Field "End Date" has no Query
	And I verify Field "Original Axis Number" has no Query
	And I verify Field "Current Axis Number" has no Query
	And I take a screenshot
	When I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 10 Feb 2000 |
		| End Date             | 10 Mar 2000 |
		| Original Axis Number | 200         |
		| Current Axis Number  | 77          |
	And I open log line 2
	Then I verify Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	