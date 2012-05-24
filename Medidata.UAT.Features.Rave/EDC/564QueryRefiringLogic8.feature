Feature: Feaature 8

Background:
    Given I login to Rave with user "DefaultUser"
	And user "User"  has study "Study" has role "Role" has site "Site" has Site Number in database "<EDC>", from the table below
		|User			|Study		       	|Role |Site		        	|Site Number |
		|editcheck  	|Edit Check Study 8	|cdm1 |Edit Check Site 8 	|80001       |
		|editcheck1 	|Edit Check Study 8	|cdm2 |Edit Check Site 8 	|80001       |
		|editcheck	 	|AM Edit Check Study|cdm1 |AM Edit Site		 	|80002       |	
	And role "cdm1" has Query actions
	And role "cdm2" has Query actions
	And study "Edit Check Study" had draft "<Draft1>"
	And I publish and push "CRF Version<RANDOMNUMBER>" to site "Edit Check Site 8"
	And I set and save "Threshold" in Configuration, Other Settings, Advance Configuration to "Value", from the table below
			|Threshold					|Value	|
			|Check Resolution Threshold	|0		|
			|Check Execution Threshold	|0		|
			|Custom Function Threshold	|0		|
	And I do cacheflush
	
	
Scenario: Data setup and verification for query re-firing.
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
	
	And I login to Rave as user "editcheck" with password "<Password>"
	And I select "DDE Module"
	And I selct link "First Pass"
	And I select "Edit Check Study 8, Prod, Edit Check Site 8"
	And I enter "sub801"
	And I select "Primary" form
	And I enter data in CRF
And I save CRF
	    |Field          |Data	|
		|Subject Name	|sub	|
		|Subject Number	|801	|
	And I select folder "Test A Single Edit" form "Informed Consent Date Form 1"
	And I select button "Locate"
	And I enter and submit the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take screenshot
    And I enter and submit the following data in folder "Test A Single Edit" form "Assessment Date Log2", from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	
	And I logout and login to Rave as user "editcheck1" with password "<Password>"
	And I select "DDE Module"
	And I selct link "Second Pass"
	And I select "Edit Check Study 8, Prod, Edit Check Site 8"
	And I enter "sub801"
	And I select "Primary" form
	And I enter data in CRF
And I save CRF
	    |Field          |Data	|
		|Subject Name	|sub	|
		|Subject Number	|801	|
	And I select folder "Test A Single Edit" form "Informed Consent Date Form 1"
	And I select button "Locate"
	And I enter and submit the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take screenshot
    And I enter and submit the following data in folder "Test A Single Edit" form "Assessment Date Log2", from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |		
		
	And I select link "Home"
	And I select "Edit Check Study 8, Prod, Edit Check Site 8"
	And I Select "sub801"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I verify Field "Assessment Date 1" displays Query with Requires Response
    And I verify Field "Numeric Field 2" displays Query with Requires Response
	And I take screenshot
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save CRF
	And I close the Query on Field "Assessment Date 1, Numeric Field 2"
	And I save CRF
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save CRF
    And I verify the queries did not fire on "Assessment Date 1" field and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save CRF	
	And I verify new queries did not fire on "Assessment Date 1" field and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2			  |1                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot
 
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I add a new Log Line
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |18          |
	And I verify Field "Assessment Date 1" displays Query with Requires Response
    And I verify Field "Numeric Field 2" displays Query with Requires Response
	And I take screenshot
	And I answer the Query on Field "Assessment Date 1, Numeric Field 2"
	And I save CRF
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |
	And I close the Query on Field "Assessment Date 1, Numeric Field 2"
	And I save CRF
	And I take screenshot
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save CRF 
	And I verify new queries did fire on "Assessment Date 1" and "Numeric Field 2" fields	
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Test A Single Edit      |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Test A Single Edit      |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot
	
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I add a new Log Line
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |18          |
	And I verify Field "Assessment Date 1" displays Query with Requires Response
    And I verify Field "Numeric Field 2" displays Query with Requires Response
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save CRF 
	And I verify new queries did fire on "Assessment Date 1" and "Numeric Field 2" fields	
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Test A Single Edit      |Assessment Date Log2            |3                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Test A Single Edit      |Assessment Date Log2            |3                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot

