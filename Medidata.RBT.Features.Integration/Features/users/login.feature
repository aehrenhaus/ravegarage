# In Rave, a timeout will occur after a configurable number of minutes of inactivity have elapsed, after which the user is prompted to re-enter the credentials in Rave. The externally authenticated user must submit iMedidata credentials. Internally authenticated users will see no change to the Rave Password Timeout process or Interaction Timeout process. The configuration settings on Rave related to Password Timeout and Interaction Timeout will apply.
# When the iMedidata session times out before Rave triggers a Password Timeout, then the user’s new session will be activated in Rave if the credentials are correct. When the iMedidata session times out before Rave triggers an Interaction Timeout, then the new session will be activated in Rave if the credentials are correct. When an internally authenticated user or an externally authenticated user clicks on logout, then their session in Rave will end.




Feature: Rave Integration for User Logins
    In order to use Rave
    As a User 
    I want to login to Rave using iMedidata

	Background:
	Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>" and user id "<User ID>"
		|User						|PIN						| Password							|User ID						|Email 							|
		|{iMedidata User 1}			|iMedidata User 1 PIN}		|{iMedidata User 1 Password}		|{iMedidata User 1 ID}			|{iMedidata User 1 Email}		|
	And there exists a Rave user "<Rave User>" with username "<Rave User Name>" and password "<Rave Password>"
		|Rave User		|Rave User Name		|Rave Password		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|
	And there exists study "<Study>" in study group "<Study Group>"
		|Study		|Study Group 	|
		|{Study A}	|{Study Group} 	|
		|{Study B}	|{Study Group} 	|
	And there exists Rave study "<Rave Study>" 
		|{Rave Study 1}	|			
	And there exists app "<App>" associated with study in iMedidata
		|App			|
		|{EDC App}		|
		|{Modules App}	|
		|{Security App}	|
	And there exists site "<Site>" in study "<Study>", 	in iMedidata	
		|Study		|Site		|
		|{Study A}	|{Site A1}	|
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role												|
		|{EDC App}		|{EDC Role 1}										|
		|{EDC App}		|{EDC Role 2}										|
		|{EDC App}		|{EDC Role 3}										|
		|{EDC App}		|{EDC Role CRA create sub cannot view all sites}	|
		|{EDC App}		|{EDC Role RM Monitor}								|
		|{Modules App}	|{Modules Role 1}									|
		|{Modules App}	|{Modules Role 2 No Reports}						|
		|{Modules App}	|{Modules Role 3 No Sites}							|
		|{Security App}	|{Security Role 1}									|		
	And there exist "<Rave URL>" with "<URL Name>"
		|Rave URL		|URL Name							|
		|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
	
@Rave 564 Patch 13
@PB2.5.3.1-01 
@Validation
Scenario: If the internally authenticated user is experiencing Password Timeout in Rave, the system will ask the user to re-enter the Password credential. 
	
	Given I am a Rave User "<Rave User 1>" with rave username "<Rave User Name 1>"  password "< Rave Password 1>" user group "<User Group 1>"
	And I am logged in to Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I set Password Timeout to 1 minute
	And I Check Password Timeout 
	And I uncheck Interaction timeout
	And I follow link "Update"
	And I wait for 65 seconds
	When I follow link "My Profile"
	Then I see the Password Timeout page
	And I should see rave username "<Rave User Name 1>" 
	And I should see text "You have been idle too long.  Please re-enter your password"
	And I should see text "Enter your Current Password"
	And I take a Screenshot
	
@Rave 564 Patch 13
@PB2.5.3.2-01 
@Validation
Scenario: If an iMedidata user is experiencing Password Timeout in Rave, the system will ask the user to re-enter the iMedidata Password credential. 

	Given I am an iMedidata User "<iMedidata User 1>" with username "<iMedidata User 1 ID>" password "<iMedidata User 1 Password>" and user group "<User Group 1>"
	And I am the owner of study group "<Study Group>" with Modules app "<Modules App>" with role "<Modules Role 1>"  EDC app "<EDC App>" with role "<EDC Role 1>"
	And I select app "<Modules App>" associated with study group "<Study Group>"
	And I am on Rave Home page
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I set Password Timeout to 1 minute
	And I Check Password Timeout 
	And I uncheck Interaction Timeout
	And I follow link "Update"
	And I wait for 65 seconds
	When I follow link "My Profile"
	Then I see the Password Timeout page
	And I should see iMedidata username "<iMedidata User 1 ID>"
	And I should see text "You have been idle too long.  Please re-enter your password"
	And I should see text "Enter your Current Password"
	And I take a Screenshot
	
