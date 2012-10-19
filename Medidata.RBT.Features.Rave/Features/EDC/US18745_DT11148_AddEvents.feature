# The data manager requires the ability to lock the Add Events functionality, so that the entry and see entry users can no longer add any new folders to the subject eCRF.
# When a user with permission to lock is on the subject homepage, the user should see a "Disable" radio button that will allow the user to "Lock Add Events". When the user clicks on the radio button, an EDC user should no longer have the ability to Add Events.
# When a user with permission to unlock is on the subject homepage, and the "Add Events" feature is disabled, then the user should have the ability to click on an "Enable" radio button to allow for "Add Events". When The "Enable" radio button is selected, an EDC user should be able to Add Events.
# The default for a subject should be unlocked.
# The same feature will be provided for the subject in grid view. In addition, when a user with the ability to lock or unlock selects "ALL" in the grid view, the disable or enable add events feature will be included, respectively.
# The Add Events controls will disappear by adding all max add events on the subject page and grid view page
# The Add Events controls will be localized with Localization locale.
# NOTE: The ability to disable and enable the Add Event functionality only depends on the user role permission to lock or unlock and DO NOT take into consideration any pre-conditions that may be associated with the lock or unlock actions.
# When a user clicks on the lock icon and link after it has been disabled, and the user is navigated to the audits page then the audit trail will display the following "Audit: Add Events disabled. User: Username Time: date and time stamp of action"
# When a user clicks on the Parent: Subject - <Subject Name>, and the user is navigated to the audits page then the audit trail will display the following "Audit: Add Events Disabled.	User: Username Time: date and time stamp of action"

Feature: Disabling/Enabling Add Events 
  As a data manager
  I want to be able to disable and reenable Add Events
  So that I can decide when a study coordinator can add new folders to a subject
  I want to be able to see the audit trail for the Add Events disabled and enabled by user

Background:

Given xml draft "US18745StudyA.xml" is Uploaded
Given Site "Site_A1" exists
Given study "US18745StudyA" is assigned to Site "Site_A1"
Given I publish and push eCRF "US18745StudyA.xml" to "Version 1"
Given following Project assignments exist
|User                           |Project        |Environment |Role                           | Site    |SecurityRole          |
|US18745_entryuser              |US18745StudyA  |Live: Prod  |US18745_entryrole              | Site_A1 |Project Admin Default |
|US18745_readonlyuser           |US18745StudyA  |Live: Prod  |US18745_readonlyrole           | Site_A1 |Project Admin Default |
|US18745_entrylockunlockuser    |US18745StudyA  |Live: Prod  |US18745_entrylockunlockrole    | Site_A1 |Project Admin Default |
|US18745_entrylockuser          |US18745StudyA  |Live: Prod  |US18745_entrylockrole          | Site_A1 |Project Admin Default |
|US18745_entryunlockuser        |US18745StudyA  |Live: Prod  |US18745_entryunlockrole        | Site_A1 |Project Admin Default |
|US18745_seeentrylockunlockuser |US18745StudyA  |Live: Prod  |US18745_seeentrylockunlockrole | Site_A1 |Project Admin Default |
|US18745_locuser                |US18745StudyA  |Live: Prod  |US18745_entrylockunlockrole    | Site_A1 |Project Admin Default |

@release_2012.1.0
@US18745-01
@Validation
Scenario:@US18745-01 By Default the user with entry permission can not see Enable and Disable radio buttons on subject page and grid view page.

	Given I log in to Rave with user "US18745_entryuser"
    When I create a Subject
    |Field      |Data                 |Control Type |
    |Label 1    |SUB{RndNum<num1>(3)} |textbox      |
	Then I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	When I select link "Grid View"
	Then I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-02
@Validation  
Scenario:@US18745-02 When the Add Events disabled, the user with entry permission can see Lock icon with Audit link on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                 |Control Type |
    |Label 1    |SUB{RndNum<num2>(3)} |textbox      |
	And I click radiobutton with label "Disabled"
	And I take a screenshot
	And I log out of Rave
	And I log in to Rave with user "US18745_entryuser"
    When I select a Subject "{Var(num2)}"
	And I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message |User                                                        |Time                   |  
       |Add Events   | disabled.     |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num2)}"
	When I select link "Grid View"
	And I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message |User                                                        |Time                   |  
       |Add Events   | disabled.     |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num2)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num2)}"
	Then I verify Audits exist
       |Audit Type   | Query Message |User                                                        |Time                   |  
       |Add Events   | disabled.     |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-03
