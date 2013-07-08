@FT_MCC-41783_MCC_61213_Download
#Add ability to inactivate Protocol Deviations to Configuration Loader

Feature: MCC-41783_MCC_61213_Download Add ability to inactivate Protocol Deviations to Configuration Loader
	As a Rave Administrator
	And I download Configuration File
	Then the download Configuration File contains active and inactive Protocol Deviations
	
Background:	
	Given I login to Rave with user "defuser" and password "password"
	And I navigate to "Configuration"
    And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I activate deviation class "20"
	And I activate deviation code "B"
		
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_MCC_61213_Download_01
@Validation
Scenario: PB_MCC_41783_MCC_61213_Download_01 As a Data Manager, when I am on the Configuration Loader page, and I select Get File, and the Core Configuration specification is downloaded, and I open it, then I see active and inactive Protocol Deviations details.
		
	Given I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I add Deviation Class
		| ClassValue | Active |
		| 90         | True   |
		| 100        | True   |
	And I inactivate deviation class "100"
	And I add Deviation Code
		| CodeValue | Active |
		| Z         | True   |
		| Y         | True   |
	And I inactivate deviation code "Y"
	And I take a screenshot
	And I select link "Configuration Loader"
	When I click the "Get File" button to download
	Then I verify "Protocol Deviations" spreadsheet data
		| Version | Deviation Classes | Class Active | Deviation Codes | Code Active |
		|         | 10                | TRUE         | A               | TRUE        |
		|         | 20                | TRUE         | B               | TRUE        |
		|         | 90                | TRUE         | Z               | TRUE        |
		|         | 100               | FALSE        | Y               | FALSE       |

	And I navigate to "Home"
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I delete Deviation Class "90"
	And I delete Deviation Class "100"
	And I delete Deviation Code "Y"
	And I delete Deviation Code "Z"
		
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_MCC_61213_Download_02
@Validation
Scenario: PB_MCC_41783_MCC_61213_Download_02 As a Data Manager, when I am on the Configuration Loader page, and I select Template Only, and I select Get File, and the Core Configuration specification is downloaded, and I open it, then I see Protocol Deviations details.
	
	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I check "Template Only"
	And I take a screenshot
	When I click the "Get File" button to download
	Then I verify "Protocol Deviations" spreadsheet data
		| Version | Deviation Classes | Class Active | Deviation Codes | Code Active | Instructions/Comments|
	Then I verify "Protocol Deviations" spreadsheet data
		| Instructions/Comments                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
		| Protocol Deviations may be added to individual fields as required and include a class, code, and a free-text box. In the 'Deviation Classes' column, please list all the Protocol Deviation Classes that will be required. In the 'Class Active' column, please specify is the Protocol Deviation Class active. In the 'Deviation Codes' column, please list all the Protocol Deviation Codes that will be required. In the 'Code Active' column, please specify is the Protocol Deviation Code active. |