@2012.2.0
@PB2.5.3.2-02
@Draft
@BUG
## IDP user
Scenario: For iMedidata users using federated single sign on, Password Timeout in Rave is not supported.

#IDP user cannot enter just a password to re-authenticate;user must be directed back to iMedidata who will re-direct to select login page.

@Rave 564 Patch 13
@PB2.5.3.3-01 
@Validation
Scenario: If Rave users are experiencing Interaction Timeout in Rave, the system will ask the user to re-enter the User Name and Password credentials. 
	
	Given I am a Rave User "<Rave User 1>" with username "<Rave User Name 1>" password "<password>"  user group "<User Group 1>"
	And I am logged in to Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I uncheck Password Timeout
	And I set Interaction Timeout to 1 minute
	And I Check Interaction Timeout 
	And I follow link "Update"
	And I wait for 65 seconds
	When I follow link "My Profile"
	Then I see the Rave Login page
	And I should see text "You have been idle too long.  Please log into the system again."
	And I see text field "User Name"
	And I see text field "Password"
	And I take a Screenshot
	
@Rave 564 Patch 13
@PB2.5.3.4-01 
@Validation
Scenario: If an iMedidata user is experiencing Interaction Timeout in Rave, this will require the user’s session on Rave to end as part of the Interaction Timeout.  The system will redirect the user to the iMedidata login page. 

	Given I am an iMedidata User "<iMedidata User 1>" with username "<iMedidata User 1 ID >"  password "<iMedidata User 1 Password>" and user group "<User Group 1>"
	And I am the owner of study "<Study A>" with Modules app "<Modules App>" with role "<Modules Role 1>"  EDC app "<EDC App>" with role "<EDC Role 1>"
	And I select app "<EDC App>" associated with study "<Study A>"
	And I am in Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I uncheck Password Timeout
	And I set Interaction Timeout to 1 minute
	And I Check Interaction Timeout 
	And I follow link "Update"
	And I wait for 65 seconds
	When I follow link "My Profile"
	Then I should see the iMedidata Login page
	And I should not be on the Rave Login page
    And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.4-02 
