@FT_MCC-62856
Feature: MCC-62856_MCC-53994 Update Enable/Disable Add Events Permissions.

Background:
	Given role "SUPER ROLE 1" exists
	Given role "SUPERROLE_MCC-62856_Lock" exists
	Given role "SUPERROLE_MCC-62856_Lock_Pre" exists
	Given role "SUPERROLE_MCC-62856_Lock_UnLock_Pre" exists
	Given role "SUPERROLE_MCC-62856_Unlock" exists
	Given role "SUPERROLE_MCC-62856_UnLock_Pre" exists
	
	Given xml draft "MCC-62856.xml" is Uploaded
	Given xml draft "MCC-62856_Lock.xml" is Uploaded
	Given xml draft "MCC-62856_Lock_Pre.xml" is Uploaded
	Given xml draft "MCC-62856_LkUnLkPre.xml" is Uploaded
	Given xml draft "MCC-62856_UnLock.xml" is Uploaded
	Given xml draft "MCC-62856_UnLk_Pre.xml" is Uploaded
	
	Given study "MCC-62856" is assigned to Site "Site 1"
	Given study "MCC-62856_Lock" is assigned to Site "Site 1"
	Given study "MCC-62856_Lock_Pre" is assigned to Site "Site 1"	
	Given study "MCC-62856_LkUnLkPre" is assigned to Site "Site 1"	
	Given study "MCC-62856_UnLock" is assigned to Site "Site 1"	
	Given study "MCC-62856_UnLk_Pre" is assigned to Site "Site 1"	

    Given following Project assignments exist
		| User           | Project             | Environment | Role                                | Site   | SecurityRole          |
		| SUPER USER 1   | MCC-62856           | Live: Prod  | SUPER ROLE 1                        | Site 1 | Project Admin Default |
		| SUPER USER 1   | MCC-62856_Lock      | Live: Prod  | SUPERROLE_MCC-62856_Lock            | Site 1 | Project Admin Default |
		| SUPER USER 1   | MCC-62856_Lock_Pre  | Live: Prod  | SUPERROLE_MCC-62856_Lock_Pre        | Site 1 | Project Admin Default |
		| SUPER USER 1   | MCC-62856_LkUnLkPre | Live: Prod  | SUPERROLE_MCC-62856_Lock_UnLock_Pre | Site 1 | Project Admin Default |
		| SUPER USER 1   | MCC-62856_UnLock    | Live: Prod  | SUPERROLE_MCC-62856_Lock            | Site 1 | Project Admin Default |
		| SUPER USER 1   | MCC-62856_UnLk_Pre  | Live: Prod  | SUPERROLE_MCC-62856_Lock_Pre        | Site 1 | Project Admin Default |
		| MCC-62856_USER | MCC-62856_UnLock    | Live: Prod  | SUPERROLE_MCC-62856_Unlock          | Site 1 | Project Admin Default |
		| MCC-62856_USER | MCC-62856_UnLk_Pre  | Live: Prod  | SUPERROLE_MCC-62856_UnLock_Pre      | Site 1 | Project Admin Default |		
		
	Given I publish and push eCRF "MCC-62856.xml" to "Version 1" with study environment "Prod"
	Given I publish and push eCRF "MCC-62856_Lock.xml" to "Version 2" with study environment "Prod"
	Given I publish and push eCRF "MCC-62856_Lock_Pre.xml" to "Version 3" with study environment "Prod"
	Given I publish and push eCRF "MCC-62856_LkUnLkPre.xml" to "Version 4" with study environment "Prod"
	Given I publish and push eCRF "MCC-62856_UnLock.xml" to "Version 5" with study environment "Prod"
	Given I publish and push eCRF "MCC-62856_UnLk_Pre.xml" to "Version 6" with study environment "Prod"
				
@release_2013.2.0
@PB_MCC_62856_MCC_53994_001
@Validation
Scenario: PB_MCC_62856_MCC_53994_001, As an Rave user, When the Add Events enabled, the user with entry permission can see the Add Events dropdown and Add button on subject page and grid view page.

	Given I login to Rave with user "SUPER USER 1"
	And I select Study "MCC-62856" and Site "Site 1"	
	When I create a Subject
		| Field            | Data              |
		| Subject initials | SUB               |
		| Subject Number   | {RndNum<num1>(3)} |
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can see "Enabled" radio button
	And I can see "Disabled" radio button
    And I take a screenshot
	
	When I select link "Grid View"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I take a screenshot
	
