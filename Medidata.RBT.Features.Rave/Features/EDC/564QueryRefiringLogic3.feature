Feature: 3 
	As a Rave user
	I want to change data
	So I can see refired queries

# Query Issue: Edit Checks with require response and no require manual close
# Open a query and answer a query, change the correct data closes the query automatically and change it back to previous data query did refires and verify there is no log
# Verifies query firing between cross forms with require response and no require manual close.

# Project to be uploaded in excel spreadsheet 'Edit Check Study 3'

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Study assignments exist
		|User		|Study		       	|Role |Site		        	|Site Number|
		|editcheck  |Edit Check Study 3	|CDM1 |Edit Check Site 3	|30001      |
    And Role "cdm1" has Action "Query"
	And Study "Edit Check Study 3" has Draft "Draft 1" includes Edit Checks from the table below
		| Edit Check                                             | Folder    | Form                    | Field                       | Query Message                                                                                                 |
		| *Greater Than Log same form                            | Week 1    | Concomitant Medications | End Date                    | Start Date can not be greater than End Date.                                                                  |
		| *Greater Than Open Query Cross Folder                  | Week 1    | Concomitant Medications | Start Date                  | 'Date Informed Consent Signed' can not be greater than.                                                       |
		| *Greater Than Open Query Log Cross Form                | Screening | Concomitant Medications | Start Date                  | 'Date Informed Consent Signed' is greater. Please revise.                                                     |
		| *Is Greater Than or Equal To Open Query Log Cross Form | Screening | Concomitant Medications | Original Axis Number        | Numeric Field is greater than or Equal to Numeric Field on Log.                                               |
		| *Is Less Than Log same form                            | Week 1    | Concomitant Medications | Current Axis Number         | Date is Less Than Date on first Number field.                                                                 |
		| *Is Less Than Open Query Log Cross Form                | Screening | Concomitant Medications | End Date                    | Date is Less Than Date on the first log form.                                                                 |
		| *Is Less Than To Open Query Log Cross Form             | Screening | Concomitant Medications | Start Date                  | Date can not be less than.                                                                                    |
		| *Is Not Equal to Open Query Cross Folder               | Week 1    | Concomitant Medications | Current Axis Number         | Numeric Field 2 is not equal Numeric Field 2.                                                                 |
		| *Is Not Equal To Open Query Log Cross Form             | Screening | Concomitant Medications | Current Axis Number         | Numeric 2 can not equal each other.                                                                           |
		| *Is Not Equal to Open Query Log Cross Form*            | Screening | Concomitant Medications | Current Axis Number         | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |
		| *Is Not Equal To Open Query Log Same form              | Week 1    | Informed Consent        | Current Distribution Number | Numeric fields are not equal.                                                                                 |
		| *Greater Than or Equal To Open Query Log same form     | Week 1    | Informed Consent        | End Date                    | 'Date Informed Consent Signed' is not equal to 'Current Date'.                                                |
	And Draft "Draft 1" in Study "Edit Check Study 3" has been published to CRF Version "<RANDOMNUMBER>" 
	And CRF Version "<RANDOMNUMBER>" in Study "Edit Check Study 3" has been pushed to Site "Edit Check Site 3" in Environment "Prod"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 3"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.1
