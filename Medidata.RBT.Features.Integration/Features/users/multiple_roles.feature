# Rave Connection page is displayed to the user that are accessing Rave for the very first time when there is untransitioned Rave account with a matching username and/or email  and then Role Selection page will be displayed to connected users accessing Rave from iMedidata that have more than one EDC role. This will enable the user to select a role and proceed to study.
When there are no matching accounts on Rave , the user new account is created automatically and user sees Role Selection page if user is assigned to more than one EDC Role.

Feature: Rave Integration for Multiple Role Support
    In order to use multiple roles in Rave
    As a User
    I want to be able to see the Role selection page
	
Background:
	Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>"  user id "<User ID/Name>"
		|User						|PIN						| Password							|User ID/Name						|Email 							|
		|{iMedidata User 1}			|{iMedidata User 1 PIN}		|{iMedidata User 1 Password}		|{iMedidata User 1 ID}			|{iMedidata User 1 Email}		|
		|{iMedidata User 2}			|{iMedidata User 2 PIN}		|{iMedidata User 2 Password}		|{iMedidata User 2 ID}			|{iMedidata User 2 Email}		|
		|{iMedidata User 3}			|{iMedidata User 3 PIN}		|{iMedidata User 3 Password}		|{iMedidata User 3 ID}			|{iMedidata User 3 Email}		|
	And there exists a Rave user "<Rave User>" with username "<Rave User Name>" password "<Rave Password>" with "<Email>"
		|Rave User		|Rave User Name		|Rave Password		|Email			|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|
	And there exists study "<Study>" in study group "<Study Group>"
		|Study		|Study Group 	|
		|{Study A}	|{Study Group} 	|
		|{Study B}	|{Study Group} 	|
		|{Study C}	|{Study Group} 	|
	And there exists Rave study "<Rave Study>" 
		|{Rave Study 1}	|
	And there exists app "<App>" associated with study 
		|App			|
		|{EDC App}		|
		|{Modules App}	|
		|{Security App}	|
	And there exists site "<Site>" in study "<Study>", 		
		|Study		|Site		|
		|{Study A}	|{Site A1}	|
		|{Study B}	|{Site B1}	|
		|{Study C}	|{Site C1}	|
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role												|
		|{EDC App}		|{EDC Role 1}										|
		|{EDC App}		|{EDC Role 2}										|
		|{EDC App}		|{EDC Role 3}										|
		|{EDC App}		|{EDC Role CRA create sub cannot view all sites}	|
		{EDC App}		|{EDC Role RM Monitor}								|
		|{Modules App}	|{Modules Role 1}									|
		|{Modules App}	|{Modules Role 2 No Reports}						|
		|{Modules App}	|{Modules Role 3 No Sites}							|
		|{Security App}	|{Security Role 1}									|	
	And there exist <Rave URL> with <URL Name>
		|Rave URL		|URL Name							|
		|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
		
@Rave 564 Patch 13
@PB2.5.1.86-01
@Validation
Scenario: If an already connected iMedidata user accesses Rave through a study application link for the first time with a single EDC role, then Rave will take the user directly to the Study page.

    Given I am an iMedidata User "<iMedidata User 1 ID>"
    And I am logged in 
    And I am connected to  Rave
    And there is an iMedidata Study "<Study A>" in Study Group "<Study Group>"
    And there is a Rave Study "<Study A>"
    And the iMedidata Study "<Study A> is linked to the Rave Study "<Study A>"
    And I have an assignment to the iMedidata Study "<Study A>" for the App "<EDC App>" Role "<EDC Role 1>" for App "<Modules App>" Role "<Modules Role 1>"
	And I am on the iMedidata Home page
    When I click on the App "<EDC App>" next to the Study  "<Study A>"
    Then I should be on the Study "<Study A>" page in Rave
	And I take a screenshot
	And I should not see Role Selection page
	And I navigate to User Adminstration
	And I search for User "<iMedidata User 1 ID>" Authenticator "iMedidata"
	And I should see only 1 result for user <iMedidata User 1 ID>" with Role "<EDC Role 1>"
    And I take a screenshot
	
