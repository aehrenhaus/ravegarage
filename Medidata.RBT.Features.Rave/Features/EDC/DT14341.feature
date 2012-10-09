Feature: DT14341
	As a Rave user
	I want to change data
	So I can see refired queries

# Query Issue: Edit Checks with require response and require manual close
# Open, answer and close a query, change the data and verify that the query did re-fire and verify no log
# Verify query firing between cross forms with require response and require manual close.
# Project to be uploaded in excel spreadsheet 'Edit Check Study 1'

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	#And following Study assignments exist
	#	|User		|Study		       |Role |Site		        |Site Number |
	#	|defuser	|Edit Check Study 3|cdm1 |Edit Check Site 1 |10001       |
	#	|defuser	|Edit Check Study 3|cdm1 |Edit Check Site 2 |20001       |
	#	|defuser	|Edit Check Study 3|cdm1 |Edit Check Site 3 |30001       |
	#	|defuser	|Edit Check Study 3|cdm1 |Edit Check Site 4 |40001       |
    # And role "cdm1" has Query actions
	#And Draft "Draft 3" in Study "Edit Check Study 3" has been published to CRF Version "<RANDOMNUMBER>" 
	#And CRF Version "<RANDOMNUMBER>" in Study "Edit Check Study 3" has been pushed to Site "Edit Check Site 3" in Environment "Prod"

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_9.1.1
@Draft 
Scenario: @PB_9.1.1

	And I select Study "Edit Check Study 3" and Site "EC Test Site"
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | sub               |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    | Field            | Data |
	    | Standard 1       | 6    |
	    | Log Field 1      | 5    |
	    | Log Field 2      | 2    |
	And I open the last log line
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answered"
	And I answer the Query "Required Field Checks Message" on Field "Field Edit Check" with "answered"	
	And I save the CRF page
	And I open the last log line
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I close the Query "Required Field Checks Message" on Field "Field Edit Check"


#564QueryRefiringLogic1
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_9.1.2
@Draft
Scenario: PB_9.1.2 As an EDC user, On a Cross Forms Standard form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.  
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications" Queries fired on log form, Modify standard fields to different good data, new Data results in system close of edit check on log form - queries closed by system and no log in the Database.

	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 1"	
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
@release_564_Patch12.1
@PB_9.1.3
@Draft
Scenario: PB_9.1.3 As an EDC user, On a Cross Forms - Standard form to log form, when a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.  
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications". Queries fired on log form, Modify log fields to different good data, new value results in system close of edit check on log form - queries closed by system and no log in the Database.

	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 1"	
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
@release_564_Patch12.1
@PB_9.1.4
@Draft
Scenario: PB_9.1.4 As an EDC user, On a Cross Forms - Standard form to log form, when a query has been answered and closed with the different data, then queries are not displayed. 
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications". Queries fired on log form, Modify standard fields to different good data, new value results in system close of edit check on log form and update \new value on standard fields in violation of edit check on log form- queries refires on log form and no log in the Database.
	
	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 1"
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
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_1.14.1
@Draft
Scenario: PB_1.14.1 As an EDC user, Cross Forms - Standard form to log form, when a query has been answered and closed with the different, then queries are not displayed.  
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications". Queries fired on log form, Modify log fields to different good data, new value results in system close of edit check on log form and update new value on standard fields in violation of edit check on log form- queries refires on log form and no log in the Database.
	
	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 1"
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
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_1.18.1
@Draft
Scenario: PB_1.18.1 As an EDC user, On a Cross Forms - log form to log form, when a query has not been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.  
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events". Queries fired on second log form, Modify log fields on same second log form to different good data, new value results in system close of edit check on second log form - queries closed by system on second log form and no log in the Database.

	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 1"	
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
@release_564_Patch12.1
@PB_1.19.1
@Draft
Scenario: PB_1.19.1 As an EDC user, On a Cross Forms - log form to log form, when a query has been answered and closed with the different data, then queries are not displayed. 
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events". Queries fired on second log form, Modify log fields on first log form to different good data, new value results in system close of edit check on second log form. Navigate to first log form and enter new value in violation of edit check - queries refired on second log form and no log in the Database

	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 1"	
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
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_1.20.1
@Draft
Scenario: PB_1.20.1 As an EDC user, On a Cross Forms log form to log form, when a query has not been answered and closed with the different data, then queries are not displayed.  
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events" Queries fired on second log form, Modify log fields on second log form to different good data, new value results in system close of edit check on second log form. Navigate to first log form and enter new value in violation of edit check - queries refired on second log form and no log in the Database

	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 1"	
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

