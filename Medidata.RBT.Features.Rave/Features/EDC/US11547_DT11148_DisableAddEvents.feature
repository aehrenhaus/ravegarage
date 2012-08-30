# The data manager requires the ability to lock the Add Events functionality, so that the site user can no longer add any new folders to the subject eCRF.
# When a user with permission to lock is on the subject homepage, the user should see a "Disable" button that will allow the user to "Lock Add Events". When the user clicks on the button, an EDC user should no longer have the ability to Add Events.
# When a user with permission to unlock is on the subject homepage, and the "Add Events" feature is disabled, then the user should have the ability to click on an "Enable" button to allow for "Add Events". When The "Enable" button is available is selected, an EDC user should be able to Add Events.
# The default for a subject should be unlocked.
# The same feature will be provided for the subject in grid view. In addition, when a user with the ability to lock or unlock selects "ALL" in the grid view, the disable or enable add events feature will be included, respectively.
# NOTE: The ability to disable and enable the Add Event functionality only depends on the user role permission to lock or unlock and DO NOT take into consideration any pre-conditions that may be associated with the lock or unlock actions.

Feature: Disabling/Enabling Add Events 
  As a data manager
  I want to be able to disable and reenable Add Events
  So that I can decide when a study coordinator can add new folders to a subject

Background:
# ASSUME USERS ARE ALREADY AVAILABLE
#	Given user "<User Name>" has study "Study A" with site "Site A1", from the table below
#        |User Name	|
#        |defuser	|
#        |cdm1		|
#        |cdm2		|
#        |siteuser	|
# VIA ARCHITECT LOADER
#	And Study "Study A" has draft "Draft 1"
#	And Study "Study A" and site "Site A1" has folder "<Folder Name>" and form "<Form Name>", from the table below
#        |Folder Name    |Form Name |
#        |Folder A1      |Form A1   |
#        |Folder A2      |Form A2   |
#	And form "<Form A1>" has fields from the table below
#		|Field		|Control Type	|VarOID		|Format		|Field Name			|Field OID	|Field Num		|Indent Level		|Active	|Is visible field	|Field Label	|Fixed Unit		|Default Value	|Field Help Text	|
#		|Field 1	|Text			|FA11		|$6     	|Field Name 1		|FieldOID1	|				|0					|True	|True				|Field Label 1	|				|				|					|
#		|Field 2	|Text			|FA12		|$6     	|Field Name 2		|FieldOID2	|				|0					|True	|True				|Field Label 2	|				|				|					|
#	And form "<Form A2>" has fields from the table below
#		|Field		|Control Type	|VarOID		|Format		|Field Name			|Field OID	|Field Num		|Indent Level		|Active	|Is visible field	|Field Label	|Fixed Unit		|Default Value	|Field Help Text	|
#		|Field 1	|Text			|FA21		|$6     	|Field Name 1		|FieldOID3	|				|0					|True	|True				|Field Label 1	|				|				|					|
#		|Field 2	|Text			|FA22		|$6     	|Field Name 2		|FieldOID4	|				|0					|True	|True				|Field Label 2	|				|				|					|	
#	And Draft "Draft 1" has matrix "<Matrix Name>", from the table below
#		|Matrix Name	|
#		|Default		|
#	And matrix "<Matrix Name>" has allow add "<Allow Add>" and max "<Max>", from the table below
#		|Matrix Name	|Allow Add	|Max	|
#		|Default		|true		|1		| ##CHECK THIS
#		|Primary		|false		|1		|
#		|Unscheduled	|true		|5		|
#	And Study "Study A" and site "Site A1"  has subject "<Subject Name>", from the table below
#        |Subject Name   |
#        |SUB004         |
#        |SUB005         |
#	And role "<Role>" has lock action "<Lock>" and unlock action "<Unlock>", from the table below
#   And all roles have "Can View Study Grid" permission
#		|Role	|Entry	|See Entry	|Lock	|Unlock	|
#		|Role 1	|true	|true	    |true	|true	|
#		|Role 2	|true	|true	    |true	|false	|
#		|Role 3	|true	|true	    |false	|true	|
#		|Role 4	|true	|true	    |false	|false	|
#	And user "<User Name>" has access to Study "Study A" with role "<Role>", from the table below
# 		|User Name	|Role	| 
#		|defuser	|Role 1	|
#		|cdm1		|Role 2	|
#		|cdm2		|Role 3	|
#		|siteuser	|Role 4	|

 
@release_2012.1.0
@US11547-01
@Draft   
Scenario:@US11547-01 By default, the Add Event feature should be available for a subject when one or more matrices/folders can be added for a study.
	When I am logged in to Rave with username "defuser" and password "password"
    And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When The "Disable" button is available
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	When I select link "Grid View"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US11547-02
@Draft   	
Scenario:@US11547-02 A user with lock permission can see the disable add event button on the subject home page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When The "Disable" button is available
	Then I can see "Disable" button
	And I take a screenshot
	And I log out of Rave
	When I am logged in to Rave with username "cdm1" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	Then I can see "Disable" button
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US11547-03
@Draft   	
Scenario Outline:@US11547-03 A user without lock permission cannot see the disable add event button on the subject home page.
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
    When I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	Then I can not see "Disable" button
	And I take a screenshot
	And I log out of Rave
	
