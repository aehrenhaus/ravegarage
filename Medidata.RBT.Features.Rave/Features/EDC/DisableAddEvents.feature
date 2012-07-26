# The data manager requires the ability to lock the Add Events functionality, so that the site user can no longer add any new folders to the subject eCRF.
# When a user with permission to lock is on the subject homepage, the user should see a "Disable" button that will allow the user to "Lock Add Events". When the user clicks on the button, an EDC user should no longer have the ability to Add Events.
# When a user with permission to unlock is on the subject homepage, and the "Add Events" feature is disabled, then the user should have the ability to click on an "Enable" button to allow for "Add Events". When the "Enable" button is selected, an EDC user should be able to Add Events.
# The default for a subject should be unlocked.
# The same feature will be provided for the subject in grid view. In addition, when a user with the ability to lock or unlock selects "ALL" in the grid view, the disable or enable add events feature will be included, respectively.
# NOTE: The ability to disable and enable the Add Event functionality only depends on the user role permission to lock or unlock and DO NOT take into consideration any pre-conditions that may be associated with the lock or unlock actions.

Feature: Disabling/Enabling Add Events 
  As a data manager
  I want to be able to disable and reenable Add Events
  So that I can decide when a study coordinator can add new folders to a subject

Background:
########### ASSUME USERS ARE ALREADY AVAILABLE
#	Given user "<User Name>" has study "Study A" with site "Site A1", from the table below
#        |User Name	|
#        |defuser	|
#        |cdm1		|
#        |cdm2		|
#        |siteuser	|
########### VIA ARCHITECT LOADER
#	And Study "Study A" has draft "Draft 1"
#	And Study "Study A" and site "Site A1" has folder "<Folder Name>" and form "<Form Name>", from the table below
#        |Folder Name    |Form Name |
#        |Folder A1      |Form A1   |
#        |Folder A2      |Form A2   |
#	And form "<Form A1>" has fields from the table below
#		|Field		|Control Type	|VarOID			|Format		|Field Name			|Field OID		|Field Num		|Indent Level		|Active	|Is visible field	|Field Label	|Fixed Unit		|Default Value	|Field Help Text	|
#		|Field 1	|Text			|FA11		|$6     	|Field Name 1		|FieldOID1	|				|0					|True	|True				|Field Label 1	|				|				|					|
#		|Field 2	|Text			|FA12		|$6     	|Field Name 2		|FieldOID2	|				|0					|True	|True				|Field Label 2	|				|				|					|
#	And form "<Form A2>" has fields from the table below
#		|Field		|Control Type	|VarOID			|Format		|Field Name			|Field OID		|Field Num		|Indent Level		|Active	|Is visible field	|Field Label	|Fixed Unit		|Default Value	|Field Help Text	|
#		|Field 1	|Text			|FA21		|$6     	|Field Name 1		|FieldOID3	|				|0					|True	|True				|Field Label 1	|				|				|					|
#		|Field 2	|Text			|FA22		|$6     	|Field Name 2		|FieldOID4	|				|0					|True	|True				|Field Label 2	|				|				|					|	
#	And draft "Draft 1" has matrix "<Matrix Name>", from the table below
#		|Matrix Name	|
#		|Primary		|
#		|Unscheduled	|
#	And matrix "<Matrix Name>" has allow add "<Allow Add>" and max "<Max>", from the table below
#		|Matrix Name	|Allow Add	|Max	|
#		|Default		|true		|1		| ##CHECK THIS
#		|Primary		|false		|1		|
#		|Unscheduled	|true		|5		|
#	And Study "Study A" and site "Site A1"  has subject "<Subject Name>", from the table below
#        |Subject Name   |
#        |SUB001      |
#        |SUB002      |
#	And role "<Role>" has lock action "<Lock>" and unlock action "<Unlock>", from the table below
#   And all roles have "Can View Study Grid" permission
#		|Role	|Lock	|Unlock	|
#		|Role 1	|true	|true	|
#		|Role 2	|true	|false	|
#		|Role 3	|false	|true	|
#		|Role 4	|false	|false	|
#	And user "<User Name>" has access to Study "Study A" with role "<Role>", from the table below
# 		|User Name	|Role	| 
#		|defuser	|Role 1	|
#		|CDM1B144V1	|Role 2	|
#		|cdm1E		|Role 3	|
#		|CDM1P11V2	|Role 4	|

 
@release_2012.1.0
@USXXXXX-01
@Draft   
Scenario: By default, the Add Event feature should be available for a subject when one or more matrices/folders can be added for a study.
	When I am logged in to Rave with username "defuser" and password "password"
    And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When I have seeded "Disable" button
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	When I click link "Grid View"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I log out of Rave

@release_2012.1.0
@USXXXXX-20
@Draft   	
Scenario: A user with lock permission can see the disable add event button on the subject home page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When I have seeded "Disable" button
	Then I can see "Disable" button
	And I log out of Rave
	When I am logged in to Rave with username "CDM1B144V1" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	Then I can see "Disable" button
	And I log out of Rave