@Validation 
Scenario:@US18745-03 When the Add Events enabled, the user with entry permission can see the Add Events dropdown and Add button on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                 |Control Type |
    |Label 1    |SUB{RndNum<num3>(3)} |textbox      |
	And I log out of Rave
	And I log in to Rave with user "US18745_entryuser"
    When I select a Subject "{Var(num3)}"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
	And I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I take a screenshot
	When I select link "Grid View"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
	And I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-04
@Validation   
Scenario:@US18745-04 By Default the read only user with seeentry permission can not see Enable and Disable radio buttons on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                 |Control Type |
    |Label 1    |SUB{RndNum<num4>(3)} |textbox      |
	And I take a screenshot
	And I log out of Rave
	And I log in to Rave with user "US18745_readonlyuser"
    When I select a Subject "{Var(num4)}"
	Then I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Grid View"
	Then I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-05
@Validation    
Scenario:@US18745-05 When the Add Events disabled, the read only user with seeentry permission can not see Enable and Disable radio buttons on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                 |Control Type |
    |Label 1    |SUB{RndNum<num5>(3)} |textbox      |
	And I click radiobutton with label "Disabled"
	And I take a screenshot
	And I log out of Rave
	And I log in to Rave with user "US18745_readonlyuser"
    When I select a Subject "{Var(num5)}"
	Then I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
	And I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Grid View"
	Then I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
	And I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-06
@Validation   
Scenario:@US18745-06 When the Add Events enabled, the read only user with seeentry permission can not see Enable and Disable radio buttons on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                 |Control Type |
    |Label 1    |SUB{RndNum<num6>(3)} |textbox      |
	And I log out of Rave
	And I log in to Rave with user "US18745_readonlyuser"
    When I select a Subject "{Var(num6)}"
	Then I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
	And I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Grid View"
	Then I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
	And I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-07
@Validation 
Scenario:@US18745-07 By Default the user with lock, unlock and entry permission can see Enable, Disable radio buttons and add event drop down on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    When I create a Subject
    |Field      |Data                 |Control Type |
    |Label 1    |SUB{RndNum<num7>(3)} |textbox      |
	Then I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	When I select link "Grid View"
	Then I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-08
@Validation 
Scenario:@US18745-08 When the Add Events disabled on subject page, the user with lock, unlock and entry permission can see the greyed out Add Events dropdown with lock icon and Audit link on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    When I create a Subject
    |Field      |Data                 |Control Type |
    |Label 1    |SUB{RndNum<num8>(3)} |textbox      |
	Then I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	When I click radiobutton with label "Disabled"
    Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message |User                                                        |Time                   |  
       |Add Events   | disabled.     |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num8)}"
	When I select link "Grid View"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message |User                                                        |Time                   |  
       |Add Events   | disabled.     |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num8)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num8)}"
	Then I verify Audits exist
       |Audit Type   | Query Message |User                                                        |Time                   |  
       |Add Events   | disabled.     |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-09
@Validation 
Scenario:@US18745-09 When the Add Events enabled on subject page, the user with lock, unlock and entry permission can see the enable Add Events dropdown and add button on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    When I create a Subject
    |Field      |Data                 |Control Type |
    |Label 1    |SUB{RndNum<num9>(3)} |textbox      |
	Then I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
 	And I take a screenshot
	When I select link "Grid View"
    Then I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
 	And I log out of Rave
	