#------------------------------------------------------------------------------------------------------------
Scenario: Task Summary

	And I navigate to a "Edit Check Study 8, Edit Check Site 8"
	And I select subject "sub801"
	And I select "Open Query" located in Task Summary
	When I select right arrow image for "Open Queries" located in "Task Summary"
	Then I should see added query on form 'Assessment Date Log2'
	When I select 'Test A Single Edit-Assessment Date Log2'
	Then I verify Field "Assessment Date 1" displays Query with Requires Response
    And I verify Field "Numeric Field 2" displays Query with Requires Response
	And I take screenshot
	
	And I select subject "sub801"
	And I select "Cancel Query" located in Task Summary
	When I select right arrow image for "Cancel Queries" located in "Task Summary"
	Then I should see added query on form 'Assessment Date Log2'
	When I select 'Test A Single Edit-Assessment Date Log2'
	Then I verify Field "Assessment Date 1" displays Query with Requires Response and Cancel
    And I verify Field "Numeric Field 2" displays Query with Requires Response and Cancel
	And I take screenshot
	
#------------------------------------------------------------------------------------------------------------
Scenario: Query Management

	And I select "Query Management"
	And I seelct "Edit Check Study 8 (Prod),  World, Edit Check Site 8, sub801"
	And I select link Search
	And I select link form "Assessment Date Log2" for subject "sub801"
	And I verify Field "Assessment Date 1" displays Query with Requires Response
    And I verify Field "Numeric Field 2" displays Query with Requires Response
	And I take screenshot
	And I verify Field "Assessment Date 1" displays Query with Requires Response
    And I verify Field "Numeric Field 2" displays Query with Requires Response
	And I take screenshot
	
    And I add a new Log Line
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |18          |
	And I verify Field "Assessment Date 1" displays Query with Requires Response
    And I verify Field "Numeric Field 2" displays Query with Requires Response
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save CRF 
	And I verify new queries did fire on "Assessment Date 1" and "Numeric Field 2" fields	
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Test A Single Edit      |Assessment Date Log2            |4                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Test A Single Edit      |Assessment Date Log2            |4                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot
	
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I add a new Log Line
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |18          |
	And I verify Field "Assessment Date 1" displays Query with Requires Response
    And I verify Field "Numeric Field 2" displays Query with Requires Response
	And I take screenshot
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save CRF
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |
	And I save CRF	
	And I close the Query on Field "Assessment Date 1, Numeric Field 2"
	And I save CRF
	And I take screenshot
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save CRF 
	And I verify new queries did fire on "Assessment Date 1" and "Numeric Field 2" fields	
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Test A Single Edit      |Assessment Date Log2            |5                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub801       |Test A Single Edit      |Assessment Date Log2            |5                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot
	
#------------------------------------------------------------------------------------------------------------
 Scenario: Generate the Data PDFs.

	And I select "PDF Generator Module"
	And I create Data PDF for Subject "sub801"
	And I generate Data PDF
	When I View Data PDF
	Then I should see "Query Data" in Audits
	And I take screenshot
	
#------------------------------------------------------------------------------------------------------------
 Scenario: When I run the Report, then query related data are displayed in the report.

Audit Trail
Edit Check Log Report
Query Detail
Stream-Audit Trail
Stream-Edit Check Log Report
Stream-Query Detail

