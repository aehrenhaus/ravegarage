@ignore
@FT_564QueryRefiringLogging8_M
Feature: US12940_8.1 Edit Checks with require response and require manual close
	As a Rave user
	I want to change data
	So I can see refired queries
	
# Query Issue: Edit Checks with require response and require manual close

#Data PDF
#Reports - Audit Trail
#Edit Check Log Report
#Query Detail
#Stream-Audit Trail
#Stream-Edit Check Log Report
#Stream-Query Detail
#J-Review
#BOXI

Background:
    Given I login to Rave with user "defuser" and password "password"
	#And following Study assignments exist
	# | User      | Study               | Role | Site              | Site Number |
	# | Defuser   | Edit Check Study 3  | cdm1 | Edit Check Site 8 | 80001       |
	# | Defuser01 | Edit Check Study 3  | cdm1 | Edit Check Site 8 | 80001       |
	# | Defuser   | Edit Check Study 3  | cdm1 | Edit Check Site 1 | 10001       |
	# | Defuser   | AM Edit Check Study | cdm1 | AM Edit Site      | 80002       |
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
	# And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
	# And subject exists sub{Var(num1)} FROM Feaure8_A1.feature
	#Given I login to Rave with user "SUPER USER 1"
	#And I navigate to "DDE"
	#And I select link "First Pass"
	#And I select link "New Batch"
	#And I choose "Edit Check Study 3" from "Study"
	#And I choose "Prod" from "Environment"
	#And I choose "Edit Check Site 8" from "Site"
	#And I type "sub {RndNum<num1>(5)}" in "Subject"
	#And I choose "Subject Identification" from "Form"
	#And I click button "Locate"
	#And I enter data in DDE and save
	#	| Field            | Data        |
	#	| Subject Number   | {Var(num1)} |
	#	| Subject Initials | sub         |	
	#And I choose "Screening" from "Folder"
	#And I choose "Informed Consent" from "Form"
	#And I click button "Locate"
	#And I enter data in DDE and save
	#    | Field                        | Data        |
	#    | Date Informed Consent Signed | 09 Jan 2000 |
	#    | End Date                     | 10 Jan 2000 |
	#    | Original Distribution Number | 10          |
	#    | Current Distribution Number  | 19          |
	#And I choose "Concomitant Medications" from "Form"
	#And I click button "Locate"	
	#And I enter data in DDE log line 1 and save
	#    | Field                | Data        |
	#    | Start Date           | 08 Jan 2000 |
	#    | End Date             | 11 Jan 2000 |
	#    | Original Axis Number | 10          |
	#    | Current Axis Number  | 20          |
	
	#Given I login to Rave with user "SUPER USER 2"
	#And I navigate to "DDE"
	#And I select link "Second Pass"
	#And I choose "Edit Check Study 3" from "Study"
	#And I choose "Prod" from "Environment"
	#And I choose "Edit Check Site 8" from "Site"
	#And I choose "sub {Var(num1)}" from "Subject"
	#And I choose "Subject Identification" from "Form"
	#And I click button "Locate"
	#And I enter data in DDE and save
	#	| Field            | Data        |
	#	| Subject Number   | {Var(num1)} |
	#	| Subject Initials | sub         |
	#And I choose "Screening" from "Folder"
	#And I choose "Informed Consent" from "Form"
	#And I click button "Locate"
	#And I enter data in DDE and save
	#    | Field                        | Data        |
	#    | Date Informed Consent Signed | 09 Jan 2000 |
	#    | End Date                     | 10 Jan 2000 |
	#    | Original Distribution Number | 10          |
	#    | Current Distribution Number  | 19          |
	#And I choose "Concomitant Medications" from "Form"
	#And I click button "Locate"	
	#And I enter data in DDE log line 1 and save
	#    | Field                | Data        |
	#    | Start Date           | 08 Jan 2000 |
	#    | End Date             | 11 Jan 2000 |
	#    | Original Axis Number | 10          |
	#    | Current Axis Number  | 20          |	
	
	#And I navigate to "Home"
	#And I select Study "Edit Check Study 3" and Site "Edit Check Site 8"
	#And I select a Subject "sub{Var(num1)}"
	#When I select Form "Concomitant Medications" in Folder "Screening"
	#And I open log line 1
	#Then I verify Query is displayed
	#	| Field               | Query Message                                                                                                 | Answered | Closed |
	#	| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | false    | false  |
	#	| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | false    | false  |
	#And I take a screenshot
	#And I answer the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date" with "{answer}"
	#And I answer the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number" with "{answer}"
	#And I save the CRF page
	#And I open log line 1
	#And I close the Query "'Date Informed Consent Signed' is greater. Please revise." on Field "Start Date"
	#And I close the Query "Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'." on Field "Current Axis Number"
	#And I save the CRF page
	#And I take a screenshot
	#And I open log line 1
	#And I enter data in CRF and save
	#	| Field               | Data        |
	#	| Start Date          | 09 Jan 2000 |
	#	| Current Axis Number | 19          |
	#And I open log line 1
	#And I verify Query is displayed
	#	| Field               | Query Message                                                                                                 |Answered | Closed |
	#	| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     |true     | true   | 
	#	| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. |true     | true   |
	#And I take a screenshot
	#When I enter data in CRF and save
	#	| Field               | Data        |
	#	| Start Date          | 08 Jan 2000 |
	#	| Current Axis Number | 20          |
	#And I open log line 1
	#Then I verify Query is displayed
	#	| Field               | Query Message                                                                                                 | Answered | Closed |
	#	| Start Date          | 'Date Informed Consent Signed' is greater. Please revise.                                                     | true     | true   |
	#	| Current Axis Number | Informed Consent 'Current Distribution Number' is not equal to Concomitant Medications 'Current Axis Number'. | true     | true   |
		
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.1.1
@Validation
@Manual
Scenario: PB_8.1.1.1 As an user, When I Generate Data PDFs and view Data PDF, then query related data are displayed.
#Can not handle save dialog, must verify manually

	And I navigate to "PDF Generator"
	And I create Data PDF
		| Name                | Profile | Study                     | Role | SiteGroup | Site              | Subject        |
		| pdf{RndNum<num>(3)} | GLOBAL1 | Edit Check Study 3 (Prod) | CDM1 | World     | Edit Check Site 8 | sub{Var(num1)} |
	And I generate Data PDF "pdf{Var(num)}"
	And I wait for PDF "pdf{Var(num)}" to complete
	When I view data PDF "sub{Var(num1)}.pdf" from request "pdf{Var(num)}"
	Then I should see "Query Data" in Audits
	And I take a screenshot 

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.2.1
@Validation
@Manual
Scenario: PB_8.1.2.1 As an user, When I run the 'Audit Trail' Report, then query related data are displayed in the report.

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
	And I search report parameter "User" with "Default User, System"
	And I set report parameter "User" with table
		| Full Name    |
		| Default User |
	When I click button "Submit Report"
	And I switch to "ReportViewer" window
	Then I should see queries on "Start Date" and "Current Axis Number" fields
	And I take a screenshot
	And I close report