@release_2012.1.0
@US18745-10
@Validation 
Scenario:@US18745-10 The user with lock, unlock and entry permission disable, enable and disable the radio button on subject page, then the user can see the three actions of the Audit trail on the subject page, grid view page and Parent: Subject page.
 
	Given I log in to Rave with user "US18745_entrylockunlockuser"
    When I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num10>(3)} |textbox      |
	Then I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	When I click radiobutton with label "Disabled"
    Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	And I click radiobutton with label "Enabled"
	And I click radiobutton with label "Disabled"	
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num10)}"
	When I select link "Grid View"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num10)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num10)}"
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-11
@Validation 
Scenario:@US18745-11 When the Add Events disabled on subject grid view page, the user with lock, unlock and entry permission can see the greyed out Add Events dropdown with lock icon and Audit link on grid view page and subject calendar page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num11>(3)} |textbox      |
	When I select link "Grid View"	
	Then I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	When I click radiobutton with label "Disabled"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	When I select link "Calendar View"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num11)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num11)}"
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-12
@Validation 
Scenario:@US18745-12 When the Add Events enabled on subject grid view page, the user with lock, unlock and entry permission can see the enable Add Events dropdown and add button on grid view page and subject calendar page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                 |Control Type |
    |Label 1    |SUB{RndNum<num12>(3)} |textbox      |
	When I select link "Grid View"
	Then I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
 	And I take a screenshot
	When I select link "Calendar View"
    Then I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
 	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-13
@Validation 
Scenario:@US18745-13 The user with lock, unlock and entry permission disable, enable and disable the radio button on grid view page, then the user can see the three actions of the Audit trail on the grid view page, subject calendar page and Parent: Subject page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num13>(3)} |textbox      |
	When I select link "Grid View"
	Then I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	When I click radiobutton with label "Disabled"
    Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	And I click radiobutton with label "Enabled"
	And I click radiobutton with label "Disabled"
 	And I take a screenshot	
	When I select link "Calendar View"
    Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot	
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num13)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num13)}"
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-14
@Validation 
Scenario:@US18745-14 When the Add Events disabled by other user with entry and lock permission on subject page, the user with lock, unlock and entry permission can see the greyed out Add Events dropdown with lock icon and Audit link on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockuser"
    And I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num14>(3)} |textbox      |
	And I click radiobutton with label "Disabled"
	And I take a screenshot
	And I log out of Rave
	And I log in to Rave with user "US18745_entrylockunlockuser"
    When I select a Subject "{Var(num14)}"
    Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                            |Time                   |  
       |Add Events   | disabled.      |entrylock user ([id] - US18745_entrylockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num14)}"
	When I select link "Grid View"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                            |Time                   |  
       |Add Events   | disabled.      |entrylock user ([id] - US18745_entrylockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num14)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num14)}"
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                            |Time                   |  
       |Add Events   | disabled.      |entrylock user ([id] - US18745_entrylockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-15
@Validation 
Scenario:@US18745-15 All the Add Events controls will disappear by adding all max add events on the subject page.
#Note: Allow Add Max are "3" for "Unscheduled" matrices

    Given I log in to Rave with user "US18745_entrylockunlockuser"
	And I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num15>(3)} |textbox      |
	And I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	And I choose "Unscheduled" from "Add Event"
    And I click button "Add"
	And I take a screenshot
	And I choose "Unscheduled" from "Add Event"
    And I click button "Add"
	And I take a screenshot
	And I choose "Unscheduled" from "Add Event"
    When I click button "Add"
	Then I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Grid View"
	Then I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US18745-16
@Validation 
Scenario:@US18745-16 All the Add Events controls will disappear by adding all max add events on the subject grid view page.
#Note: Allow Add Max are "3" for "Unscheduled" matrices

    Given I log in to Rave with user "US18745_entrylockunlockuser"
	And I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num16>(3)} |textbox      |
	And I select link "Grid View"
	And I can see "Enabled" radio button
	And I can see "Disabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	And I choose "Unscheduled" from "Add Event"
    And I click button "Add"
	And I take a screenshot
	And I choose "Unscheduled" from "Add Event"
    And I click button "Add"
	And I take a screenshot
	And I choose "Unscheduled" from "Add Event"
    When I click button "Add"
	Then I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Calendar View"
	Then I can not see "Enabled" radio button
	And I can not see "Disabled" radio button
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US18745-17
@Validation  
Scenario:@US18745-17 By Default the user with entry and lock permission, can see the disable radio button, Add Event dropdown and Add Button on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockuser"
    When I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num17>(3)} |textbox      |
	Then I can see "Disabled" radio button
	And I can not see "Enabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	When I select link "Grid View"
	Then I can see "Disabled" radio button
	And I can not see "Enabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US18745-18
