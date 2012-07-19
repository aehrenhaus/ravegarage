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

Background:

    Given I am logged in to Rave with username "defuser" and password "password"
	#And following Study assignments exist
	# | User       | Study               | Role | Site              | Site Number |
	# | editcheck  | Edit Check Study 8  | cdm1 | Edit Check Site 8 | 80001       |
	# | editcheck1 | Edit Check Study 8  | cdm2 | Edit Check Site 8 | 80001       |
	# | editcheck  | AM Edit Check Study | cdm1 | AM Edit Site      | 80002       |
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

 And I navigate to "PublishChecksHome" page with parameters
	| Name   | Value       |
	| step   | 17          |
	| action | selectcrfs  |
	| val    | 1514%3a1532 |




@release_564_Patch11
@PB_8.1.1
@Draft
Scenario: PB_8.1.1 As an EDC user, Data setup and verification for query re-firing. Folder "Screening" enter and save data on forms "Informed Consent" and "Concomitant Medications"
	
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
	
	And I am logged in to Rave with username "Defuser01" and password "password"
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
	And I verify Query is not displayed
		| Field               | Message                                                                                                       | Closed |
		| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | true   |
		| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true   |
	And I take a screenshot
	When I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 08 Jan 2000 |
		| Current Axis Number | 20          |
	And I open log line 1
	Then I verify closed Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify closed Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"

	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.2
@Draft
Scenario: PB_8.1.2
 
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
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I save the CRF page
	And I take a screenshot
	And I open log line 2
	And I verify Query is not displayed
         | Field      | Closed |
         | Start Date | false  |
	And I verify Query is displayed
         | Field               | Closed |
         | Current Axis Number | true  |

	And I take a screenshot
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open log line 2
	And I verify Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
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
	And I open log line 3
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	And I cancel the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I cancel the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	And I enter data in CRF
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I save the CRF page
	And I take a screenshot
	And I open log line 3
	And I verify Field "Start Date" has no Query
	And I verify Field "Current Axis Number" has no Query
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
@PB_8.2.1
@Draft
Scenario: PB_8.2.1 Task Summary

	And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
    And I select a Subject "sub{Var(num1)}"
	When I expand "Open Queries" in Task Summary
	Then I should see "Screening-Concomitant Medications" in "Open Queries"
	And I select "Screening-Concomitant Medications" in "Open Queries"
	And I open log line 3
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
	And I select Study "Edit Check Site 8" in "Header"
    And I select a Subject "sub{Var(num1)}"
	When I expand "Cancel Queries" in Task Summary
	Then I should see "Screening-Concomitant Medications" in "Cancel Queries"
	And I select "Screening-Concomitant Medications" in "Cancel Queries"
	And I open log line 3
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
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
	And I choose "sub70841" from "Subject"
	And I click button "Advanced Search"

	And I select Form "Concomitant Medications" in "Search Result"
	And I open log line 2
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"	
	And I take a screenshot
	And I open log line 3
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"	
	And I take a screenshot
	And I click button "Cancel"
	And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 07 Jan 2000 |
	    | End Date             | 12 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 20          |
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
	And I open the last log line
	And I verify Field "Start Date" has no Query
	And I verify Field "Current Axis Number" has no Query
	And I take a screenshot
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open the last log line
	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.3.2
@Draft
Scenario: PB_8.3.2
	
	And I navigate to "Query Management"
	And I choose "Edit Check Study 3 (Prod)" from "Study"
	And I choose "World" from "Site Group"
	And I choose "Edit Check Site 8" from "Site"
	And I choose "sub70841" from "Subject"
	And I click button "Advanced Search"

	And I select Form "Concomitant Medications" in "search result"
	And I enter data in CRF on a new log line and save and reopen
	    | Field                | Data        |
	    | Start Date           | 07 Jan 2000 |
	    | End Date             | 12 Jan 2000 |
	    | Original Axis Number | 10          |
	    | Current Axis Number  | 18          |

	And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"		
	And I take a screenshot
	And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "{answer}"
	And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "{answer}"
	And I save the CRF page
	And I open the last log line
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 09 Jan 2000 |
		| Current Axis Number | 19          |
	And I open the last log line
	And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"	
	And I save the CRF page
	And I take a screenshot
	And I open the last log line
	And I verify Field "Start Date" has no Query
	And I verify Field "Current Axis Number" has no Query
	And I take a screenshot
	And I enter data in CRF and save
		| Field               | Data        |
		| Start Date          | 07 Jan 2000 |
		| Current Axis Number | 18          |
	And I open the last log line
	#And I verify Requires Response Query with message "'Date Informed Consent Signed' is greater. Please revise." is displayed on Field "Start Date"
	#And I verify Requires Response Query with message "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." is displayed on Field "Current Axis Number"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.4.1
