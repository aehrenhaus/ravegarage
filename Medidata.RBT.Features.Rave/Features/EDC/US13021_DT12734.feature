# Help links for all standard reports should be replaced with Cloud links.

Feature: US13021_DT12734
	The Help link is selected for a standard report in the Reporter module, or View Report Help is selected in the Report Paraments, or View Report Help is selected within a generated report, the link should open a standard report is selected, then I see the cloud-based report help page.
 	As a Rave Adminstrator
	When the Help link is selected for a standard report
	Then I see the cloud-based help page

 Background:
	#Given I am logged in to Rave with username "defuser" and password "password"
	#And the following standard report assignments exist
	#| User    | Project			| Environment | Role         | Report Name                       |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | 360 Data Cleaning Progress Report |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | 360 Enrollment Report             |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | 360 Query Management Report       |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Architect Difference Report       |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Audit Trail Report                |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Audit Trail Report 2.0            |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Changes After Report              |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Check Error Report                |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Clinical Significance Report      |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Coding Assignments Report         |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Coding Hierarchy Report           |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Comprehensive Page Status Report  |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Concurrent Users Report           |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Data Listing Report               |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Edit Check Log Report             |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Edit Check Summary Report         |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Edit Check Usage Summary Report   |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | eLearning Status Report           |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Enrollment Report                 |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Lab Standard Groups Report        |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Lab Analytes Report               |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Lab Units Report                  |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Migration Audit Trail Report      |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Monitoring Visit Summary Report   |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Object Reuse Report               |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Page Status Report                |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Page Status Report 2.0            |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Productivity Report               |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Project Lab Settings Report       |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Protocol Deviations Report        |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Query Aging Report                |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Query Details Report              |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Query Resolution Worksheet Report |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Query Summary Report              |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Report Listing Report             |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | SAS On Demand Report              |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Site Administration Report        |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Sticky Note Report                |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Study Configuration Report        |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Study Media Report                |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Subject Compare Report            |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Subject CRF Versions Report       |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Subject PDF Report                |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Unit Conversions Report           |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | Unit Dictionaries Report          |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | User Listing Report               |
	#| defuser | US15417_DT13905_SJ | Prod        | Data Manager | User Permissions History Report   |


@release_2012.1.0	
@US13021_DT12734_01
@Draft

Scenario: @US13021_DT12734_01 As a Data Manager, when I select the Help link, in the Help column, in Reporter > My Reports, then I see the cloud-based report help page.

	Given I am logged in to Rave with username "defuser" and password "password"
	When I select link "Reporter"
	And I choose "Standard Reports" from "Report Type"
	And I click button "Search"
	Then I verify the following URL addresses in the address bar when I click "Help" link
	| Name                              | URL Address                                                                                    |
	| 360 Data Cleaning Progress Report | https://rave-webhelp.s3.amazonaws.com/360Reports/360_DATACLEANINGPROGRESS/WebHelp_ENG/main.htm |
	| 360 Enrollment Tracking Report    | https://rave-webhelp.s3.amazonaws.com/360Reports/360_ENROLLMENT/WebHelp_ENG/main.htm           |
	| 360 Query Management              | https://rave-webhelp.s3.amazonaws.com/360Reports/360_QUERYMANAGEMENT/WebHelp_ENG/main.htm      |
	#| Architect Difference					  |                                                                                                |
	#| Audit Trail                            |                                                                                                |
	#| Audit Trail Version 2.0                |                                                                                                |
	#| Changes After                          |                                                                                                |
	#| Check Error                            |                                                                                                |
	#| Coding Assignments                     |                                                                                                |
	#| Coding Hierarchy                       |                                                                                                |
	#| Concurrent Users                       |                                                                                                |
	#| Data Listing                           |                                                                                                |
	#| Edit Check and Custom Function Summary |                                                                                                |
	#| Edit Check Log Report                  |                                                                                                |
	#| Edit Check Summary Report              |                                                                                                |
	#| eLearning Status                       |                                                                                                |
	#| Enrollment                             |                                                                                                |
	#| Labs: Analytes                         |                                                                                                |
	#| Labs: Standard Groups                  |                                                                                                |
	#| Labs: Unit Dictionaries                |                                                                                                |
	#| Labs: Units                            |                                                                                                |
	#| Migration Audit Trail Report           |                                                                                                |
	#| Object Reuse                           |                                                                                                |
	#| Page Status                            |                                                                                                |
	#| Page Status v2.0                       |                                                                                                |
	#| Productivity                           |                                                                                                |
	#| Protocol Deviations                    |                                                                                                |
	#| Query Aging                            |                                                                                                |
	#| Query Detail                           |                                                                                                |
	#| Query Resolution Worksheet             |                                                                                                |
	#| Query Summary                          |                                                                                                |
	#| Site Administration                    |                                                                                                |
	#| Sticky Note                            |                                                                                                |
	#| Stream-Audit Trail                     |                                                                                                |
	#| Study Configuration                    |                                                                                                |
	#| Study Media                            |                                                                                                |
	#| Subject Compare Report                 |                                                                                                |
	#| Subject CRF Versions                   |                                                                                                |
	#| Subject PDF Report                     |                                                                                                |
	#| User Listing                           |                                                                                                |

	And I take a screenshot


