Feature: 8
	As a Rave user
	I want to change data
	So I can see refired queries
	
# Query Issue: Edit Checks with require response and require manual close

#Data PDF
#Task Summary

#Reports - Audit Trail
#Edit Check Log Report
#Query Detail
#Stream-Audit Trail
#Stream-Edit Check Log Report
#Stream-Query Detail

#Query Management
#J-Review
#BOXI
#Amendment Manager
#Publish Checks
#Queries on Locked datapoints, Freezed datapoints, Inactive records

Background:F

    Given I am logged in to Rave with username "defuser" and password "password"
	# And following Study assignments exist
		# |User			|Study		       	|Role |Site		        	|Site Number | 
		# |editcheck  	|Edit Check Study 8	|cdm1 |Edit Check Site 8 	|80001       |
		# |editcheck1 	|Edit Check Study 8	|cdm2 |Edit Check Site 8 	|80001       |
		# |editcheck	 	|AM Edit Check Study|cdm1 |AM Edit Site		 	|80002       |	
	# And role "cdm1" has Query actions
	# And role "cdm2" has Query actions
	# And Draft "Draft 1" in Study "Edit Check Study 8" has been published to CRF Version "<RANDOMNUMBER>" 
	# And CRF Version "<RANDOMNUMBER>" in Study "Edit Check Study 8" has been pushed to Site "Edit Check Site 3" in Environment "Prod"
	# And I set and save "Threshold" in Configuration, Other Settings, Advance Configuration to "Value", from the table below
			# |Threshold					|Value	|
			# |Check Resolution Threshold	|0		|
			# |Check Execution Threshold	|0		|
			# |Custom Function Threshold	|0		|
	# And I do cacheflush
	# And I select Study "Edit Check Study 8" and Site "Edit Check Site 8"
	
#----------------------------------------------------------------------------------------------------------------------------------------	
Scenario:  test
	And I navigate to "Architect"
	And I select "AM Edit Check Study" in "Active Projects"
	
	And I navigate to "Amendment Manager"
	And I choose "V1 (25)" from "Source CRF"
	And I choose "Target003 (39)" from "Target CRF"
	And I click button "Create Plan"
	And I take a screenshot
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select Migration Results and verify Job Status is set to Complete
	And I take a screenshot



@release_564_Patch11
@PB_8.1.1
@Draft
Scenario: PB_8.1.1 Data setup and verification for query re-firing.
Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications"
	
	And I navigate to "DDE"
	And I select "First Pass"
	And I select "New Batch"
	And I choose "Edit Check Study 3" from "Study"
	And I choose "Prod" from "Environment"
	And I choose "Edit Check Site 8" from "Site"
	And I type "sub {RndNum<num1>(5)}" in "Subject"
	And I choose "Subject Identification" from "Form"
	And I click button "Locate"

	And I enter data in DDE and save
		| Field            | Data        |
		| Subject Number   | {Var(num1)} |
		| Subject Initials | sub         |
	
	And I choose "Screening" from "Folder"
	And I choose "Informed Consent" from "Form"
	And I click button "Locate"
	And I enter data in DDE and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 09 Jan 2000 |
	    | End Date                     | 10 Jan 2000 |
	    | Original Distribution Number | 10          |
	    | Current Distribution Number  | 19          |
	And I choose "Concomitant Medications" from "Form"
	And I click button "Locate"	
	And I enter data in DDE log line 1 and save
	    | Field                | Data        |
	    | Start Date           | 08 Jan 2000 |
	    | End Date             | 11 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 20          |
	
	And I am logged in to Rave with username "coderimport" and password "password"


	And I navigate to "DDE"
	And I select "Second Pass"
	And I choose "Edit Check Study 3" from "Study"
	And I choose "Prod" from "Environment"
	And I choose "Edit Check Site 8" from "Site"
	And I choose "sub {Var(num1)}" from "Subject"
	And I choose "Subject Identification" from "Form"
	And I click button "Locate"
	And I enter data in DDE and save
		| Field            | Data        |
		| Subject Number   | {Var(num1)} |
		| Subject Initials | sub         |

	And I choose "Screening" from "Folder"
	And I choose "Informed Consent" from "Form"
	And I click button "Locate"
	And I enter data in DDE and save
	    | Field                        | Data        |
	    | Date Informed Consent Signed | 09 Jan 2000 |
	    | End Date                     | 10 Jan 2000 |
	    | Original Distribution Number | 10          |
	    | Current Distribution Number  | 19          |
	And I choose "Concomitant Medications" from "Form"
	And I click button "Locate"	
	And I enter data in DDE log line 1 and save
	    | Field                | Data        |
	    | Start Date           | 08 Jan 2000 |
	    | End Date             | 11 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 20          |
	And I navigate to "Home"
	And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
	And I select a Subject "sub{Var(num1)}"

	And I select Form "Concomitant Medications" in Folder "Screening"
	And I open log line 1
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"

	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "{answer}"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "{answer}"

	And I save the CRF page
	And I open log line 1
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I open log line 1
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I open log line 1
	And I verify Field "Start Date" has NO Query
	And I verify Field "Current Axis Number" has NO Query

	And I take a screenshot
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 20          |
	And I open log line 1
	And I verify closed Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify closed Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"

	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.2