#Audit Trail Report
	And I login to Rave as user "<User 1>" with password "<Password>"
	And I select "Reporter Module"
	And I select link "Audit Trail Report"
	And I select study "Edit Check Study 8"
	And I select site "Edit Check Site 8"
	And I select subject "sub801"
	And I select Folders "Test A Single Edit"
	And I select Forms "Informed Consent Date Form ", "Assessment Date Log2"
	When I select button "Submit Report"
	Then I should see queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I close report

#Query Detail	
	And I select "Reporter Module"
	And I select link "Query Detail"
	And I select study "Edit Check Study 8"
	And I select site "Edit Check Site 8"
	And I select subject "sub801"
	And I select Folders "Test A Single Edit"
	And I select Forms "Informed Consent Date Form ", "Assessment Date Log2"
	When I select button "Submit Report"
	Then I should see queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I close report

#Edit Check Log Report	
	And I select "Reporter Module"
	And I select link "Edit Check Log Report"
	And I select study "Edit Check Study 8"
	And I select site "Edit Check Site 8"
	And I select subject "sub801"
	And I select Form "Assessment Date Log2"
	And I select checkbox "Edit Check" for "Check Type"
	And I select checkbox Check "CheckExecution" for "Log Type"
	When I select button "Submit Report"
	Then I should see fired editchecks
	And I take screenshot
	And I close report

#Stream-Audit Trail	
	And I select "Reporter Module"
	And I select link "Stream-Audit Trail"
	And I select study "Edit Check Study 8"
	And I select site  "Edit Check Site 8"
	And I select subject "sub801"
	And I select Folders "Test A Single Edit"
	And I select Forms "Informed Consent Date Form ", "Assessment Date Log2"
	And I select button "Submit Report"
	When I select "Parameter" to "Value", from the tabe below
		|Parameter			|Value		|
		|Separator			|.			|	
		|File type			|.csv		|
		|Export type		|attachment	|
		|Save as Unicode	|Unchecked	|
	And I open excel file
	Then I should see queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I close report

#Stream-Query Detail	
	And I select "Reporter Module"
	And I select link "Stream-Query Detail"
	And I select study "Edit Check Study 8"
	And I select site  "Edit Check Site 8"
	And I select subject "sub801"
	And I select Folders "Test A Single Edit"
	And I select Forms "Informed Consent Date Form ", "Assessment Date Log2"
	And I select button "Submit Report"
	When I select "Parameter" to "Value", from the tabe below
		|Parameter			|Value		|
		|Separator			|.			|	
		|File type			|.csv		|
		|Export type		|attachment	|
		|Save as Unicode	|Unchecked	|
	And I open excel file
	Then I should see queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I close report

#Stream-Edit Check Log Report	
	And I select "Reporter Module"
	And I select link "Stream-Edit Check Log Report"
	And I select study "Edit Check Study 8"
	And I select site "Edit Check Site 8"
	And I select subject "sub801"
	And I select Form "Assessment Date Log2"
	And I select checkbox "Edit Check" for "Check Type"
	And I select checkbox Check "CheckExecution" for "Log Type"
	And I select button "Submit Report"
	And I select "Parameter" to "Value", from the tabe below
		|Parameter			|Value		|
		|Separator			|.			|	
		|File type			|.csv		|
		|Export type		|attachment	|
		|Save as Unicode	|Unchecked	|
	When I open excel file
	Then I should see fired editchecks
	And I take screenshot
	And I close report
	
#------------------------------------------------------------------------------------------------------------
 Scenario: J-Review verification.

	And I login to Rave as user "<User 1>" with password "<Password>"	
	And I select link "Home"
	And I select "Reporter Module"
	And I select "J-Review"
	And I select "Edit Check Study 8"
	And I select button "Submit Report"
	And I select "Edit Check Study 8" "Prod" from "Studies"
	And I select button "Reports"
	And I select "Detail Data Listing" report from "Type" in "Report Browser"
	And I select "MetricViews" from "Panels"
	And I select "Queries" from "MetricViews"
	And I select "Project, Site, Subject, Datapage, Field, Record Position QueryText, QueryStatus, Answered Data, Answer Text"
	When I select button "Create Report"
	Then I should see "sub801"
	And I should see "Added Query" in "QueryText"
	And I take screenshot
	And I Close "Detail Data Listing" 
	
