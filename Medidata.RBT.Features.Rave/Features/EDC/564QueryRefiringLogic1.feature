
Feature: US12940_564QueryRefiringLogic1 Edit Checks refire with require response and require manual close.
	As a Rave user
	I want to change data
	So I can see refired queries

# Query Issue: Edit Checks with require response and require manual close
# Open, answer and close a query, change the data and verify that the query did re-fire and verify no log
# Verify query firing between cross forms with require response and require manual close.
# Project to be uploaded in excel spreadsheet 'Edit Check Study 1'

Background:
 	Given xml draft "Edit_Check_Study_3_Draft_1.xml" is Uploaded
	Given Site "Edit Check Site 1" exists
	Given study "Edit Check Study 3" is assigned to Site "Edit Check Site 1"
	Given I publish and push eCRF "Edit_Check_Study_3_Draft_1.xml" to "Version 1"
	Given following Project assignments exist
		| User         | Project            | Environment | Role            | Site              | SecurityRole          |
		| SUPER USER 1 | Edit Check Study 3 | Live: Prod  | Edit Check Role | Edit Check Site 1 | Project Admin Default |
	
    #Given I login to Rave with user "defuser" and password "password"
	#And following Study assignments exist
	#	|User		|Study		       |Role |Site		        |Site Number |
	#	|editcheck  |Edit Check Study 1|cdm1 |Edit Check Site 1 |10001       |
    # And role "cdm1" has Query actions
	#And Draft "Draft 3" in Study "Edit Check Study 3" has been published to CRF Version "<RANDOMNUMBER>" 
	#And CRF Version "<RANDOMNUMBER>" in Study "Edit Check Study 3" has been pushed to Site "Edit Check Site 3" in Environment "Prod"
	#And I select Study "Edit Check Study 3" and Site "Edit Check Site 1"

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.1.1
@Validation
Scenario: PB_1.1.1 As an EDC user, On a Cross Forms - Standard form to log form, when a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed. 
	
	Given I login to Rave with user "SUPER USER 1"
	Given I create a Subject
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
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "query answered"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 1
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF on log line 1 and save and reopen
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I verify Query is not displayed
		| Field      | Query Message                                             | Answered | Closed |
		| Start Date | 'Date Informed Consent Signed' is greater. Please revise. | false    | false  |
	And I verify Query is not displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 20          |
	And I open log line 1
	Then I verify Query is not displayed
		| Field      | Query Message                                             | Answered | Closed |
		| Start Date | 'Date Informed Consent Signed' is greater. Please revise. | false    | false  |
	Then I verify Query is not displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I verify closed Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify closed Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
 
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.1.2
@Validation
Scenario: PB_1.1.2 As an EDC user, On a Cross Forms - Standard form to log form, when a query has been answered and closed with the same data and I enter the different data that originally opened the query, then queries are displayed. 

	Given I login to Rave with user "SUPER USER 1"
	And I select a Subject "SUB{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 07 Jan 2000 |
	    | End Date             | 12 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 18          |
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "query answered"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "query answered"
	And I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I save the CRF page
	And I open log line 2	
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I open log line 2
	And I verify Query is not displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
	And I verify Query is not displayed
		| Field               | Query Message                                                                                                 | Answered | Closed |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	
	When I enter data in CRF on log line 2 and save and reopen
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	Then I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.2.1
@Validation
Scenario: PB_1.2.1 As an EDC user, On a Cross Folders, Standard form to log form. when a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Folder "Screening" enter and save data on form "Informed Consent" Folder "Week 1" enter and save data on form "Concomitant Medications"
	
	Given I login to Rave with user "SUPER USER 1"
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
	And I verify Requires Response Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' can not be greater than." on Field "Start Date" with "query answered"
	And I answer the Query "'Current Distribution Number' is not equal 'Current Axis Number'." on Field "Current Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 1
	And I close the Query "'Date Informed Consent Signed' can not be greater than." on Field "Start Date"
	And I close the Query "'Current Distribution Number' is not equal 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF on log line 1 and save and reopen
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| Original Axis Number | 201         |
		| Current Axis Number  | 200         |
	And I verify Query is not displayed
		| Field               | Query Message                                                     | Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' can not be greater than.           | false    | false  |
	And I verify Query is not displayed
		| Field               | Query Message                                                     | Answered | Closed |
		| Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	When I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 09 Jan 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 99          |
	And I open log line 1
	Then I verify Query is not displayed
		| Field      | Query Message                                           | Answered | Closed |
		| Start Date | 'Date Informed Consent Signed' can not be greater than. | false    | false  |
	And I verify Query is not displayed
		| Field               | Query Message                                                     | Answered | Closed |
		| Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | false    | false  |
	And I verify closed Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify closed Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"	
	And I take a screenshot
 
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.2.2
@Validation
Scenario: PB_1.2.2 As an EDC user, On a Cross Folders, Standard form to log form. when a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed.

	Given I login to Rave with user "SUPER USER 1"
	And I select a Subject "SUB{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Week 1"
	And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 08 Jan 2000 |
	    | End Date             | 12 Feb 2000 |
	    | Original Axis Number | 100         |
	    | Current Axis Number  | 98          |
	And I verify Requires Response Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' can not be greater than." on Field "Start Date" with "query answered"
	And I answer the Query "'Current Distribution Number' is not equal 'Current Axis Number'." on Field "Current Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 2	
	And I close the Query "'Date Informed Consent Signed' can not be greater than." on Field "Start Date"
	And I close the Query "'Current Distribution Number' is not equal 'Current Axis Number'." on Field "Current Axis Number"
	And I enter data in CRF
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| Original Axis Number | 201         |
		| Current Axis Number  | 200         |
	And I save the CRF page	
	And I take a screenshot
	And I open log line 2
	And I verify Query is not displayed
		| Field               | Query Message                                                     |Answered | Closed |
		| Start Date          | 'Date Informed Consent Signed' can not be greater than.           |false    | false  |
	And I verify Query is not displayed
		| Field               | Query Message                                                     | Answered | Closed |
		| Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	And I cancel the CRF page
	When I enter data in CRF on the last log line and save and reopen
		| Field                | Data        |
		| Start Date           | 08 Jan 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 98          |
	Then I verify Not Requires Response Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"	
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.3.1
@Validation
Scenario: PB_1.3.1 As an EDC user, on a Cross Forms log form to Standard form, when a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Folder "Week 1" enter and save data on forms "Concomitant Medications" and "Informed Consent"

 	Given I login to Rave with user "SUPER USER 1" 
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
	And I verify Requires Response Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify Requires Response Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "Start Date can not be greater than End Date." on Field "End Date" with "query answered"
	And I answer the Query "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "Current Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 1
	And I close the Query "Start Date can not be greater than End Date." on Field "End Date"
	And I close the Query "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I open log line 1
	And I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 12 Jan 2000 |
		| Current Axis Number | 100         | 
	And I open log line 1
	And I verify Query is not displayed
		| Field    | Query Message                                | Answered | Closed |
		| End Date | Start Date can not be greater than End Date. | false    | false  |
	And I verify Query is not displayed
		| Field               | Query Message                                                                   | Answered | Closed |
		| Current Axis Number | Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | false    | false  |
	And I take a screenshot	
	When I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 11 Jan 2000 |
		| Current Axis Number | 101         |
	And I open log line 1
	Then I verify Query is not displayed
		| Field    | Query Message                                | Answered | Closed |
		| End Date | Start Date can not be greater than End Date. | false    | false  |
	And I verify Query is not displayed
		| Field               | Query Message                                                                   |Answered | Closed |
		| Current Axis Number | Original Axis Number' is Less Than 'Current Axis Number' on first Number field. |false    | false  |
	And I verify closed Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify closed Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.3.2
