# Help links for all standard reports should be replaced with Cloud links.

Feature: US13021_DT12734
	The Help link is selected for a standard report in the Reporter module, or View Report Help is selected in the Report Paraments, or View Report Help is selected within a generated report, the link should open a standard report is selected, then I see the cloud-based report help page.
 	As a Rave Adminstrator
	When the Help link is selected for a standard report
	Then I see the cloud-based help page

 Background:
	#Given I am logged in to Rave with username "defuser" and password "password"
	#And the following standard report assignments exist
	#| User    | Project    | Environment | Role         | Report Name                       |
	#| defuser | Jennicilin | Prod        | Data Manager | 360 Data Cleaning Progress Report |
	#| defuser | Jennicilin | Prod        | Data Manager | 360 Enrollment Report             |
	#| defuser | Jennicilin | Prod        | Data Manager | 360 Query Management Report       |
	#| defuser | Jennicilin | Prod        | Data Manager | Architect Difference Report       |
	#| defuser | Jennicilin | Prod        | Data Manager | Audit Trail Report                |
	#| defuser | Jennicilin | Prod        | Data Manager | Audit Trail Report 2.0            |
	#| defuser | Jennicilin | Prod        | Data Manager | Changes After Report              |
	#| defuser | Jennicilin | Prod        | Data Manager | Check Error Report                |
	#| defuser | Jennicilin | Prod        | Data Manager | Clinical Significance Report      |
	#| defuser | Jennicilin | Prod        | Data Manager | Coding Assignments Report         |
	#| defuser | Jennicilin | Prod        | Data Manager | Coding Hierarchy Report           |
	#| defuser | Jennicilin | Prod        | Data Manager | Comprehensive Page Status Report  |
	#| defuser | Jennicilin | Prod        | Data Manager | Concurrent Users Report           |
	#| defuser | Jennicilin | Prod        | Data Manager | Data Listing Report               |
	#| defuser | Jennicilin | Prod        | Data Manager | Edit Check Log Report             |
	#| defuser | Jennicilin | Prod        | Data Manager | Edit Check Summary Report         |
	#| defuser | Jennicilin | Prod        | Data Manager | Edit Check Usage Summary Report   |
	#| defuser | Jennicilin | Prod        | Data Manager | eLearning Status Report           |
	#| defuser | Jennicilin | Prod        | Data Manager | Enrollment Report                 |
	#| defuser | Jennicilin | Prod        | Data Manager | Lab Standard Groups Report        |
	#| defuser | Jennicilin | Prod        | Data Manager | Lab Analytes Report               |
	#| defuser | Jennicilin | Prod        | Data Manager | Lab Units Report                  |
	#| defuser | Jennicilin | Prod        | Data Manager | Migration Audit Trail Report      |
	#| defuser | Jennicilin | Prod        | Data Manager | Monitoring Visit Summary Report   |
	#| defuser | Jennicilin | Prod        | Data Manager | Object Reuse Report               |
	#| defuser | Jennicilin | Prod        | Data Manager | Page Status Report                |
	#| defuser | Jennicilin | Prod        | Data Manager | Page Status Report 2.0            |
	#| defuser | Jennicilin | Prod        | Data Manager | Productivity Report               |
	#| defuser | Jennicilin | Prod        | Data Manager | Project Lab Settings Report       |
	#| defuser | Jennicilin | Prod        | Data Manager | Protocol Deviations Report        |
	#| defuser | Jennicilin | Prod        | Data Manager | Query Aging Report                |
	#| defuser | Jennicilin | Prod        | Data Manager | Query Details Report              |
	#| defuser | Jennicilin | Prod        | Data Manager | Query Resolution Worksheet Report |
	#| defuser | Jennicilin | Prod        | Data Manager | Query Summary Report              |
	#| defuser | Jennicilin | Prod        | Data Manager | Report Listing Report             |
	#| defuser | Jennicilin | Prod        | Data Manager | SAS On Demand Report              |
	#| defuser | Jennicilin | Prod        | Data Manager | Site Administration Report        |
	#| defuser | Jennicilin | Prod        | Data Manager | Sticky Note Report                |
	#| defuser | Jennicilin | Prod        | Data Manager | Study Configuration Report        |
	#| defuser | Jennicilin | Prod        | Data Manager | Study Media Report                |
	#| defuser | Jennicilin | Prod        | Data Manager | Subject Compare Report            |
	#| defuser | Jennicilin | Prod        | Data Manager | Subject CRF Versions Report       |
	#| defuser | Jennicilin | Prod        | Data Manager | Subject PDF Report                |
	#| defuser | Jennicilin | Prod        | Data Manager | Unit Conversions Report           |
	#| defuser | Jennicilin | Prod        | Data Manager | Unit Dictionaries Report          |
	#| defuser | Jennicilin | Prod        | Data Manager | User Listing Report               |
	#| defuser | Jennicilin | Prod        | Data Manager | User Permissions History Report   |


