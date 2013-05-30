@FT_MCC-53645_Manual 
@ignore

Feature: MCC-53645 Two users cannot have the same pin number, first and last name in Rave.


Background:

	Given I login to Rave with user "SUPER USER 1"



@Release_2013.2.0
@PBMCC-53645-001
@SJ22.MAY.2013
@Validation

Scenario: MCC53645-001 When users are modified in User Administration with same Last Name,an error message show that users cannot have the same pin number, first and last name.


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

Scenario: MCC53645-002 When users are uploaded with same Last Name,an error message show that users cannot have the same pin number, first and last name.

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
	Then I verify text "User 'MCC53645-004' has a non-unique first name - last name - PIN combination." exists
	And I take a screenshot



@Release_2013.2.0
@PBMCC-53645-003
@SJ22.MAY.2013
@Validation

Scenario: MCC53645-003 When users are modified in User Administration with same First Name,an error message show that users cannot have the same pin number, first and last name.


	Given I navigate to "User Administration"
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-005 | 12345 | FirstAAA    | Last       |
	And I take a screenshot
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-006 | 12345 | FirstBBB    | Last       |
	And I take a screenshot
	And I navigate to "User Administration"
	And I select User "MCC53645-006"
	And I enter data in User Administration and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-006 | 12345 | FirstAAA    | Last       |
	Then I verify text "Enter a unique combination for First Name, Last Name and Pin" exists
	And I take a screenshot



@Release_2013.2.0
@PBMCC-53645-004
@SJ22.MAY.2013
@Validation

Scenario: MCC53645-004 When users are uploaded with same First Name,an error message show that users cannot have the same pin number, first and last name.

	Given I navigate to "User Administration"
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-007 | 12345 | FirstCCC    | Last       |	
	And I take a screenshot
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-008 | 12345 | FirstDDD    | Last       | 
	And I take a screenshot
	And I navigate to "User Administration"
	And I download User "MCC53645-008"
	And I modify User Draft and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-008 | 12345 | FirstCCC    | Last       |
	And I take a screenshot	
	And I select link "Upload Users"
	And I Upload User "Users.xml"
	Then I verify text "User 'MCC53645-008' has a non-unique first name - last name - PIN combination." exists
	And I take a screenshot




@Release_2013.2.0
@PBMCC-53645-005
@SJ22.MAY.2013
@Validation

Scenario: MCC53645-005 When users are modified in User Administration with same PIN,an error message show that users cannot have the same pin number, first and last name.


	Given I navigate to "User Administration"
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-009 | 12345 | FirstEEE    | Last       |
	And I take a screenshot
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-010 | 54321 | FirstEEE    | Last       |
	And I take a screenshot
	And I navigate to "User Administration"
	And I select User "MCC53645-010"
	And I enter data in User Administration and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-010 | 12345 | FirstEEE    | Last       |
	Then I verify text "Enter a unique combination for First Name, Last Name and Pin" exists
	And I take a screenshot




@Release_2013.2.0
@PBMCC-53645-006
@SJ22.MAY.2013
@Validation

Scenario: MCC53645-006 When users are uploaded with same PIN,an error message show that users cannot have the same pin number, first and last name.

	Given I navigate to "User Administration"
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-011 | 12345 | FirstGGG    | Last       |	
	And I take a screenshot
	And I select link "New User"
	And I enter data in User Administration and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-012 | 54321 | FirstGGG    | Last       |
	And I take a screenshot
	And I navigate to "User Administration"
	And I download User "MCC53645-012"
	And I modify User Draft and save
		| Log In*      | PIN*  | First Name* | Last Name* |
		| MCC53645-012 | 12345 | FirstGGG    | Last       |
	And I take a screenshot	
	And I select link "Upload Users"
	And I Upload User "Users.xml"
	Then I verify text "User 'MCC53645-012' has a non-unique first name - last name - PIN combination." exists
	And I take a screenshot