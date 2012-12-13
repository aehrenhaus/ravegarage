# Configuration Loader specification should include Coder Configuration.
@ignore
@FT_US13011_DT13976_Upload
Feature: US13011_DT13976 Upload

Background:
	Given I login to Rave with user "defuser" and password "password"
	

@PB_US11101_01
Scenario: Upload
	When I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click "Upload" to upload "configureation settings" file "US13011_DT13976.zip" and wait until I see "Save successful"