@Rave 564 Patch 13
@PB2.5.1.14-01
@Validation
Scenario: If an already connected iMedidata user access Rave through a study application link for with multiple EDC roles for that Study, then Role Selection page is displayed.

    Given I am an iMedidata User "<iMedidata User 1 ID>"
    And I am logged in 
    And I am connected to  Rave
    And there is an iMedidata Study "<Study A>" in Study Group "<Study Group>"
    And there is a Rave Study "<Study A>"
    And the iMedidata Study "<Study A> is linked to the Rave Study "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" Role "<EDC Role 1>", "<EDC Role 2>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" Role "<Modules Role 1>"
    And I am on the iMedidata Home page
    When I click on the App  "<EDC App>" next to the Study  "<Study A>"
    Then I should see the Role Selection Page
	And I should see "<EDC Role 1>" "<EDC Role 2>" in 'Select Role' Dropdown
	And I take a screenshot
	And I select "<EDC Role 1>" 
	And I select continue 
	And I am on Study "<Study A>" home page in Rave
	And I navigate to User Adminstration
	And I search for User "<iMedidata User 1 ID>" with Authenticator "iMedidata"
	And I should see two search results for the User "<iMedidata User 1 ID>"
	And I should see account for Role "<EDC Role 1>" assigned to user "<iMedidata User 1 ID>"
	And I should see account for Role "<EDC Role 2>" assigned to user "<iMedidata User 1 ID>"
    And I take a screenshot
	
@Rave 564 Patch 13
@PB2.5.1.14-02
@Validation
Scenario: If an already connected iMedidata user access Rave through a study application link for the first time with several EDC roles for that Study, then Role Selection page is displayed and All EDC Roles assigned to the user are displayed in the Select Role Dropdown and a account is created for each EDC Role the user is assigned to.


    Given I am an iMedidata User "<iMedidata User 1 ID>"
    And I am logged in 
    And I am connected to  Rave
    And there is an iMedidata Study "<Study A>" in Study Group "<Study Group>"
    And there is a Rave Study "<Study A>"
    And the iMedidata Study "<Study A> is linked to the Rave Study "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Roles "<EDC Role 1>", "<EDC Role 2>", "<EDC Role 3>", "<EDC Role 4>", "<EDC Role 5>", "<EDC Role 6>", "<EDC Role 7>","<EDC Role 8>", "<EDC Role 9>", "<EDC Role 10>", "<EDC Role 11>" , "<EDC Role 12>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" Role "<Modules Role 1>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Security App>" Role "<Security Group 1>"
    And I am on the iMedidata Home page
    When I click on the App  "<EDC App>" next to the Study  "<Study A>"
    Then I should see the Role Selection Page
	And I should see Roles "<EDC Role 1>", "<EDC Role 2>", "<EDC Role 3>", "<EDC Role 4>", "<EDC Role 5>", "<EDC Role 6>", "<EDC Role 7>","<EDC Role 8>", "<EDC Role 9>", "<EDC Role 10>", "<EDC Role 11>" , "<EDC Role 12>" in Select Role Dropdown
	And I take a screenshot
	And I select "<EDC Role 1>" 
	And I select continue 
	And I am on Study "<Study A>" home page in Rave
	And I navigate to User Adminstration
	And I search for User "<iMedidata User 1 ID>" with Authenticator "iMedidata"
	And I should see 12 accounts for User "<iMedidata User 1 ID>"
	And I should see Role "<EDC Role 1>" assigned to user "<iMedidata User 1 ID>" with User Group "<Modules Role 1>"
	And I should see Role "<EDC Role 2>" assigned to user "<iMedidata User 1 ID>" with User Group "<Modules Role 1>"
	And I should see Role "<EDC Role 3>" assigned to user "<iMedidata User 1 ID>" with User Group "<Modules Role 1>"
	And I should see Role "<EDC Role 4>" assigned to user "<iMedidata User 1 ID>" with User Group "<Modules Role 1>"
	And I should see Role "<EDC Role 5>" assigned to user "<iMedidata User 1 ID>" with User Group "<Modules Role 1>"
	And I should see Role "<EDC Role 6>" assigned to user "<iMedidata User 1 ID>" with User Group "<Modules Role 1>"
	And I should see Role "<EDC Role 7>" assigned to user "<iMedidata User 1 ID>"  with User Group "<Modules Role 1>"
	And I should see Role "<EDC Role 8>" assigned to user "<iMedidata User 1 ID>"  with User Group "<Modules Role 1>"
	And I should see Role "<EDC Role 9>" assigned to user "<iMedidata User 1 ID>"  with User Group "<Modules Role 1>"
	And I should see Role "<EDC Role 10>" assigned to user "<iMedidata User 1 ID>" with User Group "<Modules Role 1>"
	And I should see Role "<EDC Role 11>" assigned to user "<iMedidata User 1 ID>" with User Group "<Modules Role 1>"
	And I should see Role "<EDC Role 12>" assigned to user "<iMedidata User 1 ID>" with User Group "<Modules Role 1>"
    And I take a screenshot   