@Validation
Scenario: If an iMedidata user is experiencing an iMedidata timeout, this will require the user’s session on Rave to end as part of the Timeout.  The system will redirect the user to the iMedidata login page. 

	Given I am an iMedidata User "<iMedidata User 1>" with username "<iMedidata User 1 ID>" and password "<iMedidata User 1 Password>" 
    And I am the owner of study "<Study A>" with Modules app "<Modules App>" with role "<Modules Role 1>"  EDC app "<EDC App>" with role "<EDC Role 1>"
	And I select app "<EDC App>" associated with study "<Study A>"  
	And I am in Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I set Password Timeout to "999"
	And I Check Password Timeout 
	And I set Interaction Timeout to "999"
	And I Check Interaction Timeout 
	And I follow link "Update"
	And I follow link "Home"
	And I wait for 65 minutes
	When I follow link "iMedidata"
	Then I see the iMedidata Login page
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.5-01 
@Validation
Scenario: If a Rave managed user submits correct credentials after a Password timeout in Rave, then the user’s session will be reactivated in Rave (and the user will be directed to the page requested).

	Given I am a Rave User "<Rave User 1>" with rave username "<Rave User Name 1>"  rave password "<Rave Password 1>" with access to User Adminstration
	And I am loged in to Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I set Password Timeout to 1 minute
	And I Check Password Timeout 
	And I uncheck Interaction Timeout
	And I follow link "Update"
	And I wait for 65 seconds
	And I follow link "My Profile"
	And I see the Password Timeout page
    And I enter rave password "<Rave Password 1>" 
	When I select button "Enter"
	Then I should see page "My Profile"
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.5-02 
@Validation
Scenario: If an iMedidata-managed user submits correct credentials after a Password timeout in Rave, then the user’s session will be reactivated in Rave (and the user will be directed to the page requested).

	Given I am an iMedidata User "<iMedidata User 1>" with username "<iMedidata User 1 ID>" password "<iMedidata User 1 Password>" 
	And I am the owner of study "<Study A>" with Modules app "<Modules App>" with role "<Modules Role 1>"  EDC app "<EDC App>" with role "<EDC Role 1>"
	And I select app "<EDC App>" associated with study "<Study A>"  
	And I am in Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I set Password Timeout to 1 minute
	And I Check Password Timeout 
	And I uncheck Interaction Timeout
	And I follow link "Update"
	And I wait for 65 seconds
	And I follow link "My Profile"
	And I see the Rave Password Timeout page
	And I enter iMedidata password "<iMedidata User 1 Password>" 
	When I select button "Enter"
	Then I should see page "My Profile"
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.5-03 
@Validation
Scenario: If a Rave managed user submits correct credentials after an Interaction timeout in Rave, then the user’s new session will be activated in Rave and the user homepage is displayed.

	Given I am a Rave User "<Rave User 1>" with rave username "<Rave User Name 1>" rave password "<Rave password 1>"  with access to User Adminstration
	And I am logged in to Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I uncheck Password Timeout 
	And I set Interaction Timeout to 1 minute 
	And I Check Interaction Timeout 
	And I follow link "Update"
	And I wait for 65 seconds
	And I follow link "My Profile"
	And I see the Rave Login page
	And I enter text field Username "<Rave User Name 1>"
	And I enter text field Password "<Rave password 1>"
	When I click button "Enter"
	Then I should see Rave User "<Rave User 1>" homepage
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.5-04 
@Validation
Scenario: If an iMedidata-managed user submits correct credentials after an Interaction timeout in Rave, then the user’s new session will be activated in iMedidata and iMedidata home page is displayed.

	Given I am an iMedidata User "<iMedidata User 1>" with username "<iMedidata User 1 ID>"  password "<iMedidata User 1 Password>" 
    And I am the owner of study "<Study A>" with Modules app "<Modules App>" with role "<Modules Role 1>"  EDC app "<EDC App>" with role "<EDC Role 1>"
	And I select app "<EDC App>" associated with study "<Study A>"   
	And I am in Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I uncheck Password Timeout 
	And I set Interaction Timeout to 1 minute
	And I Check Interaction Timeout 
	And I follow link "Update"
	And I wait for 65 seconds
	And I follow link "My Profile"
	And I see iMedidata Login page
	And I Enter Text Field Username value "<iMedidata User 1 ID>"
	And I Enter Text Field Password value "<iMedidata User 1 Password>"
	When I click button "Log In"
	Then I should see iMedidata Homepage
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.5-05 
@Validation
## ReAuthenticationExternalUpgrade564, Step 23
Scenario: If an iMedidata-managed user submits correct credentials after an iMedidata timeout, then the user’s new session will be activated in iMedidata.

	Given I am an iMedidata User "<iMedidata User 1>" with username "<iMedidata User 1 ID>" password "<iMedidata User 1 Password>"
	And I am the owner of study "<Study A>" with Modules app "<Modules App>" with role "<Modules Role 1>"  EDC app "<EDC App>" with role "<EDC Role 1>"
	And I select app "<EDC App>" associated with study "<Study A>"
	And I am in Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I set Password Timeout to "999"
	And I Check Password Timeout 
	And I set Interaction Timeout to "999"
	And I Check Interaction Timeout 
	And I follow link "Update"
	And I follow link "Home"
	And I wait for 65 minutes
	And I follow link "iMedidata"
	And I see the iMedidata Login page
	And I Enter Username value "<iMedidata User 1 ID>"
	And I Enter Password value "<iMedidata User 1 Password>"
	When I click button "Log In"
	Then I should be on iMedidata Homepage
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.6-01 
@Validation
Scenario: If a Rave managed user submits incorrect credentials after a Password timeout in Rave, then the user’s session will remain inactive on Rave and the message "You have entered an incorrect password" is displayed. 

	Given I am a Rave User "<Rave User 1>" with rave username "<Rave User Name 1>" rave password "< Rave password 1>"  with access to User Adminstration
	And I am loged in to Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I set Password Timeout to 1 minute
	And I Check Password Timeout 
	And I uncheck Interaction Timeout
	And I follow link "Update"
	And I wait for 65 seconds
	And I follow link "My Profile"
	And I see the Password Timeout page
	And I enter text field Password "Wrongpassword" 
	When I select button "Enter"
	Then I should be on Rave Password timeout page
	And I should see text "You have entered an incorrect password"
	And I should see text "You have been idle too long.Please re-enter your password"
	And I should not be on "My Profile" page
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.6-02 
@Validation
Scenario: If a Rave managed user submits incorrect credentials (Wrong Password) after an Interaction timeout in Rave, then the user’s session will remain inactive on Rave and the message "Incorrect Username and/or Password " is displayed. 

	Given I am a Rave User "<Rave User 1>" with rave username "<Rave User Name 1>"  rave password "<Rave password 1>"  with access to User Adminstration
	And I am loged in to Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I uncheck Password Timeout
	And I set Interaction Timeout to 1 minute 
	And I Check Interaction Timeout 
	And I follow link "Update"
	And I wait for 65 seconds
	And I follow link "My Profile"
	And I see the Rave Login page
	And I should see text "You have been idle too long.  Please log into the system again."
	And I enter text field Username "<Rave User Name 1>"
	And I enter text field Password "wrongpassword"
	When I click button "Enter"
	Then I should see text "Incorrect Username and/or Password"
	And I should be on Rave Login page
	And I should not be on "My Profile" page
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.6-05 
@Validation
Scenario: If a Rave managed user submits incorrect credentials (Wrong Username) after an Interaction timeout in Rave, then the user’s session will remain inactive on Rave and the message "Incorrect Username and/or Password " is displayed. 
	
	Given I am a Rave User "<Rave User 1>" with rave username "<Rave User Name 1>" rave password "<Rave password 1>"   with access to User Adminstration
	And I am loged in to Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I uncheck Password Timeout
	And I set Interaction Timeout to 1 minute 
	And I Check Interaction Timeout 
	And I follow link "Update"
	And I wait for 65 seconds
	And I follow link "My Profile"
	And I see the Rave Login page
	And I should see text "You have been idle too long.  Please log into the system again."
	And I enter text field Username "<Wrong Username>"
	And I enter text field Password "Rave password 1"
	When I click button "Enter"
	Then I should see text "Incorrect Username and/or Password"
	And I should be on Rave Login page
	And I should not be on "My Profile" page
	And I take a Screenshot
	
	
