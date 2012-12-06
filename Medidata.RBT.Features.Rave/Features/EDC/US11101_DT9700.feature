# Reports on either the Study, Site or Subject pages should be sorted in alphabetical order.
Feature: US11101_DT9700 When reports are listed on either the Study, Site or Subject pages, they should be sorted in alphabetical order.
  As a Rave Adminstrator
	When I have configured reports to display on either the Study, Site or Subject pages
	Then the report names are sorted in alphabetical order

Background:
	Given xml draft "Mediflex_US11101_Draft_US11101.xml" is Uploaded
	Given study "Mediflex_US11101" is assigned to Site "Site_001"
	Given study "Mediflex_US11101" is assigned to Site "Site_002"
	Given following Project assignments exist
		| User         | Project          | Environment | Role         | Site     | SecurityRole          |
		| SUPER USER 1 | Mediflex_US11101 | Live: Prod  | SUPER ROLE 1 | Site_001 | Project Admin Default |
		| SUPER USER 1 | Mediflex_US11101 | Live: Prod  | SUPER ROLE 1 | Site_002 | Project Admin Default |
	Given I publish and push eCRF "Mediflex_US11101_Draft_US11101.xml" to "Version 1"
	Given xml User Group Configuration "US11101UserGroup.xml" is uploaded
	Given following Report assignments exist
		| Role         | Report                                      |
		| SUPER ROLE 1 | Coding Assignments - Coding Assignments     |
		| SUPER ROLE 1 | Data Listing - Data Listing Report          |
		| SUPER ROLE 1 | eLearning Status - eLearning Status         |
		| SUPER ROLE 1 | Enrollment - Enrollment Report              |
		| SUPER ROLE 1 | Page Status v2.0 - Page Status v2.0         |
		| SUPER ROLE 1 | Query Aging - Query Aging Report            |
		| SUPER ROLE 1 | Stream-Audit Trail - Audit Trail Report     |
		| SUPER ROLE 1 | Subject CRF Versions - Subject CRF Versions |
		| SUPER ROLE 1 | User Listing - User Listing Report          |
		
	Given the following Reports Matrix assignments exist
		| Project          | Report                                      | Study | Site | Subject |
		| Mediflex_US11101 | Coding Assignments - Coding Assignments     | X     |      |         |
		| Mediflex_US11101 | Data Listing - Data Listing Report          | X     |      |         |
		| Mediflex_US11101 | eLearning Status - eLearning Status         |       | X    |         |
		| Mediflex_US11101 | Enrollment - Enrollment Report              | X     | X    |         |
		| Mediflex_US11101 | Page Status v2.0 - Page Status v2.0         | X     | X    | X       |
		| Mediflex_US11101 | Query Aging - Query Aging Report            | X     | X    | X       |
		| Mediflex_US11101 | Stream-Audit Trail - Audit Trail Report     | X     | X    | X       |
		| Mediflex_US11101 | Subject CRF Versions - Subject CRF Versions | X     |      | X       |
		| Mediflex_US11101 | User Listing - User Listing Report          | X     | X    |         |
	Given I login to Rave with user "SUPER USER 1"
	And I select Study "Mediflex_US11101" and Site "Site_001"
	When I create a Subject
		| Field      | Data              |
		| Subject ID | {RndNum<num1>(5)} |
	And I navigate to "Home"

@release_2012.1.0
@PB_US11101_DT9700_01
@Validation
Scenario:  PB_US11101_DT9700_01 As a Data Manager, when I select Study "Jennicilin" then I see reports listed in alphabetical order.

When I select Study "Mediflex_US11101"
Then I verify table "Reports" is in alphabetical order
And I take a screenshot

@release_2012.1.0
@PB_US11101_DT9700_02
@Validation
Scenario: PB_US11101_DT9700_02 As a Data Manager, when I select Study "Jennicilin" and Site "ABC HOSPITAL then I see reports listed in alphabetical order.
When I select Study "Mediflex_US11101" and Site "Site_001"
Then I verify table "Reports" is in alphabetical order
And I take a screenshot

@release_2012.1.0
@PB_US11101_DT9700_03
@Validation
Scenario: @PB_US11101_DT9700_03 As a Data Manager, when I select Study "Mediflex" and Site "Site_001" and Subject created then I see reports listed in alphabetical order.

And I select Study "Mediflex_US11101" and Site "Site_001"
When I create a Subject
	| Field      | Data              |
	| Subject ID | {RndNum<num1>(5)} |
Then I verify table "Reports" is in alphabetical order
And I take a screenshot

@release_564_2012.1.0	
@PB_US11913_04
@Validation
Scenario: PB_US11101_DT9700_04 As a Data Manager, when I select Study "Jennicilin" and Site "ABC HOSPITAL and Subject "New Subject" then I see reports listed in alphabetical order.
And I select Study "Mediflex_US11101" and Site "Site_001"
When I create a Subject
	| Field      | Data              |
	| Subject ID | {RndNum<num1>(5)} |
And I select link "Grid View"
Then I verify table "Reports" is in alphabetical order
And I take a screenshot

@release_564_2012.1.0
@PB_US11913_DT9700_05
@Validation
Scenario: PB_US11913_DT9700_05 As a Data Manager, when I select report on Study, Site Subject, Grid View then I see report.


When I select Study "Mediflex_US11101"
And I select link "Enrollment - Enrollment Report"
And I switch to "ReportViewer" window
And I take a screenshot
And I switch to "Home - Medidata Rave" window
And I select Site link "Site_001"
And I select link "User Listing - User Listing Report"
And I switch to "ReportViewer" window
And I take a screenshot
And I switch to "Home - Medidata Rave" window
And I create a Subject
   | Field      | Data              |
   | Subject ID | {RndNum<num1>(5)} |
And I select link "Subject CRF Versions - Subject CRF Versions"
And I switch to "ReportViewer" window
And I take a screenshot
And I switch to "Subject" window
And I select link "Grid View"
And I take a screenshot
And I select link "Page Status v2.0 - Page Status v2.0"
And I switch to "ReportViewer" window
And I take a screenshot