@Rave 564 Patch 13
@PB2.5.1.87-01
@Validation
Scenario: If a connected iMedidata user accesses Rave with multiple EDC roles after initally accessing Rave with a single EDC role then Rave will show the Role selection page for all the roles associated with the study. 

    Given I am an iMedidata User "<iMedidata User 1 ID>"
    And I am logged in 
    And I am connected to  Rave
    And there is an iMedidata Study "<Study A>" in Study Group "<Study Group>"
    And there is a Rave Study "<Study A>"
    And the iMedidata Study "<Study A> is linked to the Rave Study "<Study A>"
    And I have an assignment to the iMedidata Study "<Study A>" for the App "<EDC App>" with Role "<EDC Role 1>" 
    And I have an assignment to the iMedidata Study "<Study A>" for the App "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
    And I click the App "<EDC App>" associated with study "<Study A>"
    And I am on Rave "<Study A>" home page
	And I should not see Role Selection page
	And I follow iMedidata link
	And I am on iMedidata Home page
	And I have an new assignment to the iMedidata study "<Study A>" for App "<EDC App>" with  Role "<EDC Role 2>", "<EDC Role 3>", "<EDC Role 4>", "<EDC Role 5>", "<EDC Role 6>", "<EDC Role 7>"
    When I click the App  "<EDC App>" associated with study "<Study A>"
	Then I should be on Role Selection page
	And I should see Roles "<EDC Role 1>", "<EDC Role 2>", "<EDC Role 3>", "<EDC Role 4>", "<EDC Role 5>", "<EDC Role 6>", "<EDC Role 7>" in dropdown "Select Role" 
    And I take a screenshot
	And I select "<EDC Role 2>" from dropdown "Select Role" 
    And I select "Continue"
    And I should be on the Study "<Study A>" home page in Rave
	And I take a screen shot
	And I navigate to User Adminstration
	And I search for User "<iMedidata User 1 ID>" with Authenticator "iMedidata"
	And I should see Role "<EDC Role 1>" assigned to user "<iMedidata User 1 ID>"
	And I should see Role "<EDC Role 2>" assigned to user "<iMedidata User 1 ID>"
	And I should see Role "<EDC Role 3>" assigned to user "<iMedidata User 1 ID>"
	And I should see Role "<EDC Role 4>" assigned to user "<iMedidata User 1 ID>" 
	And I should see Role "<EDC Role 5>" assigned to user "<iMedidata User 1 ID>" 
	And I should see Role "<EDC Role 6>" assigned to user "<iMedidata User 1 ID>" 
	And I should see Role "<EDC Role 7>" assigned to user "<iMedidata User 1 ID>"  
	And I take a screenshot
	