#------------------------------------------------------------------------------------------------------------
 Scenario: BOXI report verification.

	And I login to Rave as user "editcheck1" with password "<Password>"	
	And I select "Reporter Module"
	And I select "Business Objects XI"
	And I select "Edit Check Study 8"
	And I select button "Submit Report"
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
	And Enter "Value(s) from list" "Test A Single Edit" in "Query Filters" for "Folder Name"
	And I select "Equal To" from "In List" in "Query Filters" for "Form Name"		
	And Enter "Value(s) from list" "Assessment Date Log2" in "Query Filters" for "Form Name"
	When I select button "Run Query"
	Then I should see "sub801"
	And I should see "Added Query" in "QueryText"
	And I take screenshot
	And I Close "BOXI Report"
	
#------------------------------------------------------------------------------------------------------------
 Scenario: Migrate Subject

	And I login to Rave as user "editcheck" with password "<Password>"
	And I select "AM Edit Check Study"
	And I select site "AM Edit Site"
    And I create a Subject "sub802"
	And I select form "Mixed Form"
	And I enter data in CRF
And I save CRF
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify Field "Log Field 1" displays Query with Requires Response
	And I answer the query on "Log Field 1" field
	And I save CRF
	And I close the query on "Log Field 1" field
	And I save CRF
	And I note CRF Version "<Source CRF Version1>"
	And I take screenshot
	
	And I select site "AM Edit Site"
    And I create a Subject "sub803"
	And I select form "Mixed Form"
	And I enter data in CRF
And I save CRF
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify Field "Log Field 1" displays Query with Requires Response	
	And I answer the query on "Log Field 1" field
	And I save CRF
	And I enter data in CRF
		|Field       |Data |
        |Standard 1  |5    |
	And I close the query on "Log Field 1" field
	And I save CRF
	And I note CRF Version "<Source CRF Version1>"
	And I take screenshot
	
	And I select link "Home"
	And I select link "Architect"
	And I select link "AM Edit Check Study"
	And I select link "Draft 1"
	And I select link "Edit Checks"
	And I select edit image for "Mixed Form Query" Edit Check
	And I unselect checkbox "Active"
	And I select  link "Update"
	And I select link "Draft 1"	
	And I publish CRF Version
	And I note CRF Version "<Target CRF Version1>"
	And I select link "AM Edit Check Study"
	And I select link "Amendment Manager"
	And I select "<Source CRF Version1>" from dropdown "Source CRF"
	And I select "<Target CRF Version1>" from dropdown "Target CRF"
	And I select button "Create Plan"
	And I take screenshot
	
	And I Migrate "All Subjects"
	And I select Migration Results and verify Job Status is set to Complete
	And I take screenshot
	
	And I select link "Home"
	And I select "AM Edit Check Study"
	And I select site "AM Edit Site"
    And I select a subject "sub802"
	And I select form "Mixed Form"
	And I enter data in CRF
	    |Field       |Data |
	    |Log Field 1 |4    |
	And I verify new query did not fire on "Log Field 1" field
	And I add a new Log Line
	And I enter data in CRF	    
		|Field       |Data |
	    |Log Field 1 |3    |
	    |Log Field 2 |2    |
	And I verify new query did not fire on "Log Field 1" field
	And I take screenshot
	
	And I select site "AM Edit Site"
    And I select a subject "sub803"
	And I select form "Mixed Form"
	And I enter data in CRF
		|Field       |Data |
        |Standard 1  |8	   |
	And I save CRF	
	And I verify new query did not fire on "Log Field 1" field
	And I add a new Log Line
	And I enter data in CRF	    
		|Field       |Data |
	    |Log Field 1 |6    |
	    |Log Field 2 |2    |
	And I verify new query did not fire on "Log Field 1" field
	And I take screenshot
	
	And I select link "Home"
	And I select link "Architect"
	And I select link "AM Edit Check Study"
	And I select link "Draft 1"
	And I select link "Edit Checks"
	And I select edit image for "Mixed Form Query" Edit Check
	And I select checkbox "Active"
	And I select  link "Update"
	And I select link "Draft 1"	
	And I publish CRF Version
	And I note CRF Version "<Target CRF Version2>"
	And I select link "AM Edit Check Study"
	And I select link "Amendment Manager"
	And I select "<Target CRF Version1>" from dropdown "Source CRF"
	And I select "<Target CRF Version2>" from dropdown "Target CRF"
	And I select button "Create Plan"
	And I select link "Exceute Plan"
	And I Migrate "All Subjects"
	And I select Migration Results and verify Job Status is set to Complete
	And I take screenshot
	
	And I select link "Home"
	And I select "AM Edit Check Study"
	And I select site "AM Edit Site"
    And I select a subject "sub802"
	And I select form "Mixed Form"
	And I verify new query did fire on "Log Field 1" field with require response
	And I verify new query did fire on "Log Field 1" field with require response
	And I take screenshot
	
	And I select site "AM Edit Site"
    And I select a subject "sub803"
	And I select form "Mixed Form"
	And I verify new query did fire on "Log Field 1" field with require response
	And I verify new query did fire on "Log Field 1" field with require response
	And I take screenshot
	