@Validation
Scenario: PB_1.3.2 As an EDC user, on a Cross Forms log form to Standard form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.

	Given I login to Rave with user "SUPER USER 1"
	And I select a Subject "SUB{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Week 1"
    And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 15 Feb 2000 |
	    | End Date             | 14 Feb 2000 |
	    | Original Axis Number | 1999        |
	    | Current Axis Number  | 2000        |
	And I verify Requires Response Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify Requires Response Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "Start Date can not be greater than End Date." on Field "End Date" with "query answered"
	And I answer the Query "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "Current Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 2
	And I close the Query "Start Date can not be greater than End Date." on Field "End Date"
	And I close the Query "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "Current Axis Number"
	And I enter data in CRF
		| Field               | Data        |
		| End Date            | 15 Feb 2000 |
		| Current Axis Number | 1999        |
	And I save the CRF page
	And I take a screenshot
	And I open log line 2
	And I verify Query is not displayed
		| Field    | Query Message                                | Answered | Closed |
		| End Date | Start Date can not be greater than End Date. | false    | false  |
	And I verify Query is not displayed
		| Field               | Query Message                                                                   | Answered | Closed |
		| Current Axis Number | Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | false    | false  |
	And I take a screenshot	
	When I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 14 Feb 2000 |
		| Current Axis Number | 2000        |
	And I open log line 2
	Then I verify Requires Response Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify Requires Response Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot
	 
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.3.3
@Validation
Scenario: PB_1.3.3 As an EDC user, on a Cross Forms log form to Standard form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.

	Given I login to Rave with user "SUPER USER 1"
	And I select a Subject "SUB{Var(num1)}"
	And I select Form "Informed Consent" in Folder "Week 1"
    And I enter data in CRF and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 12 Jan 2000 |
	    | End Date                     | 11 Jan 2000 |
	    | Original Distribution Number | 100         |
	    | Current Distribution Number  | 101         |
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is not equal to Current Date." is displayed on Field "End Date"
	And I verify Requires Response Query with message "Original Distribution Number' and 'Current Distribution Number' fields are not equal." is displayed on Field "Current Distribution Number"
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is not equal to Current Date." on Field "End Date" with "query answered"
	And I answer the Query "Original Distribution Number' and 'Current Distribution Number' fields are not equal." on Field "Current Distribution Number" with "query answered"
	And I save the CRF page
	And I close the Query "'Date Informed Consent Signed' is not equal to Current Date." on Field "End Date"
	And I close the Query "Original Distribution Number' and 'Current Distribution Number' fields are not equal." on Field "Current Distribution Number"
	And I enter data in CRF
	    | Field                       | Data        |
	    | End Date                    | 13 Jan 2000 |
	    | Current Distribution Number | 100         |
	And I save the CRF page
	And I take a screenshot
	And I verify Query is not displayed
		| Field    | Query Message                                                | Answered | Closed |
		| End Date | 'Date Informed Consent Signed' is not equal to Current Date. | false    | false  |
	And I verify Query is not displayed
		| Field                       | Query Message                                                                         | Answered | Closed |
		| Current Distribution Number | Original Distribution Number' and 'Current Distribution Number' fields are not equal. | false    | false  |
	And I take a screenshot  
    When I enter data in CRF
	    | Field                       | Data        |
	    | End Date                    | 11 Jan 2000 |
	    | Current Distribution Number | 101         |
	And I save the CRF page
	Then I verify Query is displayed
		| Field    | Query Message                                                | Answered | Closed |
		| End Date | 'Date Informed Consent Signed' is not equal to Current Date. | false    | false  |
	And I verify Query is displayed
		| Field                       | Query Message                                                                         | Answered | Closed |
		| Current Distribution Number | Original Distribution Number' and 'Current Distribution Number' fields are not equal. | false    | false  |
	Then I verify Requires Response Query with message "'Date Informed Consent Signed' is not equal to Current Date." is displayed on Field "End Date"
	And I verify Requires Response Query with message "Original Distribution Number' and 'Current Distribution Number' fields are not equal." is displayed on Field "Current Distribution Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.4.1