@Draft
Scenario: PB_8.1.2
	
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Screening          |Concomitant Medications            |1                         |Start Date    |08 Jan 2000          |Screening       |Concomitant Medications			  |1                          |Start Date       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Screening          |Concomitant Medications            |1                         |Current Axis Number      |20                   |Screening       |Concomitant Medications             |1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot
 
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.3
@Draft
Scenario: PB_8.1.3
 
    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
    And I select a Subject "sub{Var(num1)}"
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF on a new log line and save
	    | Field                | Data        |
	    | Start Date           | 07 Jan 2000 |
	    | End Date             | 12 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 18          |
	And I open log line 2
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "{answer}"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "{answer}"
	And I save the CRF page
	And I open log line 2
	And I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I save the CRF page
	And I take a screenshot
	And I open log line 2
	And I verify Field "Start Date" has NO Query
	And I verify Field "Current Axis Number" has NO Query
	And I take a screenshot
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open log line 2
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is not displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is not displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.4
@Draft
Scenario: PB_8.1.4
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Screening      |Concomitant Medications            |2                         |Start Date    |07 Jan 2000          |Screening       |Concomitant Medications             |2                          |Start Date       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Screening      |Concomitant Medications            |2                         |Current Axis Number      |18                   |Screening       |Concomitant Medications             |2                          |Current Axis Number         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.5
@Draft
Scenario: PB_8.1.5
	
    Given I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
    And I select a Subject "sub72317"
	And I select Form "Concomitant Medications" in Folder "Screening"
	And I enter data in CRF on a new log line and save
	    | Field                | Data        |
	    | Start Date           | 07 Jan 2000 |
	    | End Date             | 12 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 18          |
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
	And I verify Field "Start Date" has NO Query
	And I verify Field "Current Axis Number" has NO Query
	And I take a screenshot
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open log line 3
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"	
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.6
@Draft
Scenario: PB_8.1.6

    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Screening      |Concomitant Medications            |3                         |Start Date    |07 Jan 2000          |Screening       |Concomitant Medications             |2                          |Start Date       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Screening      |Concomitant Medications            |3                         |Current Axis Number      |18                   |Screening       |Concomitant Medications             |2                          |Current Axis Number         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.2.1
@Draft
Scenario: PB_8.2.1 Task Summary

	And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
	And I select a Subject "sub22079"
#New Step Def
	When I expand "Open Queries" in Task Summary
	Then I should see "Screening-Concomitant Medications" in "Open Queries"
	And I select "Screening-Concomitant Medications" in "Open Queries"
	And I open log line 3
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
	And I select a Subject "sub22079"
#New Step Def
	When I expand "Cancel Query" in Task Summary
	Then I should see "Screening-Concomitant Medications" in "Open Query"
	And I select "Screening-Concomitant Medications" in "Open Query"
	And I open log line 3
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
# Need new step def
	And I verify Cancel Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Cancel Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Start Date"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.3.1