#------------------------------------------------------------------------------------------------------------
 Scenario: Publish Checks

	And I login to Rave as user "editcheck" with password "<Password>"
	And I select link "Architect"
	And I select link "AM Edit Check Study"
	And I select link "Draft 1"
	And I publish and push CRF Version
	And I note CRF Version "<Publish CRF Version1>"
	And I publish CRF Version
	And I note CRF Version "<Publish CRF Version2>"
	And I publish CRF Version
	And I note CRF Version "<Publish CRF Version3>"
	
	And I select link "Home"
	And I select "AM Edit Check Study"
	And I select site "AM Edit Site"
    And I create a Subject "sub804"
	And I select form "Mixed Form"
	And I enter data in CRF
And I save CRF
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify Field "Log Field 1" displays Query with Requires Response
	And I take screenshot
	And I answer the query on "Log Field 1" field
	And I save CRF
	And I close the query on "Log Field 1" field
	And I save CRF
	And I take screenshot
	
	And I select link "Home"
	And I select link "Architect"
	And I select link "AM Edit Check Study"
	And I select link "Pulish Checks"
	And I select "<Publish CRF Version1>" from dropdown "Current CRF Version"
	And I select "<Publish CRF Version2>" from dropdown "Reference CRF Version"
	And I select button "Create Plan"
	And I check "Inactivate" checkbox for "Mixed Form Query" edit check
	And I select link "Save"
	And I take screenshot
	And I select link "Publish" 
	And I verify Job Status is set to Complete
	And I take screenshot
	
	And I select link "Home"
	And I select "AM Edit Check Study"
	And I select site "AM Edit Site"
    And I select a subject "sub804"
	And I select form "Mixed Form"
	And I enter data in CRF
		|Field       |Data |
        |Standard 1  |7    |
	And I save CRF		
	And I verify new query did not fire on "Log Field 1" field
	And I take screenshot
	
	And I select link "Home"
	And I select link "Architect"
	And I select link "AM Edit Check Study"
	And I select link "Pulish Checks"
	And I select "<Publish CRF Version1>" from dropdown "Current CRF Version"
	And I select "<Publish CRF Version3>" from dropdown "Reference CRF Version"
	And I select button "Create Plan"
	And I check "Publish" checkbox for "Mixed Form Query" edit check
	And I select link "Save"
	And I take screenshot
	And I select link "Publish" 
	And I verify Job Status is set to Complete
	And I take screenshot

	And I select link "Home"
	And I select "AM Edit Check Study"
	And I select site "AM Edit Site"
    And I select a subject "sub804"
	And I select form "Mixed Form"
	And I verify new query did fire on "Log Field 1" field
	And I answer the query on "Log Field 1" field
	And I save CRF
	And I take screenshot
	And I close the query on "Log Field 1" field
	And I save CRF
	And I take screenshot
	And I enter data in CRF
		|Field       |Data |
        |Standard 1  |8    |
	And I save CRF
	And I verify new query did fire on "Log Field 1" field.
	And I take screenshot

