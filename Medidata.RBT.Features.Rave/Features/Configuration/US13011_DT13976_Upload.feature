# Configuration Loader specification should include Coder Configuration.

@FT_US13011_DT13976_Upload
@ignore
Feature: US13011
	When the Configuration Settings are Uploaded, they should include Coder Configuration details.
	As a Rave Administrator
	When I am on the Configuration Loader page
	And I Upload Configuration File
	Then the Core Configuration specification contains Coder Configuration details

 Background:
	Given I login to Rave with user "defuser"
	#And the URL has Coder installed
	#And the following Project assignments exist
	#	| User    | Project    | Environment | Role         | Site         | Site Number | User Group    |
	#	| defuser | Jennicilin | Prod        | Data Manager | ABC Hospital | 12333       | Administrator |

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.1.0	
@PB_US13011_DT13976_Upload_01
@Validation
Scenario: PB_US13011_DT13976_Upload_01, As a Data Manager, When merging configuration settings via Configuration Loader and upload is successful, then 'Coder Configuration' is displayed with complete icon.

	When I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click "Upload" to upload "configureation settings" file "RaveCoreConfig1.xml" and wait until I see "Save successful"
	Then I should see "Coder Configuration were updated" in "log"
	And I should see "Complete icon for Coder Configuration"
	And I take a screenshot
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.1.0	
@PB_US13011_DT13976_Upload_02
@Validation
Scenario: PB_US13011_DT13976_Upload_02, As a Data Manager, When overwriting exisiting configuration settings via Configuration Loader and upload is successful, then 'Coder Configuration' is displayed with complete icon.

	When I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I check "Overwrite"
	And I accept alert window
	And I click "Upload" to upload "configureation settings" file "RaveCoreConfig1.xml" and wait until I see "Save successful"
	Then I should see "Coder Configuration were updated" in "log"
	And I should see "Complete icon for Coder Configuration"
	And I take a screenshot
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.1.0	
@PB_US13011_DT13976_Upload_03
@Validation
Scenario: PB_US13011_DT13976_Upload_03, As a Data Manager, When merging configuration settings via Configuration Loader, if no Review Marking Group has been specified in the template, then the system will display a message stating that the Review Marking Group is a required field.

	When I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click "Upload" to upload "configureation settings" file "RaveCoreConfig2.xml" and wait until I see "Validation Failed"
	Then I should see "Non-Conformant icon for Coder Configuration"
	And I should see "Marking group: not found or blank" in "Coder Configuration errors"
	And I take a screenshot
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.1.0	
@PB_US13011_DT13976_Upload_04
@Validation
Scenario: PB_US13011_DT13976_Upload_04, As a Data Manager, When overwriting existing configuration settings via Configuration Loader, if no Review Marking Group has been specified in the template, then the system will display a message stating that the Review Marking Group is a required field.

	When I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I check "Overwrite"
	And I accept alert window
	And I click "Upload" to upload "configureation settings" file "RaveCoreConfig2.xml" and wait until I see "Validation Failed"
	Then I should see "Non-Conformant icon for Coder Configuration"
	And I should see "Marking group: not found or blank" in "Coder Configuration errors"
	And I take a screenshot
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_2013.1.0	
@PB_US13011_DT13976_Upload_05
@Validation
Scenario: PB_US13011_DT13976_Upload_05 As a Data Manager, When I update existing configuration settings via Configuration Loader and upload is successful, then the system will display updates in Coder Configuration page.

	When I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click "Upload" to upload "configureation settings" file "RaveCoreConfig3.xml" and wait until I see "Save successful"
	And I navigate to "Other Settings"
	And I navigate to "Coder Configuration"
	Then I should see "Monitoring Group" in "Review Marking Group dropdown" 
	And I should see "Requires Response checked" 
	And I take a screenshot
#----------------------------------------------------------------------------------------------------------------------------------------	
@release_2013.1.0	
@PB_US13011_DT13976_Upload_06
@Validation
Scenario: PB_US13011_DT13976_Upload_06 As a Data Manager, When I update existing configuration settings via Configuration Loader and upload is successful, then the system will display updates in Coder Configuration page.

	When I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I check "Overwrite"
	And I accept alert window
	And I click "Upload" to upload "configureation settings" file "RaveCoreConfig4.xml" and wait until I see "Save successful"
	And I navigate to "Other Settings"
	And I navigate to "Coder Configuration"
	Then I should see "Marking Group 6" in "Review Marking Group dropdown" 
	And I should see "Requires Response unchecked" 
	And I take a screenshot









	