@Rave 564 Patch 13
@PB2.5.1.88-01
@Validation
Scenario: If an already connected iMedidata user accesses the Rave URL for the first time with a single Rave Modules role (User Group), then Rave will take the user directly to the Rave home page with the appropriate Rave Modules role (User Group).

    Given I am an iMedidata User "<iMedidata User 1 ID>"
    And I am logged in 
    And I am connected to  Rave
    And there is an iMedidata Study "<Study A>" in Study Group "<Study Group>"
    And there is a Rave Study "<Study A>"
    And the iMedidata Study "<Study A> is linked to the Rave Study "<Study A>"
    And I have an assignment to only iMedidata Study "<Study A>" for the App "<Modules App>" Role "<Modules Role 1>"
	When I click the App  "<Modules App>" associated with study "<Study A>"
    Then I should be on Rave Home page
	And I take a screen shot
	And I see All Modules listed on the left hand side
    And I select link "User Administration"
	And I enter in text box "Log In " with User ID "<iMedidata New User 1 ID>"
	And I select "iMedidata" from the dropdown "Authenticator" 
	And I select link "Search"
	And I should see only one row in the search results table
	And I should see column Log In "<iMedidata User 1 ID>"
	And I should see column User Group "<Modules Role 1>"
	And I should see column Role "   "
	And I take a screenshot 
	
@Rave 564 Patch 13
@PB2.5.1.89-01
@Validation
Scenario: If an already connected iMedidata user accesses the Rave URL for the first time with a single EDC role for a study group with multiple studies, then Rave will take the user to the study listing page in Rave as the EDC role for that study group.

  	Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to  Rave 
    And there is an iMedidata Study Group  "<Study Group>"
	And there is Study "<Study A>", "<Study B>", "<Study C> assigned to Study Group "<Study Group>"
	And I have an Invitation to the Study Group "<Study Group>" with App "<EDC App>"  Role "<EDC Role 1>" with App "<Modules App>" Role "<Modules Role 1>" App "<Security App>" with Role "<Security Group 1>" as owner
	And I accept the invitation
	And I see Study Group "<Study Group>" Study "<Study A>", "<Study B>", "<Study C>" listed in my Studies Pane in iMedidata home page
	When I click the App  "<EDC App>" associated with study group "<Study Group>"
    Then I should be on Rave Home page
	And I should see study "<Study A>"
	And I should see study "<Study B>"
	And I should see study "<Study C>"
	And I take a screenshot 