#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.2.2
@Validation
@Manual
Scenario: PB_8.1.2.2 As an user, When I run the 'Query Detail' Report, then query related data are displayed in the report.
	
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
	Then I should see queries on "Start Date" and "Current Axis Number" fields
	#And I switch to "ReportViewer" window
	And I take a screenshot
	And I close report

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.2.3
@Validation
@Manual
Scenario: PB_8.1.2.3 As an user, When I run the 'Edit Check Log Report' Report, then query related data are displayed in the report.

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
	Then I should see fired editchecks
	#And I switch to "ReportViewer" window
	And I take a screenshot 
	And I close report

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.2.4
@Validation
@Manual
Scenario: PB_8.1.2.4 As an user, When I run the 'Stream-Audit Trail' Report, then query related data are displayed in the report.

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
	And I take a screenshot 1 of 1
	# And I switch to main window
	# And I save the file 
	And I open excel file
	Then I should see queries on "Start Date" and "Current Axis Number" fields
	And I take a screenshot 1 of 2
	And I close report
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.2.5
@Validation
@Manual
Scenario: PB_8.1.2.5 As an user, When I run the 'Stream-Query Detail' Report, then query related data are displayed in the report.

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
		| Concomitant Medications |
	And I click button "Submit Report"
	And I switch to "Stream Report" window of type "StreamReport"
	#And Im on windows
	And I type "." in "Separator"
	And I choose ".csv (text/plain)" from "File type"
	And I choose "attachment" from "Export type"
	And I uncheck "Save as Unicode"
	And I click button "Download File"
	And I take a screenshot 
	#And I switch to main window
	And I open excel file
	Then I should see queries on "Start Date" and "Current Axis Number" fields
	And I take a screenshot 
	And I close report

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.2.6
@Validation
@Manual
Scenario: PB_8.1.2.6 As an user, When I run the 'Stream-Edit Check Log Report' Report, then query related data are displayed in the report.

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
	And Im on windows
	And I type "." in "Separator"
	And I choose ".csv (text/plain)" from "File type"
	And I choose "attachment" from "Export type"
	And I uncheck "Save as Unicode"
	When I click button "Download File"
	And I take a screenshot
	#And I switch to main window
	And I open excel file
	Then I should see queries on "Start Date" and "Current Axis Number" fields
	And I take a screenshot 
	And I close report
	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.2.7