@release_2012.1.0	
@US13021_DT12734_01
@Draft

Scenario: @US13021_DT12734_01 As a Data Manager, when I select the Help link, in the Help column, in Reporter > My Reports, then I see the cloud-based report help page.

	Given I am logged in to Rave with username "defuser" and password "password"
	When I click link "Reporter"
	And I select "Standard Reports" for Report Type
	And I click link "Help" for each report
	Then I Verify the following URL addresses in the address bar for the reports listed below
	| Name                        		| URL Address                                                                                         |
	| 360 Data Cleaning Progress Report | http://rave-webhelp.s3.amazonaws.com/360Reports/360_DATACLEANINGPROGRESS/WebHelp_ENG/main.htm 	  |
	| Report Name                       | URL Address                                                                                         |
	| 360 Data Cleaning Progress Report | http://rave-webhelp.s3.amazonaws.com/360Reports/360_DATACLEANINGPROGRESS/WebHelp_ENG/main.htm       |
	| 360 Enrollment Report             | http://rave-webhelp.s3.amazonaws.com/360Reports/360_ENROLLMENT/WebHelp_ENG/main.htm                 |
	| 360 Query Management Report       | http://rave-webhelp.s3.amazonaws.com/360Reports/360_QUERYMANAGEMENT/WebHelp_ENG/main.htm            |
	| Architect Difference Report       | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ArchitectDifferenceReport.pdf      |
	| Audit Trail Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/AuditTrailReport.pdf               |
	| Audit Trail Report 2.0            | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/AuditTrailReportv2.pdf             |
	| Changes After Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ChangesAfterReport.pdf             |
	| Check Error Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/CheckErrorReport.pdf               |
	#| Clinical Significance Report      | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ClinicalSignificanceReport.pdf     |
	| Coding Assignments Report         | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/CodingAssignmentsReport.pdf        |
	| Coding Hierarchy Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/CodingHierarchyReport.pdf          |
	#| Comprehensive Page Status Report  | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ComprehensivePageStatusReport.pdf  |
	| Concurrent Users Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ConcurrentUsersReport.pdf          |
	| Data Listing Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/DataListingReport.pdf              |
	| Edit Check Log Report             | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EditCheckLogReport.pdf             |
	| Edit Check Summary Report         | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EditCheckSummaryReport.pdf         |
	| Edit Check Usage Summary Report   | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EditCheckUsageSummaryReport.pdf    |
	| eLearning Status Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/eLearningStatusReport.pdf          |
	| Enrollment Report                 | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EnrollmentReport.pdf               |
	| Lab Standard Groups Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/Lab%20StandardGroupsReport.pdf     |
	| Lab Analytes Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/LabAnalytesReport.pdf              |
	| Lab Units Report                  | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/LabUnitsReport.pdf                 |
	| Migration Audit Trail Report      | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/MigrationAuditTrailReport.pdf      |
	| Monitoring Visit Summary Report   | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/MonitoringVisitSummaryReport.pdf   |
	| Object Reuse Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ObjectReuseReport.pdf              |
	| Page Status Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/PageStatusReport.pdf               |
	| Page Status Report 2.0            | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/PageStatusReportv2.pdf             |
	| Productivity Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ProductivityReport.pdf             |
	| Project Lab Settings Report       | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ProjectLabSettingsReport.pdf       |
	| Protocol Deviations Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ProtocolDeviationsReport.pdf       |
	| Query Aging Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QueryAgingReport.pdf               |
	| Query Details Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QueryDetailsReport.pdf             |
	| Query Resolution Worksheet Report | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QueryResolutionWorksheetReport.pdf |
	| Query Summary Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QuerySummaryReport.pdf             |
	| Report Listing Report             | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ReportListingReport.pdf            |
	| SAS On Demand Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SASOnDemandReport.pdf              |
	| Site Administration Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SiteAdministrationReport.pdf       |
	| Sticky Note Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/StickyNoteReport.pdf               |
	| Study Configuration Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/StudyConfigurationReport.pdf       |
	| Study Media Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/StudyMediaReport.pdf               |
	| Subject Compare Report            | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SubjectCompareReport.pdf           |
	| Subject CRF Versions Report       | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SubjectCRFVersionsReport.pdf       |
	| Subject PDF Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SubjectPDFReport.pdf               |
	#| Unit Conversions Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UnitConversionsReport.pdf          |
	#| Unit Dictionaries Report          | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UnitDictionariesReport.pdf         |
	| User Listing Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UserListingReport.pdf              |
	| User Permissions History Report   | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UserPermissionsHistoryReport.pdf   |
	And I take a screenshot