Examples:
  	|User Name	| Password |
	|cdm2		| password |
	|siteuser	| password |

@release_2012.1.0
@US11547-04	  
@Draft   	
Scenario:@US11547-04 The "Disable Add Events" tooltip displays when a user hovers over the disable add event button on the subject home page.
	When I am logged in to Rave with username "defuser" and password "password"
    When I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When The "Disable" button is available
	Then I can see tooltip "Disable Add Events" on button labeled "Disable"
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US11547-05
@Draft   	
Scenario:@US11547-05 Clicking on the disable add event button disables the Add Event feature on the subject home page. 
	When I am logged in to Rave with username "defuser" and password "password"
	When I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When The "Disable" button is available
	And I take a screenshot
	When I click button "Disable"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I can not see "Disable" button
	And I take a screenshot
	And I log out of Rave


@release_2012.1.0
@US11547-06
@Draft   	
Scenario:@US11547-06 A user should not be able to add event if the Add Event feature is disabled on the subject home page. A lock icon, indicating that the Add Event feature is disabled, should display next to the Add Event dropdown if the user has Entry rights.
	When I am logged in to Rave with username "defuser" and password "password"
	When I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When The "Disable" button is available
	When I click button "Disable"
	And I take a screenshot
	And I log out of Rave
	When I am logged in to Rave with username "cdm1" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I can see Add Event lock icon
	And I take a screenshot
	Then I log out of Rave

@release_2012.1.0
@US11547-07
@Draft   	
Scenario:@US11547-07 A user with unlock permission can see the enable add event button on the subject home page only when the Add Event feature is disabled.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Disable" button is available
	When I click button "Disable"
	And I take a screenshot
	And I log out of Rave
	When I am logged in to Rave with username "cdm2" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	Then I can see "Enable" button
	And I take a screenshot
	And I log out of Rave
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB005"
	And The "Enable" button is available
	And I take a screenshot
	When I click button "Enable"
	And I take a screenshot
	And I log out of Rave
	When I am logged in to Rave with username "cdm2" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB005"
	Then I can not see "Enable" button
	And I take a screenshot
	And I log out of Rave


@release_2012.1.0
@US11547-08
@Draft   	
Scenario Outline:@US11547-08 A user without unlock permission cannot see the enable add event button on the subject home page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Enable" button is available
	And I take a screenshot
	And I log out of Rave
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	Then I can not see "Enable" button
	And I take a screenshot
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB005"
	Then I can not see "Enable" button
	And I take a screenshot
	And I log out of Rave

Examples:
  	| User Name  | Password |
  	|cdm1		 | password |
  	|siteuser	 | password |

@release_2012.1.0
@US11547-09
@Draft   	
Scenario:@US11547-09 The "Enable Add Events" tool tip displays when a user hovers over the enable add event button on the subject home page.
	When I am logged in to Rave with username "defuser" and password "password"
    When I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When The "Enable" button is available
	Then I can see tooltip "Enable Add Events" on button labeled "Enable"
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US11547-10
@Draft   	
Scenario:@US11547-10 Clicking on the enable add event button on the subject home page allows users to add event.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Enable" button is available
	When I click button "Enable"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	Then I can not see "Enable" button
	And I take a screenshot
	And I log out of Rave
	

@release_2012.1.0
@US11547-11
@Draft   	
Scenario:@US11547-11 A user with lock permission can see the disable add event button on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Disable" button is available
	And I take a screenshot
	And I select link "Grid View"
	Then I can see "Disable" button
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US11547-12
@Draft   	
Scenario Outline:@US11547-12 A user without lock permission cannot see the disable add event button on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Disable" button is available
	And I take a screenshot
	And I log out of Rave
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I select link "Grid View"
	Then I can not see "Disable" button
	And I take a screenshot
	And I log out of Rave
	
Examples:
  	| User Name | Password |
  	|cdm2		| password |
  	|siteuser	| password |

@release_2012.1.0
@US11547-13
@Draft   	
Scenario:@US11547-13 The "Disable Add Events" tool tip displays when a user hovers over the disable add event button on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Disable" button is available
	And I take a screenshot
	And I select link "Grid View"
	When The "Disable" button is available
	Then I can see tooltip "Disable Add Events" on button labeled "Disable"
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US11547-14
@Draft   	
Scenario:@US11547-14 Clicking on the disable add event button disables the Add Event feature on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Disable" button is available
	And I take a screenshot
	And I select link "Grid View"
	When I click button "Disable"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	Then I can not see "Disable" button
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US11547-15
@Draft   	
Scenario:@US11547-15 A user should not be able to add event if the Add Event feature is disabled on the subject grid view page. A lock icon, indicating that the Add Event feature is disabled, should display next to the Add Event dropdown.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Disable" button is available
	And I click button "Disable"
	And I take a screenshot
	And I log out of Rave
	When I am logged in to Rave with username "cdm1" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I select link "Grid View"
	Then I can not see "Add" button
	And I can see Add Event lock icon
	And I take a screenshot
	Then I log out of Rave