@Rave 564 Patch 13
@PB2.5.3.6-03 
@Validation
Scenario: If an iMedidata-managed user submits incorrect credentials after a Password timeout in Rave, then the user’s session will remain inactive on Rave. 

	Given I am an iMedidata User "<iMedidata User 1>" with username "<iMedidata User 1 ID>"  password "<iMedidata User 1 Password>" and user group "<User Group 1>"
	And I am the owner to study group "<Study Group>" with Modules app "<Modules App>" with role "<Modules Role 1>"  EDC app "<EDC App>" with role "<EDC Role 1>"
	And I select app "<Modules App>" associated with study group "<Study Group>"
	And I am in Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I set Password Timeout to 1 minute
	And I Check Password Timeout 
	And I uncheck Interaction Timeout
	And I follow link "Update"
	And I wait for 65 seconds
	And I follow link "My Profile"
	And I see the Rave Password Timeout page
	And I should see Username "<iMedidata User 1 ID>" 
	And I should see text "You have been idle too long.  Please re-enter your password"
	And I enter iMedidata password "WrongPassword" 
	When I click button "Enter"
	Then I should be on Rave Password Timeout page
	And I should see text "You have entered an incorrect password"
	And I should see text "You have been idle too long.  Please re-enter your password"
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.6-04 
@Validation
Scenario: If an iMedidata-managed user submits incorrect credentials (wrong password) after an Interaction timeout in Rave, then the user’s session will remain inactive on Rave. 

	Given I am an iMedidata User "<iMedidata User 1>" with username "<iMedidata User 1 ID>" 
	And I am the owner to study "<Study A>" with Modules app "<Modules App>" with role "<Modules Role 1>" EDC app "<EDC App>" with role "<EDC Role 1>"
	And I select app "<EDC App>" associated with study "<Study A>"
	And I am in Rave
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I uncheck Password Timeout
	And I set Interaction Timeout to 1 minute
	And I Check Interaction Timeout 
	And I follow link "Update"
	And I wait for 65 seconds
	And I follow link "My Profile"
	And I am on iMedidata Login page
	And I Enter Text Field Username value "<iMedidata User 1>"
	And I Enter Text Field Password value "WrongPassword"
	When I click button "Log In"
	Then I should be on iMedidata homepage
	And I should not be on "My Profile" page
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.8-01
@Validation
Scenario: If an iMedidata user clicks on “Logout” link in Rave, the user’s session on both Rave and iMedidata will end and the user is redirected to iMedidata Login page. 

	Given I am an iMedidata User "<iMedidata User 1>" with username "<iMedidata User 1 ID>" password "<iMedidata User 1 Password>" and user group "<User Group 1>"
	And I am the owner to study group "<Study Group>" with Modules app "<Modules App>" with role "<Modules Role 1>" EDC app "<EDC App>" with role "<EDC Role 1>"
	And I select app "<Modules App>" associated with study group "<Study Group>"
	And I am in Rave
	When I follow link "Logout"
	Then I should be on iMedidata log in page
	And I take a Screenshot