#----------------------------------------------------------------------------------------------------------------------------------------
#564QueryRefiringLogic2
#----------------------------------------------------------------------------------------------------------------------------------------	
# Query Issue: Edit Checks with no require response and no require manual close. Open a query, cancel a query, change the correct data and change it back to previous data query didn't fired and verify log
	
@release_564_Patch12.1
@PB_2.5.1
@Draft
Scenario: PB_2.5.1  As an EDC user, on a Cross Forms - Standard form to log form, when a query has been auto answered and auto closed with the same data and I enter the same data that originally opened the query, then queries are not displayed. 
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications"
	
    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 2"
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
	And I select Form "Concomitant Medications"
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
	And I take a screenshot
	And I open log line 1
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |	
	And I open log line 1
	And I verify Query is not displayed
      | Field      | Query Message                                             | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                                                                                 | Answered | Closed |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 20          |
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is not displayed on Field "Start Date"
    And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I verify Query is not displayed
      | Field      | Query Message                                             | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                                                                                 | Answered | Closed |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_2.6.1
@Draft
Scenario: PB_2.6.1 As an EDC user, On a Cross Folders - Standard form to log form, when a query has been auto answered and auto closed with the same data and I enter the same data that originally opened the query, then queries are not displayed. 
#Folder "Screening" enter and save data on form "Informed Consent", Folder "Week 1" enter and save data on form "Concomitant Medications"
			  
    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 2"
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
	And I cancel the Query "'Date Informed Consent Signed' can not be greater than Start Date." on Field "Start Date"
	And I cancel the Query "'Current Distribution Number' is not equal 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I open log line 1
	And I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| Original Axis Number | 201         |
		| Current Axis Number  | 200         |	
	And I open log line 1
	And I verify Query is not displayed
      | Field      | Query Message                                                      | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' can not be greater than Start Date. | true     | true   | 
	And I verify Query is not displayed
      | Field               | Query Message                                                     | Answered | Closed |
      | Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | true     | true   |
	And I take a screenshot	
	When I enter data in CRF
		| Field                | Data        |
		| Start Date           | 09 Jan 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 99          |
	And I save the CRF page
	And I open log line 1	
	Then I verify Query with message "'Date Informed Consent Signed' can not be greater than Start Date." is not displayed on Field "Start Date"
    And I verify Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I verify Query is not displayed
      | Field      | Query Message                                                      | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' can not be greater than Start Date. | true     | true   | 
	And I verify Query is not displayed
      | Field               | Query Message                                                     | Answered | Closed |
      | Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | true     | true   |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_2.7.1
@Draft
Scenario: PB_2.7.1 As an EDC user, On a Cross Forms log - form to Standard form, when a query has been auto answered and auto closed with the same data and I enter the same data that originally opened the query, then queries are  not displayed. 
#Folder "Week 1" enter and save data on forms "Concomitant Medications" and "Informed Consent"
			  
    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 2"
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Folder "Week 1"
	And I select Form "Concomitant Medications"
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
	And I take a screenshot
	And I open log line 1
	And I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 12 Jan 2000 |
		| Current Axis Number | 100         |
	And I open log line 1
	And I verify Query is not displayed
      | Field      | Query Message                                | Answered | Closed |
      | Start Date | Start Date can not be greater than End Date. | true     | true   | 
	And I verify Query is not displayed
      | Field               | Query Message                                                                    | Answered | Closed |
      | Current Axis Number | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | true     | true   |
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 11 Jan 2000 |
		| Current Axis Number | 101         |
	And I open log line 1
	Then I verify Query with message "Start Date can not be greater than End Date." is not displayed on Field "End Date"
    And I verify Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is not displayed on Field "Current Axis Number"
	And I verify Query is not displayed
      | Field    | Query Message                                | Answered | Closed |
      | End Date | Start Date can not be greater than End Date. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                                                    | Answered | Closed |
      | Current Axis Number | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | true     | true   |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_2.8.1