@release_2012.1.0
@USXXXXX-03
@Draft   	
Scenario Outline: A user without lock permission cannot see the disable add event button on the subject home page.
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
    When I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	Then I can not see "Disable" button
	And I log out of Rave
	
Examples:
  	|User Name	| Password |
	|cdm1E	    | password |
	|CDM1P11V2	| password |

@release_2012.1.0
@USXXXXX-04	  
@Draft   	
Scenario: The "Disable Add Events" tooltip displays when a user hovers over the disable add event button on the subject home page.
	When I am logged in to Rave with username "defuser" and password "password"
    When I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When I have seeded "Disable" button
	Then I can see tooltip "Disable Add Events" on button labeled "Disable"
	And I log out of Rave

@release_2012.1.0
@USXXXXX-05
@Draft   	
Scenario: Clicking on the disable add event button disables the Add Event feature on the subject home page. 
	When I am logged in to Rave with username "defuser" and password "password"
	When I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When I have seeded "Disable" button
	When I click button "Disable"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I can not see "Disable" button
	And I log out of Rave


@release_2012.1.0
@USXXXXX-06
@Draft   	
Scenario: A user should not be able to add event if the Add Event feature is disabled on the subject home page. A lock icon, indicating that the Add Event feature is disabled, should display next to the Add Event dropdown if the user has Entry rights.
	When I am logged in to Rave with username "defuser" and password "password"
	When I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When I have seeded "Disable" button
	When I click button "Disable"
	And I log out of Rave
	When I am logged in to Rave with username "CDM1P11V2" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	And I can see Add Event lock icon
	Then I log out of Rave

@release_2012.1.0
@USXXXXX-07
@Draft   	
Scenario: A user with unlock permission can see the enable add event button on the subject home page only when the Add Event feature is disabled.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Disable" button
	When I click button "Disable"
	And I log out of Rave
	When I am logged in to Rave with username "cdm1E" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	Then I can see "Enable" button
	And I log out of Rave
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB005"
	And I have seeded "Enable" button
	When I click button "Enable"
	And I log out of Rave
	When I am logged in to Rave with username "cdm1E" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB005"
	Then I can not see "Enable" button
	And I log out of Rave


@release_2012.1.0
@USXXXXX-08
@Draft   	
Scenario Outline: A user without unlock permission cannot see the enable add event button on the subject home page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Enable" button
	And I log out of Rave
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	Then I can not see "Enable" button
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB005"
	Then I can not see "Enable" button
	And I log out of Rave

Examples:
  	| User Name  | Password |
  	| CDM1B144V1 | password |
  	| CDM1P11V2  | password |

@release_2012.1.0
@USXXXXX-09
@Draft   	
Scenario: The "Enable Add Events" tool tip displays when a user hovers over the enable add event button on the subject home page.
	When I am logged in to Rave with username "defuser" and password "password"
    When I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	When I have seeded "Enable" button
	Then I can see tooltip "Enable Add Events" on button labeled "Enable"
	And I log out of Rave

@release_2012.1.0
@USXXXXX-10
@Draft   	
Scenario: Clicking on the enable add event button on the subject home page allows users to add event.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Enable" button
	When I click button "Enable"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	Then I can not see "Enable" button
	And I log out of Rave
	

@release_2012.1.0
@USXXXXX-11
@Draft   	
Scenario: A user with lock permission can see the disable add event button on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Disable" button
	And I click link "Grid View"
	Then I can see "Disable" button
	And I log out of Rave

@release_2012.1.0
@USXXXXX-12
@Draft   	
Scenario Outline: A user without lock permission cannot see the disable add event button on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Disable" button
	And I log out of Rave
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I click link "Grid View"
	Then I can not see "Disable" button
	And I log out of Rave
	
Examples:
  	| User Name | Password |
  	| cdm1E     | password |
  	| CDM1P11V2 | password |

@release_2012.1.0
@USXXXXX-13
@Draft   	
Scenario: The "Disable Add Events" tool tip displays when a user hovers over the disable add event button on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Disable" button
	And I click link "Grid View"
	When I have seeded "Disable" button
	Then I can see tooltip "Disable Add Events" on button labeled "Disable"
	And I log out of Rave

@release_2012.1.0
@USXXXXX-14
@Draft   	
Scenario: Clicking on the disable add event button disables the Add Event feature on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Disable" button
	And I click link "Grid View"
	When I click button "Disable"
	Then I can see "disabled" dropdown labeled "Add Event"
	And I can not see "Add" button
	Then I can not see "Disable" button
	And I log out of Rave

@release_2012.1.0
@USXXXXX-15
@Draft   	
Scenario: A user should not be able to add event if the Add Event feature is disabled on the subject grid view page. A lock icon, indicating that the Add Event feature is disabled, should display next to the Add Event dropdown.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Disable" button
	And I click button "Disable"
	And I log out of Rave
	When I am logged in to Rave with username "CDM1P11V2" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I click link "Grid View"
	Then I can not see "Add" button
	And I can see Add Event lock icon
	Then I log out of Rave