@Draft
Scenario: PB_8.3.1 Query Management

	And I navigate to "Query Management"
	And I choose "Edit Check Study 3 (Prod)" from "Study"
	And I choose "World" from "Site Group"
	And I choose "Edit Check Site 8" from "Site"
	And I choose "sub22079" from "Subject"
	And I click button "Advanced Search"

	And I select Form "Concomitant Medications" in search result
	And I open log line 2
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"	
	And I take a screenshot
	And I open log line 3
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"	
	And I take a screenshot
	
#New Step Def
	And I select "Cancel"
	And I enter data in CRF on new log line 4 and save and reopen
	    | Field               | Data        |
	    | Start Date          | 07 Jan 2000 |
	    | End Date            | 12 Jan 2000 |
	    | Original Axis Numbe | 10          |
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
	And I open log line 4
	And I verify Field "Start Date" has NO Query
	And I verify Field "Current Axis Number" has NO Query
	And I take a screenshot
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open log line 4
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.3.2
@Draft
Scenario: PB_8.3.2
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Screening      |Concomitant Medications            |4                         |Start Date    |07 Jan 2000          |Screening       |Concomitant Medications             |2                          |Start Date       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Screening      |Concomitant Medications            |4                         |Current Axis Number      |18                   |Screening       |Concomitant Medications             |2                          |Current Axis Number         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.3.3
@Draft
Scenario: PB_8.3.3
	
	And I navigate to "Query Management"
	And I choose "Edit Check Study 3 (Prod)" from "Study"
	And I choose "World" from "Site Group"
	And I choose "Edit Check Site 8" from "Site"
	And I choose "sub22079" from "Subject"
	And I click button "Advanced Search"

	And I select Form "Concomitant Medications" in search result
	And I enter data in CRF on new log line 5 and save and reopen
	    | Field               | Data        |
	    | Start Date          | 07 Jan 2000 |
	    | End Date            | 12 Jan 2000 |
	    | Original Axis Numbe | 10          |
	    | Current Axis Number | 18          |
	And I open log line 5
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"		
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "{answer}"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "{answer}"
	And I save the CRF page
	And I open log line 5
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I open log line 5
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"	
	And I save the CRF page
	And I take a screenshot
	And I open log line 5
	And I verify Field "Start Date" has NO Query
	And I verify Field "Current Axis Number" has NO Query
	And I take a screenshot
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open log line 5
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.3.4
@Draft
Scenario: PB_8.3.4
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Screening      |Concomitant Medications            |5                         |Start Date    |07 Jan 2000          |Screening       |Concomitant Medications             |2                          |Start Date       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Screening      |Concomitant Medications            |5                         |Current Axis Number      |18                   |Screening       |Concomitant Medications             |2                          |Current Axis Number         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.4.1
@Draft
Scenario: PB_8.4.1 Generate the Data PDFs.
	And I navigate to "PDF Generator"

	And I create Data PDF
	| Name                | Profile | Study                     | Role | SiteGroup | Site              | Subject |
	| pdf{RndNum<num>(3)} | test1   | Edit Check Study 8 (Prod) | CDM1 | World     | Edit Check Site 2 | SUB640  |
	
	And I generate Data PDF "pdf{Var(num)}"
	And I wait for PDF "pdf{Var(num)}" to complete
	When I View Data PDF "pdf{Var(num)}"
	#Then I should see "Query Data" in Audits
	And I take a screenshot
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.5.1
@Draft
Scenario: PB_8.5.1 When I run the Report, then query related data are displayed in the report.

	And I navigate to "Reporter"
	And I select Report "Audit Trail"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 8 | Prod        |
	And I set report parameter "Sites" with table
		| Name              |
		| Edit Check Site 8 |
	And I set report parameter "Subjects" with table
		| Name   |
		| sub 10250 |
	And I set report parameter "Folders" with table
		| Name      |
		| Screening |
	And I set report parameter "Forms" with table
		| Name                    |
		| Informed Consent        |
		| Concomitant Medications |

	And I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window

	#Then I should see queries on "Start Date" and "Current Axis Number" fields
	#And I take a screenshot
	#And I close report
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.5.2
@Draft
Scenario: PB_8.5.2 When I run the Report, then query related data are displayed in the report.