@Draft
Scenario: PB_2.8.1	As and EDC user, on a Cross Forms - log form to log form, when a query has been auto answered and auto closed with the same data and I enter the same data that originally opened the query, then queries are not displayed. 
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events"
			  
    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 2"
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
    And I select Form "Concomitant Medications" in Folder "Screening"
	And I open log line 1
	And I verify Not Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Not Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Not Requires Response Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I cancel the Query "Date can not be less than." on Field "Start Date"
	And I cancel the Query "Date is Less Than Date on the first log form." on Field "End Date"
	And I cancel the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I cancel the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I open log line 1
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 11 Jan 2000 |
	    | End Date             | 09 Feb 2000 |
	    | Original Axis Number | 102         |
	    | Current Axis Number  | 65          |
	And I open log line 1
	And I verify Query is not displayed
      | Field      | Query Message              | Answered | Closed |
      | Start Date | Date can not be less than. | true     | true   |
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
	And I open log line 1
	When I enter data in CRF and save
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| End Date             | 10 Feb 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 66          |
	And I open log line 1
	Then I verify Query with message "Date can not be less than." is not displayed on Field "Start Date"
    And I verify Query with message "Date is Less Than Date on the first log form." is not displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is not displayed on Field "Original Axis Number"
    And I verify Query with message "'Duration' and 'Current Axis Number' cannot equal." is not displayed on Field "Current Axis Number"
	And I verify Query is not displayed
      | Field      | Query Message              | Answered | Closed |
      | Start Date | Date can not be less than. | false    | false  |
	And I verify Query is not displayed
      | Field    | Query Message                                 | Answered | Closed |
      | End Date | Date is Less Than Date on the first log form. | false    | false  |
	And I verify Query is not displayed
      | Field                | Query Message                                                          | Answered | Closed |
      | Original Axis Number | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. | false    | false  |
	And I verify Query is not displayed
      | Field               | Query Message                                      | Answered | Closed |
      | Current Axis Number | 'Duration' and 'Current Axis Number' cannot equal. | false    | false  |	
	And I take a screenshot

#564QueryRefiringLogic3
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12.1
@PB_3.1.1
@Draft
Scenario: PB_3.1.1 As an EDC user, On a Cross Form Standard form to log form, When a query has been answered and auto closed with the same data and I enter the same data that originally opened the query, then queries are not displayed. 
   
	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 3"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | sub               |
	 And I select Folder "Screening"
	 And I select Form "Informed Consent"
	 And I enter data in CRF
	     | Field                        | Data        |
	     | Date Informed Consent Signed | 09 Jan 2000 |
	     | End Date                     | 10 Jan 2000 |
	     | Original Distribution Number | 10          |
	     | Current Distribution Number  | 19          |
	And I save the CRF page
	And I take a screenshot
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF
	     | Field                | Data        |
	     | Start Date           | 08 Jan 2000 |
	     | End Date             | 11 Jan 2000 |
	     | Original Axis Number | 10          |
	     | Current Axis Number  | 20          |	
	And I save the CRF page
	And I open log line 1
	And I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "answered query"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "answered query"
	And I save the CRF page
	And I open log line 1
	And I verify Query is not displayed
      | Field      | Query Message                                             | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                                                                                 | Answered | Closed |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	And I take a screenshot
	And I open log line 1
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I open log line 1
	And I verify Query is not displayed
      | Field      | Query Message                                             | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | true     | true   |
	And I verify Query is not displayed
      | Field               | Query Message                                                                                                 | Answered | Closed |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
	When I enter data in CRF
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 20          |
	And I save the CRF page
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is not displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I verify Query is not displayed
      | Field      | Query Message                                             |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. |
	And I verify Query is not displayed
      | Field               | Query Message                                                                                                 |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12.1