@Rave 564 Patch 13
@PB2.5.3.8-02
@Validation
Scenario: If an internally authenicated user clicks on “Logout” link in Rave, the user’s session on Rave will end and the user is logged out of Rave.

	Given I am a Rave User with Rave username "<Rave User Name 1>"
	And I am logged in to Rave
	When I follow link "Logout"
	Then I should be on Rave Log out page
	And I take a Screenshot
	
@Rave 564 Patch 13
@PB2.5.4.1-01 
@Validation
Scenario: If an iMedidata user attempts to login directly to Rave, the system will not authenticate the user and display a message “Please login from iMedidata using your iMedidata Username and Password.”

	Given I am an iMedidata User with username "<iMedidata User 1 ID>"
	And I am the owner to study group "<Study Group>" with Modules app "<Modules App>" with role "<Modules Role 1>" EDC app "<EDC App>" with role "<EDC Role 1>"
	And I am on the Rave login page
	And I Enter Text Field Rave User Name value "<iMedidata User 1 ID>"
	And I Enter Text Field Rave Password value "<iMedidata User 1 Password>"
	When I click button "Enter"
	Then I should see text "Please login from iMedidata using your iMedidata Username and Password."
	And I take a Screenshot
	

@Rave 564 Patch 13
@PB2.5.1.1-02 
@Validation
Scenario: If an iMedidata user selects iMedidata link in Rave, and if the session on iMedidata is inactive then the user is redirected to the iMedidata login page.

    Given I am an iMedidata User with username "<iMedidata User 1 ID>"
	And I am logged in
	And I am assignment to Study "<Study A>" with Modules app "<Modules App>" with role "<Modules Role 1>" EDC app "<EDC App>" with role "<EDC Role 1>"
	And I follow "<EDC App>" for Study "<Study A>"
	And I am on Rave Study "<Study A>" home page
	And I wait for 62 minutes
	When I follow iMedidata link 
	Then I am on iMedidata Login page
	And I take a Screenshot
	
@Rave 564 Patch 13
@PB 2.5.1.100-01 
@Validation 
Scenario: If an Rave managed user experiencing interaction time out in Rave and submits Password incorrectly more times than the number specified in the configuration module of Rave, then Rave will display message "User is Locked Out" and the Rave user account will be locked.

   Given I am a Rave User "<Rave User 1>" with rave username "<Rave User Name 1>"    with access to User Adminstration
   And I login to Rave
   And the "Number of Failed User Login Attempts" is set to "3"
   And I uncheck Password Time out 
   And I check Interaction Timeout
   And I Set Interaction Timeout to "1"
   And I wait "65" seconds
   And I follow "My Profile" 
   And I am on Rave Login Page
   When I enter  Username "<Rave User Name 1>" Password "Wrong Password" 
   And I click Login
   And I should see "Incorrect Username and/or Password"
   And I enter Username "<Rave User Name 1>" Password "Wrong Password" 
   And I click Login
   And I should see "Incorrect Username and/or Password"
   And I enter  Username "<Rave User Name 1>" Password "Wrong Password" 
   And I click Login
   Then I should see "User is Locked out" message 
   And I should be on Rave Login Page
   And I take a Screenshot
   