@Validation 
Scenario:@US18745-18 When the Add Events disabled on subject page, the user with lock and entry permission can see the greyed out Add Events dropdown with lock icon and Audit link on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockuser"
    When I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num18>(3)} |textbox      |
	Then I can see "Disabled" radio button
	And I can not see "Enabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	When I click radiobutton with label "Disabled"
    Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                            |Time                   |  
       |Add Events   | disabled.      |entrylock user ([id] - US18745_entrylockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num18)}"
	When I select link "Grid View"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                            |Time                   |  
       |Add Events   | disabled.      |entrylock user ([id] - US18745_entrylockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num18)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num18)}"
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                            |Time                   |  
       |Add Events   | disabled.      |entrylock user ([id] - US18745_entrylockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US18745-19
@Validation 
Scenario:@US18745-19 When the Add Events disabled by other user with entry, lock and unlock permission on subject page, the user with lock and entry permission can see the greyed out Add Events dropdown with lock icon and Audit link on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num19>(3)} |textbox      |
	And I click radiobutton with label "Disabled"
	And I take a screenshot
	And I log out of Rave
	And I log in to Rave with user "US18745_entrylockuser"
    When I select a Subject "{Var(num19)}"
    Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num19)}"
	When I select link "Grid View"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num19)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num19)}"
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US18745-20
@Validation 
Scenario:@US18745-20 By Default the user with entry and unlock permission, can see the enabled Add Event dropdown and Add Button on subject page and grid view page.

	Given I log in to Rave with user "US18745_entryunlockuser"
    When I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num20>(3)} |textbox      |
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see "Disabled" radio button
	And I can not see "Enabled" radio button
	And I take a screenshot
	When I select link "Grid View"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see "Disabled" radio button
	And I can not see "Enabled" radio button
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US18745-21
@Validation 
Scenario:@US18745-21 When the Add Events disabled by other user with entry, lock and unlock permission on subject page, the user with unlock and entry permission can see the enabled radio button greyed out Add Events dropdown with lock icon and Audit link on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num21>(3)} |textbox      |
	And I click radiobutton with label "Disabled"
	And I take a screenshot
	And I log out of Rave
	And I log in to Rave with user "US18745_entryunlockuser"
    When I select a Subject "{Var(num21)}"
	Then I can see "Enabled" radio button
	And I can not see "Disabled" radio button
    And I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num21)}"
	When I select link "Grid View"
	Then I can see "Enabled" radio button
	And I can not see "Disabled" radio button
    And I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num21)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num21)}"
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US18745-22
@Validation 
Scenario:@US18745-22 When the Add Events disabled by other user with entry, lock and unlock permission on subject page, the user with unlock and entry permission selects enabled radio button will enable Add Events dropdown and Add button is displayed on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num22>(3)} |textbox      |
	And I click radiobutton with label "Disabled"
	And I take a screenshot
	And I log out of Rave
	And I log in to Rave with user "US18745_entryunlockuser"
    When I select a Subject "{Var(num22)}"
	Then I can see "Enabled" radio button
	And I can not see "Disabled" radio button
    And I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
 	And I take a screenshot
	When I click radiobutton with label "Enabled"
    Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see "Disabled" radio button
	And I can not see "Enabled" radio button 
	And I log out of Rave
	And I log in to Rave with user "US18745_entrylockunlockuser"
	And I select a Subject "{Var(num22)}"
	And I click radiobutton with label "Disabled"
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |entryunlock user ([id] - US18745_entryunlockuser)           |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num22)}"
	And I select link "Grid View"
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |entryunlock user ([id] - US18745_entryunlockuser)           |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"	
	And I select a Subject "{Var(num22)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num22)}"
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                        |Time                   |  
       |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |entryunlock user ([id] - US18745_entryunlockuser)           |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US18745-23
