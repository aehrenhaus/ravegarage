@ignore
Feature: 564QueryRefiringLogic3 Edit Checks refire with require response and no require manual close.
	As a Rave user
	I want to change data
	So I can see refired queries

# Query Issue: Edit Checks with require response and no require manual close
# Open a query and answer a query, change the correct data closes the query automatically and change it back to previous data query did refires and verify there is no log
# Verifies query firing between cross forms with require response and no require manual close.
# Project to be uploaded in excel spreadsheet 'Edit Check Study 3'

Background:
 	Given xml draft "Edit_Check_Study_3_Draft_3.xml" is Uploaded
	Given Site "Edit Check Site 3" exists
	Given study "Edit Check Study 3" is assigned to Site "Edit Check Site 3"
	Given I publish and push eCRF "Edit_Check_Study_3_Draft_3.xml" to "Version 1"
	Given following Project assignments exist
		| User         | Project            | Environment | Role            | Site              | SecurityRole          |
		| SUPER USER 1 | Edit Check Study 3 | Live: Prod  | Edit Check Role | Edit Check Site 3 | Project Admin Default |

    #Given I login to Rave with user "defuser" and password "password"
	#And following Study assignments exist
	#	|User		|Study		       	|Role |Site		        	|Site Number|
	#	|editcheck  |Edit Check Study 3	|CDM1 |Edit Check Site 3	|30001      |
    #And Role "cdm1" has Action "Query"
	#And Study "Edit Check Study 3" has Draft "Draft 1" includes Edit Checks from the table below
	#	| Edit Check                                             | Folder    | Form                    | Field                       | Query Message                                                                                                 |
	#	| *Greater Than Log same form                            | Week 1    | Concomitant Medications | End Date                    | Start Date can not be greater than End Date.                                                                  |
	#	| *Greater Than Open Query Cross Folder                  | Week 1    | Concomitant Medications | Start Date                  | 'Date Informed Consent Signed' can not be greater than.                                                       |
	#	| *Greater Than Open Query Log Cross Form                | Screening | Concomitant Medications | Start Date                  | 'Date Informed Consent Signed' is greater. Please revise.                                                     |
	#	| *Is Greater Than or Equal To Open Query Log Cross Form | Screening | Concomitant Medications | Original Axis Number        | 'AE Number' is greater than or Equal to 'Original Axis Number' on Log.                                        |
	#	| *Is Less Than Log same form                            | Week 1    | Concomitant Medications | Current Axis Number         | 'Original Axis Number' is Less Than 'Current Axis Number' on first Number field.                              |
	#	| *Is Less Than Open Query Log Cross Form                | Screening | Concomitant Medications | End Date                    | Date is Less Than Date on the first log form.                                                                 |
	#	| *Is Less Than To Open Query Log Cross Form             | Screening | Concomitant Medications | Start Date                  | Date can not be less than.                                                                                    |
	#	| *Is Not Equal to Open Query Cross Folder               | Week 1    | Concomitant Medications | Current Axis Number         | 'Current Distribution Number' is not equal 'Current Axis Number'.                                             |
	#	| *Is Not Equal To Open Query Log Cross Form             | Screening | Concomitant Medications | Current Axis Number         | 'Duration' and 'Current Axis Number' cannot equal.                                                            |
	#	| *Is Not Equal to Open Query Log Cross Form*            | Screening | Concomitant Medications | Current Axis Number         | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |
	#	| *Is Not Equal To Open Query Log Same form              | Week 1    | Informed Consent        | Current Distribution Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |
	#	| *Greater Than or Equal To Open Query Log same form     | Week 1    | Informed Consent        | End Date                    | 'Date Informed Consent Signed' is not equal to 'Current Date'.                                                |
	#And Draft "Draft 3" in Study "Edit Check Study 3" has been published to CRF Version "<RANDOMNUMBER>" 
	#And CRF Version "<RANDOMNUMBER>" in Study "Edit Check Study 3" has been pushed to Site "Edit Check Site 3" in Environment "Prod"
	#And I select Study "Edit Check Study 3" and Site "Edit Check Site 3"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.1