@Draft
Scenario: PB_8.4.1 Generate the Data PDFs.
	And I navigate to "PDF Generator"

	And I create Data PDF
	| Name                | Profile | Study                     | Role | SiteGroup | Site              | Subject  |
	| pdf{RndNum<num>(3)} | GLOBAL1 | Edit Check Study 3 (Prod) | CDM1 | World     | Edit Check Site 8 | sub70841 |
	
	And I generate Data PDF "pdf{Var(num)}"
	And I wait for PDF "pdf{Var(num)}" to complete
#Can not handle save dialog, must verify manually
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
	And I search report parameter "Study" with "Edit Check Study 3"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3 | Prod        |
	And I set report parameter "Sites" with table
		| Name              |
		| Edit Check Site 8 |
	And I set report parameter "Subjects" with table
		| Name           |
		| sub{Var(num1)} |
	And I set report parameter "Folders" with table
		| Name      |
		| Screening |
	And I set report parameter "Forms" with table
		| Name                    |
		| Informed Consent        |
		| Concomitant Medications |
	And I set report parameter "Fields" with table
		| Name          |
		| CM_STRT_DT    |
		| CURR_AXIS_NUM |
	And I set report parameter "Start Date" with "{Date(0)}"
	And I set report parameter "End Date" with "{Date(0)}"
	And I search report parameter "Audit Type" with "Query"
	And I set report parameter "Audit Type" with table
		| SubCategory |
		| QueryOpen   |
	And I search report parameter "User" with "Default User"
	And I set report parameter "User" with table
		| Full Name    |
		| Default User |
	And I click button "Submit Report"
	And I switch to "ReportViewer" window
	And I take a screenshot
	And I switch to main window
	
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
	And I select Report "Query Detail"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3 | Prod        |
	And I set report parameter "Sites" with table
		| Name              |
		| Edit Check Site 8 |
	And I set report parameter "Subjects" with table
		| Name           |
		| sub{Var(num1)} |
	And I set report parameter "Folders" with table
		| Name      |
		| Screening |
	And I set report parameter "Forms" with table
		| Name                    |
		| Informed Consent        |
		| Concomitant Medications |
	And I set report parameter "Fields" with table
		| Name          |
		| CM_STRT_DT    |
		| CURR_AXIS_NUM |
	And I set report parameter "Marking Groups" with table
		| Group Name      |
		| Site            |
		| Marking Group 1 |
	And I set report parameter "Query Status" with table
		| Name |
		| Open |
	And I set report parameter "Start Date" with "{Date(0)}"
	And I set report parameter "End Date" with "{Date(0)}"

	When I click button "Submit Report"

	#Then I should see queries on "Start Date" and "Current Axis Number" fields
	And I switch to "ReportViewer" window
	And I take a screenshot
	And I switch to main window

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.5.3
@Draft
Scenario: PB_8.5.3 When I run the Report, then query related data are displayed in the report.

#Edit Check Log Report	
	And I navigate to "Reporter"
	And I select Report "Edit Check Log Report"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3 | Prod        |
	And I set report parameter "Forms" with table
		| Form Name               |
		| Concomitant Medications |
		| Informed Consent        |

	And I set report parameter "Check Type" with table
		| Check Type |
		| Edit Check |
	
	And I set report parameter "Check Log Type" with table
		| Check Log Type |
		| CheckExecution |
	When I click button "Submit Report"

	#Then I should see fired editchecks
	And I switch to "ReportViewer" window
	And I take a screenshot
	And I switch to main window

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.5.4
@Draft
Scenario: PB_8.5.4 When I run the Report, then query related data are displayed in the report.