@Validation
Scenario: PB_1.4.1 As an EDC user, On a Cross Forms log form to log form, when a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events"

	Given I login to Rave with user "SUPER USER 1"			  
    And I create a Subject
		| Field            | Data             |
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
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Requires Response Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "Date can not be less than." on Field "Start Date" with "query answered"
	And I answer the Query "Date is Less Than Date on the first log form." on Field "End Date" with "query answered"
	And I answer the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number" with "query answered"
	And I answer the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 1
	And I close the Query "Date can not be less than." on Field "Start Date"
	And I close the Query "Date is Less Than Date on the first log form." on Field "End Date"
	And I close the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I close the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF on log line 1 and save
	    | Field                | Data        |
	    | Start Date           | 11 Jan 2000 |
	    | End Date             | 09 Feb 2000 |
	    | Original Axis Number | 102         |
	    | Current Axis Number  | 65          |	
	And I open log line 1
	And I verify Query is displayed
		| Field                | Query Message                                                          | Answered | Closed |
		| Start Date           | Date can not be less than.                                             | true     | true   |
		| End Date             | Date is Less Than Date on the first log form.                          | true     | true   |
		| Original Axis Number | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. | true     | true   |
		| Current Axis Number  | 'Duration' and 'Current Axis Number' cannot equal.                     | true     | true   |
	And I take a screenshot	
	When I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| End Date             | 10 Feb 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 66          |
	And I open log line 1
	And I verify closed Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify closed Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify closed Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify closed Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
	  
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.4.2
@Validation
Scenario: PB_1.4.2 As an EDC user, On a Cross Forms log form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.  

	Given I login to Rave with user "SUPER USER 1"
	And I select a Subject "SUB{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF on a new log line and save
	    | Field                | Data        |
	    | Start Date           | 10 Feb 2000 |
	    | End Date             | 10 Mar 2000 |
	    | Original Axis Number | 200         |
	    | Current Axis Number  | 77          |
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
	And I enter data in CRF on a new log line and save
	    | Field      | Data        |
	    | Start Date | 11 Feb 2000 |
	    | End Date   | 09 Mar 2000 |
	    | AE Number  | 201         |
	    | Duration   | 77          |
	And I take a screenshot
	And I select Form "Concomitant Medications"
	And I open log line 2
	And I take a screenshot
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Requires Response Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "Date can not be less than." on Field "Start Date" with "query answered"
	And I answer the Query "Date is Less Than Date on the first log form." on Field "End Date" with "query answered"
	And I answer the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number" with "query answered"
	And I answer the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 2
	And I close the Query "Date can not be less than." on Field "Start Date"
	And I close the Query "Date is Less Than Date on the first log form." on Field "End Date"
	And I close the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I close the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number"
    And I enter data in CRF
	    | Field                | Data        |
	    | Start Date           | 11 Feb 2000 |
	    | End Date             | 09 Mar 2000 |
	    | Original Axis Number | 202         |
	    | Current Axis Number  | 76          |		
	And I save the CRF page
	And I open log line 2
	And I take a screenshot
	And I verify Query is displayed
		| Field                | Query Message                                                          | Answered | Closed |
		| Start Date           | Date can not be less than.                                             | true     | true   |
		| End Date             | Date is Less Than Date on the first log form.                          | true     | true   |
		| Original Axis Number | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. | true     | true   |
		| Current Axis Number  | 'Duration' and 'Current Axis Number' cannot equal.                     | true     | true   |
	And I take a screenshot	
	When I enter data in CRF
		| Field                | Data        |
		| Start Date           | 10 Feb 2000 |
		| End Date             | 10 Mar 2000 |
		| Original Axis Number | 200         |
		| Current Axis Number  | 77          |
	And I save the CRF page	
	And I open log line 2
	Then I verify Query is displayed
		| Field                | Query Message                                                          | Answered | Closed |
		| Start Date           | Date can not be less than.                                             | false    | false  |
	And I verify Query is displayed
		| Field                | Query Message                                                          | Answered | Closed |
		| End Date             | Date is Less Than Date on the first log form.                          | false    | false  |
	And I verify Query is displayed
		| Field                | Query Message                                                          | Answered | Closed |
		| Original Axis Number | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. | false    | false  |
	And I verify Query is displayed
		| Field                | Query Message                                                          | Answered | Closed |
		| Current Axis Number  | 'Duration' and 'Current Axis Number' cannot equal.                     | false    | false  |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.5.1