@Validation 
Scenario:@US18745-23 By Default the user with seeentry, lock and unlock permission, can see disable and enable radio buttons with message on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    When I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num23>(3)} |textbox      |
	And I log out of Rave
	And I log in to Rave with user "US18745_seeentrylockunlockuser"
	When I select a Subject "{Var(num23)}"
	Then I can see "Disabled" radio button
	And I can see "Enabled" radio button
	And I can see the label "Select 'Disabled' to not allow others to add events."
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Grid View"
	Then I can see "Disabled" radio button
	And I can see "Enabled" radio button
	And I can see the label "Select 'Disabled' to not allow others to add events."
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	And I log out of Rave	
	
@release_2012.1.0
@US18745-24
@Validation 
Scenario:@US18745-24 When the Add Events disabled, the user with lock, unlock and seeentry permission can see the message with lock icon and Audit link on subject page and grid view page.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    When I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num24>(3)} |textbox      |
	And I log out of Rave
	And I log in to Rave with user "US18745_seeentrylockunlockuser"
	When I select a Subject "{Var(num24)}"
	Then I can see "Disabled" radio button
	And I can see "Enabled" radio button
	And I can see the label "Select 'Disabled' to not allow others to add events."
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I click radiobutton with label "Disabled"
	Then I can see "Disabled" radio button
	And I can see "Enabled" radio button
	And I can see the label "Select 'Enabled' to allow others to add events."
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	And I click radiobutton with label "Enabled"
	And I click radiobutton with label "Disabled"
    When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                              |Time                   |  
       |Add Events   | disabled.      |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num24)}"
	When I select link "Grid View"
	Then I can see "Disabled" radio button
	And I can see "Enabled" radio button
	And I can see the label "Select 'Enabled' to allow others to add events."
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                              |Time                   |  
       |Add Events   | disabled.      |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num24)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num24)}"
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                              |Time                   |  
       |Add Events   | disabled.      |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-25
@Validation 
Scenario:@US18745-25 When the Add Events disabled by other user with entry, lock and unlock permission, the user with lock, unlock and seeentry permission can see the message with lock icon and Audit link on subject page and grid view page.
The user with lock, unlock and seeentry permission enable and disable the radio button, then the user can see the three actions of the Audit trail done by two users.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    When I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num25>(3)} |textbox      |
	And I click radiobutton with label "Disabled"
	And I log out of Rave
	And I log in to Rave with user "US18745_seeentrylockunlockuser"
	When I select a Subject "{Var(num25)}"
	Then I can see "Disabled" radio button
	And I can see "Enabled" radio button
	And I can see the label "Select 'Enabled' to allow others to add events."
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I take a screenshot
	When I click radiobutton with label "Enabled"
	Then I can see "Disabled" radio button
	And I can see "Enabled" radio button
	And I can see the label "Select 'Disabled' to not allow others to add events."
	And I can not see dropdown labeled "Add Event"
	And I can not see "Add" button
	And I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
	And I take a screenshot
	And I click radiobutton with label "Disabled"
    When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                              |Time                   |  
       |Add Events   | disabled.      |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)         |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num25)}"
	And I select link "Grid View"
	When I select link "Add Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                              |Time                   |  
       |Add Events   | disabled.      |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)         |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
    And I navigate to "Home"	
	And I select a Subject "{Var(num25)}"	
	And I select primary record form
	And I click audit on form level
	When I select link "Subject - SUB{Var(num25)}"
	Then I verify Audits exist
       |Audit Type   | Query Message  |User                                                              |Time                   |  
       |Add Events   | disabled.      |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | enabled.       |seeentrylockunlock user ([id] - US18745_seeentrylockunlockuser)   |dd MMM yyyy HH:mm:ss   |
	   |Add Events   | disabled.      |entrylockunlock user ([id] - US18745_entrylockunlockuser)         |dd MMM yyyy HH:mm:ss   |
 	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US18745-26