# Query Detail	
	And I navigate to "Reporter"
	And I select report "Query Detail"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 8 | Prod        |
	And I set report parameter "Sites" with table
		| Name              |
		| Edit Check Site 8 |
	And I set report parameter "Subjects" with table
		| Name   |
		| sub 10250 |
	And I set report parameter "Folders" with table
		| Name      |
		| Screening |
	And I set report parameter "Forms" with table
		| Name                    |
		| Informed Consent        |
		| Concomitant Medications |
	When I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	#Then I should see queries on "Start Date" and "Current Axis Number" fields
	And I take a screenshot
	And I close report

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.5.3
@Draft
Scenario: PB_8.5.3 When I run the Report, then query related data are displayed in the report.

#Edit Check Log Report	
	And I navigate to "Reporter"
	And I select report "Edit Check Log Report"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 8 | Prod        |
	And I set report parameter "Sites" with table
		| Name              |
		| Edit Check Site 8 |
	And I set report parameter "Subjects" with table
		| Name   |
		| sub 10250 |
	And I set report parameter "Folders" with table
		| Name      |
		| Screening |
	And I set report parameter "Forms" with table
		| Name                    |
		| Concomitant Medications       |
	

	And I select checkbox "Edit Check" for "Check Type"
	And I select checkbox Check "CheckExecution" for "Log Type"
	When I click button "Submit Report"
	And I switch to "Targeted SDV Subject Override" window
	Then I should see fired editchecks
	And I take a screenshot
	And I close report

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.5.4
@Draft
Scenario: PB_8.5.4 When I run the Report, then query related data are displayed in the report.

#Stream-Audit Trail	
	And I navigate to "Reporter"
	And I select report "Stream-Audit Trail"
And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 8 | Prod        |
	And I set report parameter "Sites" with table
		| Name              |
		| Edit Check Site 8 |
	And I set report parameter "Subjects" with table
		| Name   |
		| sub 10250 |
	And I set report parameter "Folders" with table
		| Name      |
		| Screening |
	And I set report parameter "Forms" with table
		| Name                 |
		| Concomitant Medications |
		|                      form2|
	And I click button "Submit Report"

	#And Im on windows

	When I select "Parameter" to "Value", from the tabe below
		|Parameter			|Value		|
		|Separator			|.			|	
		|File type			|.csv		|
		|Export type		|attachment	|
		|Save as Unicode	|Unchecked	|
	And I open excel file
	Then I should see queries on "Start Date" and "Current Axis Number" fields
	And I take a screenshot
	And I close report
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.5.5
@Draft
Scenario: PB_8.5.5 When I run the Report, then query related data are displayed in the report.

#Stream-Query Detail	
	And I navigate to "Reporter"
	And I select report "Stream-Query Detail"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 8 | Prod        |
	And I set report parameter "Sites" with table
		| Name              |
		| Edit Check Site 8 |
	And I set report parameter "Subjects" with table
		| Name   |
		| sub 10250 |
	And I set report parameter "Folders" with table
		| Name      |
		| Screening |
	And I set report parameter "Forms" with table
		| Name                    |
		| Concomitant Medications       |

	And I click button "Submit Report"
	When I select "Parameter" to "Value", from the tabe below
		|Parameter			|Value		|
		|Separator			|.			|	
		|File type			|.csv		|
		|Export type		|attachment	|
		|Save as Unicode	|Unchecked	|
	And I open excel file
	Then I should see queries on "Start Date" and "Current Axis Number" fields
	And I take a screenshot
	And I close report

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.5.6
@Draft
Scenario: PB_8.5.6 When I run the Report, then query related data are displayed in the report.