@Draft
Scenario: PB_3.1.1 On a Cross Form Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed. 
   
	Given  I select Study "Edit Check Study 3" and Site "Edit Check Site 3"
	 And I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | sub                                                            |

	 And I select Folder "Screening"
	 And I select Form "Informed Consent"
	 And I enter data in CRF
	     |Field							|Data        |
         |Date Informed Consent Signed	|09 Jan 2000 |
	     |End Date						|10 Jan 2000 |
	     |Original Distribution Number	|10          |
	     |Current Distribution Number	|19          |
	And I save the CRF page
	And I take a screenshot
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF
	     |Field						|Data        |
         |Start Date				|08 Jan 2000 |
	     |End Date					|11 Jan 2000 |
	     |Original Axis Number		|10          |
	     |Current Axis Number		|20          |	
	And I save the CRF page
	And I open log line 1
	And I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "."
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "."
	And I save the CRF page
	And I take a screenshot


	# Given closed Query with message "Informed Consent Date 1 is greater. Please revise" exists on Field "Start Date" in Form "Concomitant Medications" in Folder "Screening" in Subject "SUB301" in Site "Edit Check Site 3" in Study "Edit Check Study 3"
	# And closed Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." exists on Field "Current Axis Number" in Form "Concomitant Medications" in Folder "Screening" in Subject "SUB301" in Site "Edit Check Site 3" in Study "Edit Check Study 3"
	#And I am on CRF page "Concomitant Medications" in Folder "Screening" in Subject "SUB301" in Site "Edit Check Site 3" in Study "Edit Check Study 3"
	And I open log line 1
	When I enter data in CRF
		|Field					|Data        |
        |Start Date				|08 Jan 2000 |
	    |Current Axis Number	|20          |
	And I save the CRF page
	And I open log line 1
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is not displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.2
@Draft
Scenario: PB_3.1.2 On a Cross Form Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that 
originally opened the query, then queries are displayed in SQL logs. 
	
    When I run SQL Script "Query Logging Script"
    Then I should see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName		|CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName 	|TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB301       |Screening					|Concomitant Medications            |1                         |Start Date				|08 Jan 2000          |Screening       |Concomitant Medications			 	 	|1                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |'Date Informed Consent Signed' is greater. Please revise.                          |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB301       |Screening					|Concomitant Medications            |1                         |Current Axis Number		|20                   |Screening       |Concomitant Medications             	|1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |{DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.3
@Draft
Scenario: PB_3.1.3 On a Cross Form Standard form to log form, When a query has been answered and closed with the different data and I enter the same data that 
originally opened the query, then queries are displayed. 
	Given  I select Study "Edit Check Study 3" and Site "Edit Check Site 3"
	Given I select a Subject "sub{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I add a new log line
	And I enter data in CRF
		 |Field					|Data        |
		 |Start Date			|07 Jan 2000 |
		 |End Date				|12 Jan 2000 |
		 |Original Axis Number  |10          |
		 |Current Axis Number   |18          |
	And I save the CRF page
	And I open log line 2
	And I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." with Requires Response is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." with Requires Response is displayed on Field "Current Axis Number"
    And I take a screenshot
	And I enter data in CRF
		|Field					|Data        |
        |Start Date				|09 Jan 2000 |
	    |Current Axis Number	|19          |
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "."
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "."
	And I save the CRF page
	And I take a screenshot	
	And I open log line 2
	And I verify Field "Start Date" has NO Query
	And I verify Field "Current Axis Number" has NO Query
	And I take a screenshot	

	When I enter data in CRF
		|Field					|Data        |
        |Start Date				|07 Jan 2000 |
	    |Current Axis Number	|20          |
	And I save the CRF page
	And I open log line 2
	Then I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.4
@Draft
Scenario: PB_3.1.4 On a Cross Form Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed in SQL logs. 
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB301       |Screening          |Concomitant Medications            |2                         |Start Date    |07 Jan 2000          |Screening       |Concomitant Medications             |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |'Date Informed Consent Signed' is greater. Please revise.                          |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB301       |Screening          |Concomitant Medications            |2                         |Current Axis Number      |18                   |Screening       |Concomitant Medications             |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |{DateTime} |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.2.1
@Draft
Scenario: PB_3.2.1 On a Cross Folder Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.
		
	Given  I select Study "Edit Check Study 3" and Site "Edit Check Site 3"
	 And I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num2>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | sub                                                            |   
	 And I select Folder "Screening"
	 And I select Form "Informed Consent"
	 And I enter data in CRF
	   |Field							|Data        |
       |Date Informed Consent Signed	|10 Jan 2000 |
	   |End Date						|10 Feb 2000 |
	   |Original Distribution Number    |100         |
	   |Current Distribution Number     |200         |
	And I save the CRF page
	And I take a screenshot
	And I select Form "Concomitant Medications" in Folder "Week 1"
	And I enter data in CRF
		| Field					| Data        |
		|Start Date				| 09 Jan 2000 |
		|End Date				| 11 Feb 2000 |
		|Original Axis Number	|100          |
		|Current Axis Number	|99           |	
	And I save the CRF page
	And I open log line 1
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Start Date"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I open log line 1
	And I answer the Query "{message}" on Field "Start Date" with "{answer}"
	And I answer the Query "{message}" on Field "Current Axis Number" with "{answer}"
	And I save the CRF page
	And I take a screenshot	


	And I open log line 1
	When I enter data in CRF
		|Field					|Data        |
        |Start Date				|09 Jan 2000 |
	    |Current Axis Number	|99          |
	And I save the CRF page
	Then I verify Query with message "" is not displayed on Field "Start Date"
	And I verify Query with message "" is not displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.2.2
@Draft
Scenario: PB_3.2.2 On a Cross Folder Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed in SQL logs. 

    When I run SQL Script "Query Logging Script"
    Then I should see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition			|CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB302       |Week 1    |Concomitant Medications            |1                         |Start Date			|09 Jan 2000          |Week 1 |Concomitant Medications             |1                          |Assessment Date 1       |09 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |'Date Informed Consent Signed' can not be greater than.               |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB302       |Week 1    |Concomitant Medications            |1                         |Current Axis Number   |99                   |Week 1 |Concomitant Medications             |1                          |Numeric Field 2         |99               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.2.3
@Draft
Scenario: PB_3.2.3 On a Cross Folder Standard form to log form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.
	
	Given I select a Subject "sub{Var(num2)}"
	And I select Form "Concomitant Medications" in Folder "Week 1"
	And I add a new log line
	And I enter data in CRF
	    |Field						|Data			|
        |Start Date					|08 Jan 2000	|
	    |End Date					|12 Feb 2000	|
	    |Original Axis Number		|100			|
	    |Current Axis Number		|98				|	
	And I save the CRF page
	And I open log line 2
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Start Date"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Current Axis Number"
	And I take a screenshot	
	And I enter data in CRF
		| Field					| Data			|
		| Start Date			| 10 Jan 2000	|
		|Original Axis Number   |201			|
		|Current Axis Number	|200			|
	And I answer the Query "{message}" on Field "Start Date" with "{answer}"
	And I answer the Query "{message}" on Field "Current Axis Number" with "{answer}"
	And I save the CRF page
	And I take a screenshot
	And I verify Field "Start Date" has NO Query
	And I verify Field "Current Axis Number" has NO Query
	And I take a screenshot

	# Given closed Query with message "" exists on "Start Date" in folder "Week 1" in form "Concomitant Medications" in subject "SUB302"
	# And closed Query with message "" exists on "Current Axis Number" in folder "Week 1" in form "Concomitant Medications" in subject "SUB302"
	And I add a new log line

	When I enter data in CRF
		|Field					|Data        |
        |Start Date				|08 Jan 2000 |
	    |Current Axis Number	|98          |
	And I save the CRF page
	Then I verify Query with message "" is displayed on Field "Start Date"
	And I verify Query with message "" is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.2.4
@Draft
Scenario: PB_3.2.4 On a Cross Folder Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed in SQL logs. 
	
	When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName	|CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB302       |Week 1						|Concomitant Medications            |2                         |Start Date			 |08 Jan 2000          |Week 1 |Concomitant Medications             |2                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |'Date Informed Consent Signed' can not be greater than.               |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB302       |Week 1						|Concomitant Medications            |2                         |Current Axis Number	 |98                   |Week 1 |Concomitant Medications             |2                          |Numeric Field 2         |98               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.3.1
@Draft
Scenario: PB_3.3.1 On a Cross Forms log form to Standard form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed. 

	Given  I select Study "Edit Check Study 3" and Site "Edit Check Site 3"
	 And I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num3>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | sub                                                            |
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
	And I verify Query with message "{message}" with Requires Response is displayed on Field "End Date"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Current Distribution Number"
	And I take a screenshot
	And I enter data in CRF
		|Field                  |Data			|
	    |End Date				|13 Jan 2000	|
	    |Current Distribution Number    |100			|	
	And I answer the Query "{message}" on Field "End Date" with "{answer}"
	And I answer the Query "{message}" on Field "Current Distribution Number" with "{answer}"
	And I save the CRF page
	And I verify Field "End Date" has NO Query
	And I verify Field "Current Distribution Numberv" has NO Query
	And I take a screenshot	

	# Given closed Query with message "" exists on "End Date" in folder "Week 1" in form "Informed Consent" in subject "SUB303"
	# And closed Query with message "" exists on "Current Distribution Number" in folder "Week 1" in form "Informed Consent" in subject "SUB303"
	When I enter data in CRF
		|Field							|Data			|
	    |End Date						|11 Jan 2000	|
	    |Current Distribution Number    |101			|	
	And I save the CRF page
	Then I verify Query with message "{message}" with Requires Response is displayed on Field "End Date"
	Then I verify Query with message "{message}" with Requires Response is displayed on Field "Current Distribution Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.3.2
@Draft
Scenario: PB_3.3.2 On a Cross Forms log form to Standard form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed. 

    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName		|CheckActionInstanceDataPageName	|CheckActionRecordPosition |CheckActionFieldName    |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                                      |MarkingGroupName |QueryMessage                  |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB303       |Week 1						|Informed Consent    |0								|End Date		|11 Jan 2000          |Week 1 |Informed Consent     |0                          |End Date |11 Jan 2000      |*Greater Than or Equal To Open Query Log same form |Marking Group 1  |'Date Informed Consent Signed' is not equal to 'Current Date'.          |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB303       |Week 1						|Informed Consent    |0								|Current Distribution Number         |101                  |Week 1 |Informed Consent     |0                          |Numeric Field 2         |101              |*Is Not Equal To Open Query Log Same form          |Marking Group 1  |Numeric fields are not equal. |{DateTime} |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.4.1
@Draft
Scenario: PB_3.4.1 On a Cross Forms log form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.

	Given  I select Study "Edit Check Study 3" and Site "Edit Check Site 3"
	 And I create a Subject
		| Field            | Value                                                          |
		| Subject Number   | {NextSubjectNum<num4>(Edit Check Study 3,prod,Subject Number)} |
		| Subject Initials | sub                                                            |
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
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Start Date"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "End Date"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Original Axis Number"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Numeric Field 2"
	And I take a screenshot
	And I answer the Query "{message}" on Field "Start Date" with "{answer}"
	And I answer the Query "{message}" on Field "End Date" with "{answer}"
	And I answer the Query "{message}" on Field "Original Axis Number" with "{answer}"
	And I answer the Query "{message}" on Field "Numeric Field 2" with "{answer}"
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
	And I verify Field "Start Date" has NO Query
	And I verify Field "End Date" has NO Query
	And I verify Field "Original Axis Number" has NO Query
	And I verify Field "Current Axis Number" has NO Query
	And I take a screenshot	

	# Given closed Query with message "" exists on "Start Date" in folder "Screening" in form "Concomitant Medications" in subject "SUB304"
	# And closed Query with message "" exists on "End Date" in folder "Screening" in form "Concomitant Medications" in subject "SUB304"
	# And closed Query with message "" exists on "Original Axis Number" in folder "Screening" in form "Concomitant Medications" in subject "SUB304"
	# And closed Query with message "" exists on "Current Axis Number" in folder "Screening" in form "Concomitant Medications" in subject "SUB304"

	And I open log line 1
	When I enter data in CRF
		|Field						|Data        |
        |Start Date					|10 Jan 2000 |
	    |End Date					|10 Feb 2000 |
	    |Original Axis Number		|100         |
	    |Current Axis Number		|66          |
	And I save the CRF page
	Then I verify Query with message "" is not displayed on Field "Start Date"
	And I verify Requires Response Query with message "" is not displayed on Field "End Date"
	And I verify Requires Response Query with message "" is not displayed on Field "Original Axis Number"
	And I verify Requires Response Query with message "" is not displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.4.2
@Draft
Scenario: PB_3.4.2 On a Cross Forms log form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed in SQL logs. .
	
	When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Screening          |Concomitant Medications            |1                         |Start Date    |10 Jan 2000          |Screening       |Concomitant Medications             |1                          |Assessment Date 1|10 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Screening          |Concomitant Medications            |1                         |End Date    |10 Feb 2000          |Screening       |Concomitant Medications             |1                          |Assessment Date 2|10 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Screening          |Concomitant Medications            |1                         |Original Axis Number      |100                  |Screening       |Concomitant Medications             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Screening          |Concomitant Medications            |1                         |Current Axis Number      |66                   |Screening       |Concomitant Medications             |1                          |Numeric Field 2  |66               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	

#THIS IS DUPLICATE of @PB_3.4.1, please confirm
@release_564_Patch11
@PB_3.4.3
@Draft
Scenario: PB_3.4.3 On a Cross Forms log form to log form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.

	Given I select a Subject "sub{Var(num4)}"
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
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Start Date"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "End Date"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Original Axis Number"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I enter data in CRF
		|Field					|Data        |
        |Start Date				|11 Feb 2000 |
	    |End Date				|09 Mar 2000 |
	    |Original Axis Number   |202         |
	    |Current Axis Number	|76          |	
	And I answer the Query "{message}" on Field "Start Date" with "{answer}"
	And I answer the Query "{message}" on Field "End Date" with "{answer}"
	And I answer the Query "{message}" on Field "Original Axis Number" with "{answer}"
	And I answer the Query "{message}" on Field "Current Axis Number" with "{answer}"
	And I save the CRF page
	And I open log line 2 
	And I verify Field "Start Date" has NO Query
	And I verify Field "End Date" has NO Query
	And I verify Field "Original Axis Number" has NO Query
	And I verify Field "Current Axis Number" has NO Query
	And I take a screenshot	

	# Given closed Query with message "" exists on "Start Date" in folder "Week 1" in form "Concomitant Medications" in subject "SUB302"
	# And closed Query with message "" exists on "Current Axis Number" in folder "Week 1" in form "Concomitant Medications" in subject "SUB302"

	# Given closed Query with message "" exists on "Start Date" in folder "Screening" in form "Concomitant Medications" in subject "SUB304"
	# And closed Query with message "" exists on "End Date" in folder "Screening" in form "Concomitant Medications" in subject "SUB304"
	# And closed Query with message "" exists on "Original Axis Number" in folder "Screening" in form "Concomitant Medications" in subject "SUB304"
	# And closed Query with message "" exists on "Current Axis Number" in folder "Screening" in form "Concomitant Medications" in subject "SUB304"
	
	And I open log line 2
	When I enter data in CRF
		 |Field						|Data        |
         |Start Date				|10 Feb 2000 |
	     |End Date					|10 Mar 2000 |
	     |Original Axis Number		|200         |
	     |Current Axis Number		|77          |
	And I save the CRF page
	And I open log line 2
	Then I verify Query with message "" is displayed on Field "Start Date"
	And I verify Query with message "" is displayed on Field "End Date"
	And I verify Query with message "" is displayed on Field "Original Axis Number" 
	And I verify Query with message "" is displayed on Field "Current Axis Number"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.4.4
@Draft
Scenario: PB_3.4.4 On a Cross Forms log form to log form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed in SQL logs. .
	
	When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Screening          |Concomitant Medications            |2                         |Start Date					|10 Feb 2000          |Screening       |Concomitant Medications             |2                          |Assessment Date 1|10 Feb 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Screening          |Concomitant Medications            |2                         |End Date					 |10 Mar 2000          |Screening       |Concomitant Medications             |2                          |Assessment Date 2|10 Mar 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Screening          |Concomitant Medications            |2                         |Original Axis Number					|200                  |Screening       |Concomitant Medications             |2                          |Numeric Field 1  |200              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Screening          |Concomitant Medications            |2                         |Current Axis Number			      |77                   |Screening       |Concomitant Medications             |2                          |Numeric Field 2  |77               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot	
	
#---------------------------------------------------------------------------------------------------------------------------------------- 