@Validation
Scenario: PB_1.5.1 As an EDC user, Cross Forms - Standard form to log form, when a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed.  
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications". Queries fired, Answer and  Manually close queries in log fields, Modify Standard form to different bad data, do not touch log form - query and no logs in the Database.

	Given I login to Rave with user "SUPER USER 1"	
    And I create a Subject
		| Field            | Data             |
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
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'" is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "query answered"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'" on Field "Current Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 1
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'" on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I select Form "Informed Consent"
	And I enter data in CRF and save
		| Field                        | Data        |
		| Date Informed Consent Signed | 20 Jan 2000 |
		| Current Distribution Number  | 21          |
    When I select Form "Concomitant Medications"	
	And I open log line 1
	Then I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'" is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.6.1
@Validation
Scenario: PB_1.6.1 As an EDC user, On a Cross Forms - Standard form to log form. when a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed. 
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications". Queries fired, Cancel queries in log fields, Modify Standard form to different bad data, do not touch log form - query and no logs in the Database.

	Given I login to Rave with user "SUPER USER 1"	
    And I create a Subject
		| Field            | Data             |
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
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I cancel the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I cancel the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I select Form "Informed Consent"
	And I enter data in CRF and save
		| Field                        | Data        |
		| Date Informed Consent Signed | 20 Jan 2000 |
		| Current Distribution Number  | 21          |   
	When I select Form "Concomitant Medications"	
	And I open log line 1
	Then I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"	
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.7.1
@Validation
Scenario: PB_1.7.1 As an EDC user, Cross Forms - log form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.  
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events". Queries fired, Answer and  Manually close queries in log fields (second log form), Modify log form (first log form) to different bad data, do not touch second log form - query and no logs in the Database.

	Given I login to Rave with user "SUPER USER 1"			  
    And I create a Subject
		| Field            | Data             |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |  
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 10 Jan 2000 |
	    | End Date             | 10 Feb 2000 |
	    | Original Axis Number | 100         |
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
    And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 11 Jan 2000 |
	    | End Date   | 09 Feb 2000 |
	    | AE Number  | 101         |
	And I take a screenshot
    And I select Form "Concomitant Medications"	
	And I open log line 1		
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I take a screenshot
	And I answer the Query "Date can not be less than." on Field "Start Date" with "query answered"
	And I answer the Query "Date is Less Than Date on the first log form." on Field "End Date" with "query answered"
	And I answer the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 1
	And I close the Query "Date can not be less than." on Field "Start Date"
	And I close the Query "Date is Less Than Date on the first log form." on Field "End Date"
	And I close the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I select Form "Adverse Events"
	And I open log line 1
	And I enter data in CRF and save
		| Field      | Data        |
		| Start Date | 12 Jan 2000 |
		| End Date   | 08 Feb 2000 |
		| AE Number  | 100         |
	When I select Form "Concomitant Medications"
	And I open log line 1
	Then I verify Query is displayed
		| Field      | Query Message              | Answered | Closed |
		| Start Date | Date can not be less than. | false    | false  |
	And I verify Query is displayed
		| Field    | Query Message                                 | Answered | Closed |
		| End Date | Date is Less Than Date on the first log form. | false    | false  |
	And I verify Query is displayed
		| Field                | Query Message                                                          | Answered | Closed |
		| Original Axis Number | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. | false    | false  |
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.8.1
@Validation
Scenario: PB_1.8.1 As an EDC user, On a Cross Forms - log form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.  
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events". Queries fired, cancel queries in log fields (second log form), Modify log form (first log form) to different bad data, do not touch second log form - query and no logs in the Database.
	
	Given I login to Rave with user "SUPER USER 1"			  
    And I create a Subject
		| Field            | Data             |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 10 Jan 2000 |
	    | End Date             | 10 Feb 2000 |
	    | Original Axis Number | 100         |
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
    And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 11 Jan 2000 |
	    | End Date   | 09 Feb 2000 |
	    | AE Number  | 101         |
	And I take a screenshot
    And I select Form "Concomitant Medications"	
	And I open log line 1		
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I take a screenshot
	And I cancel the Query "Date can not be less than." on Field "Start Date"
	And I cancel the Query "Date is Less Than Date on the first log form." on Field "End Date"
	And I cancel the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I select Form "Adverse Events"
	And I open log line 1
	And I enter data in CRF and save
		| Field      | Data        |
		| Start Date | 12 Jan 2000 |
		| End Date   | 08 Feb 2000 |
		| AE Number  | 100         |	
	When I select Form "Concomitant Medications"
	And I open log line 1	
	Then I verify Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.9.1