#Stream-Edit Check Log Report	
	And I navigate to "Reporter"
	And I select report "Stream-Edit Check Log Report"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 8 | Prod        |
	And I set report parameter "Sites" with table
		| Name              |
		| Edit Check Site 8 |
	And I set report parameter "Subjects" with table
		| Name   |
		| sub 10250 |
	And I set report parameter "Forms" with table
		| Name                    |
		| Concomitant Medications       |

	And I select checkbox "Edit Check" for "Check Type"
	And I select checkbox Check "CheckExecution" for "Log Type"
	And I click button "Submit Report"
	And I select "Parameter" to "Value", from the tabe below
		|Parameter			|Value		|
		|Separator			|.			|	
		|File type			|.csv		|
		|Export type		|attachment	|
		|Save as Unicode	|Unchecked	|
	When I open excel file
	Then I should see fired editchecks
	And I take a screenshot
	And I close report
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.6.1
@Draft
Scenario: PB_8.6.1 When I run the Report, then query related data are displayed in the report.J-Review verification.

	And I navigate to "Reporter"
	And I select report "J-Review"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 8 | Prod        |
	And I click button "Submit Report"
	And I select "Edit Check Study 8" "Prod" from "Studies"
	And I click button "Reports"
	And I select "Detail Data Listing" report from "Type" in "Report Browser"
	And I select "MetricViews" from "Panels"
	And I select "Queries" from "MetricViews"
	And I select "Project, Site, Subject, Datapage, Field, Record Position QueryText, QueryStatus, Answered Data, Answer Text"
	When I click button "Create Report"
	Then I should see "sub801"
	And I should see "Added Query" in "QueryText"
	And I take a screenshot
	And I Close "Detail Data Listing" 
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.7.1
@Draft
Scenario: PB_8.7.1 When I run the Report, then query related data are displayed in the report. BOXI report verification.

	And I navigate to "Reporter"
	And I select report "Business Objects XI"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 8 | Prod        |
	And I click button "Submit Report"
	And I select dropdown "New"
	And I select "Web Intelligence Document"
	And I select "Rave 5.6 Universe"
	And I select "Project Name, Site Name, Subject Name, Folder Name, Form Name, Query Text" in "Results Objects"
	And I select "Site Name, Subject Name, Folder Name, FormName" in "Query Filters"
	And I select "Equal To" from "In List" in "Query Filters" for "Site Name"
	And Enter "Value(s) from list" "Edit Check Site 8" in "Query Filters" for "Site Name"
	And I select "Equal To" from "In List" in "Query Filters" for "Subject Name"		
	And Enter "Value(s) from list" "sub801" in "Query Filters" for "Subject Name"
	And I select "Equal To" from "In List" in "Query Filters" for "Folder Name"		
	And Enter "Value(s) from list" "Screening" in "Query Filters" for "Folder Name"
	And I select "Equal To" from "In List" in "Query Filters" for "Form Name"		
	And Enter "Value(s) from list" "Concomitant Medications" in "Query Filters" for "Form Name"
	When I click button "Run Query"
	Then I should see "sub801"
	And I should see "Added Query" in "QueryText"
	And I take a screenshot
	And I Close "BOXI Report"
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.8.1
@Draft
Scenario: PB_8.8.1 When I run the Report, then query related data are displayed in the report. Migrate Subject

	And I select Study "AM Edit Check Study"
	And I select Site "AM Edit Site"
    And I create a Subject
	| Field            | Value                                                          |
	| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 8,prod,Subject Number)} |
	| Subject Initials |sub802                                                            |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify "Log Field 1" field displays query opened with require response
	And I answer the query on "Log Field 1" field
	And I save the CRF page
	And I close the query on "Log Field 1" field
	And I save the CRF page
	And I note CRF Version "<Source CRF Version1>"
	And I take a screenshot
	
	And I select site "AM Edit Site"
    And I create a Subject
	| Field            | Value                                                          |
	| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 8,prod,Subject Number)} |
	| Subject Initials |sub803                                                            |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