@Rave 564 Patch 13
@PB2.5.1.25-01
@Validation
Scenario: If the user is an iMedidata user, when the user has multiple EDC Roles assigned in a specific study and subsequently accesses a specific Study in Rave from iMedidata, then Rave will display all roles for the study on the Role Selection page if the user clicked a study link on iMedidata.

    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
	And I am connected to Rave
    And there is an iMedidata Study Group  "<Study Group>"
    And there is an iMedidata Study  "<Study A>" in the Study Group  "<Study Group>"
    And there is an iMedidata Study  "<Study B>" in the Study Group "<Study Group>"
    And the iMedidata Study  "<Study A>" is linked to the Rave Study  "<Study A>"
	And the iMedidata Study  "<Study B>" is linked to the Rave Study  "<Study B>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App "<EDC App>" with Role "<EDC Role 1>","<EDC Role 2>" for App "<Modules App>" with Role "<Modules Role 1>" for App "<Security App>" with Role "<Security Group 1>"
    And I have an assignment to the iMedidata Study  "<Study B>" for the App "<EDC App>" with Role "<EDC Role 3>", "<EDC Role 4>" for app "<Modules App>" with Role "<Modules Role 1>" for App "<Security App>" with Role "<Security Group 1>"
	And I am on the iMedidata Home page
    When I follow "<EDC App>" associated with study "<Study A>"
    Then I am on the Role Selection page
	And I see "<EDC Role 1>" "<EDC Role 2>" in "Select Role" dropdown
    And I take a screen shot
    And I should not see "<EDC Role 3>", "<EDC Role 4>"
	And I select "<EDC Role 2>" from dropdown "Select Role" 
    And I select "Continue"
    And I should be on the Study Home page "<Study A>"
	And I select Home Icon 
	And I should see Study "<Study A>"
	And I should not see Study "<Study B>"
	And I follow iMedidata Link
	And I am on iMedidata Home page
	And I follow "<EDC App>" for Study "<Study B>"
	And I should be on Role Selection page
	And I should see "<EDC Role 3>", "<EDC Role 4>" in "Select Role" dropdown
	And I should not see "<EDC Role 1>", "<EDC Role 2>"
	And I select "<EDC Role 4>"
	And I am on Rave Study "<Study B>" home page
	And I should not see "<Study A>"
	And I navigate to User Adminstration 
	And I search for user "<iMedidata User 1 ID>" with Authenticator "iMedidata"
    And I verify four user accounts are displayed in search results
    And I verify "<EDC Role 1>" "<EDC Role 2>" "<EDC Role 3>", "<EDC Role 4>" for User "<iMedidata User 1 ID>"
	And I navigate to User Details page for "<EDC Role 1>"
	And I should see "<Study A> displayed in Studies Pane 
	And I take a screen shot
	And I navigate to User Details page for "<EDC Role 2>"
	And I should see "<Study A> displayed in Studies Pane 
	And I take a screen shot
	And I navigate to User Details page for "<EDC Role 3>"
	And I should see "<Study B> displayed in Studies Pane 
	And I take a screen shot
	And I navigate to User Details page for "<EDC Role 4>"
	And I should see "<Study B> displayed in Studies Pane 
	And I take a screen shot

@Rave 564 Patch 13
@PB2.5.1.25-02
@Validation
Scenario: If the user is an iMedidata user, when the user has multiple EDC Roles assigned to studies in an study group and subsequently accesses the Rave URL in iMedidata for that Study Group, then Rave will display all roles across all studies in  that Study Group  on Role selection page.

    Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
	And I am connected to Rave
    And there is an iMedidata Study Group  "<Study Group>"
    And there is an iMedidata Study "<Study A>", "<Study B>", "<Study C>" in the Study Group "<Study Group>"
	And I have an assignment to iMedidata Study "<Study A>" to App "<EDC App>" Role "<EDC Role 1>" Role "<EDC Role 2>" Modules App "<Modules App>" role "<Modules Role 1>"
	And I have an assignment to iMedidata Study "<Study B>" to App "<EDC App>" with only Role "<EDC Role 3>" Modules App "<Modules App>" Role "<Modules Role 1>"
    And I have an assignment to iMedidata Study Group "<Study Group>" with App "<EDC App>"  Role "<EDC Role 1>" Modules App "<Modules App>" Role "<Modules Role 1>"
	And I am on the iMedidata Home page
    When I follow App "<EDC App>" associated with Study Group "<Study Group>"
    Then I am on the Role Selection page
	And I see "<EDC Role 1>" "<EDC Role 2>" "<EDC Role 3>" from dropdown "Select Role" 
    And I take a screenshot
	And I select "<EDC Role 2>" from dropdown "Select Role" 
    And I select "Continue"
    And I should be on the Rave Study "<Study A>" Home page
	And I should not see "<Study B>" or "<Study C>"
	And I take a screenshot
	And I follow iMedidata link
	And I follow App "<EDC App>" for Study Group "<Study Group>"
	And I am on Role Selection page
	And I select "<EDC Role 1>
	And I should be on Rave Home page
	And I should see studies "<Study A>" "<Study C>"
	And I take a screenshot
	And I should not see Study "<Study B>"
    And I take a screen shot
	And I follow iMedidata link
	And I follow App "<EDC App>" for Study Group "<Study Group>"
	And I am on Role Selection page
	And I select "<EDC Role 3>
	And I should be on Rave Study "<Study B>" page
	And I should not see "<Study A>", "<Study B>"
	And I take a screenshot