@release_2013.2.0
@PB_MCC_62856_MCC_53994_002
@Validation
Scenario: PB_MCC_62856_MCC_53994_002, As an Rave user, When the Add Events enabled, the user with entry and lock permission can see the Add Events dropdown, Add button, Disabled radio button on subject page and grid view page.

	Given I login to Rave with user "SUPER USER 1"
	And I select Study "MCC-62856_Lock" and Site "Site 1"	
	When I create a Subject
		| Field            | Data              |
		| Subject initials | SUB               |
		| Subject Number   | {RndNum<num1>(3)} |
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see "Enabled" radio button
	And I can see "Disabled" radio button
    And I take a screenshot
	
	When I select link "Grid View"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see "Enabled" radio button
	And I can see "Disabled" radio button
	And I take a screenshot	

@release_2013.2.0
@PB_MCC_62856_MCC_53994_003
@Validation
Scenario: PB_MCC_62856_MCC_53994_003, As an Rave user, When the Add Events enabled, the user with entry and unlock permission can see the Add Events dropdown, Add button, Enabled radio button on subject page and grid view page.

	Given I login to Rave with user "SUPER USER 1"
	And I select Study "MCC-62856_UnLock" and Site "Site 1"	
	And I create a Subject
		| Field            | Data              |
		| Subject initials | SUB               |
		| Subject Number   | {RndNum<num1>(3)} |
	And I click radiobutton with label "Disabled"
	And I take a screenshot
	And I log out of Rave
	
	Given I login to Rave with user "MCC-62856_USER"
	And I select Study "MCC-62856_UnLock" and Site "Site 1"	
    When I select a Subject "{Var(num1)}"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I can see "Enabled" radio button
	And I can not see "Disabled" radio button
    And I take a screenshot
	
	When I select link "Grid View"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I can see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I take a screenshot	

@release_2013.2.0
@PB_MCC_62856_MCC_53994_004
@Validation
Scenario: PB_MCC_62856_MCC_53994_004, As an Rave user, When the Add Events enabled, the user with entry and lock permission with pre-condition can see the Add Events dropdown, Add button, Disabled radio button on subject page and grid view page.

	Given I login to Rave with user "SUPER USER 1"
	And I select Study "MCC-62856_Lock_Pre" and Site "Site 1"	
	When I create a Subject
		| Field            | Data              |
		| Subject initials | SUB               |
		| Subject Number   | {RndNum<num1>(3)} |
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see "Enabled" radio button
	And I can see "Disabled" radio button
    And I take a screenshot
	
	When I select link "Grid View"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see "Enabled" radio button
	And I can see "Disabled" radio button
	And I take a screenshot		
	
@release_2013.2.0
@PB_MCC_62856_MCC_53994_005
@Validation
Scenario: PB_MCC_62856_MCC_53994_005, As an Rave user, When the Add Events enabled, the user with entry and unlock permission can see the Add Events dropdown, Add button, Enabled radio button on subject page and grid view page.

	Given I login to Rave with user "SUPER USER 1"
	And I select Study "MCC-62856_UnLk_Pre" and Site "Site 1"	
	And I create a Subject
		| Field            | Data              |
		| Subject initials | SUB               |
		| Subject Number   | {RndNum<num1>(3)} |
	And I click radiobutton with label "Disabled"
	And I take a screenshot
	And I log out of Rave
	
	Given I login to Rave with user "MCC-62856_USER"
	And I select Study "MCC-62856_UnLk_Pre" and Site "Site 1"	
    When I select a Subject "{Var(num1)}"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I can see "Enabled" radio button
	And I can not see "Disabled" radio button
    And I take a screenshot
	
	When I select link "Grid View"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I can see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I take a screenshot	
	
@release_2013.2.0
@PB_MCC_62856_MCC_53994_006
@Validation
Scenario: PB_MCC_62856_MCC_53994_006, As an Rave user, When the Add Events enabled, the user with entry, lock, unlock permissions with pre-conditions on lock and unlock can see the Add Events dropdown and Add button on subject page and grid view page.

	Given I login to Rave with user "SUPER USER 1"
	And I select Study "MCC-62856_LkUnLkPre" and Site "Site 1"	
	When I create a Subject
		| Field            | Data              |
		| Subject initials | SUB               |
		| Subject Number   | {RndNum<num1>(3)} |
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can see "Enabled" radio button
	And I can see "Disabled" radio button
    And I take a screenshot
	
	When I select link "Grid View"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I take a screenshot	
	