#Stream-Audit Trail	
	And I navigate to "Reporter"
	And I select Report "Stream-Audit Trail"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3 | Prod        |
	And I set report parameter "Sites" with table
		| Name              |
		| Edit Check Site 8 |
	And I set report parameter "Subjects" with table
		| Name           |
		| sub{Var(num1)} |
	And I set report parameter "Folders" with table
		| Name      |
		| Screening |
	And I set report parameter "Forms" with table
		| Name                    |
		| Concomitant Medications |

	And I click button "Submit Report"
	And I switch to "Stream Report" window of type "StreamReport"
	#And Im on windows
	And I type "." in "Separator"
	And I choose ".csv (text/plain)" from "File type"
	And I choose "attachment" from "Export type"
	And I check "Save as Unicode"
	And I click button "Download File"
	And I take a screenshot
	And I switch to main window

	#And I open excel file
	#Then I should see queries on "Start Date" and "Current Axis Number" fields
	#And I take a screenshot
	#And I close report
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.5.5
@Draft
Scenario: PB_8.5.5 When I run the Report, then query related data are displayed in the report.

#Stream-Query Detail	
	And I navigate to "Reporter"
	And I select Report "Stream-Query Detail"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3 | Prod        |
	And I set report parameter "Sites" with table
		| Name              |
		| Edit Check Site 8 |
	And I set report parameter "Subjects" with table
		| Name           |
		| sub{Var(num1)} |
	And I set report parameter "Folders" with table
		| Name      |
		| Screening |
	And I set report parameter "Forms" with table
		| Name                    |
		| Concomitant Medications       |

	And I click button "Submit Report"

	And I switch to "Stream Report" window of type "StreamReport"
	#And Im on windows
	And I type "." in "Separator"
	And I choose ".csv (text/plain)" from "File type"
	And I choose "attachment" from "Export type"
	And I uncheck "Save as Unicode"
	And I click button "Download File"
	And I take a screenshot
	And I switch to main window


	#And I open excel file
	#Then I should see queries on "Start Date" and "Current Axis Number" fields
	#And I take a screenshot
	#And I close report

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.5.6
@Draft
Scenario: PB_8.5.6 When I run the Report, then query related data are displayed in the report.