And I save the CRF page
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify "Log Field 1" field displays query opened with require response	
	And I answer the query on "Log Field 1" field
	And I save the CRF page
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |5    |
	And I close the query on "Log Field 1" field
	And I save the CRF page
	And I note CRF Version "<Source CRF Version1>"
	And I take a screenshot
	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "AM Edit Check Study" in "Active Projects"
	And I select "Draft123" in "CRF Drafts"
	And I navigate to "Edit Checks"
	And I inactivate edit check "Mixed Form Query"

	And I select Draft "Draft123" in "Header"


	And I publish CRF Version "Target{RndNum<num1>(3)}"

	And I select Study "AM Edit Check Study" in "Header"
	And I navigate to "Amendment Manager"
	And I choose "V1 (25)" from "Source CRF"
	And I choose "Target003 (39)" from "Target CRF"
	And I click button "Create Plan"
	And I take a screenshot
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select Migration Results and verify Job Status is set to Complete
	And I take a screenshot

	
	And I navigate to "Home"
	And I select "AM Edit Check Study"
	And I select site "AM Edit Site"
    And I select a subject "sub802"
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |4    |
	And I verify new query did not fire on "Log Field 1" field
	And I add a new log line, enter and save the data, from the table below	    
		|Field       |Data |
	    |Log Field 1 |3    |
	    |Log Field 2 |2    |
	And I verify new query did not fire on "Log Field 1" field
	And I take a screenshot
	
	And I select site "AM Edit Site"
    And I select a subject "sub803"
	And I select Form "Mixed Form"
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |8	   |
	And I save the CRF page	
	And I verify new query did not fire on "Log Field 1" field
	And I add a new log line, enter and save the data, from the table below	    
		|Field       |Data |
	    |Log Field 1 |6    |
	    |Log Field 2 |2    |
	And I verify new query did not fire on "Log Field 1" field
	And I take a screenshot
	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I navigate to "AM Edit Check Study"
	And I navigate to "Draft 1"
	And I navigate to "Edit Checks"
	And I select edit image for "Mixed Form Query" Edit Check
	And I select checkbox "Active"
	And I select  link "Update"
	And I navigate to "Draft 1"	
	And I publish CRF Version
	And I note CRF Version "<Target CRF Version2>"
	And I navigate to "AM Edit Check Study"
	And I navigate to "Amendment Manager"
	And I select "<Target CRF Version1>" from dropdown "Source CRF"
	And I select "<Target CRF Version2>" from dropdown "Target CRF"
	And I click button "Create Plan"
	And I navigate to "Exceute Plan"
	And I Migrate "All Subjects"
	And I select Migration Results and verify Job Status is set to Complete
	And I take a screenshot
	
	And I navigate to "Home"
	And I select "AM Edit Check Study"
	And I select site "AM Edit Site"
    And I select a subject "sub802"
	And I select Form "Mixed Form"
	And I verify new query did fire on "Log Field 1" field with require response on the first log line
	And I verify new query did fire on "Log Field 1" field with require response on the second log line
	And I take a screenshot
	
	And I select site "AM Edit Site"
    And I select a subject "sub803"
	And I select Form "Mixed Form"
	And I verify new query did fire on "Log Field 1" field with require response on the first log line
	And I verify new query did fire on "Log Field 1" field with require response on the second log line
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.9.1
@Draft
Scenario: PB_8.9.1 When I run the Report, then query related data are displayed in the report. Publish Checks

	And I navigate to "Architect"
	And I navigate to "AM Edit Check Study"
	And I navigate to "Draft 1"
	And I publish and push CRF Version
	And I note CRF Version "<Publish CRF Version1>"
	And I publish CRF Version
	And I note CRF Version "<Publish CRF Version2>"
	And I publish CRF Version
	And I note CRF Version "<Publish CRF Version3>"
	
	And I navigate to "Home"
	And I select "AM Edit Check Study"
	And I select site "AM Edit Site"
    And I create a Subject
	| Field            | Value                                                          |
	| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 8,prod,Subject Number)} |
	| Subject Initials |sub804                                                            |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
