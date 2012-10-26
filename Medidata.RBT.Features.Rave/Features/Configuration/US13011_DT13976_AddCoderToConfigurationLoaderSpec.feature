# Configuration Loader specification should include Coder Configuration.
@ignore
Feature: US13011_DT13976: When the Configuration Settings are downloaded, they should include Coder Configuration details.
  As a Rave Administrator
	When I am on the Configuration Loader page
	And I select Get File
	And the Core Configuration specification is downloaded and opened
	Then the Core Configuration specification contains Coder Configuration details


Background:
	#Given I login to Rave with user "defuser" and password "password"
	#And the URL has Coder installed
	#And the following Project assignments exist
	#| User    | Project    | Environment | Role         | Site         | Site Number | User Group    |
	#| defuser | Jennicilin | Prod        | Data Manager | ABC Hospital | 12333       | Administrator |
	#And the following Marking Groups exist
	#| Review Marking Groups     |
	#| Site from System          |
	#| Site from CRA             |
	#| Site from DM              |
	#| Monitor from Lead Monitor |
	#| Monitor from Sponsor      |
	#| CRA from DM               |

@PB_US11101_01
Scenario: Test
	Given the "Core Configuration Specification Template" is downloaded
	Then I verify spreadsheet data 
	| Version | Coder Manual Queries  | Setting          | Instructions/Comments |
	|         | Review Marking Group  | site from system |                       |
	|         | Requires Response     | True             |                       |
	|         | Requires Manual Close | True             |                       |

@PB_US11101_01
Scenario: FIRST As a Data Manager, when I am on the Configuration Loader page, and I select Get File, and the Core Configuration specification is downloaded, and I open it, then I see Coder Configuration details.
	Given I login to Rave with user "defuser" and password "password"
	When I navigate to "Configuration" module
	And I navigate to "Other Settings"
	And I navigate to "Coder Configuration"
	And I enter data in "Coder Configuration" and save
	| Review Marking Group | Requires Response | Requires Manual Close |
	| site from system     | True               | True                   |
	And I navigate to "Configuration" module
	And I navigate to "Configuration Loader"
	And I click "Get File"
	And the "Core Configuration Specification Template" is downloaded
	#And I open the Core Configuration specification
	Then I verify "Coder Configuration" spreadsheet exists
	Then I verify spreadsheet data 
	| Version | Coder Manual Queries  | Setting          | Instructions/Comments |
	|         | Review Marking Group  | site from system |                       |
	|         | Requires Response     | True             |                       |
	|         | Requires Manual Close | True             |                       |
	#And I take a screenshot
	And I click the drop-down arrow for field "Site from Sytem"
	Then I see data
	| Setting                   |
	| Site from System          |
	| Site from CRA             |
	| Site from DM              |
	| Monitor from Lead Monitor |
	| Monitor from Sponsor      |
	| CRA from DM               |
	And the cursor focus is located on "Site from System"
	And I take a screenshot
	And I click the drop-down arrow for field "TRUE" for "Requires Response"
	Then I see data
	| Setting |
	| TRUE    |
	| FALSE   |
	And the cursor focus is located on "TRUE"
	And I take a screenshot
	And I click the drop-down arrow for field "TRUE" for "Requires Manual Close"
	Then I see data
	| Setting |
	| TRUE    |
	| FALSE   |
	And the cursor focus is located on "TRUE"
	And I take a screenshot
	And I select module "Configuration"
	And I select Other Settings
	And I select Coder Configuration
	And I enter data
	| Review Marking Group | Requires Response | Requires Manual Close |
	| Monitor from Sponsor |                   |                       |
	And I select module "Configuration"
	And I select Configuration Loader
	And I select "Get File"
	And the Core Configuration specification is downloaded
	And I open the Core Configuration specification
	Then I see Coder Configuration tab
	Then I see data
	| Version | Coder Manual Queries  | Setting              | Instructions/Comments |
	|         | Review Marking Group  | Monitor from Sponsor |                       |
	|         | Requires Response     | FALSE                |                       |
	|         | Requires Manual Close | FALSE                |                       |
	And I take a screenshot
	And I click the drop-down arrow for field "Site from Sytem"
	Then I see data
	| Review Marking Groups     |
	| Site from System          |
	| Site from CRA             |
	| Site from DM              |
	| Monitor from Lead Monitor |
	| Monitor from Sponsor      |
	| CRA from DM               |
	And the cursor focus is located on "Monitor from Sponsor"
	And I click the drop-down arrow for field "FALSE" for "Requires Response"
	Then I see data
	| Setting |
	| TRUE    |
	| FALSE   |
	And the cursor focus is located on "FALSE"
	And I take a screenshot
	And I click the drop-down arrow for field "FALSE" for "Requires Manual Close"
	Then I see data
	| Setting |
	| TRUE    |
	| FALSE   |
	And the cursor focus is located on "FALSE"
	And I take a screenshot

@PB_US11101_02
Scenario: As a Data Manager, when I am on the Configuration Loader page, and I select Template Only, and I select Get File, and the Core Configuration specification is downloaded, and I open it, then I see Coder Configuration details.
	Given I login to Rave with user "defuser" and password "password"
	And I select module "Configuration"
	And I select Configuration Loader
	And I select "Template Only"
	And I take a screenshot
	And I select "Get File"
	And the Core Configuration specification is downloaded
	And I open the Core Configuration specification
	Then I see Coder Configuration tab
	Then I see data
	| Version | Coder Manual Queries  | Setting | Instructions/Comments |
	|         | Review Marking Group  | [None]  |                       |
	|         | Requires Response     | FALSE   |                       |
	|         | Requires Manual Close | FALSE   |                       |
	And I take a screenshot
	And I click the drop-down arrow for field "[None]" in the Setting column for Coder Manual Queries "Review Marking Group"
	Then I see data
	| Setting          |
	| [None]           |
	| Marking Group 1  |
	| Marking Group 2  |
	| Marking Group 3  |
	| Marking Group 4  |
	| Marking Group 5  |
	| Marking Group 6  |
	| Marking Group 7  |
	| Marking Group 8  |
	| Marking Group 9  |
	| Marking Group 10 |
	And the cursor focus is located on "[None]" for "Review Marking Group"
	And I take a screenshot
	And I click the drop-down arrow for field "FALSE" for "Requires Response"
	Then I see data
	| Setting |
	| TRUE    |
	| FALSE   |
	And the cursor focus is located on "FALSE" for "Requires Response"
	And I take a screenshot
	And I click the drop-down arrow for field "FALSE" for "Requires Manual Close"
	Then I see data
	| Setting |
	| TRUE    |
	| FALSE   |
	And the cursor focus is located on "FALSE" for "Requires Manual Close"
	And I take a screenshot

@PB_US11101_03
Scenario: As a Data Manager, when I am on the Configuration Loader page, and Coder is not enabled, and I select Get File, and the Core Configuration specification is downloaded, and I open it, then I do not see Coder Configuration details.
	Given I login to Rave with user "defuser" and password "password"
	And I select module "Configuration"
	And I select Configuration Loader
	And I select "Get File"
	And the Core Configuration specification is downloaded
	And I open the Core Configuration specification
	Then I do not see Coder Configuration tab
	And I take a screenshot