@Validation
Scenario: PB_3.1.1 As an EDC user, On a Cross Form Standard form to log form, When a query has been answered and auto closed with the same data and I enter the same data that originally opened the query, then queries are not displayed. 
   
	Given I login to Rave with user "SUPER USER 1"
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
@release_564_Patch11
@PB_3.1.2
@Validation
Scenario: PB_3.1.2 As an EDC user, On a Cross Form Standard form to log form, When a query has been answered and auto closed with the different data and I enter the same data that originally opened the query, then queries are displayed. 

	Given I login to Rave with user "SUPER USER 1"
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
	And I open log line 2
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
    And I take a screenshot
	And I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "answered query"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "answered query"
	And I save the CRF page
	And I take a screenshot	
	And I open log line 2
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
		| Current Axis Number | 20          |
	And I save the CRF page
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
@PB_3.1.3
@Validation
Scenario: PB_3.1.3 As an EDC user, On a Cross Form Standard form to log form, When a query has been canceled with the different data and I enter the same data that originally opened the query, then queries are displayed. 

	Given I login to Rave with user "SUPER USER 1"
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
	And I open log line 3
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
    And I take a screenshot
	And I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I cancel the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I cancel the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot	
	And I open log line 3
	And I verify Query is not displayed
      | Field      | Query Message                                             | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' is greater. Please revise. | false    | false  |
	And I verify Query is not displayed
      | Field               | Query Message                                                                                                 | Answered | Closed |
      | Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                             |
		| Query Canceled | 'Date Informed Consent Signed' is greater. Please revise. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 3
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                                                                 |
		| Query Canceled | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 3
	When I enter data in CRF
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 20          |
	And I save the CRF page
	And I open log line 3
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.4
@Validation
Scenario: PB_3.1.4 As an EDC user, On a Cross Form Standard form to log form, When a query has been canceled with the same data and I enter the same data that originally opened the query, then queries are displayed. 

	Given I login to Rave with user "SUPER USER 1"
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
	And I verify last audit exist
		| Audit Type     | Query Message                                             |
		| Query Canceled | 'Date Informed Consent Signed' is greater. Please revise. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 4
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
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
@release_564_Patch11
@PB_3.2.1
@Validation
Scenario: PB_3.2.1 As an EDC user, On a Cross Folder Standard form to log form, When a query has been answered and auto closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.
		
	Given I login to Rave with user "SUPER USER 1"
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
@release_564_Patch11
@PB_3.2.2
@Validation
Scenario: PB_3.2.2 As an EDC user, On a Cross Folder Standard form to log form, When a query has been answered and auto closed with the different data and I enter the same data that originally opened the query, then queries are displayed.
	
	Given I login to Rave with user "SUPER USER 1"
	And I select a Subject "sub{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Week 1"
	And I add a new log line
	And I enter data in CRF
	    | Field                | Data        |
	    | Start Date           | 08 Jan 2000 |
	    | End Date             | 12 Feb 2000 |
	    | Original Axis Number | 100         |
	    | Current Axis Number  | 98          |	
	And I save the CRF page
	And I open log line 2
	And I verify Requires Response Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot	
	And I enter data in CRF
		| Field                | Data        |
		| Start Date           | 10 Jan 2000 |
		| Original Axis Number | 201         |
		| Current Axis Number  | 200         |
	And I answer the Query "'Date Informed Consent Signed' can not be greater than." on Field "Start Date" with "answered query"
	And I answer the Query "'Current Distribution Number' is not equal 'Current Axis Number'." on Field "Current Axis Number" with "answered query"
	And I save the CRF page
	And I take a screenshot
	And I open log line 2
	And I verify Query is not displayed
      | Field      | Query Message                                           | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' can not be greater than. | false    | false  |
	And I verify Query is not displayed
      | Field               | Query Message                                                     | Answered | Closed |
      | Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | false    | false  |
	And I take a screenshot
	When I enter data in CRF
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 98          |
	And I save the CRF page
	And I open log line 2
	Then I verify Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.2.3