@Rave 564 Patch 13
@PB2.5.1.100-02
@Validation
Scenario: If an iMedidata managed user experiencing password time out in Rave submits Password incorrectly,
          then Rave will display message "Incorrect Username/password" is displayed. Subsequently,
		   when the user enters the correct password, the user is returned to Raveconfiguration preceeds Rave failed login attempts configuration.
    
   Given I am an iMedidata User "<iMedidata User 1 ID >" with email "<iMedidata User 1 Email>" with username "<Rave User Name 1>"  password "<iMedidata User 1 Password>" user group "<User Group 1>"
   And I have been invited to study group> "<Study Group>"
   And I have a Rave account as Rave User "<Rave User 1>" with rave username "<Rave User Name 1>" and rave password "< rave password>" and user group "<User Group 1>" with access to All Modules
   And Rave User "<Rave User Name 1>"  is not connected to iMedidata
   And the "Number of Failed User Login Attempts"  in Rave is set to "3"
   And I check Password Time out 
   And I Set Password Timeout to "1"
   And I uncheck Interaction Timeout
   And I wait "65" seconds
   And I follow "My Profile" 
   And I am on Rave "Password Timeout" page
   When I enter Password "Wrong Password" 
   And I click Enter
   Then I am on Rave "Password Timeout" page
   And I should see Incorrect Username/password
   And I take a screenshot
   And I enter Password "Wrong Password" 
   And I click Enter
   And I see Incorrect Username/password
   And I am on Rave "Password Timeout" page
   And I enter Password "Wrong Password" 
   And I click Enter
   And I see Incorrect Username/password
   And I still on Rave "Password Timeout" page
   And I do not see "User is Locked out" message
   And I enter Password "<iMedidata User 1 Password>" 
   And I click Enter
   And I see the page "My Profile"
   And I take a screenshot

@Rave 564 Patch 13
@PB 2.5.1.100-03 
@Validation 
Scenario: If an iMedidata managed user is experiencing a Rave Password Timeout and Selects home Icon/Link on the Password Timeout page then the user is directed to iMedidata login page.

    Given I am logged in to iMedidata as iMedidata user "<iMedidata User 1 ID >" with password "<iMedidata User 1 Password>"
    And I am assigned to Study "<Study A>" with Modules app "<Modules App>" with role "<Modules Role 1>" EDC app "<EDC App>" with role "<EDC Role 1> "Security app "<Security App>" with role "<Security Role 1>"
    And I follow "<EDC App>" for Study "<Study A>"
    And I am on Rave Study "<Study A>" home page 
    And I follow the link "Configuration"
    And I follow the link "Other Settings"
    And I check Password Time out 
    And I Set Password Timeout to "1"
	And I uncheck Interaction Time out
	And I update
    And I wait "65" seconds
    And I follow link "My Profile" 
    And the "Password Timeout" page is displayed
    And I take a screenshot
	When I follow link "Home"
    Then I am on iMedidata login page
    And I take a screenshot

@release2012.2.0
@PB2.5.4.2-01
@FUTURE
Scenario: Internally authenticated users will see an invitation to sign up to their global account when they initially login in Rave.
	
	Given I am an iMedidata User "<iMedidata User 1 ID >" with email "<iMedidata User 1 Email>" with username "<Rave User Name 1>" and password "<iMedidata User 1 Password>" and user group "<User Group 1>"
	And I have been invited to study group> "<Study Group>"
	And I have a Rave account as Rave User "<Rave User 1>" with rave username "<Rave User Name 1>" and rave password "< rave password>" and user group "<User Group 1>" with email "<iMedidata User 1 Email>"
	When I login to Rave as the Rave User "<Rave User 1>"
	Then I am on the Rave User hompage
	And I see an invitation to sign up to the global account
	And I take a Screenshot
	
@2012.2.0
@PB2.5.3.2-02
@DRAFT
## IDP user
Scenario: For iMedidata users using federated single sign on, Password Timeout in Rave is not supported.
