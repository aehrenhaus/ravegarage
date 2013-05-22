@FT_MCC-53645_Manual 
@ignore

Feature: MCC-53645 Two users cannot have the same pin number, first and last name in Rave.


Background:

	Given I login to Rave with user "SUPER USER 1"



@Release_2013.2.0
@PBMCC-53645-001
@SJ22.MAY.2013
@Validation

Scenario: MCC53645-001 When users are created in User Administration, users cannot have the same pin number, first and last name.


	Given I navigate to "User Administration"
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In* 	  | PIN* | First Name*| Last Name*|
		| MCC53645-001| 12345| First 	  | Last 	  |
	And I take a screenshot
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In* 	  | PIN* | First Name*| Last Name*|
		| MCC53645-002| 12345| First      | LastOne   |
	And I take a screenshot
	And I navigate to "User Administration"
	And I select User "MCC53645-002"
	And I enter data in User Administration and save
		| Log In* 	  | PIN* | First Name*| Last Name*|
		| MCC53645-002| 12345| First 	  | Last 	  |
	Then I verify text "Enter a unique combination for First Name, Last Name and Pin" exists
	And I take a screenshot


@Release_2013.2.0
@PBMCC-53645-002
@SJ22.MAY.2013
@Validation

Scenario: MCC53645-002 When users are uploaded, users cannot have the same pin number, first and last name. 

	Given I navigate to "User Administration"
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In* 	  | PIN* | First Name*| Last Name*|
		| MCC53645-003| 12345| FirstName  | LastName  |	
	And I take a screenshot
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In* 	  | PIN* | First Name*| Last Name*|
		| MCC53645-004| 12345| FirstName  | Last      | 
	And I take a screenshot
	And I navigate to "User Administration"
	And I download User "MCC53645-004"
	And I modify User Draft and save
		| Log In* 	  | PIN* | First Name*| Last Name*|
		| MCC53645-004| 12345| FirstName  | LastName  | 
	And I take a screenshot	
	And I select link "Upload Users"
	And I Upload User "Users.xml"
	And I verify text "User 'MCC53645-004' has a non-unique first name - last name - PIN combination." exists
	And I take a screenshot