@Validation
Scenario: PB_3.2.3 As an EDC user, On a Cross Folder Standard form to log form, When a query has been canceled with the different data and I enter the same data that originally opened the query, then queries are displayed.
	
	Given I login to Rave with user "SUPER USER 1"
	And I select a Subject "sub{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Week 1"
	And I add a new log line
	And I enter data in CRF
	    | Field                | Data        |
	    | Start Date           | 08 Jan 2000 |
	    | End Date             | 12 Feb 2000 |
	    | Original Axis Number | 100         |
	    | Current Axis Number  | 98          |	
	And I save the CRF page
	And I open log line 3
	And I verify Requires Response Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
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
	And I open log line 3
	And I verify Query is not displayed
      | Field      | Query Message                                           | Answered | Closed |
      | Start Date | 'Date Informed Consent Signed' can not be greater than. | false    | false  |
	And I verify Query is not displayed
      | Field               | Query Message                                                     | Answered | Closed |
      | Current Axis Number | 'Current Distribution Number' is not equal 'Current Axis Number'. | false    | false  |
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                           |
		| Query Canceled | 'Date Informed Consent Signed' can not be greater than. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 3
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                                     |
		| Query Canceled | 'Current Distribution Number' is not equal 'Current Axis Number'. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 3
	When I enter data in CRF
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 98          |
	And I save the CRF page
	And I open log line 3
	Then I verify Query with message "'Date Informed Consent Signed' can not be greater than." is displayed on Field "Start Date"
	And I verify Query with message "'Current Distribution Number' is not equal 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.3.1
@Validation
Scenario: PB_3.3.1 As an EDC user, On a Cross Forms log form to Standard form, When a query has been answered and auto closed with the different data and I enter the same data that originally opened the query, then queries are displayed. 

	Given I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | sub               |
	And I select Folder "Week 1"
	And I select Form "Concomitant Medications"
	And I enter data in CRF
	    |Field					|Data        |
        |Start Date				|12 Jan 2000 |
	    |End Date				|11 Jan 2000 |
	    |Original Axis Number   |100         |
	    |Current Axis Number    |101         |
	And I save the CRF page
	And I take a screenshot
	And I select Form "Informed Consent" in Folder "Week 1"
	And I enter data in CRF
	    |Field							|Data        |
        |Date Informed Consent Signed	|12 Jan 2000 |
	    |End Date						|11 Jan 2000 |
	    |Original Distribution Number   |100         |
	    |Current Distribution Number    |101         |	
	And I save the CRF page
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is not equal to Current Date." is displayed on Field "End Date"
	And I verify Requires Response Query with message "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." is displayed on Field "Current Distribution Number"
	And I take a screenshot
	And I enter data in CRF
		|Field                  		|Data			|
	    |End Date						|13 Jan 2000	|
	    |Current Distribution Number    |100			|	
	And I answer the Query "'Date Informed Consent Signed' is not equal to Current Date." on Field "End Date" with "answered query"
	And I answer the Query "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." on Field "Current Distribution Number" with "answered query"
	And I save the CRF page
	And I verify Query is not displayed
      | Field    | Query Message                                                | Answered | Closed |
      | End Date | 'Date Informed Consent Signed' is not equal to Current Date. | false    | false  |
	And I verify Query is not displayed
      | Field                       | Query Message                                                                          | Answered | Closed |
      | Current Distribution Number | 'Original Distribution Number' and 'Current Distribution Number' fields are not equal. | false    | false  |
	And I take a screenshot	
	When I enter data in CRF
		|Field							|Data			|
	    |End Date						|11 Jan 2000	|
	    |Current Distribution Number    |101			|	
	And I save the CRF page
	Then I verify Requires Response Query with message "'Date Informed Consent Signed' is not equal to Current Date." is displayed on Field "End Date"
	Then I verify Requires Response Query with message "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." is displayed on Field "Current Distribution Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.3.2