@PB_3.1.4
@Draft
Scenario: PB_3.1.4 As an EDC user, On a Cross Form Standard form to log form, When a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are displayed. 

	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 3"
	And I select a Subject "sub{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I add a new log line
	And I enter data in CRF
		 | Field                | Data        |
		 | Start Date           | 07 Jan 2000 |
		 | End Date             | 12 Jan 2000 |
		 | Original Axis Number | 10          |
		 | Current Axis Number  | 18          |
	And I save the CRF page
	And I open log line 4
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
    And I take a screenshot
	And I cancel the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I cancel the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 4
	And I verify Field "Start Date" has no Query
	And I verify Field "Current Axis Number" has no Query
	And I click audit on Field "Start Date"
	And I verify Audits exist
		| Audit Type     | Query Message                                             |
		| Query Canceled | 'Date Informed Consent Signed' is greater. Please revise. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 4
	And I click audit on Field "Current Axis Number"
	And I verify Audits exist
		| Audit Type     | Query Message                                                                                                 |
		| Query Canceled | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 4
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I take a screenshot	
	And I open log line 4
	And I verify Query is not displayed
      | Field      | Query Message                                             | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | false    | false  |
	And I verify Query is not displayed
      | Field               | Query Message                                                                                                 | Answered | Closed |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I take a screenshot	
	When I enter data in CRF
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I save the CRF page
	And I open log line 4
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is not displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_3.2.1
@Draft
Scenario: PB_3.2.1 As an EDC user, On a Cross Folder Standard form to log form, When a query has been answered and auto closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.
	
	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 3"	
	 And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | sub               |
	 And I select Folder "Screening"
	 And I select Form "Informed Consent"
	 And I enter data in CRF
	   | Field                        | Data        |
	   | Date Informed Consent Signed | 10 Jan 2000 |
	   | End Date                     | 10 Feb 2000 |
	   | Original Distribution Number | 100         |
	   | Current Distribution Number  | 200         |
	And I save the CRF page
	And I take a screenshot
	And I select Form "Concomitant Medications" in Folder "Week 1"
	And I enter data in CRF
		| Field                | Data        |
		| Start Date           | 09 Jan 2000 |
		| End Date             | 11 Feb 2000 |
		| Original Axis Number | 100         |
		| Current Axis Number  | 99          |
	And I save the CRF page
	And I open log line 1
	And I verify Requires Response Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I open log line 1
	And I answer the Query "'Date Informed Consent Signed' can not be greater than." on Field "Start Date" with "answered query"
	And I answer the Query "'Current Distribution Number' is not equal 'Current Axis Number'." on Field "Current Axis Number" with "answered query"
	And I save the CRF page
	And I open log line 1
	And I verify Query is not displayed
      | Field      | Query Message                                           | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' can not be greater than. | false    | false  |
	And I verify Query is not displayed
      | Field               | Query Message                                                     | Answered | Closed |
      | Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | false    | false  |
	And I take a screenshot	 
	When I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 99          |
	And I save the CRF page
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' can not be greater than." is not displayed on Field "Start Date"
	And I verify Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_3.4.1
@Draft
Scenario: PB_3.4.1 As an EDC user, On a Cross Forms log form to log form, When a query has been answered and auto closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.

	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 3"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | sub               |
	And I select Folder "Screening"
	And I select Form "Concomitant Medications"
	And I enter data in CRF
	    |Field					|Data        |
	    |Start Date				|10 Jan 2000 |
	    |End Date				|10 Feb 2000 |
	    |Original Axis Number   |100         |
	    |Current Axis Number	|66          |
	And I save the CRF page
	And I take a screenshot
	And I select Form "Adverse Events" in Folder "Screening"
	And I enter data in CRF
	    |Field				|Data        |
        |Start Date			|11 Jan 2000 |
	    |End Date			|09 Feb 2000 |
	    |AE Number			|101         |
	    |Duration			|66          |
	And I save the CRF page
	And I take a screenshot
	And I select Form "Concomitant Medications"
	And I open log line 1
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Requires Response Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "Date can not be less than." on Field "Start Date" with "answered query"
	And I answer the Query "Date is Less Than Date on the first log form." on Field "End Date" with "answered query"
	And I answer the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number" with "answered query"
	And I answer the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number" with "answered query"
	And I save the CRF page
	And I take a screenshot
	And I open log line 1
	And I enter data in CRF
	  |Field					|Data        |
      |Start Date				|11 Jan 2000 |
	  |End Date					|09 Feb 2000 |
	  |Original Axis Number		|102         |
	  |Current Axis Number		|65          |	
	And I save the CRF page
	And I open log line 1
	And I verify Query is not displayed
      | Field      | Query Message              | Answered | Closed |
      | Start Date | Date can not be less than. | false    | false  |
	And I verify Query is not displayed
      | Field                       | Query Message                                 | Answered | Closed |
      | Current Distribution Number | Date is Less Than Date on the first log form. | false    | false  |
	 And I verify Query is not displayed
      | Field                | Query Message                                                          | Answered | Closed |
      | Original Axis Number | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. | false    | false  |
	And I verify Query is not displayed
      | Field               | Query Message                                      | Answered | Closed |
      | Current Axis Number | 'Duration' and 'Current Axis Number' cannot equal. | false    | false  |
	And I take a screenshot	
	When I enter data in CRF
		|Field						|Data        |
        |Start Date					|10 Jan 2000 |
	    |End Date					|10 Feb 2000 |
	    |Original Axis Number		|100         |
	    |Current Axis Number		|66          |
	And I save the CRF page
	And I open log line 1
	Then I verify Query with message "Date can not be less than." is not displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is not displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is not displayed on Field "Original Axis Number"
	And I verify Query with message "'Duration' and 'Current Axis Number' cannot equal." is not displayed on Field "Current Axis Number"
	And I take a screenshot	
	
