@FT_MCC-41783_Audit
@Ignore
Feature: MCC-41783_Audit Ability to audit existing inactivate/activate Protocol Deviation Code and Protocol Deviation Class
	As a Rave user
	I want to inactivate/reactive existing Protocol Deviation Code and class
	So that the correct Audits are generated in Database

Background:	
	Given I login to Rave with user "defuser" and password "password"
		
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_Audit_01
@Validation
Scenario: PB_MCC_41783_Audit_01 As an Rave user, when I update existing Deviation Class in Configuration Module and save, then the correct Audits are generated in Database for Protocol Deviation Class. 

	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	When I inactivate deviation class "10"
	And I take a screenshot
	Then I verify Protocol Deviation configuration audits exist
		| ObjectName | ObjectType | AuditName   |
		| 10         | Class      | Inactivated |
	When I activate deviation class "10"
	And I take a screenshot	
	Then I verify Protocol Deviation configuration audits exist
		| ObjectName | ObjectType | AuditName |
		| 10         | Class      | Activated |	

#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_Audit_02
@Validation
Scenario: PB_MCC_41783_Audit_02 As an Rave user, when I update existing Deviation Code in Configuration Module and save, then the correct Audits are generated in Database Protocol Deviation Code. 

	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	When I inactivate deviation code "A"
	And I take a screenshot
	Then I verify Protocol Deviation configuration audits exist
		| ObjectName | ObjectType | AuditName   |
		| A          | Code       | Inactivated |
	When I activate deviation code "A"
	And I take a screenshot
	Then I verify Protocol Deviation configuration audits exist
		| ObjectName | ObjectType | AuditName |
		| A          | Code       | Activated |
		
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_Audit_03
@Validation
Scenario: PB_MCC_41783_Audit_03 As a Data Manager, When I update existing configuration settings via Configuration Loader and upload is successful, then the correct Audits are generated in Database Protocol Deviation Class.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	When I click "Upload" to upload "configureation settings" file "MCC-41783_Audit_RaveCoreConfig1.xml" and wait until I see "Save successful"
	And I take a screenshot	
	Then I verify Protocol Deviation configuration audits exist
		| ObjectName | ObjectType | AuditName   |
		| 20         | Class      | Inactivated |
	And I navigate to "Configuration Loader"
	And I check "Overwrite"
	And I accept alert window
	And I wait for 10 seconds	
	When I click "Upload" to upload "configureation settings" file "MCC-41783_Audit_RaveCoreConfig2.xml" and wait until I see "Save successful"
	And I take a screenshot	
	Then I verify Protocol Deviation configuration audits exist
		| ObjectName | ObjectType | AuditName |
		| 20         | Class      | Activated |
		
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0	
@PB_MCC_41783_Audit_04
@Validation
Scenario: PB_MCC_41783_Audit_04 As a Data Manager, When I update existing configuration settings via Configuration Loader and upload is successful, then the correct Audits are generated in Database Protocol Deviation Code.

	And I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	When I click "Upload" to upload "configureation settings" file "MCC-41783_Audit_RaveCoreConfig3.xml" and wait until I see "Save successful"
	And I take a screenshot	
	Then I verify Protocol Deviation configuration audits exist
		| ObjectName | ObjectType | AuditName   |
		| B          | Code       | Inactivated |
	And I navigate to "Configuration Loader"
	And I check "Overwrite"
	And I accept alert window
	And I wait for 10 seconds	
	When I click "Upload" to upload "configureation settings" file "MCC-41783_Audit_RaveCoreConfig4.xml" and wait until I see "Save successful"
	And I take a screenshot	
	Then I verify Protocol Deviation configuration audits exist
		| ObjectName | ObjectType | AuditName |
		| B          | Code       | Activated |