@Validation
Scenario: PB_3.3.2 As an EDC user, On a Cross Forms log form to Standard form, When a query has been canceled with the different data and I enter the same data that originally opened the query, then queries are displayed. 

	Given I login to Rave with user "SUPER USER 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | sub               |
	And I select Folder "Week 1"
	And I select Form "Concomitant Medications" in Folder "Week 1"
	And I enter data in CRF
	    |Field					|Data        |
        |Start Date				|12 Jan 2000 |
	    |End Date				|11 Jan 2000 |
	    |Original Axis Number   |100         |
	    |Current Axis Number    |101         |
	And I save the CRF page
	And I take a screenshot
	And I select Form "Informed Consent" in Folder "Week 1"
	And I enter data in CRF
	    |Field							|Data        |
        |Date Informed Consent Signed	|12 Jan 2000 |
	    |End Date						|11 Jan 2000 |
	    |Original Distribution Number   |100         |
	    |Current Distribution Number    |101         |	
	And I save the CRF page
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is not equal to Current Date." is displayed on Field "End Date"
	And I verify Requires Response Query with message "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." is displayed on Field "Current Distribution Number"
	And I take a screenshot
	And I enter data in CRF
		|Field                  		|Data			|
	    |End Date						|13 Jan 2000	|
	    |Current Distribution Number    |100			|	
	And I cancel the Query "'Date Informed Consent Signed' is not equal to Current Date." on Field "End Date"
	And I cancel the Query "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." on Field "Current Distribution Number"
	And I save the CRF page
	And I verify Query is not displayed
      | Field    | Query Message                                                | Answered | Closed |
      | End Date | 'Date Informed Consent Signed' is not equal to Current Date. | false    | false  |
	And I verify Query is not displayed
      | Field                       | Query Message                                                                          | Answered | Closed |
      | Current Distribution Number | 'Original Distribution Number' and 'Current Distribution Number' fields are not equal. | false    | false  |
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
	When I enter data in CRF
		|Field							|Data			|
	    |End Date						|11 Jan 2000	|
	    |Current Distribution Number    |101			|	
	And I save the CRF page
	Then I verify Requires Response Query with message "'Date Informed Consent Signed' is not equal to Current Date." is displayed on Field "End Date"
	Then I verify Requires Response Query with message "'Original Distribution Number' and 'Current Distribution Number' fields are not equal." is displayed on Field "Current Distribution Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.4.1
@Validation
Scenario: PB_3.4.1 As an EDC user, On a Cross Forms log form to log form, When a query has been answered and auto closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.

	Given I login to Rave with user "SUPER USER 1"
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
      | Field    | Query Message                                 | Answered | Closed |
      | End Date | Date is Less Than Date on the first log form. | false    | false  |
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

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.4.2
@Validation
Scenario: PB_3.4.2 As an EDC user, On a Cross Forms log form to log form, When a query has been answered and auto closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.

	Given I login to Rave with user "SUPER USER 1"
	And I select a Subject "sub{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I add a new log line
	And I enter data in CRF
	    |Field					|Data        |
        |Start Date				|10 Feb 2000 |
	    |End Date				|10 Mar 2000 |
	    |Original Axis Number   |200         |
	    |Current Axis Number	|77          |
	And I save the CRF page
	And I take a screenshot	
	And I select Form "Adverse Events" in Folder "Screening"
	And I add a new log line
	And I enter data in CRF
	    |Field				|Data        |
        |Start Date			|11 Feb 2000 |
	    |End Date			|09 Mar 2000 |
	    |AE Number			|201         |
	    |Duration			|77          |
	And I save the CRF page
	And I take a screenshot	
	And I select Form "Concomitant Medications"
	And I open log line 2
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Requires Response Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I enter data in CRF
		|Field					|Data        |
        |Start Date				|11 Feb 2000 |
	    |End Date				|09 Mar 2000 |
	    |Original Axis Number   |202         |
	    |Current Axis Number	|76          |	
	And I answer the Query "Date can not be less than." on Field "Start Date" with "answered query"
	And I answer the Query "Date is Less Than Date on the first log form." on Field "End Date" with "answered query"
	And I answer the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number" with "answered query"
	And I answer the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number" with "answered query"
	And I save the CRF page
	And I open log line 2 
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
	When I enter data in CRF
		 |Field						|Data        |
         |Start Date				|10 Feb 2000 |
	     |End Date					|10 Mar 2000 |
	     |Original Axis Number		|200         |
	     |Current Axis Number		|77          |
	And I save the CRF page
	And I open log line 2
	Then I verify Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number" 
	And I verify Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.4.3