#564QueryRefiringLogic4
#----------------------------------------------------------------------------------------------------------------------------------------
# Query Issue: Edit Checks with no require response and require manual close 
# Open a query, cancel a query, change the correct data and change it back to previous data query didn't fired and verify the log
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_4.5.1
@Draft
Scenario: PB_4.5.1 As an EDC user, Cross Forms - Standard form to log form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications"

	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"
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
	And I verify Audits exist
		| Audit Type     | Query Message                                             |
		| Query Canceled | 'Date Informed Consent Signed' is greater. Please revise. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "Current Axis Number"
	And I verify Audits exist
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
@release_564_Patch12.1
@PB_4.6.1
@Draft
Scenario: PB_4.6.1 As an EDC user, Cross Folders - Standard form to log form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Folder "Screening" enter and save data on form "Informed Consent"
#Folder "Week 1" enter and save data on form "Concomitant Medications"

	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"		  
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
	And I verify Audits exist
		| Audit Type     | Query Message                                           |
		| Query Canceled | 'Date Informed Consent Signed' can not be greater than. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "Current Axis Number"
	And I verify Audits exist
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
@release_564_Patch12.1
@PB_4.7.1
@Draft
Scenario: PB_4.7.1 As an EDC user, Cross Forms - log form to Standard form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Folder "Week 1" enter and save data on forms "Concomitant Medications" and "Informed Consent"
	
	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"	
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
	And I verify Audits exist
		| Audit Type     | Query Message                                |
		| Query Canceled | Start Date can not be greater than End Date. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "Current Axis Number"
	And I verify Audits exist
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
@release_564_Patch12.1
@PB_4.8.1
@Draft
Scenario: PB_4.8.1 As an EDC user, Cross Forms - log form to log form, when a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are not displayed.
#Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events"

	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"	  
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
	And I verify Audits exist
		| Audit Type     | Query Message              |
		| Query Canceled | Date can not be less than. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "End Date"
	And I verify Audits exist
		| Audit Type     | Query Message                                                                    |
		| Query Canceled | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "Original Axis Number"
	And I verify Audits exist
		| Audit Type     | Query Message                                                          |
		| Query Canceled | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log. |
	And I take a screenshot
	And I select link "Concomitant Medications" in "Header" 
	And I open log line 1
	And I click audit on Field "Current Axis Number"
	And I verify Audits exist
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
#Query Refiring Logic5
@release_564_Patch12.1
@PB_US12940_01C
@Draft		
Scenario: @PB_US12940_01C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and I entered good data in lab field A, if I then entered the same bad data in lab field A, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = false.
	
	And I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	| Field            | Data                                                          |
	| Subject Number   | {RndNum<num1>(5)}    |
	| Subject Initials |SUB                                                            |
    | Subject ID       | SUB {Var(num1)}                                               |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
	And I save the CRF page 
    And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|true    |true    |	
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|2		|
	And I verify Query is not displayed
      |Field		                       |Query Message  												    |Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |  
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
	Then I verify Query is not displayed
      |Field		                       |Query Message  												    |Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |  
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12.1
@PB_US12940_02A	
@Draft	
Scenario: @PB_US12940_02A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = true.
	
	And I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
	And I save the CRF page  
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T"			  
	And I save the CRF page 
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|6		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	Then I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1	
@PB_US12940_02C	
@Draft	
Scenario: @PB_US12940_02C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and I entered good data in lab field B, if I then entered the same bad data in lab field B, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = false. 
	
	And I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
	And I save the CRF page
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|true    |true    |	
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                       |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F|6	   |
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                       |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F|3	   |
	Then I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1	