@Validation
Scenario: PB_1.9.1 As an EDC user, On a Cross Forms - Standard form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.  
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications". Queries fired, Answer and  Manually close queries in log fields, Modify log fields to different good data, do not touch standard form - no query and no log in the Database.

	Given I login to Rave with user "SUPER USER 1"	
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
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "query answered"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 1
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I open log line 1
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I open log line 1
	Then I verify Query is not displayed
	   | Field      | Query Message                                             | Answered | Closed |
	   | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | false    | false  |
	And I verify Query is not displayed
	   | Field               | Query Message                                                                                             | Answered | Closed |
	   | Current Axis Number | Informed Consent 'Current Distribution Number' is equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.10.1
@Validation
Scenario: PB_1.10.1 As an EDC user, Cross Forms: Standard form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed. 
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications" Queries fired, Answer and  Manually close queries in log fields, Modify log fields to different bad data, do not touch standard form - query fires and no log in the Database.

	Given I login to Rave with user "SUPER USER 1"	
    And I create a Subject
		| Field            | Data             |
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
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "query answered"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 1
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I open log line 1
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 21          |
	And I open log line 1			
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.11.1
@Validation
Scenario: PB_1.11.1 As an EDC user, On a Cross Forms Standard form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.  
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications" Queries fired on log form, Modify standard fields to different good data, new Data results in system close of edit check on log form - queries closed by system and no log in the Database.

	Given I login to Rave with user "SUPER USER 1"	
    And I create a Subject
		| Field            | Data             |
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
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I select Form "Informed Consent"
	And I enter data in CRF and save
		| Field                        | Data        |
		| Date Informed Consent Signed | 08 Jan 2000 |
		| Current Distribution Number  | 20          |		
	When I select Form "Concomitant Medications"
	And I open log line 1	
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is not displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.12.1
@Validation
Scenario: PB_1.12.1 As an EDC user, On a Cross Forms - Standard form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.  
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications". Queries fired on log form, Modify log fields to different good data, new value results in system close of edit check on log form - queries closed by system and no log in the Database.

	Given I login to Rave with user "SUPER USER 1"	
    And I create a Subject
		| Field            | Data             |
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
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot	
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I open log line 1
  	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is not displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.13.1