@release_2012.1.0
@USXXXXX-16
@Draft   	
Scenario Outline: A user with unlock permission can see the enable add event button on the subject grid view page only when the Add Event feature is disabled.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Disable" button
	And I click button "Disable"
	And I log out of Rave
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I click link "Grid View"
	Then I can see "Enable" button
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB005"
	And I click link "Grid View"
	Then I can not see "Enable" button
	
Examples:
  	| User Name | Password |
  	| defuser   | password |
  	| cdm1E      | password |

@release_2012.1.0
@USXXXXX-17
@Draft   	
Scenario Outline: A user without unlock permission cannot see the enable add event button on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Disable" button
	And I click button "Disable"
	And I log out of Rave
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I click link "Grid View"
	Then I can not see "Enable" button
	When I am logged in to Rave with username "<User Name>" and password "<Password>"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB005"
	And I click link "Grid View"
	Then I can not see "Enable" button
	And I log out of Rave
	
Examples:
  	| User Name	| Password |
  	| CDM1P11V2	| password |
  	| CDM1B144V1| password |

@release_2012.1.0 
@USXXXXX-18
@Draft   	
Scenario: The "Enable Add Events" tool tip displays when a user hovers over the enable add event button on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Enable" button
	And I click link "Grid View"
	When I have seeded "Enable" button
	Then I can see tooltip "Enable Add Events" on button labeled "Enable"
	And I log out of Rave

@release_2012.1.0
@USXXXXX-19
@Draft   	
Scenario: Clicking on the enable add event button allows users to add event on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Disable" button
	And I click button "Disable"
	When I click button "Enable"
	Then I can see "enabled" dropdown labeled "Add Event"
	Then I can see "Add" button
	Then I can not see "Enable" button
	And I log out of Rave
	
@release_2012.1.0
@USXXXXX-20
@Draft   	
Scenario: Disabling the Add Event feature on the subject home page also disables the Add Event feature on the subject grid view page.	
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Disable" button
	And I click button "Disable"
	And I click link "Grid View"
	Then I can see "disabled" dropdown labeled "Add Event"
	Then I can not see "Add" button
	Then I can not see "Disable" button
	And I log out of Rave

@release_2012.1.0
@USXXXXX-21
@Draft   	
Scenario: Disabling the Add Event feature on the subject grid view page also disables the Add Event feature on the subject home page.	
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Disable" button
	And I click link "Grid View"
	And I click button "Disable"
	And I click link "Calendar View"
	Then I can see "disabled" dropdown labeled "Add Event"
	Then I can not see "Add" button
	Then I can not see "Disable" button
	And I log out of Rave
	
@release_2012.1.0
@USXXXXX-22
@Draft   	
Scenario: Enabling the Add Event feature on the subject home page also enables the Add Event feature on the subject grid view page.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I have seeded "Enable" button
	And I click button "Enable"
	And I click link "Grid View"
	Then I can see "enabled" dropdown labeled "Add Event"
	Then I can see "Add" button
	Then I can not see "Enable" button
	And I log out of Rave	
		
@release_2012.1.0
@USXXXXX-23
@Draft   	
Scenario: Enabling the Add Event feature on the subject grid view page also enables the Add Event feature on the subject home page.	
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I click link "Grid View"
	And I have seeded "Disable" button
	And I click button "Disable"
	And I click button "Enable"
	And I click link "Calendar View"
	Then I can see "enabled" dropdown labeled "Add Event"
	Then I can see "Add" button
	Then I can not see "Enable" button
	And I log out of Rave			

@release_2012.1.0
@USXXXXX-24
@Draft   	
Scenario: Locking "All" in the subject grid view page disables the Add Event feature.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I click link "Grid View"
	And I have seeded "Disable" button
	When I click link "All"
	And I check Lock checkbox
	And I click radiobutton with label "Set"
	And I click button "Save"
	Then I can see "disabled" dropdown labeled "Add Event"
	Then I can not see "Add" button
	Then I can not see "Disable" button
	And I log out of Rave	

@release_2012.1.0
@USXXXXX-25
@Draft   	
Scenario: Unlocking "All" in the subject grid view page enables the Add Event feature.
	When I am logged in to Rave with username "defuser" and password "password"
	And I select Study "Study A" and Site "Site A1" 
	And I select a Subject "SUB004"
	And I click link "Grid View"
	When I click link "All"
	And I check Lock checkbox
	And I click radiobutton with label "Set"
	And I click button "Save"
	And I have seeded "Enable" button
	And I check Lock checkbox
	And I click radiobutton with label "Clear"
	And I click button "Save"
	Then I can see "enabled" dropdown labeled "Add Event"
	And I can see "Add" button
	And I can not see "Enable" button
	And I log out of Rave	