#Stream-Edit Check Log Report	
	And I navigate to "Reporter"
	And I select Report "Stream-Edit Check Log Report"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3 | Prod        |
	
	And I set report parameter "Forms" with table
		| Form Name                    |
		| Concomitant Medications       |
	And I set report parameter "Check Type" with table
		| Check Type |
		| Edit Check |
	
	And I set report parameter "Check Log Type" with table
		| Check Log Type |
		| CheckExecution |
	
	And I click button "Submit Report"
	
	And I switch to "Stream Report" window of type "StreamReport"
	#And Im on windows
	And I type "." in "Separator"
	And I choose ".csv (text/plain)" from "File type"
	And I choose "attachment" from "Export type"
	And I uncheck "Save as Unicode"
	And I click button "Download File"
	And I take a screenshot
	And I switch to main window

	#And I open excel file
	#Then I should see queries on "Start Date" and "Current Axis Number" fields
	#And I take a screenshot
	#And I close report
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.6.1
@Draft
Scenario: PB_8.6.1 When I run the Report, then query related data are displayed in the report.J-Review verification.
#MANUAL
	And I navigate to "Reporter"
	And I select Report "J-Review"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3 | Prod        |
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
#MANUAL
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
	
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num2>(5)} |
	| Subject Initials | sub               |
	And I note down "crfversion" to "ver#"
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I open log line 1
	And I verify Requires Response Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answer query"
	And I save the CRF page
	And I open log line 1
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I save the CRF page
	#And I note CRF Version "<Source CRF Version1>"
	And I take a screenshot
	
	And I select Site "AM Edit Site" in "Header"
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num3>(5)} |
		| Subject Initials | sub               |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I open log line 1
	And I verify Requires Response Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"	
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answer query"
	And I save the CRF page
	And I open log line 1
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |5    |
	And I open log line 1
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I save the CRF page
	#And I note CRF Version "<Source CRF Version1>"
	And I take a screenshot
	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "AM Edit Check Study" in "Active Projects"
	And I create Draft "Draft {RndNum<d#>(5)}" from Project "AM Edit Check Study" and Version "V9  ({Var(ver#)})"

	And I navigate to "Edit Checks"
	And I inactivate edit check "Mixed Form Query"
	And I take a screenshot
	And I select Draft "Draft {Var(d#)}" in "Header"
	And I publish CRF Version "Target{RndNum<TV#>(3)}"
	And I note down "crfversion" to "newversion#"
	And I select Study "AM Edit Check Study" in "Header"
	And I navigate to "Amendment Manager"
	And I choose "V9  ({Var(ver#)})" from "Source CRF"
	And I choose "{Var(newversion#)}" from "Target CRF"
	And I click button "Create Plan"
	And I take a screenshot
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot
	
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I select a Subject "sub{Var(num2)}"
	And I select Form "Mixed Form"
	And I open the last log line
	And I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |4    |
	And I verify Query with message "Query Opened on Log Field 1" is not displayed on Field "Log Field 1"
	#And I verify new query did not fire on "Log Field 1" field
	And I enter data in CRF on a new log line and save
		|Field       |Data |
	    |Log Field 1 |3    |
	    |Log Field 2 |2    |
	And I open the last log line
	And I verify Query with message "Query Opened on Log Field 1" is not displayed on Field "Log Field 1"
	And I take a screenshot
	
	And I select Site "AM Edit Site" in "Header"
    And I select a Subject "sub{Var(num3)}"
	And I select Form "Mixed Form"
	And I open the last log line
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |8	   |
	And I save the CRF page	
	And I verify Query with message "Query Opened on Log Field 1" is not displayed on Field "Log Field 1"
	And I enter data in CRF on a new log line and save 
		|Field       |Data |
	    |Log Field 1 |6    |
	    |Log Field 2 |2    |
	And I open the last log line
	And I verify Query with message "Query Opened on Log Field 1" is not displayed on Field "Log Field 1"
	And I take a screenshot
	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "AM Edit Check Study" in "Active Projects"
	And I select "Draft {Var(d#)}" in "CRF Drafts"

	And I navigate to "Edit Checks"
	And I activate edit check "Mixed Form Query"

	And I select Draft "Draft {Var(d#)}" in "Header"
	And I publish CRF Version "Target{RndNum<TV#>(3)}"
	And I note down "crfversion" to "newversion1#"
	And I select Study "AM Edit Check Study" in "Header"
	And I navigate to "Amendment Manager"
	And I choose "{Var(newversion#)}" from "Source CRF"
	And I choose "{Var(newversion1#)}" from "Target CRF"
	And I click button "Create Plan"
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot
	
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I select a Subject "sub{Var(num2)}"
	And I select Form "Mixed Form"
	And I open log line 1
	And I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I click button "Cancel"
	And I open log line 2
	And I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I take a screenshot
	
	And I select Site "AM Edit Site" in "Header"
    And I select a Subject "sub{Var(num3)}"
	And I select Form "Mixed Form"
	And I open log line 1
	And I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I click button "Cancel"
	And I open log line 2
	And I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.9.1