@PB_US12940_03A
@Draft		
Scenario: @PB_US12940_03A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I entered good data in lab field A and then again entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = true.

	And I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|4		|	  
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered|Closed|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T"	
	And I save the CRF page  
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|2		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|4		|
    Then I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_04A
@Draft		
Scenario: @PB_US12940_04A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I entered good data in lab field B and then again entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = true.

	And I select Study "Standard Study" and Site "Site 1"
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
	And I enter data in CRF and save  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|2		|	
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered|Closed|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T" 
	And I save the CRF page
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|6		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|2		|   		
    And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_04D
@Draft		
Scenario: @PB_US12940_04D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and the query is then closed, if I entered good data in lab field B and then again entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
  	And I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|2		|  	
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered|Closed|
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|true    |false |	
	And I take a screenshot
	And I close the only Query on Field "Lab Field 8 - WBC - rr = F ; rmc = T"	
	And I save the CRF page 	  
	And I verify closed Query with message "Lab Field 8 must be greater than Lab Field 7. Please verify." is displayed on Field "Lab Field 8 - WBC - rr = F ; rmc = T"	
	And I take a screenshot
	And I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|6		| 
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|2		|    		
    And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_11B
@Draft		
Scenario: @PB_US12940_11B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = false.

	And I select Study "Standard Study" and Site "Site 1"
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 4 must be greater than Lab Field 3. Please verify." on Field "Lab Field 4 - WBC - rr = F ; rmc = F"  	  
	And I save the CRF page
	And I click audit on Field "Lab Field 4 - WBC - rr = F ; rmc = F"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 4 must be greater than Lab Field 3. Please verify.       |
	And I take a screenshot
	And I select link "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|2		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
	Then I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |	
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_11C
@Draft	
Scenario: @PB_US12940_11C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = false.

	And I select Study "Standard Study" and Site "Site 1"
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F"  
	And I save the CRF page
	And I click audit on Field "Lab Field 6 - WBC - rr = T ; rmc = F"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 6 must be greater than Lab Field 5. Please verify.       |
	And I take a screenshot
	And I select link "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|2		|
	And I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
	Then I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1	
@PB_US12940_11D	
@Draft	
Scenario: @PB_US12940_11D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = true.

	And I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 8 must be greater than Lab Field 7. Please verify." on Field "Lab Field 8 - WBC - rr = F ; rmc = T"   	  
	And I save the CRF page
	And I click audit on Field "Lab Field 8 - WBC - rr = F ; rmc = T"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 8 must be greater than Lab Field 7. Please verify.       |
	And I take a screenshot
	And I select link "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|2		|  	
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |	  
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|  
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |  		
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1	  
@PB_US12940_12A	
@Draft	
Scenario: @PB_US12940_12A
As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = true.

	And I select Study "Standard Study" and Site "Site 1"
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T"   	  
	And I save the CRF page
	And I click audit on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 2 must be greater than Lab Field 1. Please verify.       |
	And I take a screenshot
	And I select link "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|6		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		| 
	Then I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_12B