@Rave 564 Patch 13 
@PB2.5.8.28-04 
@Validation
@BUG
Scenario: If an iMedidata user with two EDC roles in a linked study has one of the roles changed, they will be prompted for the new roles when they access Rave. The account for Role that are removed will get inactivated in Rave.

  	Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 2 ID>" in iMedidata
    And I am connected to  Rave 
    And there is an iMedidata Study Group  "<Study Group>" 
	And there is an iMedidata Study "<Study C>" assigned to Study Group "<Study Group>"
	And I have an assignment to study "<Study C>" with App "<EDC App>" Role "<EDC Role 1>" Role "<EDC Role 2>" App "<Modules App>" with Role "<Modules Role 1>" for App "<Security App>" with Role "<Security Group 1>"
	And I click the App "<EDC App>" associated with study "<Study C>"
    And I am on the Role Selection page
	And I see "<EDC Role 1>" "<EDC Role 2>" in "Select Role" dropdown
    And I select "<EDC Role 2>" from dropdown "Select Role" 
    And I select "Continue"
    And I am on Rave Home page
	And I navigate to User Adminstration in Rave
	And I search for User "<iMedidata User 2 ID>" Authenticator "iMedidata"
	And I should see only two accounts for "<iMedidata User 2 ID>" with Role "<EDC Role 1>" "<EDC Role 2>"
	And I select link "iMedidata"
	And I am on iMedidata Home page
    And my Role "<EDC Role 1>" for Study "<Study C>" is changed to "<EDC Role 3>"
	When I click the App  "<EDC App>" associated with study "<Study C>"
	Then I should see "<EDC Role 2>" "<EDC Role 3>" in "Select Role" dropdown
	And I take a screenshot
	And I should not see "<EDC Role 1>" in "Select Role" dropdown
    And I select "<EDC Role 3>" from dropdown "Select Role" 
    And I select "Continue"
    And I am on Rave Study "<Study C>" page
	And I navigate to User Adminstration
	And I search for User "<iMedidata User 2 ID>" Authenticator "iMedidata"
	And I should see two accounts for "<iMedidatat User 2 ID>" with Role "<EDC Role 2>", "<EDC Role 3>"
	And I should not see account for Role "<EDC Role 1>"
	And I take a screenshot 
	And I check "Include Inactive Records"
	And I search for User "<iMedidata User 2 ID>" Authenticator "iMedidata"
	And I should see "<EDC Role 1>" is displayed
	And I navigate to User Details page for "<EDC Role 1>"
	And I should see Active Check box is unchecked
	And I should not see "<Study C>" in Studies Pane
	And I take a screenshot

	
