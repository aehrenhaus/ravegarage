@FT_MCC_41783_MCC_61213_Upload
@ignore
#Add ability to inactivate Protocol Deviations to Configuration Loader

Feature: MCC_41783_MCC_61213_Upload Add ability to inactivate Protocol Deviations to Configuration Loader.
	As a Rave Administrator
	And I Upload Configuration File
	Then the Core Configuration specification contains active and inactive Protocol Deviations
	
Background:	
	Given role "MCC_41783 Role" exists
	Given xml draft "MCC_41783.xml" is Uploaded
	Given xml draft "MCC_41783_GL.xml" is Uploaded
	Given Site "MCC-41783 Site" exists	
	Given study "MCC-41783" is assigned to Site "MCC-41783 Site"
	Given following Project assignments exist
		| User         | Project    | Environment | Role           | Site           | SecurityRole          | GlobalLibraryRole            |
		| SUPER USER 1 | MCC-41783  | Live: Prod  | MCC_41783 Role | MCC-41783 Site | Project Admin Default | Global Library Admin Default |
	Given I publish and push eCRF "MCC_41783.xml" to "Version 1"
	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I inactivate deviation class "20"
	And I inactivate deviation code "B"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_MCC_61213_Upload_01
@Validation
Scenario: PB_MCC_41783_MCC_61213_Upload_01 As a Data Manager, When I update existing configuration settings via Configuration Loader and upload is successful, then 'ProtocolDeviations' is displayed with complete icon.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	When I click "Upload" to upload "configureation settings" file "MCC_61213_RaveCoreConfig1.xml" and wait until I see "Save successful"
	Then I should see "Complete icon for ProtocolDeviations"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_MCC_61213_Upload_02
@Validation
Scenario: PB_MCC_41783_MCC_61213_Upload_02 As a Data Manager, When I update existing configuration settings via Configuration Loader and upload is successful, then the system will display updates in Protocol Deviations page.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click "Upload" to upload "configureation settings" file "MCC_61213_RaveCoreConfig2.xml" and wait until I see "Save successful"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	When I select edit for "30" in "Class"
	Then I verify checkbox "Active" checked for "30" in "Class"
	And I take a screenshot
	When I select edit for "C" in "Code"
	Then I verify checkbox "Active" checked for "C" in "Code"
	And I take a screenshot	

	And I navigate to "Home"
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I delete Deviation Class "30"
	And I delete Deviation Code "C"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_MCC_61213_Upload_03
@Validation
Scenario: PB_MCC_41783_MCC_61213_Upload_03 As a Data Manager, When I update existing configuration settings via Configuration Loader and upload is successful, then the system will display updates in Protocol Deviations page.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click "Upload" to upload "configureation settings" file "MCC_61213_RaveCoreConfig3.xml" and wait until I see "Save successful"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	When I select edit for "40" in "Class"
	Then I verify checkbox "Active" unchecked for "40" in "Class"
	And I take a screenshot
	When I select edit for "D" in "Code"
	Then I verify checkbox "Active" unchecked for "D" in "Code"
	And I take a screenshot

	And I navigate to "Home"
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I delete Deviation Class "40"
	And I delete Deviation Code "D"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_MCC_61213_Upload_04
@Validation
Scenario: PB_MCC_41783_MCC_61213_Upload_04 As a Data Manager, When I update existing configuration settings via Configuration Loader with inactive Protocol Deviations Class, Code and upload is successful, then the system will not display inactive Protocol Deviations on CRF Page.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click "Upload" to upload "configureation settings" file "MCC_61213_RaveCoreConfig4.xml" and wait until I see "Save successful"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	When I select edit for "50" in "Class"
	Then I verify checkbox "Active" unchecked for "50" in "Class"
	And I take a screenshot
	When I select edit for "E" in "Code"
	Then I verify checkbox "Active" unchecked for "E" in "Code"
	And I take a screenshot
	And I navigate to "Home"
	And I select Study "MCC-41783" and Site "MCC-41783 Site"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num7>(5)} |
		| Subject Initials | sub               |
	And I select Form "AE"
	And I enter data in CRF and save
	    | Field | Data |
	    | Age   | 22   |
	When I add Protocol Deviation
		| Field | Class | Code | Text                    |
		| Age   | 10    | A    | Protocol Deviation test |
	Then I verify deviation "class" with value "50" does not exist in CRF
	And I verify deviation "code" with value "E" does not exist in CRF
	And I take a screenshot

	And I navigate to "Home"
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"	
	And I delete Deviation Class "50"
	And I delete Deviation Code "E"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_MCC_61213_Upload_05