@Validation
@Manual
Scenario: PB_8.1.2.7 As an user, When I run the 'J-Review' Report, then query related data are displayed in the report.

	And I navigate to "Reporter"
	And I select Report "J-Review"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3 | Prod        |
	And I click button "Submit Report"
	And I select link "Edit Check Study 3" "Prod" from "Studies"
	And I click button "Reports"
	And I select link "Detail Data Listing" report from "Type" in "Report Browser"
	And I select link "MetricViews" from "Panels"
	And I select link "Queries" from "MetricViews"
	And I select link "Project, Site, Subject, Datapage, Field, Record Position QueryText, QueryStatus, Answered Data, Answer Text"
	When I click button "Create Report"
	Then I should see "sub{Var(num1)}"
	And I should see "Added Query" in "QueryText"
	And I take a screenshot 
	And I Close "Detail Data Listing" 

	
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_8.1.2.8
@Validation
@Manual
Scenario: PB_8.1.2.8 As an user, When I run the 'BOXI' Report, then query related data are displayed in the report.

	And I navigate to "Reporter"
	And I select report "Business Objects XI"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| Edit Check Study 3 | Prod        |
	And I click button "Submit Report"
	And I select dropdown "New"
	And I select link "Web Intelligence Document"
	And I select link "Rave 5.6 Universe"
	And I select link "Project Name, Site Name, Subject Name, Folder Name, Form Name, Query Text" in "Results Objects"
	And I select link "Site Name, Subject Name, Folder Name, FormName" in "Query Filters"
	And I select link "Equal To" from "In List" in "Query Filters" for "Site Name"
	And Enter "Value(s) from list" "Edit Check Site 8" in "Query Filters" for "Site Name"
	And I select link "Equal To" from "In List" in "Query Filters" for "Subject Name"		
	And Enter "Value(s) from list" "sub{Var(num1)}" in "Query Filters" for "Subject Name"
	And I select link "Equal To" from "In List" in "Query Filters" for "Folder Name"		
	And Enter "Value(s) from list" "Screening" in "Query Filters" for "Folder Name"
	And I select link "Equal To" from "In List" in "Query Filters" for "Form Name"		
	And Enter "Value(s) from list" "Concomitant Medications" in "Query Filters" for "Form Name"
	When I click button "Run Query"
	Then I should see "sub{Var(num1)}"
	And I should see "Added Query" in "QueryText"
	And I take a screenshot 
	And I Close "BOXI Report"

	
#----------------------------------------------------------------------------------------------------------------------------------------	