@Draft
Scenario: PB_8.9.1 Publish Checks

	And I navigate to "Architect"
	And I select "AM Edit Check Study" in "Active Projects"
	And I select "Draft 1" in "CRF Drafts"
	And I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion1#"
	And I select "AM Edit Check Study" in "Header"
	And I push CRF Version "{Var(newversion1#)}" to "All Sites"
	And I select "Draft 1" in "CRF Drafts"


	And I publish CRF Version "Pub2{RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion2#"
	And I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion3#"
	
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num4>(5)} |
		| Subject Initials | sub               |
	#And I note down "crfversion" to "ver#"
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I open the last log line
	And I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I take a screenshot
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answer query"
	And I save the CRF page
	And I open the last log line
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I save the CRF page
	And I open the last log line
	And I take a screenshot
	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "AM Edit Check Study" in "Active Projects"
	And I select "Publish Checks"
	And I choose "{Var(newversion1#)}" from "Current CRF Version"
	And I choose "{Var(newversion2#)}" from "Reference CRF Version"
	And I click button "Create Plan"
	And I check "Inactivate" in "Mixed Form Query"
	And I select "Save"
	And I take a screenshot
	And I select "Publish"
	And I accept alert window
	And I select "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot
	
	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I select a Subject "sub{Var(num4)}"
	And I select Form "Mixed Form"
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |7    |
	And I open the last log line
	And I verify Query is displayed
         | Field       | Query Message               | Closed |
         | Log Field 1 | Query Opened on Log Field 1 | true   |
	And I take a screenshot
	
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "AM Edit Check Study" in "Active Projects"
	And I select "Publish Checks"
	And I choose "{Var(newversion1#)}" from "Current CRF Version"
	And I choose "{Var(newversion3#)}" from "Reference CRF Version"
	And I click button "Create Plan"
	And I check "Publish" in "Mixed Form Query"
	And I select "Save"
	And I take a screenshot
	And I select "Publish"
	And I accept alert window
	And I select "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot

	And I navigate to "Home"
	And I select Study "AM Edit Check Study" and Site "AM Edit Site"
    And I select a Subject "sub{Var(num4)}"
	And I select Form "Mixed Form"
	And I open the last log line
	And I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	


	And I take a screenshot
	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |8    |
	And I open the last log line
	And I verify Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answer query"
	And I save the CRF page

	And I take a screenshot
	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.10.1
@Draft
Scenario: PB_8.10.1 When I run the Report, then query related data are displayed in the report. Queries verification on data points with Freeze, Hard lock and Inactive records

	And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | sub               |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I open the last log line
	And I verify Requires Response Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answered"
	And I save the CRF page
	And I open the last log line
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I enter data in CRF
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I save the CRF page
	And I open the last log line
	And I take a screenshot
	And I check "Freeze" on "Log Field 1"
	And I save the CRF page
	And I open the last log line
	And I take a screenshot

	And I click button "Cancel"
	And I add a new log line
	And I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I open the last log line
	And I verify Requires Response Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answered"
	And I save the CRF page
	And I open the last log line
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I enter data in CRF
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I save the CRF page
	And I open the last log line
	And I take a screenshot
	And I check "Hard Lock" on "Log Field 1"
	And I save the CRF page
	And I open the last log line
	And I take a screenshot

	And I click button "Cancel"
	And I add a new log line
	And I enter data in CRF and save
	    |Field       |Data |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I open the last log line
	And I verify Requires Response Query with message "Query Opened on Log Field 1" is displayed on Field "Log Field 1"
	And I answer the Query "Query Opened on Log Field 1" on Field "Log Field 1" with "answered"
	And I save the CRF page
	And I open the last log line
	And I close the Query "Query Opened on Log Field 1" on Field "Log Field 1"
	And I enter data in CRF
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I save the CRF page
	And I open the last log line
	And I take a screenshot
	And I click button "Cancel"
	And I select "Inactivate"
	And I choose "3" from "Inactivate"
	And I click button "Inactivate"
	And I take a screenshot

	And I enter data in CRF and save
		|Field       |Data |
        |Standard 1  |7    |
	And I open log line 1
	And I verify Query is displayed
		| Field      | Query Message               | Answered | Closed |
		| Start Date | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I click button "Cancel"
	And I open log line 2
	And I verify Query is not displayed
		| Field      | Query Message               | Answered | Closed |
		| Start Date | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
	And I click button "Cancel"
	And I select "Reactivate"
	And I choose "3" from "Reactivate"
	And I click button "Reactivate"
	And I take a screenshot
	And I open log line 3
	And I verify Query is displayed
		| Field      | Query Message               | Answered | Closed |
		| Start Date | Query Opened on Log Field 1 | false    | false  |
	And I take a screenshot
