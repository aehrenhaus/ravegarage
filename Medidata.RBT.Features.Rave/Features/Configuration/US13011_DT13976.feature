# Configuration Loader specification should include Coder Configuration.
#@ignore
@FT_US13011_DT13976
Feature: US13011_DT13976_1
	When the Configuration Settings are downloaded, they should include Coder Configuration details.
	As a Rave Administrator
	When I am on the Configuration Loader page
	And I select Get File
	And the Core Configuration specification is downloaded and opened
	Then the Core Configuration specification contains Coder Configuration details

Background:
	Given I login to Rave with user "defuser" and password "password"
	#And the URL has Coder installed
	#And the following Project assignments exist
	#	| User    | Project    | Environment | Role         | Site         | Site Number | User Group    |
	#	| defuser | Jennicilin | Prod        | Data Manager | ABC Hospital | 12333       | Administrator |
	#And the following Marking Groups exist
	#	| Review Marking Groups   |
	#	| site from system        |
	#	| Marking Group 2         |
	#	| Marking Group 3         |
	#	| Marking Group 4		  |
	#	| Marking Group 5		  |
	#	| Marking Group 6         |

#Note: This feature file assumes that they are only 10 Marking Groups set in Rave.

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.1.0
@PB_US11101_01
@Draft
Scenario: @PB_US11101_01 As a Data Manager, when I am on the Configuration Loader page, and I select Get File, and the Core Configuration specification is downloaded, and I open it, then I see Coder Configuration details.
	
	Given I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Coder Configuration"
	And I enter data in "Coder Configuration" and save
		| Review Marking Group | Requires Response |
		| Site                 | True              |
	And I select link "Configuration Loader"
	And I click the "Get File" button to download
	And I verify "Coder Configuration" spreadsheet data
		| Version | Coder Manual Queries | Setting | Instructions/Comments                                                                                                                                                                 |
		|         | Review Marking Group | Site    | Marking Groups enable queries to be opened by Coder and directed to specific roles.  These roles will be able to take action against the query as long as the role action permits it. |
		|         | Requires Response    | True    | A response by the user role the query has been opened against is needed.  True = a response is required.  False = No response is required and query text will just be displayed.      |  
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Coder Configuration"
	And I enter data in "Coder Configuration" and save
		| Review Marking Group | Requires Response |
		| Monitoring Group     | False             |
	And I navigate to "Other Settings"
	And I navigate to "Configuration Loader"
	And I click the "Get File" button to download
	And I verify "Coder Configuration" spreadsheet data
		| Version | Coder Manual Queries | Setting          | Instructions/Comments                                                                                                                                                                 |
		|         | Review Marking Group | Monitoring Group | Marking Groups enable queries to be opened by Coder and directed to specific roles.  These roles will be able to take action against the query as long as the role action permits it. |
		|         | Requires Response    | False            | A response by the user role the query has been opened against is needed.  True = a response is required.  False = No response is required and query text will just be displayed.      |
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.1.0
@PB_US11101_02
@Draft
Scenario:@PB_US11101_02  As a Data Manager, when I am on the Configuration Loader page, and I select Template Only, and I select Get File, and the Core Configuration specification is downloaded, and I open it, then I see Coder Configuration details.
	
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Configuration Loader"
	And I check "Template Only"
	And I take a screenshot
	And I click the "Get File" button to download
	Then I verify "Coder Configuration" spreadsheet data
		| Version | Coder Manual Queries | Setting | Instructions/Comments                                                                                                                                                                 |
		|         | Review Marking Group |         | Marking Groups enable queries to be opened by Coder and directed to specific roles.  These roles will be able to take action against the query as long as the role action permits it. |
		|         | Requires Response    |         | A response by the user role the query has been opened against is needed.  True = a response is required.  False = No response is required and query text will just be displayed.      |