@Validation
Scenario: PB_3.4.3 As an EDC user, On a Cross Forms log form to log form, When a query has been canceled with the different data and I enter the same data that originally opened the query, then queries are not displayed.

	Given I login to Rave with user "SUPER USER 1"
	And I select a Subject "sub{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I add a new log line
	And I enter data in CRF
	    |Field					|Data        |
        |Start Date				|10 Feb 2000 |
	    |End Date				|10 Mar 2000 |
	    |Original Axis Number   |200         |
	    |Current Axis Number	|77          |
	And I save the CRF page
	And I take a screenshot	
	And I select Form "Adverse Events" in Folder "Screening"
	And I add a new log line
	And I enter data in CRF
	    |Field				|Data        |
        |Start Date			|11 Feb 2000 |
	    |End Date			|09 Mar 2000 |
	    |AE Number			|201         |
	    |Duration			|77          |
	And I save the CRF page
	And I take a screenshot	
	And I select Form "Concomitant Medications"
	And I open log line 3
	And I verify Requires Response Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Requires Response Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number"
	And I verify Requires Response Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I enter data in CRF
		|Field					|Data        |
        |Start Date				|11 Feb 2000 |
	    |End Date				|09 Mar 2000 |
	    |Original Axis Number   |202         |
	    |Current Axis Number	|76          |	
	And I cancel the Query "Date can not be less than." on Field "Start Date"
	And I cancel the Query "Date is Less Than Date on the first log form." on Field "End Date"
	And I cancel the Query "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." on Field "Original Axis Number"
	And I cancel the Query "'Duration' and 'Current Axis Number' cannot equal." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 3
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
	And I click audit on Field "Start Date"
	And I verify last audit exist
		| Audit Type     | Query Message              |
		| Query Canceled | Date can not be less than. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 3
	And I click audit on Field "End Date"
	And I verify last audit exist
		| Audit Type     | Query Message                                 |
		| Query Canceled | Date is Less Than Date on the first log form. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 3
	And I click audit on Field "Original Axis Number"
	And I verify last audit exist
		| Audit Type     |Query Message                                                          |
		| Query Canceled |'AE Number' is greater than or Equal to 'Original Axis Number' on Log. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 3
	And I click audit on Field "Current Axis Number"
	And I verify last audit exist
		| Audit Type     | Query Message                                      |
		| Query Canceled | 'Duration' and 'Current Axis Number' cannot equal. |
	And I take a screenshot	
	And I select link "Concomitant Medications" in "Header"
	And I open log line 3
	When I enter data in CRF
		 |Field						|Data        |
         |Start Date				|10 Feb 2000 |
	     |End Date					|10 Mar 2000 |
	     |Original Axis Number		|200         |
	     |Current Axis Number		|77          |
	And I save the CRF page
	And I open log line 3
	Then I verify Query with message "Date can not be less than." is displayed on Field "Start Date"
	And I verify Query with message "Date is Less Than Date on the first log form." is displayed on Field "End Date"
	And I verify Query with message "'AE Number' is greater than or Equal to 'Original Axis Number' on Log." is displayed on Field "Original Axis Number" 
	And I verify Query with message "'Duration' and 'Current Axis Number' cannot equal." is displayed on Field "Current Axis Number"
	And I take a screenshot

#---------------------------------------------------------------------------------------------------------------------------------------- 
@release_564_Patch11
@PB_3.1.5
@Validation
Scenario: PB_3.1.5 As an EDC user, On a Cross Form Standard form to log form, When a query has been canceled with the different data and I enter the same data that originally opened the query, then queries are displayed. 
  
  	Given I login to Rave with user "SUPER USER 1" 
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
	When I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I cancel the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I cancel the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I open log line 1
	And I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is not displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is not displayed on Field "Current Axis Number"
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
	And I take a screenshot
	When I enter data in CRF
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 20          |
	And I save the CRF page
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------