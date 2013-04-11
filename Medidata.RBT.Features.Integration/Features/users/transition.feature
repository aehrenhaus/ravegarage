Feature: Rave Integration for Transition
    In order to transition users to iMedidata
    As a User xx
    I want to be able to see the iMedidata connection page
	
	
	Background1:
	Given I am an iMedidata user with first name "<Fname>" and last name "<Lname>" with pin "<PIN>" password "<Password>" and user id "<User id/Name>"
		|Fname								|Lname								|PIN						| Password							|User id/Name						|Email 							|
		|{iMedidata User First Name 1}		|{iMedidata User Last Name 1}		|iMedidata User 1 PIN}		|{iMedidata User 1 Password}		|{iMedidata User 1 id}			|{iMedidata User 1 Email}		|
		|{iMedidata User First Name 2}	    |{iMedidata User Last Name 2}		|iMedidata User 2 PIN}		|{iMedidata User 2 Password}		|{iMedidata User 2 id}			|{iMedidata User 2 Email}		|
		|{iMedidata Base User First Name}	|{iMedidata Base User Last Name} 	|iMedidata Base User PIN}	|{iMedidata Base User Password}		|{iMedidata Base User id}		|{iMedidata Base User Email}	|
		|{New User First Name }				|{New User Last Name }				|							|{New User Password}				|{New User id}					|{New User Email}				|
	And there exists a Rave user "<Rave user>" with username <Rave user Name>" and password "<Rave Password>" with "<Email>" and "<Rave First Name>" and "<Rave Last "Nane>"
		|Rave user		|Rave user Name		|Rave Password		|Email			|Rave First Name 	|Rave Last Name 	|
		|{Rave user 1}	|{Rave user Name 1}	|{Rave Password 1}	|{Rave Email 1}	|Rave First Name 1	|Rave Last Name 1	|
		|{Rave user 2}	|{Rave user Name 2}	|{Rave Password 2}	|{Rave Email 2}	|Rave First Name 2	|Rave Last Name 2	|
		|{Rave user 5}	|{Rave user Name 5}	|{Rave Password 5}	|{Rave Email 5}	|Rave First Name 5	|Rave Last Name 5	|
		|{Rave user 6}	|{Rave user Name 6}	|{Rave Password 6}	|{Rave Email 6}	|Rave First Name 6	|Rave Last Name 6	|
	And there exists study "<Study>" in Study Aroup "<Study Aroup>"
		|Study		|Study Aroup 	|
		|{Study A}	|{Study Aroup} 	|
		|{Study B}	|{Study Aroup} 	|
		|{Study C}	|{Study Aroup} 	|
		|{Study D}	|{Study Aroup} 	|
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
		|{Study D}	|{Site D1}	|	
	And there exists subject <Subject> with eCRF page "<eCRF Page>" in Site <Site>
		|Site		|Subject		|eCRF Page		|
		|{Site A1}	|{Subject 1}	|{eCRF Page 1}	|	
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role												|                             |
		|{EDC App}		|{EDC Role 1}										|No ViewAllSitesinSiteGroup   |
		|{EDC App}		|{EDC Role 2}										|No ViewAllSitesinSiteGroup   |
		|{EDC App}		|{EDC Role 3}										|No ViewAllSitesinSiteGroup   |
		|{EDC App}		|{EDC Role CRA create sub cannot view all sites}	|No ViewAllSitesinSiteGroup   |
		|{EDC App}		|{EDC Role RM Monitor}								|ViewAllSitesinSiteGroup      |
		|{Modules App}	|{Modules Role 1}									|                             |
		|{Modules App}	|{Modules Role 2 No Reports}						|                             |
		|{Modules App}	|{Modules Role 3 No Sites}							|                             |
		|{Security App}	|{Security Role 1}									|                             |			
	And there exist <Rave URL> with <URL Name>
		|Rave URL		|URL Name							|
		|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
		|{Rave URL 2}	|{rave564conlabtesting2.mdsol.com	|
		|{Rave URL 3}	|{rave564conlabtesting3.mdsol.com	|
		|{Rave URL 4}	|{rave564conlabtesting4.mdsol.com	|
	And There exists <eLearning Course> associated with "<Role>"
		|eLearning Course	|
		|{Course 1}
		

Background2:

	Given I am a Rave admin user
    And I create a Rave user with Mandatory fields
    And I enter <Credentials>,  Site Group, Investigator checkbox, Investigator Number, DEA Number, Network Mask
    And I assign the Rave user to the All Modules User Group
	And I enter <date> in Training Date
	And I check the box for Training Signed
	And I activate the user
	And I assign the Rave user to Study A with role <Role 1>
	And I assign the Rave user to Study B with role <Role 2>
	And I assign the Rave user to Study C with role <Role2>
	And there exists Site C1 associated with Study C
	And I assign Site C1 to User
	And I assign eLearning to Study B with role <Role 2>
	And I assign <Report> to the Rave user
	And I assign BOXI to the Rave user 
	And I assign JReview to the Rave user
	And I assign Architect Difference standard report to the Rave user
	And I assign User Saved report to the Rave user
	And I assign Audit Trail Report to the Rave user
	And I assign the Other Modules as follows:
	|Module								|Project				    |Role							|Security Group		|Deny Access	|Remove	|
	|Architect Project					|Study A					|Architect Role 1		        |					|				|		|
	|Module								|Volume						|Role							|Security Group		|Deny Access	|Remove	|
	|Architect Global Library			|Global Library 1			|Global Library role 1	        |					|				|	    |
	|Batch Upload Configuration	        |Study A				    |Batch upload Role1          	|					|				|		|
	|SafetyGatewayMapping		     	|Study A				    |Mapping Role1		         	|					|				|		|
	|SafetyGatewayManagement	        |Study A				    |Management Role1	            |					|				|		|
	And there is an iMedidata Study  "<Study A>" and "<Study B>"
    And the iMedidata Study  "<Study A>" is linked to the Rave Study "<Study A>"
    And the iMedidata Study  "<Study B>" is linked to the Rave Study "<Study B>"
    And I Invite the Rave user to the iMedidata Study "<Study A>" for the App link  "<EDC App>" with Role "<EDC Role 1>"
	And I Invite the Rave user to the iMedidata Study "<Study A>" for the App link  "<Modules App>" with Role "<Modules Role 1>"
	And I Invite the Rave user to the iMedidata Study "<Study B>" for the App link  "<EDC App>" with Role "<EDC Role 2>"
	And I Invite the Rave user to the iMedidata Study "<Study B>" for the App link  "<Modules App>" with Role "<Modules Role 1>"
	And the Rave user creates the iMedidata account <iMedidata User 1 id> and accepts the invitation to <Study A> and <Study B>
	When I click on app link "<EDC App>" next to the Study  "<Study A>"
	Then I should see Rave Connection page
	And I should see text "To permanently link your Rave account with your "<First Name 1>" "<Last Name 1>"(<iMedidata User 1 id>, <iMedidata User 1 Email>) iMedidata account, please enter your Rave user name and Password.
	And I should see link "Link to Existing Account"
	And I follow "Link to Existing account"
	And I enter credentials for an existing Rave account
    And I should be on the Rave Study page for the Study  "<Study A>"


@Rave 564 Patch 13
@PB2.5.1.75-01
@Validation
Scenario: If an iMedidata user accesses Rave through the Rave URL or study for the first time with a single EDC role and there are no 
untransitioned Rave user accounts with matching email address or username, then Rave will create a new account and take the user to the requested study page.


	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
    And I am not connected to Rave
    And there is not a Rave user with an Email of "<iMedidata User 1 Email>"
	And there is not a Rave user with an Username of "<iMedidata User 1 id>"
    And there is an iMedidata Study  "<Study A>"
    And there is a Rave Study  "<Study A>"
    And the iMedidata Study  "<Study A>" is linked to the Rave Study  "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>" App  "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
    When I click on app link "<EDC App>" next to the Study  "<Study A>"
	Then I should be on the Rave Study page for the Study  "<Study A>"
    And I should see my name is "<First Name 1>" "<Last Name 1>"
	And I click on User Adminstration
	And I enter Username "<iMedidata User 1 id>" in Login Text Field	
	And I select Authenticator "iMedidata"
	And I click the search link
	And I navigate to user Details for User "<iMedidata User 1 id>"
	And I should see "<Study A>" listed in Studies pane
	And I should see Authenticator "iMedidata"
	And I should see Role "<EDC Role 1>"
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.1.76-02
@Validation
Scenario: If an iMedidata user accesses Rave through the Rave URL or study for the first time with a single EDC role and there is a single untransitioned
          Rave account with matching username only, then Rave will display the Rave Connection page and prompt the user for
   the password to the single account found and provide options to select a different account or create a new account in Rave.

	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
    And I am not connected to Rave
	And there is a Rave user with Name "<First Name 1>" "<Last Name 1>"
	And Rave username  "<iMedidata User 1 id>"
	And the Email of the Rave user does not match with iMedidata user
    And there is an iMedidata Study  "<Study A>"
    And there is a Rave Study  "<Study A>"
    And the iMedidata Study  "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>"  App  "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
    When I click on app link "<EDC App>" next to the Study  "<Study A>"
	Then I should be on Rave Connection page
	And I should see "Connect your Rave account to iMedidata"
	And I should see "To permanently link your Rave account with your" "<First Name 1>" "<Last Name 1>" (<iMedidata User 1 id>, "<iMedidata User 1 Email>") iMedidata account, please enter your Rave Password.
    And I should see "Rave Account" "<iMedidata User 1 id>"
	And I should see Password is " "
	And I should see "Link Account" button
	And I should see "Create a New Account"
    And I should see "Choose a different Account"
	And I enter Password "<Rave user Password 1>"
	And I select "Link Account"
	And I am on Rave Study "<Study A>" home page
	And I click on User Adminstration
    And I enter Username "<iMedidata User 1 id>" in Login text field
    And I select "iMedidata" as Authenticator
    And I click the search link
    And I should see my name "<First Name 1>" "<Last Name 1>"And I navigate to user details page for user "<iMedidata User 1 id>"
	And I should see "<Study A>"in Studies pane
	And I should see Authenticator "iMedidata"
	And I should see Login: "<iMedidata User 1 id>"
	And I take a screenshot
	And I navigate to User Adminstration
	And I search for user "<iMedidata User 1 id>" Authenticator "Internal"
	And I should see no results
	And I take a screenshot
	 

@Rave 564 Patch 13
@PB2.5.1.76-01
@Validation
Scenario: If an iMedidata user accesses Rave through the Rave URL or study for the first time with a single EDC role and there is a single
           untransitioned Rave account with matching email address only, then Rave will display the Rave Connection page and prompt the user for
		   the password to the single account found and provide options to select a different account or create a new account in Rave.

	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user  "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user  "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user  "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study B>"
    And there is a Rave Study  "<Study B>"
    And the iMedidata Study  "<Study B>" is linked to the Rave Study "<Study B>"
    And I have an assignment to the iMedidata Study "<Study B>"  for the App link  "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
	When I click on app link "<EDC App>" next to the Study  "<Study A>"
    Then I should be on the Rave Connection page
	And I should see text "To permanently link your Rave account with your "<First Name 1>" "<Last Name 1>"(<iMedidata User 1 id>, <iMedidata User 1 Email>) iMedidata account, please enter your Rave Password."
    And I should see "Connect your Rave account to iMedidata"
    And I should see label "Rave Account" "<Rave user Name 1>"
    And I should see label "Password" 
	And I should see Password text field
    And I should see "Link Account" button
	And I should see "Choose a different Account" link
	And I should see "Create a New Account" button
	And I enter Password "<Rave user Password 1>"
	And I select "Link Account" button
	And I am on Rave Study "<Study A>" home page
    And I click on User Admin
    And I enter Username "<iMedidata User 1 id>" in Login text field
    And I select "iMedidata" as Authenticator
    And I click the search link
    And I should see my name "<First Name 1>" "<Last Name 1>"
	And I navigate to user details page for user "<iMedidata User 1 id>"
	And I should see "<Study A>"in Studies pane
	And I should see Log in "<iMedidata User 1 id>"
	And I take a screenshot
	And I navigate to User Administration
	And I search for "<Rave user Name 1>" Authenticator "Internal"
	And I should see no results
	And I select Authenticator "iMedidata"
	And I check "Include Inactive Records"
	And I search
	And I should see "<iMedidata User 1 id>" 
	And I navigate to User Details page for "<iMedidata User 1 id>"
	And I should see Active check box is Unchecked
	And I should see Authenticator "iMedidata"
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.77-01
@Validation
Scenario: If an iMedidata user accesses Rave through the Rave URL or study for the first time with a single EDC role and there is a single untransitioned Rave
              account with matching email address and Username,  then Rave will display Rave Connection page and prompt the user for
		   the password to the single account found or create a new account in Rave or link to a different account.
	
	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
    And there is a Rave user with Username "<iMedidata User 1 id>"
    And the Rave user has an Email of "<iMedidata User 1 Email>"
	And there is an iMedidata Study  "<Study B>"
    And there is a Rave Study  "<Study B>"
    And the iMedidata Study  "<Study B>" is linked to the Rave Study "<Study B>"
    And I have an assignment to the iMedidata Study "<Study B>" for the App link  "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
	When I click on app link "<EDC App>" next to the Study  "<Study B>"
    Then I should be on the Rave Connection page
	And I should see text "To permanently link your Rave account with your "<First Name 1>" "<Last Name 1>"(<iMedidata User 1 id>, <iMedidata User 1 Email>) iMedidata account, please enter your Rave Password.
    And I should see "Connect your Rave account to iMedidata"
    And I should see "Rave Account" is "<iMedidata User 1 id>"
    And I should see "Password" is " "
    And I should see "Link Account" button
	And I should see "Create a New Account"
	And I should see "Choose a different account"
	And I enter Password "<Rave Password 1>"
	And I follow "Link Account"
	And I am on Rave Study "<Study B>" home page
	And I navigate to User Adminstration
	And I search for user "<iMedidata User 1 id>" with Authenticator "iMedidata"
	And I navigate to user details page for user "<iMedidata User 1 id>"
	And I should see "<Study B>" in Studies pane
	And I should see Authenticator "iMedidata"
	And I should see Login "<iMedidata User 1 id>"
	And I should see Email "<iMedidata User 1 Email>"
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.78-01
@Validation
Scenario: If an unconnected iMedidata user accesses Rave through a study application link for the first time with multiple EDC roles
          for that study and there is a single Rave account with matching email, then Rave will display the Rave Connection
		   page and prompt the user for the password to the single account found.  After successful authentication Rave will merge the
		   selected account with the iMedidata-created account.  Rave will then show the Role Selection page and prompt the user for
		   which EDC role from the list of roles assigned to that Rave account in that study page.
   
	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user  "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user  "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user  "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study B>"
    And there is a Rave Study  "<Study B>"
    And the iMedidata Study  "<Study B>" is linked to the Rave Study "<Study B>"
    And I have an assignment to the iMedidata Study "<Study B>" for the App link  "<EDC App>" with Role "<EDC Role 1>" with Role "<EDC Role 2>" for app "<Modules App>" with Role "<Modules Role 1>"
	And I click on app link "<EDC App>" next to the Study  "<Study A>"
    And I am on the Rave Connection page
	And I fill in "Password" with "<Rave Password 1>"
    When I click on "Link Account"
	Then I should be on the Role Selection page
    And I take a screenshot
	And I should see "Select Role" dropdown
    And I should see "Please select a role from the list below"
    And I should see "<EDC Role 1>" "<EDC Role 2>" in "Select Role" dropdown
	And I select "<EDC Role 1>" 
    And I follow "Continue"
	And I should see Rave "<Study B>" home page in Rave
	And I navigate to User Adminstration 
	And I search for User "<iMedidata User 1 id>" Authenticator "iMedidata"
	And I should see two  search results
	And I should see Role "<EDC Role 1>" for User "<iMedidata User 1 id>"
	And I should see Role "<EDC Role 2>" for user "<iMedidata User 1 id>"
	And I take a screenshot
	And I navigate to "<EDC Role 1>" user details page for User "<iMedidata User 1 id>"
	And I should see "Authenticator" :iMedidata
	And I should see Login:"<iMedidata User 1 id>1"
	And I navigate to "<EDC Role 2>" user details page for User "<iMedidata User 1 id>"
	And I should see "Authenticator" :iMedidata
	And I should see Login:"<iMedidata User 1 id>2"



@Rave 564 Patch 13
@PB2.5.1.79-01
@Validation
Scenario: If an unconnected iMedidata user accesses Rave through a study application link for the first time with multiple EDC roles for
             that study and there is a single Rave account with matching username then Rave will display the Rave Connection
			  page and prompt the user for the password to the single account found.  After successful authentication Rave will merge
			   the selected account with the iMedidata-created account.  Rave will then show the Role Selection page and prompt the user
			    for which EDC role from the list of roles assigned to that Rave account in that study.  Once the role is selected, Rave
				 will take the user to the requested study page as the selected Role.
   
	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>" has a Username "<iMedidata User 1 id>"
    And the Rave user "<Rave user 1>" has an Email of "<Rave user 1 Email>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study B>"
    And there is a Rave Study  "<Study B>"
    And the iMedidata Study  "<Study B>" is linked to the Rave Study "<Study B>"
    And I have an assignment to the iMedidata Study "<Study B>" for the App link  "<EDC App>" with Role "<EDC Role 1>" Role "<EDC Role 2>" for App "<Modules App>" with Role "<Modules Role 1>"
	And I click on app link "<EDC App>" next to the Study  "<Study B>"
    And I am on the Rave Connection page
	And I fill in "Password" with "<Rave Password 1>"
    When I click on "Link Account" Button
	Then I should be on the Role Selection page
    And I take a screenshot
	And I should see "Role Selection"
    And I should see "Please select a role from the list below"
    And I should see  "<EDC Role 1>" "<EDC Role 2>" from "Select Role" dropdown
    And I select "<EDC Role 1>" 
    And I follow "Continue"
	And I should see Rave Study "<Study B>" home page
	And I navigate to User Adminstration 
	And I search for User "<iMedidata User 1 id>" Authenticator "iMedidata"
	And I should see two search results
	And I should see Role "<EDC Role 1>" for User "<iMedidata User 1 id>"
	And I should see Role "<EDC Role 2>" for user "<iMedidata User 1 id>"
	And I take a screenshot
	And I navigate to "<EDC Role 1>" user details page for User "<iMedidata User 1 id>"
	And I should see "Authenticator" :iMedidata
	And I should see Login:"<iMedidata User 1 id>1"
	And I navigate to "<EDC Role 2>" user details page for User "<iMedidata User 1 id>"
	And I should see "Authenticator" :iMedidata
	And I should see Login:"<iMedidata User 1 id>2"


@Rave 564 Patch 13
@PB2.5.1.80-01
@Validation
Scenario: If an unconnected iMedidata user accesses Rave through URL, study for the first time with a single EDC role and there are multiple Rave accounts with matching email, then Rave will display the Rave Connection page and prompt the user to select the account, and then enter password to the selected account.
   
	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>"has a Username "<Rave user Name 1>"
	And the Rave user "<Rave user 1>" First name is "<Rave First Name 1>" Last Name is "<Rave Last Name 1>"
    And the Rave user "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is a Rave user "<Rave user 2>"
    And the Rave user "<Rave user 2>" has a Username "<Rave user Name 2>"
    And the Rave user "<Rave user 2>" First name is "<Rave First Name 2>" Last Name is "<Rave Last Name 2>"
	And the Rave user "<Rave user 2>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user "<Rave user 2>" has a Password "<Rave Password 2>"
	And there is an iMedidata Study "<Study C>"
    And there is a Rave Study "<Study C>"
    And the iMedidata Study "<Study C>" is linked to the Rave Study "<Study C>"
	And I have an assignment to the iMedidata Study "<Study C>" for the App link  "<EDC App>" with Role "<EDC Role 1>" for app "<Modules App>" with Role "<Modules Role 1>" 
	When I click on app link "<EDC App>" next to the Study  "<Study C>"
    Then I am on the Rave Connection page
	And I should see "Connect your Rave account to iMedidata"
	And I should see text "To permanently link your Rave account with your "<First Name 1>" "<Last Name 1>"(<iMedidata User 1 id>, <iMedidata User 1 Email>) iMedidata account, please enter your Rave Password."
	And I should see "<Rave First Name 1>""<Rave Last Name 1>" (<Rave user Name 1>)" in "Rave Account" dropdown
  	And I should see "<Rave First Name 2>""<Rave Last Name 2>" (<Rave user Name 2>)" in "Rave Account" dropdown
    And I take a screenshot
	And I should see "Password" is " "
    And I should see "Choose a Different Account"
    And I should see "Link  Account"
	And I should see " Create a New Account"
	And I select "<Rave user Name 1>" from "Rave Account" Dropdown
	And I enter password "<Rave user 1 Password>"
	And I click on "Link Account" button
	And I am on Rave Study "<Study C>" home page
	And I navigate to User Adminstration
	And I search for user "<iMedidata User 1 id>" with Authenticator "iMedidata" 
	And I navigate to user details page for user "<iMedidata User 1 id>" 
	And I should see Login is "<iMedidata User 1 id>"
	And I should not see Login "<Rave user Name 1>"
	And I should see Authenticator is iMedidata
	And I take a screenshot
	And I navigate to User Adminstration
	And I search for User "<Rave user Name 2>" Authenticator "Internal"
	And I should see "<Rave user Name 2>" in search results
	And I navigate to User Details page for User "<Rave user Name 2>"
	And I should see "Internal"
	And I should see Login "<Rave user Name 2>"
	And I take a screenshot
   
@Rave 564 Patch 13
@PB2.5.8.28-102
@Validation
Scenario Outline: When a user views the Rave Connection page, the following attributes and text that shows the possible options.

Examples:
    | Field       | Text                                            | 
    | Page Title  | Connect your Rave account to iMedidata          | 
    | Text        | To permanently link your Rave account with your "<iMedidata User First Name>""<iMedidata User last Name>" ("<iMedidata Username>", "<iMedidata User Email>") iMedidata account, please enter your Rave Password.                  | 
    | Label       | Rave Account                                    | 
    | Text        | "<Rave username>"                               | 
    | Label       | Password                                        | 
    | Button      | Link Account                                    | 
    | Button      | Create a New Account                            |
	| Link        | Choose a different account                      |

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Name is "<iMedidata User First Name 1>" "<iMedidata User Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study "<Study A>"
    And there is a Rave Study "<Study A>"
    And the iMedidata Study "<Study A>" is linked to the Rave Study "<Study A>"
	And I have an assignment to the iMedidata Study "<Study A>" for the App link "<EDC App>" with Role "<EDC Role 1>" for app "<Modules App>" with Role "<Modules Role 1>"
	When I click on app link "<EDC App>" for Study "<Study A>"
    Then I am on the Rave Connection page
    And I should see a message 'To permanently link your Rave account with your "<iMedidatat User First Name 1>" "iMedidata User Last Name 1>"(<iMedidata User 1 id>, <iMedidata User 1 Email>) iMedidata account, please enter your Rave Password'.
	And I should see text "Connect your Rave account to iMedidata"
	And I should see label "Rave Account"
	And I should see label "Password"
	And I should see button "Link Account"
	And I should see link "Choose a Different Account"
	And I should see button "Create a New Account"
	And I should see "To link your iMedidata account with a new account on this URL, click 'Create a New Account' button"
	And I should see Rave user Name "<Rave user Name 1>"
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.8.28-103
@Validation
Scenario: When a user views the Rave Connection page, they will see the iMedidata First and Last Name displayed with the iMedidata
           Username in parenthesis.

	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user with User Name "<iMedidata User 1 id>
	And the Rave user is not connected to iMedidata
	And there is an iMedidata Study  "<Study A>"
	And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<EDC App>" with Role "<EDC Role 1>" 
	When I click on app link "<EDC App>" for Study "<Study A>"
    Then I am on the Rave Connection page
	And I should see label "Rave Account"
	And I should see text "Connect your Rave account to iMedidata"
	And I should see "To permanently link your Rave account with your "<First Name 1>" "<Last Name 1>"(<iMedidata User 1 id>, <iMedidata User 1 Email>)" iMedidata account, please enter your Rave user Name and Password.
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.8.28-104
@Validation
Scenario: When a user views the Rave Connection page, they will see text prompting them to link their account if they have only
           one non-transitioned Rave account with a matching email address . "To permanently link your Rave account with your  "<First Name >""<Last Name >" ("<iMedidata User id>", "<iMedidata User Email>") iMedidata account,
         please enter your Rave Password."

	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>" with Username "<Rave user Name 1>"
    And the Rave user  "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user  "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study A>"
	When I click on app link "<EDC App>" for Study  "<Study A>"
    Then I am on the Rave Connection page
	And I should see text "To permanently link your Rave account with your "<First Name 1>""<Last Name 1>" ("<iMedidata User 1 id>", "<iMedidata User 1 Email>") iMedidata account, please enter your Rave Password."
	And I take a screenshot
	
@Rave 564 Patch 13
@PB2.5.1.92-01
@Validation
Scenario: If an unconnected iMedidata user accesses the Rave Connection page and there are multiple existing unconnected Rave accounts with matching email or username
           then Rave will display the usernames associated with the accounts with matching email accounts in the User Name dropdown regardless of username and prompt
		   for the entry of the associated password of the selected username’s account.

    Given I am an iMedidata User
    And I am logged in 
    And my Name is "<First Name 5>" "<Last Name 5>"
	And my username is "<iMedidata User 5 id>"
    And my Email is "<iMedidata User 5 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 5>"
    And the Rave user  "<Rave user 5>" has a Username "<Rave user Name 5>"
    And the Rave user  "<Rave user 5>" has an Email of "<iMedidata User 5 Email>"
    And the Rave user  "<Rave user 5>" has a User Group of "<Modules Role 5>"
    And the Rave user  "<Rave user 5>" has a Password "<Rave Password 5>"
	And there is a Rave user "<Rave user 6>"
    And the Rave user  "<Rave user 6>" has a Username "<Rave user Name 6>"
    And the Rave user  "<Rave user 6>" has an Email of "<iMedidata User 5 Email>"
    And the Rave user  "<Rave user 6>" has a User Group of "<Modules Role 6>"
    And the Rave user  "<Rave user 6>" has a Password "<Rave Password 6>"
	And there is an iMedidata Study  "<Study A>"
    And there is a Rave Study  "<Study A>"
	And I have an assignment to Rave Study "<Study A>" for App "<EDC App> with Role "<Edc Role 1>" for app <Modules App> with Role "<Modules Role 1>"
	And I click on app link "<EDC App>" next to the Study  "<Study A>"
    And I am on the Rave Connection page
	And I should see User Name dropdown
	And I should see "<Rave user Name 5>", "<Rave user Name 6>" usernames associated with the accounts in the dropdown
	And I take a screenshot	
	When I select user "<Rave user Name 5>" from User Name dropdown
	And I enter associated password of the selected username’s account
	Then I select Link Account
	And I am on Rave Study "<Study A>" page
	And I navigate to User Adminstration
	And I search for User "<iMedidata User 5 id>" Authenticator "iMedidata"
	And I navigate to User Details page for User "<iMedidata User 5 id>" Authenticator "iMedidata"
	And I see Authenticator "iMedidata"
	And I see Login "<iMedidata User 5 id>"
	And I take a screenshot	


@Rave 564 Patch 13
@PB2.5.1.94-01
@Validation
Scenario: If on the Rave Connection page the unconnected iMedidata user enters an incorrect Rave Password for the selected account,
           when the user clicks the “Link Account” button on Rave Connection page, then Rave will display a message “Incorrect Username and/or Password”.
 
	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user  "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user  "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user  "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study A>"
    And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<EDC App>" with Role "<EDC Role 1>"
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" for Study  "<Study A>"
    And I am on the Rave Connection page
	When I fill in "Password" with "<Rave Password 1>2"
    And I click on "Link Account"
    Then I should see "Incorrect Username and/or Password"
    And I take a screenshot
	And I should be on the Rave Connection page 
	And I should not be on Rave Study "<Study A>" home page
	And I enter "<Rave Password 1>"
	And I follow "Link Account"
	And I should be on Rave Study "<Study A>" home page
	And I should not see "Incorrect Username and/or password" message
	And I take a screenshot
	

  
@Rave 564 Patch 13
@PB2.5.1.95-01
@Validation
Scenario: If on the Rave Connection page the externally unconnected iMedidata user submits Password incorrectly more
          times than the number specified in the configuration module of Rave, then Rave will display message “User is Locked Out” 
		  and the Rave user account will be locked.

	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user  "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user  "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user  "<Rave user 1>" has a Password "<Rave Password 1>"
	And the "Number of Failed User Login Attempts" is set to "3" in Configuration Module Other Settings page in Rave
	And there is an iMedidata Study  "<Study A>"
    And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<EDC App>" with Role "<EDC Role 1>" for app "<Modules App>" with Role "<Modules Role 1>"
	And I am on the iMedidata Home page
	And I click on app link "<EDC App>" for Study  "<Study A>"
    And I am on the Rave Connection page
	And I fill in "Password" with "<Rave Password 1>23"
    And I click on "Link Account"
    And I should see "Incorrect Username and/or Password"
    And I should be on the Rave Connection page 
	And I take a screenshot
	And I fill in "Password" with "<Rave Password 1>23"
    And I click on "Link Account"
    And I should see "Incorrect Username and/or Password"
    And I should be on the Rave Connection page 
	And I take a screenshot
	And I fill in "Password" with "<Rave Password 1>23"
    When I click on "Link Account"
    Then I should see "User is Locked Out" message
	And I take a screenshot
    And I should be on the Rave Connection page
	And I log in to Rave as Rave user "<Rave user Name 2>"
	And user "<Rave user Name 2>" has access to User Adminstration in Rave
	And I navigate to User Details page for User "<Rave user Name 1 >" in Rave
	And I should see Locked out checked
	And I should see Authenticator "Internal"
	And I take a screenshot	
	
	

@Rave 564 Patch 13
@PB2.5.1.96-01
@Validation
Scenario: If an unconnected iMedidata user accesses the Rave Connection page and clicks on ‘Choose a Different Account’,
          then Rave will take the user to the Choose Different Account page.

   	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is a Rave user "<Rave user 2>"
	And the Rave user "<Rave user 2>" has a Username "<Rave user Name 2>"
    And the Rave user "<Rave user 2>" has an Email of "<iMedidata User 2 Email>"
    And the Rave user "<Rave user 2>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study A>"
    And I have an assignment to the iMedidata Study "<Study A>" for the App  "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" for Study "<Study A>"
    And I am on the Rave Connection Page
	And I should see "To permanently link your Rave account with your "First Name last Name (Userid, Email) iMedidata account, please enter your Rave Password"
	And I should see Rave Account "<Rave user Name 1>"
	When I click on "Choose a Different Account" link
	Then I should see "To permanently connect your Rave account with your "First Name last Name (Userid, Email) iMedidata account, please enter your Rave username and Password"
	And I should see Rave Account ""
	And I should see Password " "
	And I take a screenshot
	And I enter Rave Account "<Rave user Name 2>"
	And I enter Password "<Rave Password 1>"
	And I Select "Link to Existing Account"
    And I am on Rave Study "<Study A>" home page
	And I navigate to User Adminstration
	And I navigate to User Details page for "<Rave user Name 1>"
	And I should see Authenticator "Internal"
	And I take a screenshot
	And I search for User "<Rave user Name 2>" Authenticator "internal"
	And I should see no search Results
	And I search for User "<iMedidata User 1 id>" Authenticator "iMedidata"
	And I navigate to User Details page for "<iMedidata User 1 id>"
	And I should see login "<iMedidata User 1 id>"
    And I take a screenshot	
  
@Rave 564 Patch 13
@PB2.7.5.28-02 
@Validation
Scenario: When a user views the Choose Different Account page, they will see attributes and text that shows the possible selections. 

Examples:
    | Field       | Text                                            | 
    | Page Title  | Connect your Rave account to iMedidata          | 
    | Text        | To permanently connect your Rave account with your "<iMedidata First Name>""<iMedidata Last Name>" ("<iMedidata UserName>","<iMedidata Email">) iMedidata account, please enter your Rave username and Password.|
    | Label       | Rave Account                                    | 
    | Label       | Password                                        | 
    | Button      | Link to Existing Account                        | 
    | Button      | Create a New Account                            |

	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user  "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user  "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user  "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study A>"
    And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<EDC App>" with Role "<EDC Role 1>"
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" for Study  "<Study A>"
    And I am on the Rave Connection Page
	When I click on "Choose a Different Account"
	Then I should be on the Choose Different Account page
	And I should see text "To permanently connect your Rave account with your "<iMedidata First Name 1>" "<iMedidata Last Name 1>"(<iMedidata User 1 id>, <iMedidata User 1 Email>) iMedidata account, please enter your Rave username and Password."
    And I should see "Rave Account" label
	And I should see "Rave Account" editable text field
	And I should see "Password" label
	And I should see "Password" editable text field
	And I should see "Link to an Existing Account"
	And I should see "To link your iMedidata account with a new account on this URL, click 'Create a New Account' button."
	And I should see "Create a New Account"
   	And I take a screenshot	

@Rave 564 Patch 13
@PB2.5.1.98-01
@Validation
Scenario: If the unconnected iMedidata user enters correct Rave user Name and Password, when the user clicks “Link to Existing Account”
 button on the Choose Different Account page, then the user’s Authenticator for the current Rave URL is set to “iMedidata” on the My Profile page.


   	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user "<Rave user 1>" has an Email of "<Rave user 1 Email>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study A>"
    And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" for Study  "<Study A>"
    And I am on the Rave Connection Page
	And I click on "Choose a Different Account"
	And I am on the Choose Different Account page
	And I fill in "Rave Account" with "<Rave user Name 1>"
    And I fill in "Password" with "<Rave Password 1>"
	And I take a screenshot
    And I click on "Link to an Existing Account"
    And I should be in Rave Study "<Study A>" home page
 	And I should see my name is "<First Name 1>" "<Last Name 1>"
 	And I take a screenshot	
	And I follow "My Profile"
	When I am on "My Profile" page
	Then I should see  "Authenticator" is set to "iMedidata"
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.1.99-01
@Validation
Scenario: If the unconnected iMedidata user enters incorrect Rave user Name or Password and clicks “Link to Existing Account”
 button on the Choose Different Account page, then Rave will display a message “Incorrect Username and/or Password”.

 	
	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user "<Rave user 1>" has an Email of "<Rave user 1 Email>"
    And the Rave user "<Rave user 1>" has a User Group of "<Modules Role 1>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study A>"
    And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" for Study "<Study A>"
    And I am on the Rave Connection Page
	And I click on "Choose a Different Account"
	And I should be on Choose a Different account page
	And I fill in "Rave Account" with "<Rave user Name 1>"
    And I fill in "Password" with "<Rave Password 1>xx"
    When I click on "Link to an Existing Account"
    Then I should see "Incorrect Username and/or Password"
    And I take a screenshot 
	And I should be on the Choose Different Account page
	And I fill in "Password" with "<Rave Password 1>"
	And I click on "Link to an Existing Account"
	And I Should see "Incorrect Username and/or Password"
	And I should not be on Rave Study "<Study A>" home page
	And I fill in "Password" with "<Rave Password 1>"
	And I click on "Link to Existing Account"
	And I should be on Rave Study "<Study A>" home page
    And I take a screenshot 

@Rave 564 Patch 13
@PB2.5.1.99-02
@Validation
Scenario: If the unconnected iMedidata user enters correct credentials of an already connected iMedidata user on the Choose Different Account page, then Rave will display a message “This Account is already linked please enter ............”.

 	
	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user "<Rave user 1>" has an Email of "<iMedidata user 1 Email>"
    And the Rave user "<Rave user 1>" has a User Group of "<Modules Role 1>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And there exists a Rave user with User Name "<Rave user 2>" Password "<Rave Password 2>" that is connected to iMedidata
	And there exists a iMedidata User with User Name "<iMedidata User 2 id>" Password "<iMedidata User 2 Password>" that is connected to Rave
	And there is an iMedidata Study  "<Study A>"
    And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" for Study "<Study A>"
    And I am on the Rave Connection Page
	And I click on "Choose a Different Account"
	And I should be on Choose a Different account page
	And I fill in "Rave Account" with "<Rave user Name 2>"
    And I fill in "Password" with "<Rave Password 2>"
    When I click on "Link to an Existing Account"
    Then I should see "This user account is already linked to iMedidata. Please enter another User Name or click 'Create a New Account' button."
    And I take a screenshot 
	And I should be on the Choose Different Account page
	And I fill in "Rave Account" with "<iMedidata User 2 id>"
    And I fill in "Password" with "<iMedidata User 2 Password>"
    And I click on "Link to an Existing Account"
	And I should see "This user account is already linked to iMedidata. Please enter another User Name or click 'Create a New Account' button."
    And I take a screenshot 


@Rave 564 Patch 13
@PB2.5.1.100-01
@Validation
Scenario: When on the Choose Different Account page, if the unconnected iMedidata user submits Password incorrectly more times than the
                  number specified in the configuration module of Rave, then Rave will display message “User is Locked Out” and the
				  Rave user account will be locked.

	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user "<Rave user 1>" has an Email of "<Rave user 1 Email>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study A>"
	And the "Number of Failed User Login Attempts" is set  to"3" in Other Settings section of the "Configuration" module 
    And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" for Study  "<Study A>"
    And I am on the Rave Connection Page
	And I click on "Choose a Different Account"
	And I am on the Choose Different Account page
	And I fill in "Rave Account" with "<Rave user Name 1>"
    And I fill in "Password" with "<Rave Password 1>xx"
    And I click on "Link to an Existing Account"
    And I should see "Incorrect Username and/or Password"
    And I should be on the Choose Different Account page 
    And I fill in "Password" with "<Rave Password 1>"
    And I click on "Link to an Existing Account"
    And I should see "Incorrect Username and/or Password"
    And I fill in "Password" with "<Rave Password 1>xx"
    When I click on "Link to an Existing Account"
    Then I should see "User is Locked Out"
    And I should be on the Choose Different Account page 
	And I take a screenshot	
	And I Login to Rave as User "<Rave user Name 2>" with access to User Adminstration
	And I navigate to User Adminstration
	And I search for Rave user "<Rave user Name 1>" 
	And I navigate to User Details page for "<Rave user Name 1>"
	And I see "Locked Out" Checked
	And I take a screenshot	
	
@Rave 564 Patch 13
@PB2.5.1.102-01
@Validation
Scenario: If the iMedidata user clicks on “Create a New Account” button on Rave Connection page, then the system will take the user to relevant home page, study page with the relevant role, using the
		  iMedidata-created account.
    
	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata account is not connected to Rave
	And there is a Rave user "<Rave user name 1>"
	And the Rave user "<Rave user Name 1>" Email "<iMedidata User 1 Email>"
	And the Rave user "<Rave user Name 1>" is not connected to Rave
	And there is an iMedidata Study  "<Study A>"
    And there is a Rave Study  "<Study A>"
    And the iMedidata Study  "<Study A>" is linked to the Rave Study "<Study A>"
    And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study "<Study A>" for the App link  "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" for study "<Study A>"
    And I am on the Rave Connection Page 
	And I should see Rave Account "<Rave user Name 1>"
    When I click on button "Create a New Account"
    Then I should be on the Rave Study page for the Study "<Study A>"
    And I take a screenshot
	And I should see my name is "<First Name 1>" "<Last Name 1>"
	And I navigate to My Profile page for User "<iMedidata User 1 id>"
	And I should see Authenticator is "iMedidata"
	And I take a screenshot	
	And I navigate to User Adminstration
	And I navigate to "<Rave user Name 1>"
	And I should see Authenticator "Internal"
	And I take a screenshot

	
@Rave 564 Patch 13
@PB2.5.1.74-01
@Validation
Scenario: When merging iMedidata created and non-transitioned accounts, If the iMedidata user has one or more EDC Roles in a specific study, all Rave study assignments and studysite assignments of that internal user account will not be copied to each newly created external user role in Rave. 

#Background 2

	Given I in iMedidata
	And I should not see "<Study C>" in Studies home page in iMedidata
	And I navigate to Rave by following "<EDC App>" for "<Study A>"
	When I navigate to User Details page for "<iMedidata User 1 ID>" for <Role 2>
    Then I should not see "<Study C>" under Studies Pane
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.74-02
@Validation
@BUG
Scenario: When merging iMedidata created and non-transitioned accounts, if a user has more than one EDC Role in a specific study, all Rave report assignments of that internal user account should be copied to each newly created external user role in Rave.  The handling of account data should be fully transparent to the user.	 

# Background 2
    
	Given I am on Rave Study page "<Study A>" for User "<iMedidata User 1 id>"
	And I navigate to "Report Adminstration"
	And I navigate to "Report Assignment"
	When I select <Report>
	Then I verify that user "<iMedidata User 1 id>" is assigned to <Report>
	And I take a screenshot
	

@Rave 564 Patch 13
@PB2.5.1.74-03
@Validation
@BUG
Scenario: When merging iMedidata created and non-transitioned accounts, if a user has more than one EDC Role in a specific study,  security role rights, and deny access rights of that internal user account should be copied to each newly created external user role in Rave except for Security Group rights.  The handling of account data should be fully transparent to the user.

	
	# Background 2
    
	Given I am on Rave Study page "<Study A>" for User "<iMedidata User 1 id>"
	When I navigate to user details page for user "<iMedidata User 1 id>" with role "Role1"
	Then I verify the Other Modules as follows:
	|Module|Project|Role|Security Group|Deny Access|
	|Architect Project|Study A|Architect Role 1|||
	|Architect Global Library|Global Library 1|Global Library role 1|||
	|Batch Upload Configuration|Study A|Batch upload Role1|||
	|SafetyGatewayMapping|Study A|Mapping Role1|||
	|SafetyGatewayManagement|Study A|Management Role1|||
	And I take a Screenshot
	And I navigate to user details page for user "<iMedidata User 1 id>" with role "Role2"
	And I verify the Other Modules as follows:
	|Module|Project|Role|Security Group|Deny Access|
	|Architect Project|Study A|Architect Role 1|||
	|Architect Global Library|Global Library 1|Global Library role 1|||
	|Batch Upload Configuration|Study A|Batch upload Role1|||
	|SafetyGatewayMapping|Study A|Mapping Role1|||
	|SafetyGatewayManagement|Study A|Management Role1|||
	And I take a Screenshot
	

@Rave 564 Patch 13
@PB2.5.1.74-04
@Validation
@BUG
Scenario: When merging iMedidata created and non-transitioned accounts, if a user has more than one EDC Role in a specific study, all Rave user attributes of that internal user account should be copied to each newly created external user role in Rave. The handling of account data should be fully transparent to the user.

	# Background 2
    
	Given I am on Rave Study page "<Study A>" for User "<iMedidata User 1 id>"
	When I navigate to user details page for user "<iMedidata User 1 id>" with role "Role1"
	Then I verify <Credential>,  Site Group, Investigator checkbox, Investigator Number, DEA Number, Network Mask
	And I take a screenshot
	And I navigate to user details page for user "<iMedidata User 1 id>" with role "Role2"
	And I verify <Credential>,  Site Group, Investigator checkbox, Investigator Number, DEA Number, Network Mask
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.74-05
@Validation
@BUG
Scenario: When merging iMedidata created and non-transitioned accounts, if a user has more than one EDC Role in a specific study, all Rave eLearning of that internal user account should be copied to each newly created external user role in Rave.  The handling of account data should be fully transparent to the user.

 	# Background 2
    
	Given I am on Rave Study page "<Study A>" for User "<iMedidata User 1 id>"
	When I navigate to user details page for user "<iMedidata User 1 id>" with role 1
	Then I verify elearning assignment is not displayed
	And I take a screenshot
	And I navigate to user details page for user "<iMedidata User 1 id>" with role 2
	And I verify elearning assignment is displayed
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.74-06(A)
@Validation
@BUG
Scenario: When merging iMedidata created and non-transitioned accounts, if a user has more than one EDC Role in a specific study, BOXI assignments of that internal user account should be copied to each newly created external user role in Rave.  The handling of account data should be fully transparent to the user.

	# Background 2
    
	Given I am on Rave Study page "<Study A>" for User "<iMedidata User 1 id>"
	And I navigate to "Report Admin"
	And I navigate to "Report Assignment"
	When I select <Boxi>
	Then I verify that user "<iMedidata User 1 id>" is assigned to <Boxi>
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.74-06(B)
@Validation
@BUG
Scenario: When merging iMedidata created and non-transitioned accounts, if a user has more than one EDC Role in a specific study, J-Review assignments of that internal user account should be copied to each newly created external user role in Rave.  The handling of account data should be fully transparent to the user.

	# Background 2
    
	Given I am on Rave Study page "<Study A>" for User "<iMedidata User 1 id>"
	And I navigate to "Report Admin"
	And I navigate to "Report Assignment"
	When I select <J-Review>
	Then I verify that user "<iMedidata User 1 id>" is assigned to <J-Review>
	And I take a screenshot
	

@FUTURE
@PB2.5.1.74-06(C)
@DRAFT
@BUG
Scenario: When merging iMedidata created and non-transitioned accounts, if a user has more than one EDC Role in a specific study, DDE assignments of that internal user account should be copied to each newly created external user role in Rave.  The handling of account data should be fully transparent to the user.

@Rave 564 Patch 13
@PB2.5.1.74-07
@Validation
@BUG
Scenario: When merging iMedidata created and non-transitioned accounts, if a user has more than one EDC Role in a specific study, all training of that internal user account should be copied to each newly created external user role in Rave.  The handling of account data should be fully transparent to the user.
	
	# Background 2
    
	Given I am on Rave Study page "<Study A>" for User "<iMedidata User 1 id>"
	When I navigate to user details page for user "<iMedidata User 1 id>" with role "Role1"
	Then I verify <Training Date> and <Training Signed> 
	And I take a screenshot
	And I navigate to user details page for user "<iMedidata User 1 id>" with role "Role2"
	And I verify <Training Date> and <Training Signed>
    And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.74-02(B)
@Validation
@BUG
Scenario: When merging iMedidata created and non-transitioned accounts, all Rave user Saved Report assignments of that internal user account should be
         copied to newly created external user role in Rave.  The handling of account data should be fully transparent to the user.	 

    Given I am  a Rave user with User name "<iMedidata User 1 id>"
	And I am logged in 
	And I have assigned "<USReport>" with "<Study A>" in "My Reports" page
	And "<Study A>" doesnt exists in iMedidata
	And "<Study A>" is not a linked study
	And I navigate to the "<USReport>"
	And I verify that "<Study A>" is assigned to the report
	And I click Submit Report
	And I should see "<USReport>" is generated
	And I take a screenshot
	And a new study "<Study A>" is created in iMedidata
	And I have a invitation to join study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>" for App "<Modules App>" with Role "<modules Role 1>"
	And I activate my account in iMedidata
	And I am logged in to iMedidata as "<iMedidata User 1 id>"
	And I accept the Invitation to Study "<Study A>"
	And I follow "<EDC App>" for Study "<Study A>" 
	When I navigate to "Reporter" Module
	And I am on "My Reports" page
	Then I verify that  "<USReport>" is listed in My Reports page
	And I take a screenshot
	And I follow the "<USReport>" link
	And I should see "<Study A>" assigned to the "<USReport>"
	And I enter required Report Parameters
	And I select "Submit Report" button
	And I should see the "<USReport>" report is opened
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.74-02(C)
@Validation
@BUG
Scenario: When merging iMedidata created and non-transitioned accounts, all Rave user Saved Report assignments of that internal user account
 should be copied to newly created external user role in Rave. The Study assigned to the User Saved Report in Rave
  will not be copied over if the study is not a linked study, when user is transitioned to iMedidata. 	 

    
	Given I am  a Rave user with User name "<iMedidata User 1 id>"
	And I have assigned "<USReport>" with "<Study B>"
	And "<Study B>" doesnt exists in iMedidata
	And "<Study B>" is not a linked study
	And I have a invitation to join study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>" for App "<Modules App>" with Role "<modules Role 1>"
	And I activate my account in iMedidata
	And I am logged in to iMedidata as "<iMedidata User 1 id>"
	And I accept the Invitation to Study "<Study A>"
	And I follow "<EDC App>" for Study "<Study A>"
	And I am on Rave Connection page
	And I enter Password "<Password>"
	And I click on Link Account
	And I am on Rave "<Study A>" page
	When I navigate to Reporter
	Then I should see "<USReport>" assigned to the User
	And I take a screenshot
	And I follow "<USReport>"
	And I should not see "<Study B>" assigned to the "<USReport>"
	And I take a screenshot
	
	
@Rave 564 Patch 13
@PB2.5.1.74-02(D)
@Validation
Scenario: If the user is an Transitioned user, and Training is not checked for the User in Rave, When the User is transitioned to a iMedidata User with multiple roles , training should be checked automatically with trained date, preventing Rave from blocking
           that user from accessing a study in EDC.	


	Given I am an existing Rave user "<Rave user Name 1>" with Email "<iMedidata User 1 Email>"
    And my Training is not Checked
    And there is iMedidata User "<iMedidata User 1 id>"
	And I am logged in to iMedidata as iMedidata User "<iMedidata User 1 id>" with Email "<iMedidata User 1 Email>"
	And I have an assignment to "<Study A>" for app "<EDC App>" with Role "<EDC Role 1>" "<EDC Role 2>" for app "<Modules App>" with Role "<Modules Role 2>" for App "<Security Group>" with Role "<Security Group 2>" 
	And I am not connected to Rave
    And I click on Modules App "<Modules App>" next to the Study  "<Study A>"
	And I am on the Rave Connection Page 
	And I enter Rave user password into the "Password" text field
	And I follow "Link Account"
    And I am on the Rave Study "<Study A>" Home page
    And I navigate to the User Administration Module
	When I navigate to the User Details page for "<iMedidata User 1 id>" user for "<EDC Role 1>"
	Then I should see user Training is checked 
	And I take a screenshot
	And I navigate to the User Details page for "<iMedidata User 1 id>" user for "<EDC Role 2>"
	And I should see user Training is checked 
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.1.76-77
@Validation
Scenario: If an already connected iMedidata user accesses the Rave URL for the first time with a single Rave Modules role (User Group) and then gets an invitation to Rave EDC App, the iMedidata user will be taken directly to the Rave Study page.

    Given I am an iMedidata User "<iMedidata User 1 id>"
    And there is an iMedidata Study "<Study A>" in Study Group "<Study Group>"
    And there is a Rave Study "<Study A>"
    And the iMedidata Study "<Study A> is linked to the Rave Study "<Study A>"
    And I have an assignment to only iMedidata Study "<Study A>" for the App "<Modules App>" Role "<Modules Role 1>"
	When I click the App  "<Modules App>" associated with study "<Study A>"
    Then I should be on Rave Home page
	And I take a screen shot
	And I see All Modules listed on the left hand side
	And I follow iMedidata Link
	And I am on iMedidata Home page	
	And I am invited to Rave EDC App  "<EDC App>" the Role "<EDC Role 1>" for study "<Study A>"
	And I select App named "<EDC App>" associated with study "<Study A>"
	And I am on Study "<Study A>" Home page 
	And I navigate to Rave Home page
    And I select link "User Administration"
	And I enter in text box "Log In " with User id "<iMedidata User 1 id>"
	And I select "iMedidata" from the dropdown "Authenticator" 
	And I select link "Search"
	And I should see only one row in the search results table
	And I should see column Log In "<iMedidata User 1 id>"
	And I should see column User Group "<Modules Role 1>"
	And I navigate to user details page
	And I should see "<Study A>" listed in the Studies Pane		
	And I should see User Group Role "<Modules Role 1>"
	And I should see "<EDC Role 1>" listed
	And I take a screenshot 


@Rave 564 Patch 13
@PB2.5.1.76-03
@Validation
Scenario: When merging iMedidata created and non-transitioned accounts, the iMedidata account information will take precedence over the Rave account details.

    Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to RavePass-KS
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study B>"
    And I have an assignment to the iMedidata Study "<Study B>" for the App link  "<EDC App>" with one Role "<EDC Role 1>" for App "<Modules App>" with Role "<Modules Role 1>"
    And I am on the iMedidata Home page
	And I follow link "Account Details"
	And I note Username "iMedidata User 1 id"
	And I note Email "iMedidata User 1 Email"
	And I note First Name "iMedidata User 1 SQA"
	And I note Last Name "iMedidata User 1 SQA
	And I fill in Middle name with " "
	And I fill in Title with "SQA TESTER"
	And I fill in Department with "Department 1"
	And I fill in Address Line 1 with "79 Fifth Avenue"
	And I fill in Address Line 2 with "iMedidata"
	And I fill in Address Line 3 with "Blank"
	And I fill in City with "New York"
	And I fill in Postal Code with "Blank"
	And I fill in State with "New York"
	And I fill in Country with "United States of America"
	And I fill in Time Zone with "Alaska"
	And I fill in Locale with "English"
	And I fill in Phone with "444"
	And I fill in Mobile Phone with "333"
	And I fill in Fax "with "222"
	And I fill in Pager with "111"
	And I take a screenshot 
	And I click Save button on "Account Details" page
    And I log out 
	And I log in to Rave as Rave user "<Rave user Name 2>"
	And "<Rave user Name 2>" has access to User Adminstration
	And I navigate to "User Administration" in Rave
	And I search for Rave user with Username "<Rave user Name 1>"
	And I navigate to the User Details page
	And I note Email "iMedidata User 1 Email"
	And I note First Name "<Rave user Name 1>"
	And I note Last Name "<Rave user Name 1>"
	And I fill in Title with "Rave SQA TESTER"
	And I fill in Department with "Rave Department 1"
	And I fill in Address Line 1 with "Rave 79 Fifth Avenue"
	And I fill in Address Line 2 with "Rave"
	And I fill in Address Line 3 with "Rave"
	And I fill in City with "Rave"
	And I fill in Postal Code with "Rave"
	And I fill in State with "Rave"
	And I fill in Country with "Rave"
	And I fill in Time Zone with "Rave"
	And I fill in Locale with "English"
	And I fill in Phone with "545"
	And I fill in Mobile Phone with "234"
	And I fill in Fax "with "678"
	And I fill in Pager with "2234"
	And I follow Update
	And I take a screenshot 
	And I log out
	And I log in to iMedidata as "<iMedidata User 1 id>"
	And I am on the iMedidata Home page
	And I click on app link "<EDC App>" next to the Study  "<Study B>"
	And I am on the Rave Connection Page 
	And I enter Rave user password into the "Password" text field
	And I select "Link Account" button
    And I am on the Rave Study page for the Study  "<Study B>"
	And I follow the the link "User Administration"
	And I search for "<iMedidata User 1 id>" Autheneticator "iMedidata"
	When I navigate to the User details page for the iMedidata User "<iMedidata User 1 id>"
	And I should see Login "<iMedidata User 1 id>"
	Then I should see text First Name as "iMedidata User 1 SQA"
	And I should see text  Middle Name " "
	And I should see text Last Name "iMedidata User 1 SQA"
	And I should see Title with "SQA TESTER"
	And I should see Department with "Department 1"
	And I should see Address Line 1 with "79 Fifth Avenue"
	And I should see Address Line 2 with "iMedidata"
	And I should see Address Line 3 with "Blank"
	And I should see City with "New York"
	And I should see Postal Code with "Blank"
	And I should see State with "New York"
	And I should see Country with "USA"
	And I should see Time Zone with "Alaska"
	And I should see Locale with "English"
	And I should see Telephone with "444"
	And I should see Mobile Phone with "333"
	And I should see Facsimile "with "222"
	And I should see Pager with "111"
	And I should see Authenticator "iMedidata"
	And I take a screenshot 

 @Rave 564 Patch 13   
 @PB2.5.1.76-04  
 @Validation
Scenario: When merging iMedidata created (first time with a single EDC role) and untransitioned Rave account,
          the user-selected non-transitioned accounts will be deactivated after the merge.

	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user  "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user  "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user  "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study B>"
    And there is a Rave Study  "<Study B>"
    And the iMedidata Study  "<Study B>" is linked to the Rave Study "<Study B>"
    And I have an assignment to the iMedidata Study "<Study B>" for the App link  "<EDC App>" with one Role "<EDC Role 1>"
	And I have assignment to iMedidata Study "<Study B>" for App link  "<Modules App>" with role "<Modules Role 1>"
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" for Study "<Study B>"
	And I am on the Rave Connection Page 
	And I see Rave Account "<Rave user Name 1>"
	And I enter Rave user password into the "Password" text field
	And I select "Link Account" button
    And I am on the Rave Study page for the Study  "<Study B>"
	And I navigate to "User Administration"
	And I search the Rave user  "<Rave user name 1>"
	And Authenticator set to "Internal"
	And I should see no Results
	And I take a screenshot
	And I search for User "<iMedidata User 1 id>" Authenticator "iMedidata" with "Include Inactive Records" checked
	When I navigate to the User details page for the User "<iMedidata User 1 id>"
	Then I see the "Active" check box is unchecked
	And I should see Login "<Rave user Name 1>"
    And I see the User Details section shows grayed out fields
	And I should see iMedidata User Name "<iMedidata User 1 id>"
	And I should see Authenticator "iMedidata"
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.1.76-06
@Validation
Scenario: When merging iMedidata created and non-transitioned accounts, if there are conflicting study assignments between
         the iMedidata-created account and the Rave account, the iMedidata account study assignments will take precendence,
		  overriding the non-transitioned account information.

    Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And the Rave user "<Rave user 1>" is assigned to Study "<Study A>" in Rave with Role "<EDC role 1>" 
	And there is an iMedidata Study  "<Study B>"
    And there is a Rave Study  "<Study B>"
    And the iMedidata Study  "<Study B>" is linked to the Rave Study "<Study B>"
	And I have an assignment to the iMedidata Study "<Study B>" for the App "<EDC App>" with one Role "<EDC Role 1>" Modules App "<Modules App>" for Role "<Modules Role1>"
	And Rave user "<Rave user 1>" an assigment to iMedidata Study "<Study B>" with Role "<EDC Role 2>" in Rave as Internal user
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" next to the Study  "<Study B>"
	And I am on the Rave Connection Page 
	And I enter Rave user password into the "Password" text field
	And I select "Link Account" button
    And I am on the Rave Study page for the Study  "<Study B>"
    And I navigate to the User Administration Module
	When I navigate to the User Details page for the selected  "<iMedidata User 1 Email>" user
	Then I should see "<Study B>" with Role "<EDC Role 1>" in Studies Pane
	And I should not see Study "<Study A>" 
	And I should not see "<Study B>" with Role "<EDC Role 2>"
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.1.76-07
@Validation
Scenario: When merging iMedidata created and non-transitioned accounts, if there are conflicting study-site assignments between
 the iMedidata-created account and the Rave account, the iMedidata account study-site assignments will take precendence, provided the Role assigned to the user does not have "ViewAllSiteinSiteGroup"action assigned.

    Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study "<Study B>"
	And there is an iMedidata Site  "<Site B>" assigned to Study "<Study B>"
    And there is a Rave Study "<Study B>"
	And there is a Rave Site  "<Site A>" assigned to Study "<Study B>"
	And there is a Rave Study "<Study C>" which is not connected to iMedidata
	Adn there is a Rave Site "<Site C>" assigned to Rave Study "<study C>"
	And Rave user "<Rave user Name 1>" has a Rave assignment to Study "<Study C>" with Site "<site C>"
	And the iMedidata Study "<Study B>" is linked to the Rave Study "<Study B>"
	And I have an assignment to the iMedidata Study "<Study B>" and Site  "<Site B>" for the App link  "<EDC App>" with "<EDC Role 1>" Modules App "<Modules App>" with Role "<Modules Role 1>"
	And Rave user "<Rave user Name 1>" has a Rave assigment to Study "<Study B>" Site  "<Site A>" with "<EDC Role 1>"
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" next to the Study  "<Study B>"
	And I am on the Rave Connection Page 
	And I enter Rave user password into the "Password" text field
	And I select "Link Account" button
    And I am on the Rave Site "<Site B>" home page for Study "<Study B>"
	And I should not see Rave Site "<Site A>" for Study "<Study B>"
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.1.76-11
@Validation
Scenario: When merging iMedidata created and non-transitioned accounts, if there are conflicting study-site assignments between
the iMedidata-created account and the Rave account, the iMedidata account study-site assignments will take precendence, but when ViewAllSitesinSiteGroup action is assigned to the Role assigned to the user, user will be able to all sites for the study regardless of what is assigned to the user in iMedidata.


    Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not connected to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user "<Rave user 1>" has a Password "<Rave Password 1>"
	And EDC Role "<EDC Role 1>"And there is an iMedidata Study "<Study B>"
	And there is an iMedidata Site "<Site B>"
    And there is a Rave Study "<Study B>"
	And there is a Rave Site "<Site A>"
	And the iMedidata Study "<Study B>" is linked to the Rave Study "<Study B>"
	And I have an assignment to the iMedidata Study "<Study B>" and Site  "<Site B>" for the App link  "<EDC App>" with "<Edc Role RM Monitor>" Modules App "<Modules App>" Role "<Modules Role 1>"
	And Rave user "<Rave user Name 1>" has an  assigment to Study "<Study B>" and Site  "<Site A>" in Rave 
    And I am on the iMedidata Home page
	And I click on app link "<EDC App>" next to the Study  "<Study B>"
	And I am on the Rave Connection Page 
	And I enter Rave user password into the "Password" text field
	And I select "Link Account" button
    And I am in Rave
	And I should see Rave Site "<Site A>" Site "<Site B>" for Study "<Study B>"
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.1.76-08
@Validation
Scenario: When merging iMedidata created and non-transitioned accounts, if there are conflicting security role and group
           assignments between the iMedidata-created account and the Rave account, the iMedidata account security role and
		    group assignments will take precendence.
	

	Given I am an existing Rave user "<Rave user Name 1>"
	And my Email is "<iMedidata User 2 Email>"
	And there is a Rave Study named "<Study A>" 
	And there is an Rave Site named "<Site A>"
	And the Rave Site named "<Site A>" and Rave Study named "<Study A>" are assigned to the Rave user "<Rave user Name 1>" for Role "<EDC Role 1>"
    And the Rave user "<Rave user Name 1>" is assigned to Rave Security Group "<Security Group 1>"
	And the Rave user "<Rave user Name 1>" assigned Rave Security Role "Project Admin Default"
    And there is iMedidata User "<iMedidata User 1 id>"
	And I am logged in to iMedidata as iMedidata User "<iMedidata User 1 id>"
	And I am a Study Group owner
	And I created a new Study named "<Study A>"
	And I created a new Site named “<Site A>" for Study "<Study A>"
	And I have invited a new iMedidata user with Email "<iMedidata User 2 Email>" to the Study "<Study A>" as Study Owner for app "<EDC App>" with Role "<EDC Role 2>" for app "<Modules App>" with Role "<Modules Role 2>" for App "<Security Group>" with Role "<Security Group 2>" with Site "<Site A>"
	And new iMedidata user's username is "<iMedidata User 2 id>"
	And the "<iMedidatat User 2 id>" has activated account
	And I log out
	And I log in as iMedidata user "<iMedidata User 2 id>"
	And I accept the invitation to Study "<Study A>", Site "<Site A>"
    And I click on Modules App "<Modules App>" next to the Study  "<Study A>"
	And I am on the Rave Connection Page 
	And I enter Rave user password into the "Password" text field
	And I follow "Link Account"
    And I am on the Rave Study Site Home page
    And I access the Rave Home module
    And I navigate to the User Administration Module
	When I navigate to the User Details page for "<iMedidata User 2 id>" user
	Then I should see user is assigned to Rave Security Role "Project Admin Default"  Security Group <Security Group 2>
	And I should not see "<Security Group 1>" for the User in "Other Modules" pane
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.76-09
@Validation
Scenario:  When merging iMedidata created and non-transitioned accounts, if there are conflicting report assignments
          between the iMedidata-created account and the Rave account, the resultant account will contain
		   the outer join of all assignments.


	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 id>"
    And my Email is "<iMedidata User 1 Email>"
	And my iMedidata Account is not linked to Rave
	And there is a Rave user "<Rave user 1>"
    And the Rave user  "<Rave user 1>" has a Username "<Rave user Name 1>"
    And the Rave user  "<Rave user 1>" has an Email of "<iMedidata User 1 Email>"
    And the Rave user  "<Rave user 1>" has a User Group of "<Modules Role 1>"
    And the Rave user  "<Rave user 1>" has a Password "<Rave Password 1>"
	And there is an iMedidata Study  "<Study B>"
	And there is a Rave Study  "<Study B>"
	And the iMedidata Study  "<Study B>" is linked to the Rave Study "<Study B>"
	And I have an assigment to Study "<Study B>" for app "<EDC App>" Role "<Edc Role 1>" Modules App "<Modules App>" Role "<Modules Role 1>"
	And Rave user "<Rave user Name 1>" is assigned to Report "<A>" in Rave
	And I have an assignment to Report "<B>" in Rave
	And I am on the iMedidata Home page
	And I click on "<EDC App>" next to the Study  "<Study B>"
	And I am on the Rave Connection Page 
	And I enter "<Rave user 1>" password "<Rave Password 1>" in to the "Password" text field
	And I select "Link Account" button
    And I am on the Rave Study page for the Study "<Study B>"
    And I access the Rave Home page
    When I navigate to the Reporter Module
	Then I should see that I am assigned to Report "<A>" and Report "<B>" on My Reports page
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.76-12
@Validation
DT # 14191
Scenario: If an existing iMedidata user is invited to a new Study Group without studies, a duplicate user is not created in Rave when
             the user navigates to Rave from iMedidata.

	
	Given I am a Study Group Owner "<iMediata Administrator>"
	And I created a new Study named "<Study A>"
    And I have invited a new iMedidata user with Email "<iMedidata User 2 Email>" to the Study "<Study A>" for app "<EDC App>" with Role "<EDC Role 2>" 
	And the new iMedidata user's username is "<iMedidata User 2 ID>"
	And the "<iMedidatat User 2 ID>" has activated account
	And I log out
	And I log in as iMedidata user "<iMedidata User 2 ID>"
	And I accept the invitation to Study "<Study A>"
    And I click on EDC App "<EDC App>" next to the Study "<Study A>"
    And I am on the Rave "<Study A>" Home page
    And I access the Rave Home module
	And I select link "User Administration"
	And I search for user "<iMedidata User 2 ID>" with iMedidata as "Authenticator"	
	And I see one rows in the search results table
	And I should not see a duplicate user
	And I follow link iMedidata
	And I am on the iMedidata home page
	And I Logout
	And I login as Study Group Owner  "<iMediata Administrator>"
	And I create a new Study Group "<Study Group A>" with EDC App
	And I invite iMedidata user with Email "<iMedidata User 2 Email>" to the Study Group "<Study Group A>" for app "<EDC App>" with Role "<EDC Role 1>" 
	And the "<iMedidata User 2 Email>" accepts invitation
	And I click on EDC App "<EDC App>" next to the Study Group "<Study Group A>"
    And I am on the Rave Home page
	And I select link "User Administration"
	And I search for user "<iMedidata User 2 ID>" with iMedidata as "Authenticator"	
	And I see one rows in the search results table
	And I should not see a duplicate user
	And I take a screenshot
	And I follow link iMedidata
	And I am on the iMedidata home page
	And I Logout



@Rave 564 Patch 13
@PB2.5.1.76-13
@Validation
Scenario: When an internal user with assignments to Rave Internal Studies is transitioned to iMedidata with assignment to Studies that are now linked to the Internal Rave Studies the user is assigned to, the user should be assigned to the studies on Rave appropriately.
	
	
	Given I am an existing Rave user "<Rave user Name 1>"
	And my Email is "<iMedidata User 1 Email>"
	And there is a Rave Study named "<Study A>" 
	And there is a Rave Study named "<Study B>"
	And Study "<Study A>" "<Study B>" are not connected to iMedidata
	And I am assigned to Study "<Study A>" "<Study B>" with "<EDC Role 1>"
	And I am invited to iMedidata 
	And there exists a new study "<Study A>" "<Study B>" in iMedidata
	And the "<study A>" "<Study B>" are now linked to Rave Studies "<Study A>" "<Study B>"
	And I have invitation to join "<Study A>" with App "<EDC App>" with role "<EDC Role 1>" App "<Modules App>" with "<Modules Role 1>"
	And I have invitation to join "<Study B>" with App "<EDC App>" with role "<EDC Role 1>" App "<Modules App>" with "<Modules Role 1>"
	And I activate my account
	And I log in to iMedidata as "<iMedidata User 1 ID>"
	And I accept the invitation to Study "<Study A>", "<Study B>"
    And I click on App "<EDC App>" for Study "<Study A>"
	And I am on the Rave Connection Page 
	And I enter Rave user password into the "Password" text field
	And I follow "Link Account"
    And I am on the Rave Study "<Study A>" page
	And I click on Home 
	And I should see "<Study A>", "<Study B>" on Rave home page
	And I take a screenshot
    And I navigate to the User Administration Module
	When I navigate to the User Details page for "<iMedidata User 1 ID>" user for "<EDC Role 1>"
	Then I should see user is assigned to "<Study A>" , "<Study B>" in Studies Pane with Role "<EDC Role 1>"
	And I take a screenshot
	And I navigate to Architect page
	And I select "<Study A>"
	And I navigate to Studies Environment Set Up page
	And I should see Linked to iMedidata is checked
	And I take a screenshot
	And I navigate to Architect page
	And I select "<Study B>"
	And I navigate to Studies Environment Set Up page
	And I should see Linked to iMedidata is checked
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.1.76-14
@Validation
Scenario: When an internal user with assignments to External iMedidata Studies in Rave is transitioned to iMedidata with assignments those iMedidata studies the user is assigned to in Rave as internal user, the user should be assigned to the studies appropriately.
	
	
	Given I am an existing Rave user "<Rave user Name 1>"
	And my Email is "<iMedidata User 1 Email>"
	And there is a Study named "<Study A>" 
	And there is a Study named "<Study B>"
	And Study "<Study A>" "<Study B>" are connected to iMedidata
	And I am assigned to Study "<Study A>" "<Study B>" with "<EDC Role 1>" in Rave
	And I am invited to iMedidata 
	And I have invitation to join "<Study A>" with App "<EDC App>" with role "<EDC Role 1>" App "<Modules App>" with "<Modules Role 1>"
	And I have invitation to join "<Study B>" with App "<EDC App>" with role "<EDC Role 1>" App "<Modules App>" with "<Modules Role 1>"
	And I activate my account
	And I log in to iMedidata as "<iMedidata User 1 ID>"
	And I accept the invitation to Study "<Study A>", "<Study B>"
    And I click on App "<EDC App>" for Study "<Study A>"
	And I am on the Rave Connection Page 
	And I enter Rave user password into the "Password" text field
	And I follow "Link Account"
    And I am on the Rave Study "<Study A>" page
	And I click on Home 
	And I should see "<Study A>", "<Study B>" on Rave home page
	And I take a screenshot
    And I navigate to the User Administration Module
	When I navigate to the User Details page for "<iMedidata User 1 ID>" user for "<EDC Role 1>"
	Then I should see user is assigned to "<Study A>" , "<Study B>" in Studies Pane with Role "<EDC Role 1>"
	And I take a screenshot
	And I navigate to Architect page
	And I select "<Study A>"
	And I navigate to Studies Environment Set Up page
	And I should see Linked to iMedidata is checked
	And I take a screenshot
	And I navigate to Architect page
	And I select "<Study B>"
	And I navigate to Studies Environment Set Up page
	And I should see Linked to iMedidata is checked
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.76-92
@Validation
@Build 181
Scenario: As a Rave user I complete an eLearning course and my account is merged with iMedidata,then the course should be still shown as completed

   Given I have a Rave account as Rave User "<Rave User 1>" with rave username "<Rave User Name 1>" rave password "<rave password>"
         email "<iMedidata New User 1 Email>" with Trained Date and "Training Signed" checkbox checked
   And Rave User "<Rave User Name 1>"  is not connected to iMedidata
   And I am logged in to the Rave
   And new Rave Study "<Study A>" is created
   And new Rave "<New Site A1>" is created with site number "<Unique number1>"
   And I am assigned to study "<Study A>" with  "<New Site A1>" with role "<EDC Role 1>"
   And I am assigned User Group "<Modules Role 1>"
   And there exists Security Group "<Security Group 1>" and Security Role "<Security Role 1>" associated with Study "<Study A>"
   And I have assigned Security Role "<Security Role 1>" to Project "<Study A>"
   And I have assigned to eLearning Course "<Course 1>" on Study Role Assignments: "<Study A>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see course status as "Not Started" under eLearning section on User Details page
   And I select "Home" icon
   And I see the "eLearning Home" page 
   And I take a screenshot
   And I select "Start" button to start the eLearning Course "<Course 1>"
   And I have completed and passed the eLearning Course "<Course 1>"
   And I navigate to "User Administration" Module
   And I search for Rave user "<Rave User 1>"
   And I go to the User Details page for user "<Rave User 1>"
   And I see elearning Course status as "Completed" under eLearning section on User Details page 
   And I take a screenshot
   And I select link "Home"
   And I do not see the "eLearning Home" page 
   And I see the site "<New Site A1>" home page for "<Study A>"
   And I logout of Rave
   And I am an iMedidata User
   And I am logged in as "<iMedidata User 1 ID>"
   And my username is "<iMedidata User 1 ID>"
   And my Email is "<iMedidata New User 1 Email>"
   And there is an iMedidata Study named "<Study A>"
   And there is an iMedidata Site "<New Site A1>" with site number "<Unique number1>"
   And I am assigned to study "<Study A>" with app "<Edc App>" with role "<EDC Role 1>"
   And I am assigned to study "<Study A>" with app "<Modules App>" with role "<Modules Role 1>"
   And I am assigned to study "<Study A>" with app "<Security App>" with role "<Security Group 1>"
   And I follow the link "<EDC App>" associated with study "<Study A>"
   And I see the "Rave Connection" Page
   And I enter the Rave password "<Rave Password 1>"
   When I select link "Link Account"
   Then I see the site "<Site A1>" home page for "<Study A>"
   And I do not see the eLearning Home page
   And I navigate to "User Administration" Module
   And I search for user "<iMedidata User 1 ID>"
   And I go to the User Details page for user "<iMedidata User 1 ID>"
   And I am assigned to study "<Study A>" with role "<EDC Role 1>"
   And I see Security Group "<Security Group 1>" associated with Study "<Study A>"
   And I see assigned Security Role "<Security Role 1>" associated with Study "<Study A>"
   And I see elearning Course status as "Completed" under eLearning section on User Details page 
   And I take a screenshot

		
@Rave 564 Patch 13
@PB2.5.1.76-93
@Validation
@Build 181
Scenario: If Internal Rave user has not completed an eLearning course and account is merged with iMedidata,then the course is required for Access.

    Given I have a Rave account as Rave User "<Rave User 1>" with rave username "<Rave User Name 1>" with rave password "<rave password>"
	 email "<iMedidata New User 1 Email>" with Trained Date and "Training Signed" checkbox checked
    And Rave User "<Rave User Name 1>"  is not connected to iMedidata
    And I am logged in to the Rave
    And new Rave Study "<Study A>" is created
    And new Rave "<New Site A1>" is created with site number "<Unique number2>"
    And I am assigned to study "<Study A>" with  "<New Site A1>" with role "<EDC Role 1>"
    And I am assigned User Group "<Modules Role 1>"
    And there exists Security Group "<Security Group 1>" and Security Role "<Security Role 1>" associated with Study "<Study A>"
    And I have assigned Security Role "<Security Role 1>" to Project "<Study A>"
    And I have assigned to eLearning Course "<Course 1>" on Study Role Assignments: "<Study A>" for EDC Role "<EDC Role 1>"
    And I navigate to "User Administration Module"
    And I search for user "<Rave User Name 1>"
    And I go to the User Details page for user "<Rave User Name 1>"
	And I see status "Not Started" under eLearning section under User Details page
    And I select link "Home"
    And I see the "eLearning Home" page 
    And I take a screenshot
    And I select "Start" button to start the eLearning Course "<Course 1>"
    And I stop and do not complete the eLearning Course "<Course 1>"
    And I navigate to "User Administration" Module
    And I search for user "<Rave User Name 1>"
    And the eLearning Course "<Course 1>" is not removed from the User Details page
    And the Status is "Incomplete"
    And I take a screenshot
    And  I select link "Home"
    And I see the "eLearning Home" page with eLearning Course Status "Incomplete"
    And I take a screenshot
    And I am an iMedidata User
    And I am logged in as "<iMedidata User 1 ID>"
    And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata New User 1 Email>"
    And there is an iMedidata Study named "<Study A>"
    And there is an iMedidata Site "<New Site A1>" with site number "<Unique number2>"
    And I am assigned to study "<Study A>" with app "<Edc App>" with role "<EDC Role 1>"
    And I am assigned to study "<Study A>" with app "<Modules App>" with role "<Modules Role 1>"
    And I am assigned to study "<Study A>" with app "<Security App>" with role "<Security Group 1>"
	And I follow the link "<EDC App>" associated with study "<Study A>"
	And I see the "Rave Connection" Page
	And I enter the Rave password "<Rave Password 1>"
	When I follow link "Link Account"
	Then I  see the "eLearning Home" page
	And I take a screenshot
	And I navigate to "User Administration" Module
    And I search for user "<iMedidata User 1 ID>"
    And I go to the User Details page for user "<iMedidata User 1 ID>"
    And I see assigned EDC role "<EDC Role 1>" associated with study "<Study A>"
    And I see exists Security Group "<Security Group 1>"  associated with Study "<Study A>"
    And I am assigned Security Role "<Security Role 1>" associated with Study "<Study A>"
    And I see elearning course is required on eLearning section
	And I see the eLearning Course Status "Incomplete"
    And I take a screenshot

@Rave 564 Patch 13
@PB2.5.1.76-94
@Validation
Scenario: If internal Rave user do not start an eLearning course and account is merged with iMedidata,
          then the course is still shown as "Not Started"

   Given I have a Rave account as Rave User "<Rave User 1>" with rave username "<Rave User Name 1>" with rave password "<rave password>"
         with email "<iMedidata New User 1 Email>" with Trained Date and "Training Signed" checkbox checked
   And Rave User "<Rave User Name 1>"  is not connected to iMedidata
   And I am logged in to the Rave
   And new Rave Study "<Study C>" is created
   And new Rave "<New Site C1>" is created with site number "<Unique number3>"
   And I am assigned to study "<Study C>" with  "<New Site C1>" with role "<EDC Role 1>"
   And I am assigned User Group "<Modules Role 1>"
   And there exists Security Group "<Security Group 1>" and Security Role "<Security Role 1>" associated with Study "<Study C>"
   And I have assigned Security Role "<Security Role 1>" to Project "<Study C>"
   And I have assigned to eLearning Course "<Course 1>" on Study Role Assignments: "<Study C>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration Module"
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see status "Not Started" under eLearning section under User Details page
   And I select link "Home"
   And I see the "eLearning Home" page with Status "Not Started"
   And I take a screenshot
   And I am an iMedidata User
   And I am logged in as "<iMedidata User 1 ID>"
   And my username is "<iMedidata User 1 ID>"
   And my Email is "<iMedidata New User 1 Email>"
   And there is an iMedidata Study named "<Study C>"
   And there is an iMedidata Site "<New Site C1>" with site number "<Unique number3>"
   And I am assigned to study "<Study C>" with app "<Edc App>" with role "<EDC Role 1>"
   And I am assigned to study "<Study C>" with app "<Modules App>" with role "<Modules Role 1>"
   And I am assigned to study "<Study C>" with app "<Security App>" with role "<Security Group 1>"
   And I follow the link "EDC App" associated with study "<Study C>"
   And I see the "Rave Connection" Page
   And I enter the Rave password "<Rave Password 1>"
   When I follow link "Link Account"
   Then I  see the eLearning home page with Status "Not Started" in Rave
   And I take a screenshot
   And I navigate to "User Administration" Module
   And I search for user "<iMedidata User 1 ID>"
   And I go to the User Details page for user "<iMedidata User 1 ID>"
   And I see assigned EDC role "<EDC Role 1>" associated with study "<Study C>"
   And I see Security Group "<Security Group 1>" associated with Study "<Study C>"
   And I see assigned Security Role "<Security Role 1>" associated with Study "<Study C>"
   And I see the eLearning section with Status "Not Started" for eLearning course "<Course 1>"
   And I take a screenshot

		
@Rave 564 Patch 13
@PB2.5.1.76-95
@Validation
Scenario: As Internal Rave user I am assigned to eLearning course for a particular edc role which has a status of Not Started. When my account is merged with iMedidata,
          the eLearning course is still required and status should show as "Not Started" for that particular assigned role in Rave and eLearning course 
		  not required for the second role , user should be able to access Rave with the second role.

 
   Given I have a Rave account as Rave User "<Rave User 1>" with rave username "<Rave User Name 1>"
                with rave password "<rave password>" with email "<iMedidata New User 1 Email>" with Trained Date and "Training Signed" checkbox checked
   And Rave User "<Rave User Name 1>"  is not connected to iMedidata
   And I am logged in to the Rave
   And new Rave Study "<Study C>" is created
   And new Rave "<New Site C1>" is created with site number "<Unique number4>"
   And I am assigned to study "<Study C>" with  "<New Site C1>" with role "<EDC Role 1>"
   And I am assigned User Group "<Modules Role 1>"
   And there exists Security Group "<Security Group 1>" and Security Role "<Security Role 1>" associated with Study "<Study C>"
   And I have assigned Security Role "<Security Role 1>" to Project "<Study C>"
   And I have assigned to eLearning Course "<Course 1>" on Study Role Assignments: "<Study C>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration Module"
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see status "Not Started" under eLearning section under User Details page
   And I select link "Home"
   And I see the "eLearning Home" page with Status "Not Started"
   And I take a screenshot
   And I am an iMedidata User
   And I am logged in as "<iMedidata User 1 ID>"
   And my username is "<iMedidata User 1 ID>"
   And my Email is "<iMedidata New User 1 Email>"
   And there is an iMedidata Study named "<Study C>"
   And there is an iMedidata Site "<New Site C1>" with site number "<Unique number4>"
   And I am assigned to study "<Study C>" with app "<Edc App>" with role "<EDC Role 1>" and "<EDC Role 2>"
   And I am assigned to study "<Study C>" with app "<Modules App>" with role "<Modules Role 1>"
   And I am assigned to study "<Study C>" with app "<Security App>" with role "<Security Group 1>"
   And I follow the link "<EDC App>" associated with study "<Study C>"
   And I see the "Connect your Rave account to iMedidata" page
   And I enter the Rave password "<Rave Password 1>"
   And I follow link "Link Account"
   And I see the "Role Selection" page
   When I select EDC Role "<EDC Role 1>"
   And select "Continue" button
   Then I  see the "eLearning Home" page with Status "Not Started"
   And I take a screenshot
   And I navigate to "User Administration" Module
   And I search for user "<iMedidata User 1 ID>"
   And I go to the User Details page for user "<iMedidata User 1 ID>"
   And I see assigned EDC role "<EDC Role 1>" associated with study "<Study C>"
   And I see Security Group "<Security Group 1>" associated with Study "<Study C>"
   And I see assigned Security Role "<Security Role 1>" associated with Study "<Study C>"
   And I see the Status for eLearning course shown as "Not Started"
   And I select Link "iMedidata"
   And I follow the link "<EDC App>" associated with study "<Study C>"
   And I see the Role Selection Page
   And I select Role "<EDC Role 2>"
   And I select "Continue" button
   And I am on Rave Study Site "<New Site C1>" Home page
   And I take a screenshot
   And I navigate to "User Administration" Module
   And I search for user "<iMedidata User 1 ID>"
   And I go to the User Details page for user "<iMedidata User 1 ID>"
   And I see assigned EDC role "<EDC Role 2>" associated with study "<Study C>"
   And I see Security Group "<Security Group 1>" associated with Study "<Study C>"
   And I see assigned Security Role "<Security Role 1>" associated with Study "<Study C>"
   And I see that there is no eLearning course assigned
   And I take a screenshot
		
@Rave 564 Patch 13
@PB2.5.1.76-96
@Validation
@Build 182
Scenario: If internal Rave user has not started eLearning course and  overide the course when account is merged with iMedidata,
          then the course should not be shown as "Not Started" and not required.

   Given I have a Rave account as Rave User "<Rave User 1>" with rave username "<Rave User Name 1>"
                with rave password "<rave password>" with email "<iMedidata New User 1 Email>" with Trained Date and "Training Signed" checkbox checked
   And Rave User "<Rave User Name 1>"  is not connected to iMedidata
   And I am logged in to the Rave
   And new Rave Study "<Study C>" is created
   And new Rave "<New Site C1>" is created with site number "<Unique number5>"
   And I am assigned to study "<Study C>" with  "<New Site C1>" with role "<EDC Role 1>"
   And I am assigned User Group "<Modules Role 1>"
   And there exists Security Group "<Security Group 1>" and Security Role "<Security Role 1>" associated with Study "<Study C>"
   And I have assigned Security Role "<Security Role 1>" to Project "<Study C>"
   And I have assigned to eLearning Course "<Course 1>" on Study Role Assignments: "<Study C>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration Module"
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see status "Not Started" under eLearning section of User Details page
   And I check the "Override" check box 
   And I save changes
   And I select link "Home"
   And I do not see the "eLearning Home" page with Status "Not Started"
   And I am on Study Site "<New Site C1>" page
   And I take a screenshot
   And I am an iMedidata User
   And I am logged in as "<iMedidata User 1 ID>"
   And my username is "<iMedidata User 1 ID>"
   And my Email is "<iMedidata New User 1 Email>"
   And there is an iMedidata Study named "<Study C>"
   And there is an iMedidata Site "<New Site C1>" with site number "<Unique number5>"
   And I am assigned to study "<Study C>" with app "<Edc App>" with role "<EDC Role 1>"
   And I am assigned to study "<Study C>" with app "<Modules App>" with role "<Modules Role 1>"
   And I am assigned to study "<Study C>" with app "<Security App>" with role "<Security Group 1>"
   And I follow the link "<EDC App>" associated with study "<Study C>"
   And I see the "Rave Connection" Page
   And I enter the Rave password "<Rave Password 1>"
   When I follow link "Link Account"
   Then I  do not see the eLearning Home page with Status "Not Started"
   And I am on Study Site "<New Site C1>" page
   And I take a screenshot
   And I navigate to "User Administration" Module
   And I search for user "<iMedidata User 1 ID>"
   And I go to the User Details page for user "<iMedidata User 1 ID>"
   And I see assigned EDC role "<EDC Role 1>" associated with study "<Study C>"
   And I see Security Group "<Security Group 1>" associated with Study "<Study C>"
   And I see assigned Security Role "<Security Role 1>" associated with Study "<Study C>"
   And I see elearning course is not required on eLearning section
   And I take a screenshot
		
@Rave 564 Patch 13
@PB2.5.1.76-97
@Validation
@Build 181
Scenario: If Internal Rave user has not completed (Incomplete) an eLearning course and override the course,when account is merged
           with iMedidata,then the course is not required

   Given I have a Rave account as Rave User "<Rave User 1>" with rave username "<Rave User Name 1>"
               with rave password "<rave password>" with email "<iMedidata New User 1 Email>" with Trained Date and "Training Signed" checkbox checked
   And Rave User "<Rave User Name 1>"  is not connected to iMedidata
   And I am logged in to the Rave
   And new Rave Study "<Study A>" is created
   And new Rave "<New Site A1>" is created with site number "<Unique number6>"
   And I am assigned to study "<Study A>" with  "<New Site A1>" with role "<EDC Role 1>"
   And I am assigned User Group "<Modules Role 1>"
   And there exists Security Group "<Security Group 1>" and Security Role "<Security Role 1>" associated with Study "<Study A>"
   And I have assigned Security Role "<Security Role 1>" to Project "<Study A>"
   And I have assigned to eLearning Course "<Course 1>" on Study Role Assignments: "<Study A>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration Module
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see status "Not Started" under eLearning section under User Details page
   And I select link "Home"
   And I see the "eLearning Home" page 
   And I take a screenshot
   And I select "Start" button to start the eLearning Course "<Course 1>"
   And I stop and do not complete the eLearning Course "<Course 1>"
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 1>"
   And the eLearning Course "<Course 1>" is not removed from the User Details page
   And the Status is "Incomplete"
   And I check the "Override" check box
   And I save changes.
   And I take a screenshot
   And  I select link "Home"
   And I should not see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I should be on Study Site "<New Site A1>" page
   And I take a screenshot
   And I am an iMedidata User
   And I am logged in as "<iMedidata User 1 ID>"
   And my username is "<iMedidata User 1 ID>"
   And my Email is "<iMedidata New User 1 Email>"
   And there is an iMedidata Study named "<Study A>"
   And there is an iMedidata Site "<New Site A1>" with site number "<<Unique number6>"
   And I am assigned to study "<Study A>" with app "<Edc App>" with role "<EDC Role 1>"
   And I am assigned to study "<Study A>" with app "<Modules App>" with role "<Modules Role 1>"
   And I am assigned to study "<Study A>" with app "<Security App>" with role "<Security Group 1>"
   And I follow the link "EDC App" associated with study "<Study A>"
   And I see the "Rave Connection" Page
   And I enter the Rave password "<Rave Password 1>"
   When I follow link "Link Account"
   Then I  do not see the "eLearning Home" page
   And I am on Study Site "<New Site A1>" page
   And I take a screenshot
   And I navigate to "User Administration" Module
   And I search for user "<iMedidata User 1 ID>"
   And I go to the User Details page for user "<iMedidata User 1 ID>"
   And I see EDC role "<EDC Role 1>" associated with study "<Study A>"
   And I see Security Group "<Security Group 1>"  associated with Study "<Study A>"
   And I am assigned Security Role "<Security Role 1>" associated with Study "<Study A>"
   And I see elearning course is not required on eLearning section
   And I take a screenshot
		
@Rave 564 Patch 13
@PB2.5.1.76-98
@Validation
@Build 181
Scenario: If Internal Rave user has not passed the eLearning course and account is merged with iMedidata, then the course is still required.

   Given I have a Rave account as Rave User "<Rave User 1>" with rave username "<Rave User Name 1>"
                and rave password "<rave password>" and email "<iMedidata New User 1 Email>" with Trained Date and "Training Signed" checkbox checked
   And Rave User "<Rave User Name 1>"  is not connected to iMedidata
   And I am logged in to the Rave
   And new Rave Study "<Study A>" is created
   And new Rave "<New Site A1>" is created with site number "<Unique number7>"
   And I am assigned to study "<Study A>" with  "<New Site A1>" with role "<EDC Role 1>"
   And I am assigned User Group "<Modules Role 1>"
   And there exists Security Group "<Security Group 1>" and Security Role "<Security Role 1>" associated with Study "<Study A>"
   And I have assigned Security Role "<Security Role 1>" to Project "<Study A>"
   And I have assigned to eLearning Course "<Course 1>" on Study Role Assignments: "<Study A>" for EDC Role "<EDC Role 1>"
   And I navigate to "User Administration Module
   And I search for user "<Rave User Name 1>"
   And I go to the User Details page for user "<Rave User Name 1>"
   And I see status "Not Started" under eLearning section under User Details page
   And I select link "Home"
   And I see the "eLearning Home" page 
   And I take a screenshot
   And I select "Start" button to start the eLearning Course "<Course 1>"
   And I completed the eLearning Course "<Course 1>"
   And I failed the eLearning Course
   And I take a screenshot
   And I navigate to "User Administration" Module
   And I search for user "<Rave User Name 1>"
   And the eLearning Course "<Course 1>" is not removed from the User Details page
   And the Status is "Incomplete"
   And I take a screenshot
   And  I select link "Home"
   And I should see the "eLearning Home" page with eLearning Course Status "Incomplete"
   And I should not be on Study Site "<New Site A1>" page
   And I am logged out as Rave User "<Rave User Name 1>" 
   And I am an iMedidata User
   And I am logged in as "<iMedidata User 1 ID>"
   And my username is "<iMedidata User 1 ID>"
   And my Email is "<iMedidata New User 1 Email>"
   And there is an iMedidata Study named "<Study A>"
   And there is an iMedidata Site "<New Site A1>" with site number "<Unique number7>"
   And I am assigned to study "<Study A>" with app "<Edc App>" with role "<EDC Role 1>"
   And I am assigned to study "<Study A>" with app "<Modules App>" with role "<Modules Role 1>"
   And I am assigned to study "<Study A>" with app "<Security App>" with role "<Security Group 1>"
   And I follow the link "<EDC App>" associated with study "<Study A>"
   And I see the "Rave Connection" Page
   And I enter the Rave password "<Rave Password 1>"
   When I follow link "Link Account"
   Then I  see the "eLearning Home" page
   And I take a screenshot
   And I navigate to "User Administration" Module
   And I search for user "<iMedidata User 1 ID>"
   And I go to the User Details page for user "<iMedidata User 1 ID>"
   And I see assigned EDC role "<EDC Role 1>" associated with study "<Study A>"
   And I see exists Security Group "<Security Group 1>"  associated with Study "<Study A>"
   And I am assigned Security Role "<Security Role 1>" associated with Study "<Study A>"
   And I see eLearning course is required on eLearning section
   And I see eLearning course status as 'Incomplete'
   And I take a screenshot


@Future
@PB2.5.1.XXX
@Draft
Scenario: If an iMedidata user accesses Rave through the Rave URL or study for the first time with a single EDC role and there is a single untransitioned Rave
              account with matching email address and Username,  then Rave the Rave Connection page and prompt the user for
		   the password to the single account found or create a new account in Rave or link to a different account. When I choose to create a new account, then Rave will create a new account with the username(1) but with the same email address.

@Future
@PB2.5.1.76-10
@Draft
Scenario: When merging iMedidata created and non-transitioned accounts, if there are conflicting assignments between multipl
          e non-transitioned Rave accounts, the most-recently modified Rave account will take precendence.