@release_2012.1.0	
@US13021_DT12734_02
@Draft
Scenario: @US13021_DT12734_02 As a Data Manager, when I select a standard report in Reporter > My Reports, and I select View Report Help, then I see the cloud-based report help page.
	Given I am logged in to Rave with username "defuser" and password "password"
	When I select link "Reporter"
	And I choose "Standard Reports" from "Report Type"
	And I click button "Search"
	Then I verify the following URL addresses in the address bar when I click "View Report Help" link in Prompts page 
	#By going into each report
	| Name                              | URL Address                                                                                    |
	| 360 Data Cleaning Progress Report | https://rave-webhelp.s3.amazonaws.com/360Reports/360_DATACLEANINGPROGRESS/WebHelp_ENG/main.htm |
	| 360 Enrollment Tracking Report    | https://rave-webhelp.s3.amazonaws.com/360Reports/360_ENROLLMENT/WebHelp_ENG/main.htm           |
	| 360 Query Management              | https://rave-webhelp.s3.amazonaws.com/360Reports/360_QUERYMANAGEMENT/WebHelp_ENG/main.htm      |
	#| Architect Difference					  |                                                                                                |
	#| Audit Trail                            |                                                                                                |
	#| Audit Trail Version 2.0                |                                                                                                |
	#| Changes After                          |                                                                                                |
	#| Check Error                            |                                                                                                |
	#| Coding Assignments                     |                                                                                                |
	#| Coding Hierarchy                       |                                                                                                |
	#| Concurrent Users                       |                                                                                                |
	#| Data Listing                           |                                                                                                |
	#| Edit Check and Custom Function Summary |                                                                                                |
	#| Edit Check Log Report                  |                                                                                                |
	#| Edit Check Summary Report              |                                                                                                |
	#| eLearning Status                       |                                                                                                |
	#| Enrollment                             |                                                                                                |
	#| Labs: Analytes                         |                                                                                                |
	#| Labs: Standard Groups                  |                                                                                                |
	#| Labs: Unit Dictionaries                |                                                                                                |
	#| Labs: Units                            |                                                                                                |
	#| Migration Audit Trail Report           |                                                                                                |
	#| Object Reuse                           |                                                                                                |
	#| Page Status                            |                                                                                                |
	#| Page Status v2.0                       |                                                                                                |
	#| Productivity                           |                                                                                                |
	#| Protocol Deviations                    |                                                                                                |
	#| Query Aging                            |                                                                                                |
	#| Query Detail                           |                                                                                                |
	#| Query Resolution Worksheet             |                                                                                                |
	#| Query Summary                          |                                                                                                |
	#| Site Administration                    |                                                                                                |
	#| Sticky Note                            |                                                                                                |
	#| Stream-Audit Trail                     |                                                                                                |
	#| Study Configuration                    |                                                                                                |
	#| Study Media                            |                                                                                                |
	#| Subject Compare Report                 |                                                                                                |
	#| Subject CRF Versions                   |                                                                                                |
	#| Subject PDF Report                     |                                                                                                |
	#| User Listing                           |                                                                                                |

	And I take a screenshot
	