@Validation
Scenario: PB_1.13.1 As an EDC user, On a Cross Forms - Standard form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed. 
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications". Queries fired on log form, Modify standard fields to different good data, new value results in system close of edit check on log form and update \new value on standard fields in violation of edit check on log form- queries refires on log form and no log in the Database.
	
	Given I login to Rave with user "SUPER USER 1"
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
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I select Form "Informed Consent"
	And I enter data in CRF and save
		| Field                        | Data        |
		| Date Informed Consent Signed | 08 Jan 2000 |
		| Current Distribution Number  | 20          |      
	And I select Form "Concomitant Medications"
	And I open log line 1
  	And I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is not displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I take a screenshot
	And I select Form "Informed Consent"
	And I enter data in CRF and save
		| Field                        | Data        |
		| Date Informed Consent Signed | 09 Jan 2000 |
		| Current Distribution Number  | 19          |	
	When I select Form "Concomitant Medications"
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.14.1
@Validation
Scenario: PB_1.14.1 As an EDC user, Cross Forms - Standard form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.  
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications". Queries fired on log form, Modify log fields to different good data, new value results in system close of edit check on log form and update new value on standard fields in violation of edit check on log form- queries refires on log form and no log in the Database.
	
	Given I login to Rave with user "SUPER USER 1"
    And I create a Subject
		| Field            | Data             |
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
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
    And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |	
	And I open log line 1
 	And I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is not displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I take a screenshot
	And I select Form "Informed Consent"
	When I enter data in CRF and save
		| Field                        | Data        |
		| Date Informed Consent Signed | 10 Jan 2000 |
		| Current Distribution Number  | 20          |
	And I select Form "Concomitant Medications"
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.15.1
@Validation
Scenario: PB_1.15.1 As an EDC user, On a Cross Forms - log form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.  
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events". Queries fired, Answer and  Manually close queries on "Concomitant Medications" form, Modify log fields to different good data on "Adverse Events" form, do not touch "Concomitant Medications" form - no queries on "Concomitant Medications" and no log in the Database.

	Given I login to Rave with user "SUPER USER 1"	
    And I create a Subject
		| Field            | Data             |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 10 Jan 2000 |
	    | End Date   | 10 Feb 2000 |
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
    And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 11 Jan 2000 |
	    | End Date   | 09 Feb 2000 |
	And I take a screenshot
    And I select Form "Concomitant Medications"
	And I open log line 1
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I take a screenshot
	And I answer the Query "Date can not be less than." on Field "Start Date" with "query answered"
	And I answer the Query "Date is Less Than Date on the first log form." on Field "End Date" with "query answered"
	And I save the CRF page
	And I open log line 1
	And I close the Query "Date can not be less than." on Field "Start Date"
	And I close the Query "Date is Less Than Date on the first log form." on Field "End Date"
	And I save the CRF page
	And I take a screenshot
	And I select Form "Adverse Events"
	And I open log line 1
	When I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 10 Jan 2000 |
	    | End Date   | 10 Feb 2000 |
	And I select Form "Concomitant Medications"
	And I open log line 1
	Then I verify Query is not displayed
		| Field      | Query Message              | Answered | Closed |
		| Start Date | Date can not be less than. | false    | false  |
	And I verify Query is not displayed
		| Field      | Query Message                                 | Answered | Closed |
		| Start Date | Date is Less Than Date on the first log form. | false    | false  |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.16.1