@Draft		
Scenario: @PB_US12940_12B 
As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = false.

	And I select Study "Standard Study" and Site "Site 1"
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
    And I take a screenshot
	And I cancel the Query "Lab Field 4 must be greater than Lab Field 3. Please verify." on Field "Lab Field 4 - WBC - rr = F ; rmc = F"   	  
	And I save the CRF page
	And I click audit on Field "Lab Field 4 - WBC - rr = F ; rmc = F"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 4 must be greater than Lab Field 3. Please verify.       |
	And I take a screenshot
	And I select link "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |6		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	Then I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |	
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_12C
@Draft		
Scenario: @PB_US12940_12C 
As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = false.

	And I select Study "Standard Study" and Site "Site 1"
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F"   	  
	And I save the CRF page
	And I click audit on Field "Lab Field 6 - WBC - rr = T ; rmc = F"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 6 must be greater than Lab Field 5. Please verify.       |
	And I take a screenshot
	And I select link "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                        |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F |6		|
	And I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                       |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F|3	   |
	And I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_12D
@Draft		
Scenario: @PB_US12940_12D 
As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = true.

	And I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 8 must be greater than Lab Field 7. Please verify." on Field "Lab Field 8 - WBC - rr = F ; rmc = T"   	    
	And I save the CRF page
	And I click audit on Field "Lab Field 8 - WBC - rr = F ; rmc = T"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 8 must be greater than Lab Field 7. Please verify.       |
	And I take a screenshot
	And I select link "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|6		|  
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |  
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|3		|  
	Then I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   | 	
	And I take a screenshot	


#----------------------------------------------------------------------------------------------------------------------------------------	
#564QueryRefiringLogic_LogForm_2FldEC	
@release_564_Patch12.1
@PB-US12940-01A
@Draft	
Scenario: @PB-US12940-01A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I entered good data in log field B and then again entered the same bad data in log field B as when the query was closed, then the system should not refire a query on log field B. 
Query with requires response = true and requires manual close = true.
	
	And I select Study "Standard Study" and Site "Site 1"	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB               |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	And I enter data in CRF
	  |Field		|Data   |
      |Log Field 1	|5		|
      |Log Field 2	|4		|
	When I save the CRF page
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  |  
	And I take a screenshot
	When I answer the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2" with "Data will be changed."
	And I enter data in CRF	  
      | Field       | Data |
      | Log Field 2 | 3    |		  
	And I save the CRF page  
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | True     | False  |
	And I take a screenshot 	  
	When I close the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2"
	And I save the CRF page 
	And I open log line 1	  
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | True     | True   |
	And I take a screenshot 	  
	When I enter data in CRF
       | Field       | Data |
       | Log Field 2 | 5    |	   
	And I save the CRF page
	And I open log line 1
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered  | Closed  |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False     | False   |
	And I take a screenshot	
	When I enter data in CRF
      | Field       | Data |
      | Log Field 2 | 3    |
	And I save the CRF page	  
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed  |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False     | False  |	
	And I take a screenshot 

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB-US12940-01D
@Draft 
Scenario: @PB-US12940-01D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I entered good data in log field B and then again entered the same bad data in log field B as when the query was closed, then the system should not refire a query on log field B. 
Query with requires response = false and requires manual close = true
	
	And I select Study "Standard Study" and Site "Site 1"	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9001D          |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |  
      | Log Field 7 | 5    |
      | Log Field 8 | 4    |
	And I save the CRF page 
	And I open log line 1		  
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  |
	And I take a screenshot 	  
	When I enter data in CRF	  
      | Field       | Data |
      | Log Field 8 | 3    |		  
	And I save the CRF page 
	And I open log line 1 
	Then I verify Query is displayed
      | Field       | Message                                                  | Answered | Closed |
      | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | False  |
	And I take a screenshot 		  
	When I close the Query "Log field 8 must be equal to Log field 7. Please verify." on Field "Log Field 8"
	And I save the CRF page 
	And I open log line 1 	  
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | True   |	  
	And I take a screenshot 
	When I enter data in CRF	  
      | Field       | Data |
      | Log Field 8 | 5    |	 
	And I save the CRF page 
	And I open log line 1 	
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  | 
	And I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | True   | 
	And I take a screenshot 	  
	When I enter data in CRF	  
      | Field       | Data |
      | Log Field 8 | 3    |	 
	And I save the CRF page 
	And I open log line 1 
	Then I verify Query is displayed  
      | Field       | Message                                                  | Answered | Closed |
      | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | True   |	 	 	  
	And I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  | 
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
#564QueryRefiringLogic_StdForm_1FldEC
@release_564_Patch12.1
@PB_US12940_01A
@Draft		
Scenario: PB_US12940_01A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and the query is then closed, and I entered good data in field A, if I then entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = true and requires manual close = true.
	
	And I select Study "Standard Study" and Site "Site 1"
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1" with "Data will be changed."
	And I save the CRF page	  
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page
	Then I verify closed Query with message "Data will be changed." is displayed on Field "Age 1"
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 1		|20		|
	And I take a screenshot	  		  
	And I enter data in CRF and save
      |Field		|Data   |
      |Age 1		|17		|
	And I take a screenshot
	And I verify Query is displayed
	| Field | Query Message                                                                        | Closed | Answered |
	| Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_01C