@Validation
Scenario: PB_MCC_41783_MCC_61213_Upload_05 As a Data Manager, When I update existing configuration settings via Configuration Loader with inactive Protocol Deviations Class, Code and upload is successful, then the system will not display inactive Protocol Deviations on Architect Edit Checks Steps page.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click "Upload" to upload "configureation settings" file "MCC_61213_RaveCoreConfig5.xml" and wait until I see "Save successful"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	When I select edit for "60" in "Class"
	Then I verify checkbox "Active" unchecked for "60" in "Class"
	And I take a screenshot
	When I select edit for "F" in "Code"
	Then I verify checkbox "Active" unchecked for "F" in "Code"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-41783" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Edit Checks"
	And I click on icon "Check Steps" for Edit Check "EC PD"
	When I select link "Add Check Action"
    Then I verify deviation "code" with value "F" does not exist
	And I verify deviation "class" with value "60" does not exist
	And I take a screenshot

	And I navigate to "Home"
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I delete Deviation Class "60"
	And I delete Deviation Code "F"
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_MCC_61213_Upload_06
@Validation
Scenario: PB_MCC_41783_MCC_61213_Upload_06 As a Data Manager, When I update existing configuration settings via Configuration Loader with inactive Protocol Deviations Class, Code and upload is successful, then the system will not display inactive Protocol Deviations on Global Library Volumes Edit Checks Steps page.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click "Upload" to upload "configureation settings" file "MCC_61213_RaveCoreConfig5.xml" and wait until I see "Save successful"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	When I select edit for "60" in "Class"
	Then I verify checkbox "Active" unchecked for "60" in "Class"
	And I take a screenshot
	When I select edit for "F" in "Code"
	Then I verify checkbox "Active" unchecked for "F" in "Code"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-41783" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Edit Checks"
	And I click on icon "Check Steps" for Edit Check "EC PD"
	When I select link "Add Check Action"
    Then I verify deviation "code" with value "F" does not exist
	And I verify deviation "class" with value "60" does not exist
	And I take a screenshot	
	
	And I navigate to "Home"
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"	
	And I delete Deviation Class "60"
	And I delete Deviation Code "F"
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_MCC_61213_Upload_07
@Validation
Scenario: PB_MCC_41783_MCC_61213_Upload_07 As a Data Manager, When I overwrite existing configuration settings via Configuration Loader and upload is successful, then the system will display updates in Protocol Deviations page.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click "Upload" to upload "configureation settings" file "MCC_61213_RaveCoreConfig6.xml" and wait until I see "Save successful"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	When I select edit for "70" in "Class"
	Then I verify checkbox "Active" checked for "70" in "Class"
	And I take a screenshot
	When I select edit for "G" in "Code"
	Then I verify checkbox "Active" checked for "G" in "Code"
	And I take a screenshot
	And I navigate to "Configuration Loader"
	And I check "Overwrite"
	And I accept alert window
	And I wait for 20 seconds
	And I click "Upload" to upload "configureation settings" file "MCC_61213_RaveCoreConfig7.xml" and wait until I see "Save successful"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	When I select edit for "70" in "Class"
	Then I verify checkbox "Active" unchecked for "70" in "Class"
	And I take a screenshot
	When I select edit for "G" in "Code"
	Then I verify checkbox "Active" unchecked for "G" in "Code"
	And I take a screenshot

	And I navigate to "Home"
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I delete Deviation Class "70"
	And I delete Deviation Code "G"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_MCC_61213_Upload_08
@Validation
Scenario: PB_MCC_41783_MCC_61213_Upload_08 As a Data Manager, When I upload configuration settings via Configuration Loader with no Class Active and Code Actice Coulumns, then 'ProtocolDeviations' is displayed with Non-Conformant icon.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	When I click "Upload" to upload "configureation settings" file "MCC_61213_RaveCoreConfig.xml" and wait until I see "Validation Failed"
	Then I should see "Non-Conformant icon for ProtocolDeviations"
	And I should see "Required Column: 'Class Active' is missing from the worksheet." in "ProtocolDeviations errors"
	And I should see "Required Column: 'Code Active' is missing from the worksheet." in "ProtocolDeviations errors"
	And I take a screenshot