@Validation
Scenario: PB_1.16.1 As an EDC user, On a Cross Forms - log form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.   
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events". Queries fired, Answer and  Manually close queries on "Concomitant Medications" form, Modify log fields to different bad data on "Adverse Events" form, do not touch "Concomitant Medications" form - queries fire on "Concomitant Medications" and no log in the Database.

	Given I login to Rave with user "SUPER USER 1"	
    And I create a Subject
		| Field            | Data             |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 10 Jan 2000 |
	    | End Date             | 10 Feb 2000 |
	    | Original Axis Number | 100         |
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
    And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 11 Jan 2000 |
	    | End Date   | 09 Feb 2000 |
	    | AE Number  | 101         |
	And I take a screenshot
    And I select Form "Concomitant Medications"	
	And I open log line 1
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I take a screenshot
	And I answer the Query "Date can not be less than." on Field "Start Date" with "query answered"
	And I answer the Query "Date is Less Than Date on the first log form." on Field "End Date" with "query answered"
	And I answer the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number" with "query answered"
	And I save the CRF page
	And I open log line 1
	And I close the Query "Date can not be less than." on Field "Start Date"
	And I close the Query "Date is Less Than Date on the first log form." on Field "End Date"
	And I close the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I open log line 1
	When I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 09 Jan 2000 |
	    | End Date             | 11 Feb 2000 |
	    | Original Axis Number | 99          |
	And I open log line 1
	Then I verify Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.17.1
@Validation
Scenario: PB_1.17.1 As an EDC user, On a Cross Forms - log form to log form, when a query has not been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.  
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events". Queries fired on second log form, Modify log fields on first log form to different good data, new value results in system close of edit check on second log form - queries closed by system on second log form and no log in the Database.

	Given I login to Rave with user "SUPER USER 1"	
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 10 Jan 2000 |
	    | End Date   | 10 Feb 2000 |
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
    And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 11 Jan 2000 |
	    | End Date   | 09 Feb 2000 |
	And I take a screenshot
    And I select Form "Concomitant Medications"
	And I open log line 1
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I take a screenshot
	And I select Form "Adverse Events"
	And I open log line 1
	When I enter data in CRF and save
		| Field      | Data        |
		| Start Date | 10 Jan 2000 |
		| End Date   | 10 Feb 2000 |	
	And I select Form "Concomitant Medications"	
	And I open log line 1
	Then I verify Query with message "Date can not be less than." is not displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is not displayed on Field "End Date"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.18.1
@Validation
Scenario: PB_1.18.1 As an EDC user, On a Cross Forms - log form to log form, when a query has not been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.  
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events". Queries fired on second log form, Modify log fields on same second log form to different good data, new value results in system close of edit check on second log form - queries closed by system on second log form and no log in the Database.

	Given I login to Rave with user "SUPER USER 1"	
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 10 Jan 2000 |
	    | End Date   | 10 Feb 2000 |
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
    And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 11 Jan 2000 |
	    | End Date   | 09 Feb 2000 |
	And I take a screenshot
    And I select Form "Concomitant Medications"	
	And I open log line 1
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I take a screenshot
	When I enter data in CRF and save
		| Field      | Data        |
		| Start Date | 11 Jan 2000 |
		| End Date   | 09 Feb 2000 |			
	And I open log line 1
	Then I verify Query with message "Date can not be less than." is not displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is not displayed on Field "End Date"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.19.1
@Validation
Scenario: PB_1.19.1 As an EDC user, On a Cross Forms - log form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed. 
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events". Queries fired on second log form, Modify log fields on first log form to different good data, new value results in system close of edit check on second log form. Navigate to first log form and enter new value in violation of edit check - queries refired on second log form and no log in the Database

	Given I login to Rave with user "SUPER USER 1"	
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 10 Jan 2000 |
	    | End Date   | 10 Feb 2000 |
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
    And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 11 Jan 2000 |
	    | End Date   | 09 Feb 2000 |
	And I take a screenshot
    And I select Form "Concomitant Medications"
	And I open log line 1		
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I take a screenshot
	And I select Form "Adverse Events"
	And I open log line 1
	And I enter data in CRF and save
		| Field      | Data        |
		| Start Date | 10 Jan 2000 |
		| End Date   | 10 Feb 2000 |
	And I select Form "Concomitant Medications"
	And I open log line 1
	And I verify Query with message "Date can not be less than." is not displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is not displayed on Field "End Date" 
	And I take a screenshot	
	And I select Form "Adverse Events"
	And I open log line 1
	When I enter data in CRF and save
		| Field      | Data        |
		| Start Date | 11 Jan 2000 |
		| End Date   | 09 Feb 2000 |
	And I select Form "Concomitant Medications"
	And I open log line 1
	Then I verify Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.20.1
