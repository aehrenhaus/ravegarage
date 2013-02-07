﻿# Configuration Loader specification should include Coder Configuration.
#@ignore
@FT_US13011_DT13976_Upload
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
@release_564_2012.1.0	
@PB_US13011_DT13976_Upload_01
@Draft
Scenario: PB_US13011_DT13976_Upload_01, As a Data Manager, When merging configuration settings via Configuration Loader and upload is successful, then 'Coder Configuration' is displayed with complete icon.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click "Upload" to upload "configureation settings" file "RaveCoreConfig1.xml" and wait until I see "Save successful"
	And I should see "Coder Configuration were updated" in "log"
	Then I should see "Complete icon for Coder Configuration"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0	
@PB_US13011_DT13976_Upload_02
@Draft
Scenario: PB_US13011_DT13976_Upload_02, As a Data Manager, When overwriting exisiting configuration settings via Configuration Loader and upload is successful, then 'Coder Configuration' is displayed with complete icon.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I check "Overwrite"
	And I accept alert window
	When I click "Upload" to upload "configureation settings" file "RaveCoreConfig1.xml" and wait until I see "Save successful"
	And I should see "Coder Configuration were updated" in "log"
	Then I should see "Complete icon for Coder Configuration"
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0	
@PB_US13011_DT13976_Upload_03
@Draft
Scenario: PB_US13011_DT13976_Upload_03, As a Data Manager, When merging configuration settings via Configuration Loader, if no Review Marking Group has been specified in the template, then the system will display a message stating that the Review Marking Group is a required field.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	When I click "Upload" to upload "configureation settings" file "RaveCoreConfig2.xml" and wait until I see "Validation Failed"
	And I should see "Non-Conformant icon for Coder Configuration"
	Then I should see "Marking group: not found or blank" in "Coder Configuration errors"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0	
@PB_US13011_DT13976_Upload_04
@Draft
Scenario: PB_US13011_DT13976_Upload_04, As a Data Manager, When overwriting existing configuration settings via Configuration Loader, if no Review Marking Group has been specified in the template, then the system will display a message stating that the Review Marking Group is a required field.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I check "Overwrite"
	And I accept alert window
	When I click "Upload" to upload "configureation settings" file "RaveCoreConfig2.xml" and wait until I see "Validation Failed"
	And I should see "Non-Conformant icon for Coder Configuration"
	Then I should see "Marking group: not found or blank" in "Coder Configuration errors"

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_2012.1.0	
@PB_US13011_DT13976_Upload_05
@Draft
Scenario: PB_US13011_DT13976_Upload_05 As a Data Manager, When I update existing configuration settings via Configuration Loader and upload is successful, then the system will display updates in Coder Configuration page.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	When I click "Upload" to upload "configureation settings" file "RaveCoreConfig3.xml" and wait until I see "Save successful"
	And I navigate to "Other Settings"
	And I navigate to "Coder Configuration"
	Then I should see "Marking Group 5" in "Review Marking Group dropdown" 
	And I should see "Requires Response checked" 

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_2012.1.0	
@PB_US13011_DT13976_Upload_06
@Draft
Scenario: PB_US13011_DT13976_Upload_06 As a Data Manager, When I update existing configuration settings via Configuration Loader and upload is successful, then the system will display updates in Coder Configuration page.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I check "Overwrite"
	And I accept alert window
	When I click "Upload" to upload "configureation settings" file "RaveCoreConfig4.xml" and wait until I see "Save successful"
	And I navigate to "Other Settings"
	And I navigate to "Coder Configuration"
	Then I should see "Marking Group 6" in "Review Marking Group dropdown" 
	And I should see "Requires Response unchecked" 










	