@release_2012.1.0	
@US13021_DT12734_03
@Draft
Scenario: @US13021_DT12734_03 As a Data Manager, when I a standard report in Reporter > My Reports, and I execute that report, and I select View Report Help, then I see the cloud-based report help page.
	Given I am logged in to Rave with username "defuser" and password "password"
	When I select link "Report"
	And I set report parameter "Study" with table
		| Name               | Environment |
		| US15417_DT13905_SJ | Prod        |
	And I click button "Submit Report"
	And I switch to the second window
	And I click link "View Report Help"
	Then I verify current URL is "URL"
	And I take a screenshot
	#Examples: 
	| Report                            | URL Address                                                                                    |
	| 360 Data Cleaning Progress Report | https://rave-webhelp.s3.amazonaws.com/360Reports/360_DATACLEANINGPROGRESS/WebHelp_ENG/main.htm |
    | 360 Enrollment Tracking Report    | https://rave-webhelp.s3.amazonaws.com/360Reports/360_ENROLLMENT/WebHelp_ENG/main.htm           |
	| 360 Query Management              | https://rave-webhelp.s3.amazonaws.com/360Reports/360_QUERYMANAGEMENT/WebHelp_ENG/main.htm      |
	#| Architect Difference					  |                                                                                                |
	#| Audit Trail                            |                                                                                                |
	#| Audit Trail Version 2.0                |                                                                                                |
	#| Changes After                          |                                                                                                |
	#| Check Error                            |                                                                                                |
	#| Coding Assignments                     |                                                                                                |
	#| Coding Hierarchy                       |                                                                                                |
	#| Concurrent Users                       |                                                                                                |
	#| Data Listing                           |                                                                                                |
	#| Edit Check and Custom Function Summary |                                                                                                |
	#| Edit Check Log Report                  |                                                                                                |
	#| Edit Check Summary Report              |                                                                                                |
	#| eLearning Status                       |                                                                                                |
	#| Enrollment                             |                                                                                                |
	#| Labs: Analytes                         |                                                                                                |
	#| Labs: Standard Groups                  |                                                                                                |
	#| Labs: Unit Dictionaries                |                                                                                                |
	#| Labs: Units                            |                                                                                                |
	#| Migration Audit Trail Report           |                                                                                                |
	#| Object Reuse                           |                                                                                                |
	#| Page Status                            |                                                                                                |
	#| Page Status v2.0                       |                                                                                                |
	#| Productivity                           |                                                                                                |
	#| Protocol Deviations                    |                                                                                                |
	#| Query Aging                            |                                                                                                |
	#| Query Detail                           |                                                                                                |
	#| Query Resolution Worksheet             |                                                                                                |
	#| Query Summary                          |                                                                                                |
	#| Site Administration                    |                                                                                                |
	#| Sticky Note                            |                                                                                                |
	#| Stream-Audit Trail                     |                                                                                                |
	#| Study Configuration                    |                                                                                                |
	#| Study Media                            |                                                                                                |
	#| Subject Compare Report                 |                                                                                                |
	#| Subject CRF Versions                   |                                                                                                |
	#| Subject PDF Report                     |                                                                                                |
	#| User Listing                           |                                                                                                |

	And I take a screenshot
	                                                                                   