@Validation
Scenario: PB_1.20.1 As an EDC user, On a Cross Forms log form to log form, when a query has not been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.  
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events" Queries fired on second log form, Modify log fields on second log form to different good data, new value results in system close of edit check on second log form. Navigate to first log form and enter new value in violation of edit check - queries refired on second log form and no log in the Database

	Given I login to Rave with user "SUPER USER 1"	
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 10 Jan 2000 |
	    | End Date   | 10 Feb 2000 |
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
    And I enter data in CRF and save
	    | Field      | Data        |
	    | Start Date | 11 Jan 2000 |
	    | End Date   | 09 Feb 2000 |
	And I take a screenshot
    And I select Form "Concomitant Medications"	
	And I open log line 1	
	And I verify Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I take a screenshot
	And I enter data in CRF
		| Field      | Data        |
		| Start Date | 11 Jan 2000 |
		| End Date   | 09 Feb 2000 |	
	And I save the CRF page
	And I open log line 1	
	And I verify Query with message "Date can not be less than." is not displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is not displayed on Field "End Date" 
	And I take a screenshot
	And I select Form "Adverse Events"
	And I open log line 1	
	When I enter data in CRF and save
		| Field      | Data        |
		| Start Date | 12 Jan 2000 |
		| End Date   | 08 Feb 2000 |	
	And I select Form "Concomitant Medications"
	And I open log line 1
	Then I verify Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.21.1
@Validation
Scenario: PB_1.21.1 As an EDC user, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.
#Queries fired, Answer and  Manually close query on log field, Modify Standard field to different bad data, do not touch log field - query and no logs in the Database

	Given I login to Rave with user "SUPER USER 1"
    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |5    |
	    |Log Field 1 |4    |
	    |Log Field 2 |3    |
	And I take a screenshot
	And I open log line 1	
	And I verify Requires Response Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I take a screenshot
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "query answered"
	And I save the CRF page
	And I open log line 1	
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I save the CRF page
	And I take a screenshot
	When I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |6    |
	And I open log line 1
	Then I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"	
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.22.1
@Validation
Scenario: PB_1.22.1 As an EDC user, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are displayed.  
#Queries fired, cancel query on log field, Modify Standard field to different bad data, do not touch log field - query re-fires and no logs in the Database. Modify log field to different bad data, do not touch standard field - query re-fires and no logs in the Database.

	Given I login to Rave with user "SUPER USER 1"
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I open log line 1	
	And I verify Requires Response Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I take a screenshot
	And I cancel the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I save the CRF page
	And I take a screenshot
	And I open log line 1	
	When I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |7    |
	And I open log line 1
	Then I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.22.2
@Validation
Scenario: PB_1.22.2 As an EDC user, when a query has been canceled with the different data and I enter the same data that originally opened the query, then queries are displayed.  
	
	Given I login to Rave with user "SUPER USER 1"
	And I select a Subject "SUB{Var(num1)}"
	And I select Form "Mixed Form"
    And I add a new log line
	And I enter data in CRF and save  
		|Field       |Data |
	    |Log Field 1 |4    |
	    |Log Field 2 |2    |
	And I open log line 2	
	And I verify Requires Response Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I take a screenshot
	And I enter data in CRF
		|Field       |Data |
        |Log Field 1 |8    |
	And I cancel the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I save the CRF page
	And I take a screenshot
	And I open log line 1		
	When I enter data in CRF and save
		|Field       |Data |
        |Log Field 1 |4    |
	And I open log line 1	
	Then I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_1.22.3
@Validation
Scenario: PB_1.22.3 As an EDC user, when a query has been cancel with the different data and I enter the same data that originally opened the query, then queries are displayed.  

	Given I login to Rave with user "SUPER USER 1"
	And I select a Subject "SUB{Var(num1)}"
	And I select Form "Mixed Form"
    And I add a new log line
	And I enter data in CRF and save 
		|Field       |Data |
	    |Log Field 1 |4    |
	    |Log Field 2 |2    |
	And I open log line 3		
	And I verify Requires Response Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I take a screenshot
	And I enter data in CRF
		|Field       |Data |
        |Log Field 1 |8    |
	And I cancel the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I save the CRF page
	And I take a screenshot
	And I open log line 3		
	When I enter data in CRF and save
		|Field       |Data |
        |Standard 1	 |10   |
	And I open log line 3
	Then I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------