@release_2012.1.0	
@US13021_DT12734_02
@Draft
Scenario: @US13021_DT12734_02 As a Data Manager, when I select a standard report in Reporter > My Reports, and I select View Report Help, then I see the cloud-based report help page.
	Given I am logged in to Rave with username "defuser" and password "password"
	When I click link "Reporter"
	And I select "Standard Reports" for Report Type
	And I select each report
	And I select link "View Report Help"
	Then I Verify the following URL addresses in the address bar for the reports listed below
	| Report Name                       | URL Address                                                                                         |
	| 360 Data Cleaning Progress Report | http://rave-webhelp.s3.amazonaws.com/360Reports/360_DATACLEANINGPROGRESS/WebHelp_ENG/main.htm       |
	| 360 Enrollment Report             | http://rave-webhelp.s3.amazonaws.com/360Reports/360_ENROLLMENT/WebHelp_ENG/main.htm                 |
	| 360 Query Management Report       | http://rave-webhelp.s3.amazonaws.com/360Reports/360_QUERYMANAGEMENT/WebHelp_ENG/main.htm            |
	| Architect Difference Report       | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ArchitectDifferenceReport.pdf      |
	| Audit Trail Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/AuditTrailReport.pdf               |
	| Audit Trail Report 2.0            | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/AuditTrailReportv2.pdf             |
	| Changes After Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ChangesAfterReport.pdf             |
	| Check Error Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/CheckErrorReport.pdf               |
	#| Clinical Significance Report      | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ClinicalSignificanceReport.pdf     |
	| Coding Assignments Report         | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/CodingAssignmentsReport.pdf        |
	| Coding Hierarchy Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/CodingHierarchyReport.pdf          |
	#| Comprehensive Page Status Report  | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ComprehensivePageStatusReport.pdf  |
	| Concurrent Users Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ConcurrentUsersReport.pdf          |
	| Data Listing Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/DataListingReport.pdf              |
	| Edit Check Log Report             | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EditCheckLogReport.pdf             |
	| Edit Check Summary Report         | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EditCheckSummaryReport.pdf         |
	| Edit Check Usage Summary Report   | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EditCheckUsageSummaryReport.pdf    |
	| eLearning Status Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/eLearningStatusReport.pdf          |
	| Enrollment Report                 | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EnrollmentReport.pdf               |
	| Lab Standard Groups Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/Lab%20StandardGroupsReport.pdf     |
	| Lab Analytes Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/LabAnalytesReport.pdf              |
	| Lab Units Report                  | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/LabUnitsReport.pdf                 |
	| Migration Audit Trail Report      | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/MigrationAuditTrailReport.pdf      |
	| Monitoring Visit Summary Report   | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/MonitoringVisitSummaryReport.pdf   |
	| Object Reuse Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ObjectReuseReport.pdf              |
	| Page Status Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/PageStatusReport.pdf               |
	| Page Status Report 2.0            | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/PageStatusReportv2.pdf             |
	| Productivity Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ProductivityReport.pdf             |
	| Project Lab Settings Report       | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ProjectLabSettingsReport.pdf       |
	| Protocol Deviations Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ProtocolDeviationsReport.pdf       |
	| Query Aging Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QueryAgingReport.pdf               |
	| Query Details Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QueryDetailsReport.pdf             |
	| Query Resolution Worksheet Report | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QueryResolutionWorksheetReport.pdf |
	| Query Summary Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QuerySummaryReport.pdf             |
	| Report Listing Report             | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ReportListingReport.pdf            |
	| SAS On Demand Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SASOnDemandReport.pdf              |
	| Site Administration Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SiteAdministrationReport.pdf       |
	| Sticky Note Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/StickyNoteReport.pdf               |
	| Study Configuration Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/StudyConfigurationReport.pdf       |
	| Study Media Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/StudyMediaReport.pdf               |
	| Subject Compare Report            | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SubjectCompareReport.pdf           |
	| Subject CRF Versions Report       | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SubjectCRFVersionsReport.pdf       |
	| Subject PDF Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SubjectPDFReport.pdf               |
	#| Unit Conversions Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UnitConversionsReport.pdf          |
	#| Unit Dictionaries Report          | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UnitDictionariesReport.pdf         |
	| User Listing Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UserListingReport.pdf              |
	| User Permissions History Report   | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UserPermissionsHistoryReport.pdf   |
	And I take a screenshot