@release_2012.1.0
@US11547-16
@Draft   	
Scenario Outline:@US11547-16 A user with unlock permission can see the enable add event button on the subject grid view page only when the Add Event feature is disabled.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Disable" button is available
	And I click button "Disable"
	And I take a screenshot
	And I log out of Rave
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I select link "Grid View"
	Then I can see "Enable" button
	And I take a screenshot
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB005"
	And I select link "Grid View"
	Then I can not see "Enable" button
	And I take a screenshot
	
Examples:
  	| User Name | Password |
  	| defuser   | password |
  	| cdm2      | password |

@release_2012.1.0
@US11547-17
@Draft   	
Scenario Outline:@US11547-17 A user without unlock permission cannot see the enable add event button on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Disable" button is available
	And I click button "Disable"
	And I take a screenshot
	And I log out of Rave
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I select link "Grid View"
	Then I can not see "Enable" button
	And I take a screenshot
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB005"
	And I select link "Grid View"
	Then I can not see "Enable" button
	And I take a screenshot
	And I log out of Rave
	
Examples:
  	|User Name	 | Password |
  	|cdm1		 | password |
  	|siteuser	 | password |

@release_2012.1.0 
@US11547-18
@Draft   	
Scenario:@US11547-18 The "Enable Add Events" tool tip displays when a user hovers over the enable add event button on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Enable" button is available
	And I take a screenshot
	And I select link "Grid View"
	When The "Enable" button is available
	Then I can see tooltip "Enable Add Events" on button labeled "Enable"
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US11547-19
@Draft   	
Scenario:@US11547-19 Clicking on the enable add event button allows users to add event on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Disable" button is available
	And I take a screenshot
	And I click button "Disable"
	When I click button "Enable"
	Then I can see "enabled" dropdown labeled "Add Event"
	Then I can see "Add" button
	Then I can not see "Enable" button
	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US11547-20
@Draft   	
Scenario:@US11547-20 Disabling the Add Event feature on the subject home page also disables the Add Event feature on the subject grid view page.	
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Disable" button is available
	And I click button "Disable"
	And I take a screenshot
	And I select link "Grid View"
	Then I can see "disabled" dropdown labeled "Add Event"
	Then I can not see "Add" button
	Then I can not see "Disable" button
	And I take a screenshot
	And I log out of Rave

@release_2012.1.0
@US11547-21
@Draft   	
Scenario:@US11547-21 Disabling the Add Event feature on the subject grid view page also disables the Add Event feature on the subject home page.	
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Disable" button is available
	And I take a screenshot
	And I select link "Grid View"
	And I click button "Disable"
	And I take a screenshot
	And I select link "Calendar View"
	Then I can see "disabled" dropdown labeled "Add Event"
	Then I can not see "Add" button
	Then I can not see "Disable" button
	And I take a screenshot
	And I log out of Rave
	
@release_2012.1.0
@US11547-22
@Draft   	
Scenario:@US11547-22 Enabling the Add Event feature on the subject home page also enables the Add Event feature on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And The "Enable" button is available
	And I take a screenshot
	And I click button "Enable"
	And I select link "Grid View"
	Then I can see "enabled" dropdown labeled "Add Event"
	Then I can see "Add" button
	Then I can not see "Enable" button
	And I take a screenshot
	And I log out of Rave	
		
@release_2012.1.0
@US11547-23
@Draft   	
Scenario:@US11547-23 Enabling the Add Event feature on the subject grid view page also enables the Add Event feature on the subject home page.	
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I select link "Grid View"
	And The "Disable" button is available
	And I take a screenshot
	And I click button "Disable"
	And I click button "Enable"
	And I take a screenshot
	And I select link "Calendar View"
	Then I can see "enabled" dropdown labeled "Add Event"
	Then I can see "Add" button
	Then I can not see "Enable" button
	And I take a screenshot
	And I log out of Rave			

@release_2012.1.0
@US11547-24
@Draft   	
Scenario:@US11547-24 Locking "All" in the subject grid view page disables the Add Event feature.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I select link "Grid View"
	And The "Disable" button is available
	And I take a screenshot
	When I select link "All"
	And I check "Lock"
	And I click radiobutton with label "Set"
	And I take a screenshot
	And I click button "Save"
	And I take a screenshot
	Then I can see "disabled" dropdown labeled "Add Event"
	Then I can not see "Add" button
	Then I can not see "Disable" button
	And I take a screenshot
	And I log out of Rave	

@release_2012.1.0
@US11547-25
@Draft   	
Scenario:@US11547-25 Unlocking "All" in the subject grid view page enables the Add Event feature.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I select link "Grid View"
	When I select link "All"
	And I check Lock checkbox
	And I click radiobutton with label "Set"
	And I take a screenshot
	And I click button "Save"
	And I take a screenshot
	And The "Enable" button is available
	And I check Lock checkbox
	And I click radiobutton with label "Clear"
	And I take a screenshot
	And I click button "Save"
	And I take a screenshot
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see "Enable" button
	And I take a screenshot
	And I log out of Rave
	And I take a screenshot	