@Rave 564 Patch 13
@PB2.5.1.73-01
@Validation
@BUG
Scenario: If a user has more than one EDC Role in a specific study profile data, user attributes should be equally applied to each role in Rave.  The handling of account data should be fully transparent to the user.
	
	Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave User  "<iMedidata User 1 ID>"
    And the Rave User has an EDC Role of "<EDC Role 1>" "<EDC Role 2>"
    And there is an iMedidata Study Group  "<Study Group>"
    And there is an iMedidata Study  "<Study A>" in the Study Group  "<Study Group>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>"  Role "<EDC Role 1>" Role "<EDC Role 2>" for App "<Modules App>" with Role "<Modules Role 1>" App "<security App>" with Role "<Security Group 1>"
	And I am on the iMedidata Home page
	And I navigate to Account Details page
	And I note the following:
	|Email|First Name|Last Name|TimeZone|Locale|Phone|UserName|
	|iMedidata User 1 Email|iMedidata First Name1|iMedidata Last Name1|"<EST>"|"<Eng>"|20398239|"<iMedidata User 1 ID>"|
    And I take a screenshot
	And I click the App  "<EDC App>" associated with study "<Study A>"
	And I select Role "<EDC Role 1>" on Role Selection page
	And I am on Rave Homepage
	And I navigate to My Profile 
	And I verify the following:
    |Email|First Name|Last Name|TimeZone|Language|TelePhone|iMedidata UserName|
	|iMedidata User 1 Email|iMedidata First Name1|iMedidata Last Name1|"<EST>"|"<Eng>"|20398239|"<iMedidata User 1 ID>"|
	And I take a screenshot
	And I select link "User Administration"
	And I search for user "<iMedidata User 1 ID>" with iMedidata as "Authenticator"	
	And I see two rows in the search results table
	And I navigate to user details page for "<EDC Role 1>"
	And I verify the following:
	|Email|First Name|Last Name|TimeZone|Language|TelePhone|iMedidata UserName|
	|iMedidata User 1 Email|iMedidata First Name1|iMedidata Last Name1|"<EST>"|"<Eng>"|20398239|"<iMedidata User 1 ID>"|
	And I should see Study "<Study A>" in Studies pane with Role "<EDC Role 1>"
	And I take a screenshot
	And I navigate to User Details page for "<EDC Role 2>"
	And I verify the following:
	|Email|First Name|Last Name|TimeZone|Language|TelePhone|iMedidata UserName|
	|iMedidata User 1 Email|iMedidata First Name1|iMedidata Last Name1|"<EST>"|"<Eng>"|20398239|"<iMedidata User 1 ID>"|
	And I should see Study "<Study A>" in Studies pane with Role "<EDC Role 2>"
	And I take a screenshot

	
@Rave 564 Patch 13
@PB2.5.1.73-02
@Validation
Scenario: If an iMedidata user has more than one EDC Role, then the following attributes will be active for that user irrespective of the role selected when Rave is accessed by the user from iMedidata: Project, Role, and Deny Access. 
          
	Given I am an iMedidata User
    And I am logged in
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to  Rave User "<iMedidata User 1 ID>"
    And there is an iMedidata Study Group  "<Study Group>"
    And there is an iMedidata Study  "<Study A>" in the Study Group  "<Study Group>"
	And there is a Rave Study  "<Study A>"
    And the iMedidata Study  "<Study A>" is linked to the Rave Study  "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>"  Role "<EDC Role 1>" Role "<EDC Role 2>" for app  "<Modules Ap>" Role "<Modules Role 1>" for app "<Security App>" with Role "<Security Group 1>"
	And there is a Rave Study "<Study B>" that is not connected to iMedidata
	And I am on the iMedidata Home page
    And I click the App  "<EDC App>" associated with study "<Study A>"
	And I select "<EDC Role 1>" from "Select Role" on Role selection page
	And I am on Rave Study "<Study A>" page
	And I select link "User Administration"
	And I search for user "<iMedidata User 1 ID>" with iMedidata as "Authenticator"	
	And I see two rows in the search results table
	And I navigate to user details page for "<EDC Role 1>"
	And I follow "Assign to Project" in Other Modules 
	And I select a "Project" "<Study B>"
	And I select a "Role"
	And I uncheck "Deny Access"
	And I take a screenshot
	And I follow "Assign"
	And I should see the project added to "Other Modules" section of the User
	And I navigate to User Details page for "<EDC Role 2>"
	And I follow "Assign to Project" in Other Modules 
	And I select a "Project" "<Study B>"
	And I select a "Role"
	And I uncheck "Deny Access"
	And I take a screenshot
	And I follow "Assign"
	And I should see the project added to "Other Modules" section of the User
    And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.73-03
