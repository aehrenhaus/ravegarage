# Reports on either the Study, Site or Subject pages should be sorted in alphabetical order.
@ignore
Feature: US11101 When reports are listed on either the Study, Site or Subject pages, they should be sorted in alphabetical order.
  As a Rave Adminstrator
	When I have configured reports to display on either the Study, Site or Subject pages
	Then the report names are sorted in alphabetical order


Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	# And the following Project assignments exist
	# | User    | Project    | Environment | Role         | Site                | Site Number | User Group |
	# | defuser | Jennicilin | Prod        | Data Manager | ABC Hospital        | 12333       | Reports    |
	# | defuser | Fixitol    | Prod        | CRA          | Huntington Hospital | 111222      | EDC        |
	# And there is a User Group "Reports"
	# | Modules                                                                                                              | Permissions                                 |
	# | EditContactInfo, ReportAdminCustomParameters, ReportAdminManager, ReportAssignment, ReportLocalization, ReportMatrix | EDC Module, Reporter, Report Administration |
	# And there is a User Group "EDC"
	# | Modules         | Permissions |
	# | EditContactInfo | EDC Module  |
	# And Role "Data Manager" has the following eport assignments
	# | Report Name          |
	# | Data Listing         |
	# | eLearning Status     |
	# | Enrollment           |
	# | SAS On Demand        |
	# | Subject CRF Versions |
	# And the following Reports Matrix assignments exist
	# | Projects   | Report Name          | Study | Site | Subject |
	# | Jennicilin | Coding Assignments   | X     | X    | X       |
	# | Jennicilin | Data Listing         | X     |      |         |
	# | Jennicilin | eLearning Status     |       | X    |         |
	# | Jennicilin | Enrollment           |       |      | X       |
	# | Jennicilin | Page Status v2.0     |       |      | X       |
	# | Jennicilin | Query Aging          | X     | X    | X       |
	# | Jennicilin | SAS On Demand        |       | X    |         |
	# | Jennicilin | Script Utility       | X     | X    | X       |
	# | Jennicilin | Subject CRF Versions | X     |      |         |
	# | Jennicilin | User Listing         | X     | X    | X       |
@PB_US11101_01
Scenario:  PB_US11101_01 As a Data Manager, when I select Study "Jennicilin" then I see reports listed in alphabetical order.
	When I select Study "Mediflex"
	Then I verify table "Reports" is in alphabetical order
	And I take a screenshot

@PB_US11101_02
Scenario: PB_US11101_02 As a Data Manager, when I select Study "Jennicilin" and Site "ABC HOSPITAL then I see reports listed in alphabetical order.
	When I select Study "Mediflex" and Site "LabSite01"
	Then I verify table "Reports" is in alphabetical order
	And I take a screenshot

@PB_US11101_03
Scenario: PB_US11101_03 As a Data Manager, when I select Study "Jennicilin" and Site "ABC HOSPITAL and Subject "New Subject" then I see reports listed in alphabetical order.
	When I select Study "Mediflex" and Site "LabSite01"
	And I select a Subject "1212"
	Then I verify table "Reports" is in alphabetical order
	And I take a screenshot