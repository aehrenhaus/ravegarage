Feature: 4
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
@Passed
@Web
Scenario: PB_4.1.1 On a Cross Forms Standard form to log form, when a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.

    Given I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | SUB	                                                        |
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
	And I take a screenshot

	# Given closed Query with message "" exists on Field "Start Date" in Form "Concomitant Medications" in Folder "Screening" in Subject "SUB301" in Site "Edit Check Site 3" in Study "Edit Check Study 3"

	And I open log line 1
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 20          |
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.1.2
@Draft
@Web
Scenario: PB_4.1.2

	When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName                               | MarkingGroupName | QueryMessage                                                                                                  | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub401      | Screening               | Concomitant Medications         | 1                         | Start Date           | 08 Jan 2000          | Screening                | Concomitant Medications          | 1                          | Start Date          | 08 Jan 2000      | *Greater Than Open Query Log Cross Form     | Marking Group 1  | 'Date Informed Consent Signed' is greater. Please revise.                                                     | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub401      | Screening               | Concomitant Medications         | 1                         | Current Axis Number  | 20                   | Screening                | Concomitant Medications          | 1                          | Current Axis Number | 20               | *Is Not Equal to Open Query Log Cross Form* | Site             | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | {DateTime} |
	And I take a screenshot
  
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.1.3
@Passed
@Web
Scenario: PB_4.1.3

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"
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
	And I take a screenshot
	And I open log line 2	
	
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
@PB_4.1.4
@Draft
@Web
Scenario: PB_4.1.4
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName                               | MarkingGroupName | QueryMessage                                                                                                  | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub401      | Screening               | Concomitant Medications         | 2                         | Start Date           | 07 Jan 2000          | Screening                | Concomitant Medications          | 2                          | Start Date          | 07 Jan 2000      | *Greater Than Open Query Log Cross Form     | Marking Group 1  | 'Date Informed Consent Signed' is greater. Please revise.                                                     | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub401      | Screening               | Concomitant Medications         | 2                         | Current Axis Number  | 18                   | Screening                | Concomitant Medications          | 2                          | Current Axis Number | 18               | *Is Not Equal to Open Query Log Cross Form* | Site             | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | {DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.2.1
@Passed
@Web
Scenario: PB_4.2.1 On a Cross Folders Standard form to log form, Folder "Screening" enter and save data on form "Informed Consent" , Folder "Week 1" enter and save data on form "Concomitant Medications"

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"			  
    And I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | SUB                                                            |
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
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.2.2
@Draft
@Web
Scenario: PB_4.2.2
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName                            | MarkingGroupName | QueryMessage                                                      | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub402      | Week 1                  | Concomitant Medications         | 1                         | Start Date           | 09 Jan 2000          | Week 1                   | Concomitant Medications          | 1                          | Start Date          | 09 Jan 2000      | *Greater Than Open Query Cross Folder    | Marking Group 1  | 'Date Informed Consent Signed' can not be greater than.'          | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub402      | Week 1                  | Concomitant Medications         | 1                         | Current Axis Number  | 99                   | Week 1                   | Concomitant Medications          | 1                          | Current Axis Number | 99               | *Is Not Equal to Open Query Cross Folder | Marking Group 1  | 'Current Distribution Number' is not equal 'Current Axis Number'. | {DateTime} |
	And I take a screenshot
    
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.2.3
@Passed
@Web
Scenario: PB_4.2.3
	
	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"
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
	And I take a screenshot
	
	And I open log line 2
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
@PB_4.2.4
@Draft
@Web
Scenario: PB_4.2.4
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName                            | MarkingGroupName | QueryMessage                                                      | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub402      | Week 1                  | Concomitant Medications         | 2                         | Start Date           | 08 Jan 2000          | Week 1                   | Concomitant Medications          | 2                          | Start Date          | 08 Jan 2000      | *Greater Than Open Query Cross Folder    | Marking Group 1  | 'Date Informed Consent Signed' can not be greater than.'          | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub402      | Week 1                  | Concomitant Medications         | 2                         | Current Axis Number  | 98                   | Week 1                   | Concomitant Medications          | 2                          | Current Axis Number | 98               | *Is Not Equal to Open Query Cross Folder | Marking Group 1  | 'Current Distribution Number' is not equal 'Current Axis Number'. | {DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.3.1
@Passed
@Web
Scenario: PB_4.3.1 Verifies query firing between cross forms in opposite direction with no require response and require manual close.
Cross Forms: log form to Standard form 
Folder "Week 1" enter and save data on forms "Concomitant Medications" and "Informed Consent"

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"			  
    And I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | SUB                                                            |
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
	And I take a screenshot

	And I open log line 1	
	When I enter data in CRF and save
		| Field               | Data        |
		| End Date            | 11 Jan 2000 |
		| Current Axis Number | 101         |
	And I open log line 1
	Then I verify Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify Query with message "'Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.3.2
@Draft
@Web
Scenario: PB_4.3.2
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName               | MarkingGroupName | QueryMessage                                                                     | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub403      | Week 1                  | Concomitant Medications         | 1                         | End Date             | 11 Jan 2000          | Week 1                   | Concomitant Medications          | 1                          | End Date            | 11 Jan 2000      | *Greater Than Log same form | Marking Group 1  | Start Date can not be greater than End Date.                                     | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub403      | Week 1                  | Concomitant Medications         | 1                         | Current Axis Number  | 101                  | Week 1                   | Concomitant Medications          | 1                          | Current Axis Number | 101              | *Is Less Than Log same form | Marking Group 1  | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | {DateTime} |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.3.3
@Passed
@Web
Scenario: PB_4.3.3
	
	Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"
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
	And I take a screenshot

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
@PB_4.3.4
@Draft
@Web
Scenario: PB_4.3.4
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName               | MarkingGroupName | QueryMessage                                                                     | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub403      | Week 1                  | Concomitant Medications         | 2                         | End Date             | 14 Feb 2000          | Week 1                   | Concomitant Medications          | 2                          | End Date            | 14 Feb 2000      | *Greater Than Log same form | Marking Group 1  | Start Date can not be greater than End Date.                                     | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub403      | Week 1                  | Concomitant Medications         | 2                         | Current Axis Number  | 2000                 | Week 1                   | Concomitant Medications          | 2                          | Current Axis Number | 2000             | *Is Less Than Log same form | Marking Group 1  | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | {DateTime} |
	And I take a screenshot
   
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.3.5
@Passed
@Web
Scenario: PB_4.3.5

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"
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
	And I cancel the Query "'Date Informed Consent Signed' is not equal to Current Date" on Field "End Date"
	And I cancel the Query "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." on Field "Current Distribution Number"
	And I save the CRF page
	And I take a screenshot
	
	When I enter data in CRF and save
	    | Field                       | Data        |
	    | End Date                    | 11 Jan 2000 |
	    | Current Distribution Number | 101         |
	Then I verify Query with message "'Date Informed Consent Signed' is not equal to Current Date" is displayed on Field "End Date"
	And I verify Query with message "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." is displayed on Field "Current Distribution Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.3.6
@Draft
@Web
Scenario: PB_4.3.6

    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName        | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName            | TriggerFieldData | EditCheckName                                      | MarkingGroupName | QueryMessage                                                                           | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub403      | Week 1                  | Informed Consent                | 0                         | End Date                    | 11 Jan 2000          | Week 1                   | Informed Consent                 | 0                          | End Date                    | 11 Jan 2000      | *Greater Than or Equal To Open Query Log same form | Marking Group 1  | 'Date Informed Consent Signed' is not equal to Current Date                            | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub403      | Week 1                  | Informed Consent                | 0                         | Current Distribution Number | 101                  | Week 1                   | Informed Consent                 | 0                          | Current Distribution Number | 101              | *Is Not Equal To Open Query Log Same form          | Marking Group 1  | 'Original Distribution Number' and 'Current Distribution Number' fields are not equal. | {DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.4.1
@Passed
@Web
Scenario: PB_4.4.1 Verifies query firing between cross forms in opposite direction in different folder with no require response and require manual close.
Cross Forms: log form to log form 
Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events"

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"			  
    And I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | SUB                                                            |
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
	And I take a screenshot

	And I open log line 1	
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
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.4.2
@Draft
@Web
Scenario: PB_4.4.2
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName     | TriggerFieldData | EditCheckName                                          | MarkingGroupName | QueryMessage                                                                     | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub404      | Screening               | Concomitant Medications         | 1                         | Start Date           | 10 Jan 2000          | Screening                | Concomitant Medications          | 1                          | Start Date           | 10 Jan 2000      | *Is Less Than To Open Query Log Cross Form             | Marking Group 1  | Date can not be less than.                                                       | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub404      | Screening               | Concomitant Medications         | 1                         | End Date             | 10 Feb 2000          | Screening                | Concomitant Medications          | 1                          | End Date             | 10 Feb 2000      | *Is Less Than Open Query Log Cross Form                | Marking Group 1  | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub404      | Screening               | Concomitant Medications         | 1                         | Original Axis Number | 100                  | Screening                | Concomitant Medications          | 1                          | Original Axis Number | 100              | *Is Greater Than or Equal To Open Query Log Cross Form | Marking Group 1  | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log.           | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub404      | Screening               | Concomitant Medications         | 1                         | Current Axis Number  | 66                   | Screening                | Concomitant Medications          | 1                          | Current Axis Number  | 66               | *Is Not Equal To Open Query Log Cross Form             | Marking Group 1  | 'Duration' and 'Current Axis Number' cannot equal.                               | {DateTime} |
	And I take a screenshot
   
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.4.3
@Passed
@Web
Scenario: PB_4.4.3

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"
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
	And I take a screenshot

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
@release_564_Patch11
@PB_4.4.4
@Draft
@Web
Scenario: PB_4.4.4
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName     | TriggerFieldData | EditCheckName                                          | MarkingGroupName | QueryMessage                                                                     | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub404      | Screening               | Concomitant Medications         | 2                         | Start Date           | 10 Feb 2000          | Screening                | Concomitant Medications          | 2                          | Start Date           | 10 Feb 2000      | *Is Less Than To Open Query Log Cross Form             | Marking Group 1  | Date can not be less than.                                                       | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub404      | Screening               | Concomitant Medications         | 2                         | End Date             | 10 Mar 2000          | Screening                | Concomitant Medications          | 2                          | End Date             | 10 Mar 2000      | *Is Less Than Open Query Log Cross Form                | Marking Group 1  | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub404      | Screening               | Concomitant Medications         | 2                         | Original Axis Number | 200                  | Screening                | Concomitant Medications          | 2                          | Original Axis Number | 200              | *Is Greater Than or Equal To Open Query Log Cross Form | Marking Group 1  | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log.           | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub404      | Screening               | Concomitant Medications         | 2                         | Current Axis Number  | 77                   | Screening                | Concomitant Medications          | 2                          | Current Axis Number  | 77               | *Is Not Equal To Open Query Log Cross Form             | Marking Group 1  | 'Duration' and 'Current Axis Number' cannot equal.                               | {DateTime} |
	And I take a screenshot
	
# Query Issue: Edit Checks with no require response and require manual close 
# Open a query, cancel a query, change the correct data and change it back to previous data query didn't fired and verify the log

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.5.1
@Draft
@Web
Scenario: PB_4.5.1
Cross Forms: Standard form to log form
Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications"

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"	
    And I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | SUB                                                            |
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
	And I take a screenshot
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
@Draft
@Web
Scenario: PB_4.5.2
	
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName                               | MarkingGroupName | QueryMessage                                                                                                  | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub405      | Screening               | Concomitant Medications         | 1                         | Start Date           | 08 Jan 2000          | Screening                | Concomitant Medications          | 1                          | Start Date          | 08 Jan 2000      | *Greater Than Open Query Log Cross Form     | Marking Group 1  | 'Date Informed Consent Signed' is greater. Please revise.                                                     | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub405      | Screening               | Concomitant Medications         | 1                         | Current Axis Number  | 20                   | Screening                | Concomitant Medications          | 1                          | Current Axis Number | 20               | *Is Not Equal to Open Query Log Cross Form* | Site             | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | {DateTime} |
	And I take a screenshot
    
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.5.3
@Draft
@Web
Scenario: PB_4.5.3

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"
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
	And I take a screenshot
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
@PB_4.5.4
@Draft
@Web
Scenario: PB_4.5.4
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName                               | MarkingGroupName | QueryMessage                                                                                                  | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub405      | Screening               | Concomitant Medications         | 2                         | Start Date           | 07 Jan 2000          | Screening                | Concomitant Medications          | 2                          | Start Date          | 07 Jan 2000      | *Greater Than Open Query Log Cross Form     | Marking Group 1  | 'Date Informed Consent Signed' is greater. Please revise.                                                     | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub405      | Screening               | Concomitant Medications         | 2                         | Current Axis Number  | 18                   | Screening                | Concomitant Medications          | 2                          | Current Axis Number | 18               | *Is Not Equal to Open Query Log Cross Form* | Site             | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | {DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.6.1
@Draft
@Web
Scenario: PB_4.6.1
Cross Folders: Standard form to log form
Folder "Screening" enter and save data on form "Informed Consent"
Folder "Week 1" enter and save data on form "Concomitant Medications"

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"			  
    And I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | SUB                                                            |
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
	And I take a screenshot
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
@Draft
@Web
Scenario: PB_4.6.2
	
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName                            | MarkingGroupName | QueryMessage                                                      | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub406      | Week 1                  | Concomitant Medications         | 1                         | Start Date           | 09 Jan 2000          | Week 1                   | Concomitant Medications          | 1                          | Start Date          | 09 Jan 2000      | *Greater Than Open Query Cross Folder    | Marking Group 1  | 'Date Informed Consent Signed' can not be greater than.           | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub406      | Week 1                  | Concomitant Medications         | 1                         | Current Axis Number  | 99                   | Week 1                   | Concomitant Medications          | 1                          | Current Axis Number | 99               | *Is Not Equal to Open Query Cross Folder | Marking Group 1  | 'Current Distribution Number' is not equal 'Current Axis Number'. | {DateTime} |
	And I take a screenshot
    
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.6.3
@Draft
@Web
Scenario: PB_4.6.3

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"
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
@PB_4.6.4
@Draft
@Web
Scenario: PB_4.6.4
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName                            | MarkingGroupName | QueryMessage                                                      | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub406      | Week 1                  | Concomitant Medications         | 2                         | Start Date           | 08 Jan 2000          | Week 1                   | Concomitant Medications          | 2                          | Start Date          | 08 Jan 2000      | *Greater Than Open Query Cross Folder    | Marking Group 1  | 'Date Informed Consent Signed' can not be greater than.           | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub406      | Week 1                  | Concomitant Medications         | 2                         | Current Axis Number  | 98                   | Week 1                   | Concomitant Medications          | 2                          | Current Axis Number | 98               | *Is Not Equal to Open Query Cross Folder | Marking Group 1  | 'Current Distribution Number' is not equal 'Current Axis Number'. | {DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_4.7.1
@Draft
@Web
Scenario: PB_4.7.1 Verifies query firing between cross forms in opposite direction with no require response and require manual close.
Cross Forms: log form to Standard form 
Folder "Week 1" enter and save data on forms "Concomitant Medications" and "Informed Consent"

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"			  
    And I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | SUB                                                            |
	And I select Form "Concomitant Medications" in Folder "Week 1"
	And I enter data in CRF and save
	    | Field                | Data        |
	    | Start Date           | 12 Jan 2000 |
	    | End Date             | 11 Jan 2000 |
	    | Original Axis Number | 100         |
	    | Current Axis Number  | 101         |
	And I open log line 1
	And I verify Not Requires Response Query with message "Start Date can not be greater than End Date." is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I cancel the Query "Start Date can not be greater than End Date." on Field "End Date"
	And I cancel the Query "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
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
	And I verify Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is not displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.7.2
@Draft
@Web
Scenario: PB_4.7.2

    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName               | MarkingGroupName | QueryMessage                                                                    | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub407      | Week 1                  | Concomitant Medications         | 1                         | End Date             | 11 Jan 2000          | Week 1                   | Concomitant Medications          | 1                          | End Date            | 11 Jan 2000      | *Greater Than Log same form | Marking Group 1  | Start Date can not be greater than End Date.                                    | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub407      | Week 1                  | Concomitant Medications         | 1                         | Current Axis Number  | 101                  | Week 1                   | Concomitant Medications          | 1                          | Current Axis Number | 101              | *Is Less Than Log same form | Marking Group 1  | Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | {DateTime} |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.7.3
@Draft
@Web
Scenario: PB_4.7.3

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"
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
	And I verify Not Requires Response Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I enter data in CRF
		| Field               | Data        |
		| End Date            | 15 Feb 2000 |
		| Current Axis Number | 1999        |
	And I cancel the Query "Start Date can not be greater than End Date." on Field "End Date"
	And I cancel the Query "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
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
	And I verify Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.7.4
@Draft
@Web
Scenario: PB_4.7.4
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName    | TriggerFieldData | EditCheckName               | MarkingGroupName | QueryMessage                                                                    | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub407      | Week 1                  | Concomitant Medications         | 2                         | End Date             | 14 Feb 2000          | Week 1                   | Concomitant Medications          | 2                          | End Date            | 14 Feb 2000      | *Greater Than Log same form | Marking Group 1  | Start Date can not be greater than End Date.                                    | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub407      | Week 1                  | Concomitant Medications         | 2                         | Current Axis Number  | 2000                 | Week 1                   | Concomitant Medications          | 2                          | Current Axis Number | 2000             | *Is Less Than Log same form | Marking Group 1  | Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | {DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.7.5
@Draft
@Web
Scenario: PB_4.7.5  
 
    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"
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
@PB_4.7.6
@Draft
@Web
Scenario: PB_4.7.6

    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName        | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName            | TriggerFieldData | EditCheckName                                      | MarkingGroupName | QueryMessage                                                                           | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub407      | Week 1                  | Informed Consent                | 0                         | End Date                    | 11 Jan 2000          | Week 1                   | Informed Consent                 | 0                          | End Date                    | 11 Jan 2000      | *Greater Than or Equal To Open Query Log same form | Marking Group 1  | 'Date Informed Consent Signed' is not equal to Current Date.                           | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub407      | Week 1                  | Informed Consent                | 0                         | Current Distribution Number | 101                  | Week 1                   | Informed Consent                 | 0                          | Current Distribution Number | 101              | *Is Not Equal To Open Query Log Same form          | Marking Group 1  | 'Original Distribution Number' and 'Current Distribution Number' fields are not equal. | {DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_4.8.1
@Draft
@Web
Scenario: PB_4.8.1 Verifies query firing between cross forms in opposite direction in different folder with no require response and require manual close.
Cross Forms: log form to log form 
Folder "Screening" enter and save data on forms "Concomitant Medications" and "Adverse Events"

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"			  
    And I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | SUB                                                            |
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
	And I verify Not Requires Response Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "End Date"
	And I verify Not Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Not Requires Response Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"		
	And I take a screenshot
	And I cancel the Query "Date can not be less than." on Field "Start Date"
	And I cancel the Query "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "End Date"
	And I cancel the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I cancel the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 1
	And I take a screenshot
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
	And I verify Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is not displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is not displayed on Field "Original Axis Number"
	And I verify Query with message "'Duration' and 'Current Axis Number' cannot equal." is not displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.8.2
@Draft
@Web
Scenario: PB_4.8.2
	
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName     | TriggerFieldData | EditCheckName                                          | MarkingGroupName | QueryMessage                                                                    | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub408      | Screening               | Concomitant Medications         | 1                         | Start Date           | 10 Jan 2000          | Screening                | Concomitant Medications          | 1                          | Start Date           | 10 Jan 2000      | *Is Less Than To Open Query Log Cross Form             | Marking Group 1  | Date can not be less than.                                                      | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub408      | Screening               | Concomitant Medications         | 1                         | End Date             | 10 Feb 2000          | Screening                | Concomitant Medications          | 1                          | End Date             | 10 Feb 2000      | *Is Less Than Open Query Log Cross Form                | Marking Group 1  | Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub408      | Screening               | Concomitant Medications         | 1                         | Original Axis Number | 100                  | Screening                | Concomitant Medications          | 1                          | Original Axis Number | 100              | *Is Greater Than or Equal To Open Query Log Cross Form | Marking Group 1  | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log.          | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub408      | Screening               | Concomitant Medications         | 1                         | Current Axis Number  | 66                   | Screening                | Concomitant Medications          | 1                          | Current Axis Number  | 66               | *Is Not Equal To Open Query Log Cross Form             | Marking Group 1  | 'Duration' and 'Current Axis Number' cannot equal.                              | {DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.8.3
@Draft
@Web
Scenario: PB_4.8.3

    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 4"
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
	And I verify Not Requires Response Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "End Date"
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
	And I cancel the Query "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." on Field "End Date"
	And I cancel the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I cancel the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
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
	And I verify Query with message "Original Axis Number' is Less Than 'Current Axis Number' on first Number field." is displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_4.8.4
@Draft
@Web
Scenario: PB_4.8.4
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      | ProjectName        | SiteNumber | SiteName          | Environment | SubjectName | CheckActionInstanceName | CheckActionInstanceDataPageName | CheckActionRecordPosition | CheckActionFieldName | CheckActionFieldData | TriggerFieldInstanceName | TriggerFieldInstanceDatapageName | TriggerFieldRecordPosition | TriggerFieldName     | TriggerFieldData | EditCheckName                                          | MarkingGroupName | QueryMessage                                                                    | EventTime  |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub408      | Screening               | Concomitant Medications         | 2                         | Start Date           | 10 Feb 2000          | Screening                | Concomitant Medications          | 2                          | Start Date           | 10 Feb 2000      | *Is Less Than To Open Query Log Cross Form             | Marking Group 1  | Date can not be less than.                                                      | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub408      | Screening               | Concomitant Medications         | 2                         | End Date             | 10 Mar 2000          | Screening                | Concomitant Medications          | 2                          | End Date             | 10 Mar 2000      | *Is Less Than Open Query Log Cross Form                | Marking Group 1  | Original Axis Number' is Less Than 'Current Axis Number' on first Number field. | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub408      | Screening               | Concomitant Medications         | 2                         | Original Axis Number | 200                  | Screening                | Concomitant Medications          | 2                          | Original Axis Number | 200              | *Is Greater Than or Equal To Open Query Log Cross Form | Marking Group 1  | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log.          | {DateTime} |
      | Edit Check Study 3 | 40001      | Edit Check Site 4 | PROD        | sub408      | Screening               | Concomitant Medications         | 2                         | Current Axis Number  | 77                   | Screening                | Concomitant Medications          | 2                          | Current Axis Number  | 77               | *Is Not Equal To Open Query Log Cross Form             | Marking Group 1  | 'Duration' and 'Current Axis Number' cannot equal.                              | {DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	