And I save the CRF page
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify "Log Field 1" field displays query opened with require response
	And I take a screenshot
	And I answer the query on "Log Field 1" field
	And I save the CRF page
	And I close the query on "Log Field 1" field
	And I save the CRF page
	And I take a screenshot
	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I navigate to "AM Edit Check Study"
	And I navigate to "Pulish Checks"
	And I select "<Publish CRF Version1>" from dropdown "Current CRF Version"
	And I select "<Publish CRF Version2>" from dropdown "Reference CRF Version"
	And I click button "Create Plan"
	And I check "Inactivate" checkbox for "Mixed Form Query" edit check
	And I navigate to "Save"
	And I take a screenshot
	And I navigate to "Publish" 
	And I verify Job Status is set to Complete
	And I take a screenshot
	
	And I navigate to "Home"
	And I select "AM Edit Check Study"
	And I select site "AM Edit Site"
    And I select a subject "sub804"
	And I select Form "Mixed Form"
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |7    |
	And I save the CRF page		
	And I verify new query did not fire on "Log Field 1" field
	And I take a screenshot
	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I navigate to "AM Edit Check Study"
	And I navigate to "Pulish Checks"
	And I select "<Publish CRF Version1>" from dropdown "Current CRF Version"
	And I select "<Publish CRF Version3>" from dropdown "Reference CRF Version"
	And I click button "Create Plan"
	And I check "Publish" checkbox for "Mixed Form Query" edit check
	And I navigate to "Save"
	And I take a screenshot
	And I navigate to "Publish" 
	And I verify Job Status is set to Complete
	And I take a screenshot

	And I navigate to "Home"
	And I select "AM Edit Check Study"
	And I select site "AM Edit Site"
    And I select a subject "sub804"
	And I select Form "Mixed Form"
	And I verify new query did fire on "Log Field 1" field
	And I answer the query on "Log Field 1" field
	And I save the CRF page
	And I take a screenshot
	And I close the query on "Log Field 1" field
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |8    |
	And I save the CRF page
	And I verify new query did fire on "Log Field 1" field.
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.10.1
@Draft
Scenario: PB_8.10.1 When I run the Report, then query related data are displayed in the report. Queries verification on data points with Freeze, Hard lock and Inactive records

	And I select "Edit Check Study 8"
	And I select site "Edit Check Site 8"
    And I create a Subject
	| Field            | Value                                                          |
	| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 8,prod,Subject Number)} |
	| Subject Initials |sub805                                                            |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify "Log Field 1" field displays query opened with require response on first record position
	And I take a screenshot
	And I add new log line 2
	And I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify "Log Field 1" field displays query opened with require response on second record position
	And I take a screenshot
	And I add new log line 3
	And I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify "Log Field 1" field displays query opened with require response on third record position
	And I take a screenshot
	
	And I answer the query on "Log Field 1" field on first record position
	And I save the CRF page
	And I answer the query on "Log Field 1" field on seond record position
	And I save the CRF page
	And I answer the query on "Log Field 1" field on third record position
	And I save the CRF page
	
	And I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I close the query on "Log Field 1" field
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I close the query on "Log Field 1" field
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I close the query on "Log Field 1" field
	And I save the CRF page
	And I take a screenshot
	
	And I select edit icon on first record position
	And I select checkbox "Freeze" on "Log Field 1" field on first record position
	And I save the CRF page
	And I select edit icon on second record position
	And I select checkbox "Hadrd Lock" on "Log Field 1" field on second record position
	And I save the CRF page
	And I navigate to "Inactivate"
	And I select "3" in dropdown
	And I select "Inactivate" button
	And I take a screenshot
	
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |7    |
	And I save the CRF page		
	And I verify new query did fire on "Log Field 1" field on first record position
	And I take a screenshot
	And I verify new query did not fire on "Log Field 1" field on second record position
	And I take a screenshot
	And I verify new query did not fire on "Log Field 1" field on third record position
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.10.2
@Draft
Scenario: PB_8.10.2 When I run the Report, then query related data are displayed in the report.
	
	When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceDataPageName 	|CheckActionRecordPosition |CheckActionFieldName 	|CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName 	|TriggerFieldRecordPosition |TriggerFieldName   |TriggerFieldData 	|EditCheckName		|MarkingGroupName 	|QueryMessage                   |EventTime  |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub805       |Mixed Form			            |2                         |Log Field 1      		|18                   |Screening       |Standard 1			             	|2                          |Standard 1			|7               	|Mixed Form Query 	|Site             	|Query Opened on Log Field 1	|{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub805       |Mixed Form			            |3                         |Log Field 1      		|18                   |Screening       |Standard 1			             	|2                          |Standard 1			|7               	|Mixed Form Query 	|Site             	|Query Opened on Log Field 1	|{DateTime} |
	And I take a screenshot
	
#------------------------------------------------------------------------------------------------------------
	