#------------------------------------------------------------------------------------------------------------
 Scenario: Queries verification on data points with Freeze, Hard lock and Inactive records

	And I select "Edit Check Study 8"
	And I select site "Edit Check Site 8"
    And I create a Subject "sub805"
	And I select form "Mixed Form"
	And I enter data in CRF
And I save CRF
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify Field "Log Field 1" displays Query with Requires Response on first record position
	And I take screenshot
	And I add new log line 2
	And I enter data in CRF
And I save CRF
	    |Field       |Data |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify Field "Log Field 1" displays Query with Requires Response on second record position
	And I take screenshot
	And I add new log line 3
	And I enter data in CRF
And I save CRF
	    |Field       |Data |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I verify Field "Log Field 1" displays Query with Requires Response on third record position
	And I take screenshot
	
	And I answer the query on "Log Field 1" field on first record position
	And I save CRF
	And I answer the query on "Log Field 1" field on seond record position
	And I save CRF
	And I answer the query on "Log Field 1" field on third record position
	And I save CRF
	
	And I enter data in CRF
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I close the query on "Log Field 1" field
	And I save CRF
	And I take screenshot
	And I enter data in CRF
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I close the query on "Log Field 1" field
	And I save CRF
	And I take screenshot
	And I enter data in CRF
	    |Field       |Data |
	    |Log Field 1 |6    |
	And I close the query on "Log Field 1" field
	And I save CRF
	And I take screenshot
	
	And I select edit icon on first record position
	And I select checkbox "Freeze" on "Log Field 1" field on first record position
	And I save CRF
	And I select edit icon on second record position
	And I select checkbox "Hadrd Lock" on "Log Field 1" field on second record position
	And I save CRF
	And I select link "Inactivate"
	And I select "3" in dropdown
	And I select "Inactivate" button
	And I take screenshot
	
	And I enter data in CRF
		|Field       |Data |
        |Standard 1  |7    |
	And I save CRF		
	And I verify new query did fire on "Log Field 1" field on first record position
	And I take screenshot
	And I verify new query did not fire on "Log Field 1" field on second record position
	And I take screenshot
	And I verify new query did not fire on "Log Field 1" field on third record position
	And I take screenshot
	When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceDataPageName 	|CheckActionRecordPosition |CheckActionFieldName 	|CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName 	|TriggerFieldRecordPosition |TriggerFieldName   |TriggerFieldData 	|EditCheckName		|MarkingGroupName 	|QueryMessage                   |EventTime  |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub805       |Mixed Form			            |2                         |Log Field 1      		|18                   |Test A Single Edit       |Standard 1			             	|2                          |Standard 1			|7               	|Mixed Form Query 	|Site             	|Query Opened on Log Field 1	|{DateTime} |
	  |Edit Check Study 8 |80001       |Edit Check Site 8 |PROD        |sub805       |Mixed Form			            |3                         |Log Field 1      		|18                   |Test A Single Edit       |Standard 1			             	|2                          |Standard 1			|7               	|Mixed Form Query 	|Site             	|Query Opened on Log Field 1	|{DateTime} |
	And I take screenshot
	
#------------------------------------------------------------------------------------------------------------
	