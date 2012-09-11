﻿# Reports on either the Study, Site or Subject pages should be sorted in alphabetical order.

Feature: US11913
 When reports are listed on either the Study, Site or Subject pages, they should be sorted in alphabetical order.
  As a Rave Adminstrator
When I have configured reports to display on either the Study, Site or Subject pages
Then the report names are sorted in alphabetical order

 Background:
Given I am logged in to Rave with username "defuser" and password "password"
# And the following Project assignments exist
# | User    | Project    | Environment | Role | Site     | Site Number | User Group |
# | defuser | Mediflex   | Prod        | cdm1 | LabSite01| 2426        | Reports    |
# And User Group has "Reports"
# And Role "cdm1" has Action "Entry"
# And Role "Data Manager" has the following Report assignments
# | Report Name          |
# | Coding Assignments   | 
# | Data Listing         |
# | eLearning Status     |
# | Enrollment           |
# | Page Status v2.0     |
# | Query Aging          |
# | Stream-Audit Trail   |
# | Subject CRF Versions |
# | Subject PDF Report   |
# | User Listing         |
# And the following Reports Matrix assignments exist
# | Projects   | Report Name          | Study | Site | Subject |
# | Mediflex   | Coding Assignments   | X     |      |         |
# | Mediflex   | Data Listing         | X     |      |         |
# | Mediflex   | eLearning Status     |       | X    |         |
# | Mediflex   | Enrollment           | X     | X    |         |
# | Mediflex   | Page Status v2.0     | X     | X    | X       |
# | Mediflex   | Query Aging          | X     | X    | X       |
# | Mediflex   | Stream-Audit Trail   | X     | X    | X       |
# | Mediflex   | Subject CRF Versions | X     |      | X       |
# | Mediflex   | Subject PDF Report   |       | X    | X       |
# | Mediflex   | User Listing         | X     | X    |         |

#And I select Study "Mediflex" and Site "LabSite01"

@release_2012.1.0
@PB_US11913_01
@Validation
Scenario: @PB_US11101_01 As a Data Manager, when I select Study "Mediflex" then I see reports listed in alphabetical order.

When I select Study "Mediflex"
Then I verify table "Reports" is in alphabetical order
And I take a screenshot

@release_2012.1.0
@PB_US11913_02
@Validation
Scenario: @PB_US11101_02 As a Data Manager, when I select Study "Mediflex" and Site "LabSite01" then I see reports listed in alphabetical order.

When I select Study "Mediflex" and Site "LabSite01"
Then I verify table "Reports" is in alphabetical order
And I take a screenshot

@release_2012.1.0
@PB_US11913_03
@Validation
Scenario: @PB_US11101_03 As a Data Manager, when I select Study "Mediflex" and Site "LabSite01" and Subject created then I see reports listed in alphabetical order.

And I select Study "Mediflex" and Site "LabSite01"
When I create a Subject
	| Field            | Data               |
	| Subject Initials | SUB                |
	| Subject Number   | {RndNum<num1>(3)}  |
Then I verify table "Reports" is in alphabetical order
And I take a screenshot

@release_564_2012.1.0	
@PB_US11913_04
@Draft
Scenario: PB_US11913_04 As a Data Manager, when I select Study "Jennicilin" and Site "ABC HOSPITAL and Subject "New Subject" and Grid View then I see reports listed in alphabetical order.

And I select Study "Mediflex" and Site "LabSite01"
When I create a Subject
	| Field            | Data               |
	| Subject Initials | SUB                |
	| Subject Number   | {RndNum<num1>(3)}  |
And I select link "Grid View"
Then I verify table "Reports" is in alphabetical order
And I take a screenshot

@release_564_2012.1.0
@PB_US11913_05
@Draft
Scenario: PB_US11913_05 As a Data Manager, when I select report on Study, Site Subject, Grid View then I see report.

When I select Study "Mediflex" and Site "LabSite01"
And I take a screenshot
And I verify that the all the reports are linked into report module

When I create a Subject
	| Field            | Data               |
	| Subject Initials | SUB                |
	| Subject Number   | {RndNum<num1>(3)}  |
And I take a screenshot
And I verify that the all the reports are linked into report module