@Draft		
Scenario: PB_US12940_01C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and I entered good data in field A, if I then entered the same bad data in field A, then the system should not refire a query on field A. Query with requires response = true and requires manual close = false.
   
   And I select Study "Standard Study" and Site "Site 1"	
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot		  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I save the CRF page	  
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data    	|
      |Age 3		|20			|
	And I take a screenshot		  		  
	And I enter data in CRF and save
      |Field		|Data   |
      |Age 3		|17		|
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | false    |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_04A	
@Draft	
Scenario: PB_US12940_04A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = true and requires manual close = true
	
	And I select Study "Standard Study" and Site "Site 1"	
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
    When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1" with "Data will be changed."
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 1		|71		|
	And I verify Query is displayed
     | Field | Query Message                                                                        | Closed | Answered |
     | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | true     |
	And I take a screenshot
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page
	And I verify Query is displayed
     | Field | Query Message                                                                        | Closed | Answered |
     | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 20   |
	And I verify Query is displayed
     | Field | Query Message                                                                        | Closed | Answered |
     | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 71   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_04D	
@Draft	
Scenario: PB_US12940_04D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = false and requires manual close = true
    
	And I select Study "Standard Study" and Site "Site 1"	
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 71   |	  
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | true     |	
	And I take a screenshot
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page	
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 20   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |	
	And I take a screenshot 
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 71   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_07A	
@Draft	
Scenario: PB_US12940_07A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = true and requires manual close = true
	
	And I select Study "Standard Study" and Site "Site 1"	
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page		  
	And I click audit on Field "Age 1"
	And I take a screenshot	  
	And I verify Audits exist
	| Audit Type     | Query Message                                                                        |
	| Query Canceled | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I select link "Form 1" in "Header"
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 20   |
	And I verify Query is not displayed
      | Field | Query Message                                                                        | Closed | Answered |
      | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 17   |
	And I verify Query is not displayed
      | Field | Query Message                                                                        | Closed | Answered |
      | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_07B	
@Draft	
Scenario: PB_US12940_07B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = false and requires manual close = false
	
	And I select Study "Standard Study" and Site "Site 1"	
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 2"
	And I save the CRF page		  
	And I click audit on Field "Age 2"
	And I take a screenshot	  
	And I verify Audits exist
	| Audit Type     | Query Message                                                                        |
	| Query Canceled | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I select link "Form 1" in "Header"	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 20   |
	And I verify Query is not displayed
      | Field | Query Message                                                                        | Closed | Answered |
      | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |	 	  
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 17   |
	And I verify Query is not displayed
      | Field | Query Message                                                                        | Closed | Answered |
      | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot	
	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_07C	
@Draft	
Scenario: PB_US12940_07C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = true and requires manual close = false
	
	And I select Study "Standard Study" and Site "Site 1"	
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3"
	And I save the CRF page		  
	And I click audit on Field "Age 3"
	And I take a screenshot	  
	And I verify Audits exist
	| Audit Type     | Query Message                                                                        |
	| Query Canceled | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I select link "Form 1" in "Header"  
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 20   |
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |	  
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 17   |
   	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch12.1
@PB_US12940_07D
@Draft		
Scenario: PB_US12940_07D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = false and requires manual close = true
	
	And I select Study "Standard Study" and Site "Site 1"	
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page		  
	And I click audit on Field "Age 4"
	And I take a screenshot	  
	And I verify Audits exist
	| Audit Type     | Query Message                                                                        |
	| Query Canceled | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I select link "Form 1" in "Header"  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 20   |
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |		  
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 17   |	  
   	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------	