@Validation
Scenario: If a user is a external user and is connected to a Internal user with more than one EDC Role for a study the following attributes should be equally applied to each role in Rave.  The handling of account data should be fully transparent to the user.
	| Attribute                	| 
	| Credentials              	| 
	| Sponsor Approval         	| 
	| Investigator       		| 
	| Investigator Number       |  
	| DEA Number       			| 
	| Network Mask       		| 


    Given I am an iMedidata User "<iMedidata User 1 ID>"
    And I have activated my account 
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>"  Role "<EDC Role 1>" Role "<EDC Role 2>" for app  "<Modules Ap>" Role "<Modules Role 1>" for app "<Security App>" with Role "<Security Group 1>"
    And there exists a Rave User with Username "<iMedidata User 1 ID>"
	And I log in to Rave as user "<Rave User Name 1>" with access to "User Adminstration"
	And I navigate to User Adminstration
	And I navigate to User Details page for user "<iMedidata User 1 ID>"
	And I update the following :
    | Credentials              	| Cred 	|
	| Sponsor Approval         	| Check | 
	| Investigator       		| Check |
	| Investigator Number       | 38278 | 
	| DEA Number       			| 82343 |
	| Network Mask       		| NewMa |
	And I take a screenshot
	And I log out 
	And I log in to iMedidata as "<iMedidata User 1 ID>"
    And I click the App "<EDC App>" associated with study "<Study A>"
	And I am on Rave Connection Page
	And I enter Password "<Password>"
	And I follow "Link Account"
	And I am on Role Selection page
	And I select "<EDC Role 1>" from "Select Role" 
	And I am on Rave Study "<Study A>" page
	And I select link "User Administration"
	And I search for user "<iMedidata User 1 ID>" with iMedidata as "Authenticator"	
	And I see two rows in the search results table
	When I navigate to user details page for "<EDC Role 1>"  
	Then I should see the following applied to "<EDC Role 1>"
	| Credentials              	| Cred 	|
	| Sponsor Approval         	| Check | 
	| Investigator       		| Check |
	| Investigator Number       | 38278 | 
	| DEA Number       			| 82343 |
	| Network Mask       		| NewMa |
	And I take a screenshot
	And I navigate to User Details page for "<EDC Role 2>"
	Then I should see the following applied to "<EDC Role 2>"
	| Credentials              	| Cred 	|
	| Sponsor Approval         	| Check | 
	| Investigator       		| Check |
	| Investigator Number       | 38278 | 
	| DEA Number       			| 82343 |
	| Network Mask       		| NewMa |
	And I take a screenshot


release2012.2.0
@PB2.5.8.28-06 
@DRAFT
Scenario: If a new user is invited to an iMedidata study linked to a Rave study with a multiple EDC roles, after the user accepts the invitation and follows the EDC link to Rave for the first role, then Rave should display the role selection page to the user and when the user selects a role then Rave should create a user with the EDC role assigned in iMedidata on the Rave project and link the account.

@release2012.2.0
@PB2.5.8.28-09
@DRAFT
Scenario: If a new user is invited to an iMedidata study linked to a Rave study with two EDC roles and a Modules assignment, after the user accepts the invitation and follows the EDC link to Rave for the first role, then Rave should display the role selection page to the user and when the user selects a role then Rave should create a user with the EDC role and the Modules assignments from iMedidata on the Rave project and link the account. When the user goes back to iMedidata and follows the EDC link to Rave, sees the roles selection page and chooses the second EDC role, the user should access Rave as the second role.

@release2012.2.0
@PB2.5.1.103-01
@DRAFT
Scenario: If an already connected iMedidata user accesses the Role Selection page for the first time with multiple EDC Roles assigned for that Rave URL, then Rave will display the associated EDC roles as a list, allowing the user to simply select a role (no dropdowns).