@release_2012.1.0	
@US13021_DT12734_03
@Draft
Scenario: @US13021_DT12734_03 As a Data Manager, when I a standard report in Reporter > My Reports, and I execute that report, and I select View Report Help, then I see the cloud-based report help page.
	Given I am logged in to Rave with username "defuser" and password "password"
	When I click link "Reporter"
	And I select "Standard Reports" for Report Type
	And I select Report "Data Listing" 
	And I select study "US15417_DT13905_SJ"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| US15417_DT13905_SJ | Prod        |
	And I click button "Submit Report"
	And I switch to "DataListingsReport" window
	And I click link "View Report Help"
	Then I Verify the following URL addresses in the address bar for the reports listed below
	| Report Name                       | URL Address                                                                                         |
	| 360 Data Cleaning Progress Report | http://rave-webhelp.s3.amazonaws.com/360Reports/360_DATACLEANINGPROGRESS/WebHelp_ENG/main.htm       |
	| 360 Enrollment Report             | http://rave-webhelp.s3.amazonaws.com/360Reports/360_ENROLLMENT/WebHelp_ENG/main.htm                 |
	| 360 Query Management Report       | http://rave-webhelp.s3.amazonaws.com/360Reports/360_QUERYMANAGEMENT/WebHelp_ENG/main.htm            |
	| Architect Difference Report       | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ArchitectDifferenceReport.pdf      |
	| Audit Trail Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/AuditTrailReport.pdf               |
	| Audit Trail Report 2.0            | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/AuditTrailReportv2.pdf             |
	| Changes After Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ChangesAfterReport.pdf             |
	| Check Error Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/CheckErrorReport.pdf               |
	#| Clinical Significance Report      | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ClinicalSignificanceReport.pdf     |
	| Coding Assignments Report         | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/CodingAssignmentsReport.pdf        |
	| Coding Hierarchy Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/CodingHierarchyReport.pdf          |
	#| Comprehensive Page Status Report  | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ComprehensivePageStatusReport.pdf  |
	| Concurrent Users Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ConcurrentUsersReport.pdf          |
	| Data Listing Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/DataListingReport.pdf              |
	| Edit Check Log Report             | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EditCheckLogReport.pdf             |
	| Edit Check Summary Report         | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EditCheckSummaryReport.pdf         |
	| Edit Check Usage Summary Report   | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EditCheckUsageSummaryReport.pdf    |
	| eLearning Status Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/eLearningStatusReport.pdf          |
	| Enrollment Report                 | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/EnrollmentReport.pdf               |
	| Lab Standard Groups Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/Lab%20StandardGroupsReport.pdf     |
	| Lab Analytes Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/LabAnalytesReport.pdf              |
	| Lab Units Report                  | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/LabUnitsReport.pdf                 |
	| Migration Audit Trail Report      | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/MigrationAuditTrailReport.pdf      |
	| Monitoring Visit Summary Report   | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/MonitoringVisitSummaryReport.pdf   |
	| Object Reuse Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ObjectReuseReport.pdf              |
	| Page Status Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/PageStatusReport.pdf               |
	| Page Status Report 2.0            | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/PageStatusReportv2.pdf             |
	| Productivity Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ProductivityReport.pdf             |
	| Project Lab Settings Report       | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ProjectLabSettingsReport.pdf       |
	| Protocol Deviations Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ProtocolDeviationsReport.pdf       |
	| Query Aging Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QueryAgingReport.pdf               |
	| Query Details Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QueryDetailsReport.pdf             |
	| Query Resolution Worksheet Report | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QueryResolutionWorksheetReport.pdf |
	| Query Summary Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/QuerySummaryReport.pdf             |
	| Report Listing Report             | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/ReportListingReport.pdf            |
	| SAS On Demand Report              | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SASOnDemandReport.pdf              |
	| Site Administration Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SiteAdministrationReport.pdf       |
	| Sticky Note Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/StickyNoteReport.pdf               |
	| Study Configuration Report        | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/StudyConfigurationReport.pdf       |
	| Study Media Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/StudyMediaReport.pdf               |
	| Subject Compare Report            | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SubjectCompareReport.pdf           |
	| Subject CRF Versions Report       | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SubjectCRFVersionsReport.pdf       |
	| Subject PDF Report                | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/SubjectPDFReport.pdf               |
	#| Unit Conversions Report           | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UnitConversionsReport.pdf          |
	#| Unit Dictionaries Report          | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UnitDictionariesReport.pdf         |
	| User Listing Report               | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UserListingReport.pdf              |
	| User Permissions History Report   | http://rave-webhelp.s3.amazonaws.com/Reports_Manuals/Manuals_ENG/UserPermissionsHistoryReport.pdf   |
	And I take a screenshot