@Validation 	
Scenario:@US18745-26  The Add Events controls can be localized on the subject page.

	Given I log in to Rave with user "US18745_locuser"
	When I create a Subject
    |Field       |Data                  |Control Type |
    |LLabel 1    |SUB{RndNum<num26>(3)} |textbox      |
    Then I can see "LDisabled" radio button
	And I can see "LEnabled" radio button
	And I can see "enabled" dropdown labeled "LAdd Event"
	And I can see "LAdd" button
	And I take a screenshot
	When I click radiobutton with label "LDisabled"	
	Then I can see "disabled" dropdown labeled "LAdd Event"
	And I can not see "LAdd" button
	And I can see "LDisabled" radio button
	And I can see "LEnabled" radio button	
 	And I take a screenshot
	And I click radiobutton with label "LEnabled"
    And I click radiobutton with label "LDisabled"
 	When I select link "LAdd Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type    |Query Message  |User                              |Time                 |
       |LAdd Events   |disabled.      |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|	   
       |LAdd Events   |enabled.       |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|
	   |LAdd Events   |disabled.      |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num26)}"
	And I select primary record form
	And I click audit on form level
	When I select link "LSubject - SUB{Var(num26)}"
	Then I verify Audits exist
       |Audit Type    |Query Message  |User                              |Time                 |
       |LAdd Events   |disabled.      |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|	   
       |LAdd Events   |enabled.       |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|
	   |LAdd Events   |disabled.      |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|
 	And I take a screenshot
	
@release_2012.1.0
@US18745-27
@Validation 	
Scenario:@US18745-27 The Add Events controls can be localized on the grid view page.

	Given I log in to Rave with user "US18745_locuser"
	And I create a Subject
    |Field       |Data                  |Control Type |
    |LLabel 1    |SUB{RndNum<num27>(3)} |textbox      |
	When I select link "LGrid View"
    Then I can see "LDisabled" radio button
	And I can see "LEnabled" radio button
	And I can see "enabled" dropdown labeled "LAdd Event"
	And I can see "LAdd" button
	And I take a screenshot
	When I click radiobutton with label "LDisabled"	
	Then I can see "disabled" dropdown labeled "LAdd Event"
	And I can not see "LAdd" button
	And I can see "LDisabled" radio button
	And I can see "LEnabled" radio button	
 	And I take a screenshot
	And I click radiobutton with label "LEnabled"
    And I click radiobutton with label "LDisabled"
 	When I select link "LAdd Event is currently disabled for this subject."
	Then I verify Audits exist
       |Audit Type    |Query Message  |User                              |Time                 |
       |LAdd Events   |disabled.      |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|	   
       |LAdd Events   |enabled.       |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|
	   |LAdd Events   |disabled.      |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|
	And I take a screenshot
	And I navigate to "Home"
	And I select a Subject "{Var(num27)}"
	And I select primary record form
	And I click audit on form level
	When I select link "LSubject - SUB{Var(num27)}"
	Then I verify Audits exist
       |Audit Type    |Query Message  |User                              |Time                 |
       |LAdd Events   |disabled.      |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|	   
       |LAdd Events   |enabled.       |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|
	   |LAdd Events   |disabled.      |loc user ([id] - US18745_locuser) |dd LMMM yyyy HH:mm:ss|
 	And I take a screenshot
	
@release_2012.1.0
@US18745-28
@Validation   	
Scenario:@US18745-28 Locking "All" in the subject grid view page disables the Add Event feature. 
Unlocking "All" in the subject grid view page enables the Add Event feature.

	Given I log in to Rave with user "US18745_entrylockunlockuser"
    And I create a Subject
    |Field      |Data                  |Control Type |
    |Label 1    |SUB{RndNum<num28>(3)} |textbox      |
	And I select link "Grid View"
	When I select link "All"
	Then I can see "Disabled" radio button
	And I can see "Enabled" radio button
	And I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	And I check "Lock" in "Subject level"
	When I click radiobutton with label "Set"
	And I take a screenshot
	And I click button "Save"
	And I take a screenshot
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I can see Add Event lock icon
	And I can see link "Add Event is currently disabled for this subject."
	And I take a screenshot
	And I check "Lock" in "Subject level"
	When I click radiobutton with label "Clear"
	And I take a screenshot
	And I click button "Save"
	And I take a screenshot
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see Add Event lock icon
	And I can not see link "Add Event is currently disabled for this subject."
	And I take a screenshot
	And I log out of Rave