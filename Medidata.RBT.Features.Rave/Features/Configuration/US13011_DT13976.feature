# Configuration Loader specification should include Coder Configuration.

Feature: US13011_DT13976
	When the Configuration Settings are downloaded, they should include Coder Configuration details.
	As a Rave Administrator
	When I am on the Configuration Loader page
	And I select Get File
	And the Core Configuration specification is downloaded and opened
	Then the Core Configuration specification contains Coder Configuration details

 Background:
	Given I am logged in to Rave with username "defuser" and password "password"
	#And the URL has Coder installed
	#And the following Project assignments exist
	#	| User    | Project    | Environment | Role         | Site         | Site Number | User Group    |
	#	| defuser | Jennicilin | Prod        | Data Manager | ABC Hospital | 12333       | Administrator |
	#And the following Marking Groups exist
	#	| Review Marking Groups     |
	#	| Site from System          |
	#	| Site from CRA             |
	#	| Site from DM              |
	#	| Monitor from Lead Monitor |
	#	| Monitor from Sponsor      |
	#	| CRA from DM               |

#Note: This feature file assumes that they are only 10 Marking Groups set in Rave.

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US11101_01
@Draft
Scenario: @PB_US11101_01 As a Data Manager, when I am on the Configuration Loader page, and I select Get File, and the Core Configuration specification is downloaded, and I open it, then I see Coder Configuration details.
	
	Given I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Coder Configuration"
	And I enter data in "Coder Configuration" and save
		| Review Marking Group | Requires Response | Requires Manual Close |
		| site from system     | True              | True                  |
	And I select link "Configuration Loader"
	And I click button "Get File"
	When the "Core Configuration Specification" spreadsheet is downloaded
	Then I verify "Coder Configuration" tab exists in the spreadsheet
	And I verify "Coder Configuration" spreadsheet data
		| Version | Coder Manual Queries  | Setting          | Instructions Comments                                                                                                                                                                 |
		|         | Review Marking Group  | site from system | Marking Groups enable queries to be opened by Coder and directed to specific roles.  These roles will be able to take action against the query as long as the role action permits it. |
		|         | Requires Response     | True             | A response by the user role the query has been opened against is needed.  True = a response is required.  False = No response is required and query text will just be displayed.      |
		|         | Requires Manual Close | True             | The user role the query has been opened against will be able to close the query.  True = Query can be closed manually.  False = Query cannot be closed manually.                      |
	
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Coder Configuration"
	And I enter data in "Coder Configuration" and save
		| Review Marking Group      | Requires Response | Requires Manual Close |
		| Monitor from Lead Monitor | False             | False                 |
	And I navigate to "Other Settings"
	And I navigate to "Configuration Loader"
	And I click button "Get File"
	When the "Core Configuration Specification" spreadsheet is downloaded
	Then I verify "Coder Configuration" tab exists in the spreadsheet
	And I verify "Coder Configuration" spreadsheet data
		| Version | Coder Manual Queries  | Setting                   | Instructions Comments                                                                                                                                                                 |
		|         | Review Marking Group  | Monitor from Lead Monitor | Marking Groups enable queries to be opened by Coder and directed to specific roles.  These roles will be able to take action against the query as long as the role action permits it. |
		|         | Requires Response     | False                     | A response by the user role the query has been opened against is needed.  True = a response is required.  False = No response is required and query text will just be displayed.      |
		|         | Requires Manual Close | False                     | The user role the query has been opened against will be able to close the query.  True = Query can be closed manually.  False = Query cannot be closed manually.                      |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US11101_02
@Draft
Scenario:@PB_US11101_02  As a Data Manager, when I am on the Configuration Loader page, and I select Template Only, and I select Get File, and the Core Configuration specification is downloaded, and I open it, then I see Coder Configuration details.
	
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Configuration Loader"
	And I check "Template Only"
	And I take a screenshot
	And I click button "Get File"
	And the "Core Configuration Specification Template" spreadsheet is downloaded
	When I verify "Coder Configuration" tab exists in the spreadsheet
	Then I verify "Coder Configuration" spreadsheet data
		| Version | Coder Manual Queries  | Setting | Instructions Comments                                                                                                                                                                 |
		|         | Review Marking Group  | [None]  | Marking Groups enable queries to be opened by Coder and directed to specific roles.  These roles will be able to take action against the query as long as the role action permits it. |
		|         | Requires Response     |         | A response by the user role the query has been opened against is needed.  True = a response is required.  False = No response is required and query text will just be displayed.      |
		|         | Requires Manual Close |         | The user role the query has been opened against will be able to close the query.  True = Query can be closed manually.  False = Query cannot be closed manually.                      |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US11101_03
@Manual
Scenario: @PB_US11101_03 As a Data Manager, when I am on the Configuration Loader page, and Coder is not enabled, and I select Get File, and the Core Configuration specification is downloaded, and I open it, then I do not see Coder Configuration details.

	And I navigate to "Configuration"
	When I navigate to "Other Settings"
	Then I should not see link "Coder Configuration"

	And I select link "Configuration Loader"
	And I select "Get File"
	#When the Core Configuration specification is downloaded
	And I open the Core Configuration specification
	Then I do not see Coder Configuration tab
	And I take a screenshot