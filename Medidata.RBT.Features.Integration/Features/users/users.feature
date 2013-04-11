# Rave sets up a trust relationship with iMedidata via an SSL certificate.  iMedidata includes both the web application server and the Central Authentication Service (CAS) server. The CAS server permits a user to access multiple Medidata applications, like Rave, after providing their credentials only once via iMedidata. In other words CAS centralizes the authentication process, providing the user the ability to access multiple Medidata applications seamlessly. Finally, to communicate with iMedidata, Rave uses Rave Web Services Outbound (RWSO) which serves as an intermediary to facilitate the external connection to iMedidata, which may be outside the trusted network.  Finally, the iMedidata API requires a public-private key handshake prior to any data exchange, and uses a temporary token that authenticates the exchange to prevent any unauthorized access.  
# When an externally authenticated user successfully logs in iMedidata, the system will display all the studies the user has access to. From iMedidata the user will be able to access a specific Study within Rave.
# Rave will check if the request has originated from iMedidata and will do the following:
# 1)	Get the iMedidata username and email address
# 2)	If the user’s iMedidata account is not yet connected to a Rave account, prompt the user to connect the account
# 3)	Authenticate the iMedidata user
# 4)	If the user has multiple roles in Rave, prompt the user for which role to use in that Rave session
# Internally authenticated users will be able to use Forgot Password feature on Rave from the Rave Login page. Externally authenticated users should use the Forgot Password feature on iMedidata. User information of an externally authenticated user resides on iMedidata. 
# For clarity purposes, accessing Rave ‘for the first time’ means that a new Rave session is created from the single-sign-on iMedidata session.  A ‘connected’ user account refers to an account in Rave that is externally authenticated from an iMedidata user account.  An ‘unconnected’ account refers to a normal Rave account that uses only Rave for authentication.
# The Rave data fields that have been added due to this integration are Authenticator, External User Name and Last External Update Date. These fields will be referenced later in this document.
# - Authenticator field displays “Internal” or “iMedidata” as non-editable value. The default value is “Internal” indicating that the Rave user is an internally authenticated user.
# - External User Name field displays the user’s iMedidata User Name as a non-editable value.
# - Last External Update Date field displays localized date and time, when the information on iMedidata was last fetched by Rave and displayed as a non-editable value.

Feature: Rave Integration for Users
    In order to create and update Users in Rave
    As a User xx
    I want to have my User accounts created and synchronized between Rave and iMedidata
	
	Background:
	Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>" and user id "User ID>"
		|User						|PIN						| Password							|User ID						|Email 							|
		|{iMedidata User 1}			|iMedidata User 1 PIN}		|{iMedidata User 1 Password}		|{iMedidata User 1 ID}			|{iMedidata User 1 Email}		|
		|{iMedidata User 2}			|iMedidata User 2 PIN}		|{iMedidata User 2 Password}		|{iMedidata User 2 ID}			|{iMedidata User 2 Email}		|
		|{iMedidata User 3}			|iMedidata User 3 PIN}		|{iMedidata User 3 Password}		|{iMedidata User 3 ID}			|{iMedidata User 3 Email}		|
		|{iMedidata User 4}			|iMedidata User 4 PIN}		|{iMedidata User 4 Password}		|{iMedidata User 4 ID}			|{iMedidata User 4 Email}		|
		|{New User}					|{New User PIN}				|{New User Password}				|{New User ID}					|{New User Email}				|
	And there exists a Rave user "<Rave User>" with username "<Rave User Name>" and password "<Rave Password>"
		|Rave User		|Rave User Name		|Rave Password		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|
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
	And there exists subject <Subject> with eCRF page "<eCRF Page>" in Site <Site>
		|Site		|Subject		|eCRF Page		|
		|{Site A1}	|{Subject 1}	|{eCRF Page 1}	|	
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
		|{Rave URL 2}	|{rave564conlabtesting2.mdsol.com	|
		|{Rave URL 3}	|{rave564conlabtesting3.mdsol.com	|
		|{Rave URL 4}	|{rave564conlabtesting4.mdsol.com	|

@Rave 564 Patch 13
@PB2.7.5.13-10
@Validation
Scenario: When a user is created and accepts invitation to a study or study group in iMedidata , then the user account is created in Rave automatically and linked to iMedidata.  All this does is create the account, and provide an assignment
   
    Given there is User "<New User>" with a valid email account
	And I am an iMedidata user with User name "<iMedidata user 1 ID>"
	And I am the owner to <Entity>
	And I invite user "<New User>" to <Entity> for  Modules app "<Modules App>" with role "<Modules Role 1>" and EDC App "<EDC App>" with role "<EDC Role 1>"
	And I login to email account for user "<New User>"
	And I select invitation from iMedidata user
	And I select link from email to activate account
	And I activate iMedidata account for user "<New User>"
	And I log in to iMedidata as user "<New User>"
	And I see the invitation for <Entity>
	And I accept the invitation
	And I log out
	And I log in as "<iMedidata User 1 ID>"
	And I navigate to Rave by following "<EDC App>" for <Entity>
	And I navigate to User Adminstration
	And I search for User "<New User>" with Authenticator "iMedidata"
	And I should see "<New User>" in search results
	And I navigate to user details for "<New User>"
	And I should see source :iMedidata
	And I should see assignment to the <Result>
	And I take a screenshot

|Entity                | Result|
|Study                 | Study |
|Study Group           | Studies in the Study Group|

	
@Rave 564 Patch 13
@PB2.7.5.13-11
@Validation
@BUG
Scenario: When a user accepts invitation to a Study or Study Group in iMedidata and the message has not been prosessed yet to Rave,
          the user will see the following message "Your user account is in the process of being updated. Please Go Back to iMedidata
		  and try again." when trying to navigate to Rave.
	
    Given there is iMedidata User "<New User>" with a valid email account
	And I am an iMedidata user with User name "<iMedidata user 1 ID>"
	And I am the owner to the Study <Entity>
	And I invite user "<New User>" to Study <Entity> for  Modules app "<Modules App>" with role "<Modules Role 1>" and EDC App "<EDC App>" with role "<EDC Role 1>"
	And I login to email account for iMedidata user "<New User>"
	And I select invitation from iMedidata user
	And I select link from email to activate account
	And I activate iMedidata account for user "<New User>"
	And I log in to iMedidata as user "<New User>"
	And I see the invitation for Study <Entity>
	And I accept the invitation
	And the message has not be processed yet
	When I follow "<EDC App>" for <Entity>
	Then I should see message "Your user account is in the process of being updated. Please Go Back to iMedidata and try again."
	And I should see "Go Back" button
	And I take a screenshot


@Rave 564 Patch 13
@PB2.7.5.13-12
@Validation
@BUG
Scenario: When a user accepts invitation to a Study or Study Group in iMedidata and the message has not been prosessed yet to Rave,
             the user will see the following message "Your user account is in the process of being updated. Please Go Back to
			 iMedidata and try again." when trying to navigate to Rave.When clicking on "Go Back"button user should be directed to iMedidata home page
	
    Given there is User "<New User>" with a valid email account
	And I am an iMedidata user with User name "<iMedidata user 1 ID>"
	And I am the owner to <Entity>
	And I invite user "<New User>" to <Entity> for  Modules app "<Modules App>" with role "<Modules Role 1>" and EDC App "<EDC App>" with role "<EDC Role 1>"
	And I login to email account for user "<New User>"
	And I select invitation from iMedidata user
	And I select link from email to activate account
	And I activate iMedidata account for user "<New User>"
	And I log in to iMedidata as user "<New User>"
	And I see the invitation for <Entity>
	And I accept the invitation
	And the message has not be processed yet
	And I follow "<EDC App>" for <Entity>
	And I should see message "Your user account is in the process of being updated. Please Go Back to iMedidata and try again."
	And I should see "Go Back" button
	And I take a screenshot
	When I follow "Go back" button
	Then I should be on iMedidata home page
	And I take a screenshot


@Rave 564 Patch 13
@PB2.7.5.13-13
@Validation
@BUG
Scenario: When a user accepts invitation to a Study or Study Group in iMedidata and the message has not been prosessed yet to Rave,
          the user will see the following message "Your user account is in the process of being updated. Please Go Back to iMedidata and try again."
           when trying to navigate to Rave. When clicking on Refresh button on the browser window , user should remain on the same page.
	
    Given there is User "<New User>" with a valid email account
	And I am an iMedidata user with User name "<iMedidata user 1 ID>"
	And I am the owner to <Entity>
	And I invite user "<New User>" to <Entity> for  Modules app "<Modules App>" with role "<Modules Role 1>" and EDC App "<EDC App>" with role "<EDC Role 1>"
	And I login to email account for user "<New User>"
	And I select invitation from iMedidata user
	And I select link from email to activate account
	And I activate iMedidata account for user "<New User>"
	And I log in to iMedidata as user "<New User>"
	And I see the invitation for <Entity>
	And I accept the invitation
	And the message has not be processed yet
	And I follow "<EDC App>" for <Entity>
	And I should see message "Your user account is in the process of being updated. Please Go Back to iMedidata and try again."
	And I should see "Go Back" button
	And I take a screenshot
	When I click on the Refresh button on the browser 
	Then I should remain on the page
	And I should see the message "Your user account is in the process of being updated. Please Go Back to iMedidata and try again."
	And I take a screenshot


@Rave 564 Patch 13
@PB2.7.5.13-20
@Validation
@BUG
Scenario: When a user is created in iMedidata with EDC roles , one and only one user account is created in Rave automatically for each role.

	Given I am an iMedidata user
	And I am not connected to Rave
	And I am logged in to iMedidata as "<iMedidata User 2 ID>"
	And I have invitation to Study "<Study A>" with app "<EDC App>" Role "<EDC Role 1>" "<EDC Role 2>" "<EDC Role 3>"
	And I have invitation to study "<Study A> with App "<Modules App>" Role "<Modules Role 1>" for app "<Architect Security>" Role "<Security Group 1>"
	And I accept invitation to Study "<Study A>"
	And I follow app "<EDC App>" for Study "<Study A>"
	And I am on Role Selection page
	And I select Role "<EDC Role 1>"
	And I am on Study "<Study A>" home page
	And I navigate to User Adminstration
	When I search for user "<iMedidata User 2 ID>" with Authenticator set to  iMedidata
	Then I should see three results for "<iMedidata User 2 ID>" 
	And I take a screenshot
	And I should see account for Role "<EDC Role 1>" 
	And I should see account for Role "<EDC Role 2>"
	And I should see account for Role "<EDC Role 3>"
	And I navigate to User Details for "<EDC Role 1>" 
	And I should see Study "<Study A>" in Studies Pane with Role "<EDC Role 1>"
	And I take a screenshot
	And I navigate to User Details for "<EDC Role 2>"
	And I should see Study "<Study A>" in Studies Pane with Role "<EDC Role 2>"
	And I take a screenshot
	And I navigate to User Details for "<EDC Role 3>"
	And I should see Study "<Study A>" in Studies Pane with Role "<EDC Role 3>"
    And I take a screenshot

@Rave 564 Patch 13
@PB2.7.5.13-11A
@Validation
Scenario: When a User Account Details modified in iMedidata, that user account is updated in User Details page in Rave automatically with out the iMedidata user accessing Rave.

  	Given I am an existing iMedidata user with username "<iMedidata User 1 ID>"
	And I am  logged in to iMedidata
	And I have an assignment to Study "<Study A>" for app "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" Role "<Modules Role 1>"
	And I follow link "Account Details"
	And I take a screenshot
	And I enter Username "<iMedidata User 1 ID>"
	And I enter Email "<Email>"
	And I enter First Name "FirstName"
	And I enter Middle Name "MiddleName"
	And I enter Last Name "LastName"
	And I enter Title "Title"
	And I enter Department "Department"
	And I enter Address Line 1 "AddressLine1"
	And I enter Address Line 2 "AddressLine2"
	And I enter Address Line 3 "AddressLine3"
	And I enter City "City"
	And I enter Postal Code "Postal Code"
	And I select State "<State>"
	And I select  Country "<Country>"
	And I select Time Zone "<TimeZone>"
	And I select  Locale "<Locale>"
	And I enter Phone "Phone"
	And I enter Mobile Phone "Mobile Phone"
	And I enter Fax "Fax"
	And I enter Pager "Pager"
	And I take a screenshot
	And I follow the link "Home"
	And I follow "<Modules App>" for Study "<Study A>"
	And I am in Rave
	And I follow the the link "User Administration"
	And I navigate to the User Details page for iMedidata user with login "<iMedidata User 1 ID>"
	And I see Login "<iMedidata User 1 ID>"
	And I see Title "Title"
	And I see First Name "First Name"
	And I see Middle Name "Middle Name"
	And I see Last Name "Last Name"
	And I see Email "<Email>"
	And I see Telephone "Phone"
	And I see Facsimile "Fax"
	And I see Institution "Institution"
	And I see Address Line 1 "Address Line 1"
	And I see Address Line 2 "Address Line 2"
	And I see Address Line 3 "Address Line 3"
	And I see City "City"
	And I see State "<State>"
	And I see Postal Code "Postal Code"
	And I see Country "<Country>"
	And I see Mobile Phone "Mobile Phone"
	And I see Pager "Pager"
	And I see dropdown Language "<Locale>"
	And I see text "TimeZone" "<Time Zone>"
	And I take a screenshot
	And I follow link iMedidata
	And I follow link "Account Details"
	And I enter First Name "FirstNamexx"
	And I enter Middle Name "MiddleNamexx"
	And I enter Last Name "LastNamexx"
	And I enter Title "Titlexx"
	And I enter Address Line 1 "AddressLine1xx"
	And I enter Address Line 2 "AddressLine2xx"
	And I enter City "Cityxx"
	And I enter Postal Code "Postal Codexx"
	And I take a screenshot
	And I click "Save"
	And I log out
    And I login as Rave user "<Rave User 1>" with username "<Rave User Name 1>" and password "<Rave Password 1>"
	When I navigate to the User Details page for iMedidata user with login "<iMedidata User 1 ID>"
	Then I should see Login "<iMedidata User 1 ID>"
	And I should see text First Name is "First Namexx"
	And I should see text Middle Name is "Middle Namexx" 
	And I should see text Last Name is "Last Namexx"
	And I should see text Title is "Titlexx"
	And I should see text Institution is "Institution"
	And I should see text Address Line 1 is "Address Line 1xx" 	
	And I should see text Address Line 2 is "Address Line 2xx"
	And I should see text Address Line 3 is "Address Line 3"
	And I should see text City is "Cityxx"
	And I should see text State is "<State" 
	And I should see text Postal Code is "Postal Codexx"
	And I should see text Country is "<Country>"
	And I should see text Email is "Email"	
	And I should see text Phone is "Phone"	
	And I should see text Facsimile is "Fax"
	And I should see text Language is "<Locale>"
	And I should see text "TimeZone" is "<Time Zone>"
	And I should see the Last External Update Date is recent
	And I take a screenshot


@Rave 564 Patch 13
@PB2.7.5.13-11B
@Validation
Scenario: When a user details modified in iMedidata, that user account is updated in My Profile page in Rave automatically.

  	Given I am an existing iMedidata user with username "<iMedidata User 1 ID>"
	And I am  logged in to iMedidata
	And I follow link "Account Details"
	And I take a screenshot
    And I enter Username "<iMedidata User 1 ID>"
	And I enter Email "<Email>"
	And I enter First Name "FirstName"
	And I enter Middle Name "MiddleName"
	And I enter Last Name "LastName"
	And I enter Title "Title"
	And I enter Department "Department"
	And I enter Address Line 1 "AddressLine1"
	And I enter Address Line 2 "AddressLine2"
	And I enter Address Line 3 "AddressLine3"
	And I enter City "City"
	And I enter Postal Code "Postal Code"
	And I select State "<State>"
	And I select  Country "<Country>"
	And I select Time Zone "<TimeZone>"
	And I select  Locale "<Locale>"
	And I enter Phone "Phone"
	And I enter Mobile Phone "Mobile Phone"
	And I enter Fax "Fax"
	And I enter Pager "Pager"
	And I save my changes
	And I note the time changes are saved "<Time 1>"
	And I follow the link "Home"
	And I follow a "<Modules App>" for Study "<Study A>"
	And I am in Rave
	And I follow the the link "My Profile"
	And I should see Username "<iMedidata User 1 ID>"
	And I should see should Email "<Email>"
	And I should see First Name "FirstName"
	And I should see Middle Name "MiddleName"
	And I should see Last Name "LastName"
	And I should see Title "Title"
	And I should  see Institution "Institution"
	And I should see Address Line 1 "AddressLine1"
	And I should see Address Line 2 "AddressLine2"
	And I should see Address Line 3 "AddressLine3"
	And I should see City "City"
	And I should see Postal Code "Postal Code"
	And I should see State "<State>"
	And I should see Country "<Country>"
    And I should see Locale "<Locale>"
	And I should see Phone "Phone"
	And I should see Time Zone "<Time Zone>"
	And I should see Fax "Fax"
	And I verify the Last External Update Time on My Profile page is equals to "<Time 1>"
	And I take a screenshot
   
    
@release2012.2.0
@PB2.7.5.13-12  
@FUTURE
Scenario: When a user is disabled in iMedidata, that user account is deactivated in Rave automatically.

@Rave 564 Patch 13
@PB2.7.5.13-01
@Validation
Scenario Outline: When a user is created or updated in iMedidata, the following User attributes are synchronized between Rave and iMedidata and displayed on the My Profile page.


Examples:
  | iMedidata Field Name          | Rave Field Name                          | 
  | First Name                    | First Name                               | 
  | Last Name                     | Last Name                                | 
  | Email                         | Email                                    | 
  | Locale                        | Locale / Language                        | 
  | Middle Name                   | Middle Name                              | 
  | Institution                   | Institution                              | 
  | Title                         | Title                                    | 
  | Address Line 1                | Address Line 1                           | 
  | Address Line 2                | Address Line 2                           | 
  | Address Line 3                | Address Line 3                           | 
  | City                          | City                                     | 
  | State                         | State                                    | 
  | Postal Code                   | Postal Code                              | 
  | Country                       | Country                                  | 
  | Phone                         | Phone                                    | 
  | Fax                           | Fax                                      | 
  | Time Zone                     | TimeZone                                 | 

	Given I am an existing iMedidata user "<iMedidata User 1>" with username "<iMedidata User 1 ID>"
	And I am  logged in to iMedidata
	And I have an assignment to Study "<Study A>" for app "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" Role "<Modules Role 1>"
	And I invite New User "<iMediata User 2 ID>" to "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>"
	And "<iMediata User 2 ID>" has activated iMedidata Account
	And I log out 
	And I log in as "<iMediata User 2 ID>" in to iMedidata
	And I accept "<Study A>" invitation
	And I follow link "Account Details"
	And I enter Username "<iMedidata User 2 ID>"
	And I enter Email "<Email>"
	And I enter First Name "FirstName"
	And I enter Middle Name "MiddleName"
	And I enter Last Name "LastName"
	And I enter Title "Title"
	And I enter Department "Department"
	And I enter Address Line 1 "AddressLine1"
	And I enter Address Line 2 "AddressLine2"
	And I enter Address Line 3 "AddressLine3"
	And I enter City "City"
	And I enter Postal Code "Postal Code"
	And I select State "<State>"
	And I select  Country "<Country>"
	And I select Time Zone "<TimeZone>"
	And I select  Locale "<Locale>"
	And I enter Phone "Phone"
	And I enter Mobile Phone "Mobile Phone"
	And I enter Fax "Fax"
	And I enter Pager "Pager"
	And I save my changes
	And I follow a "<EDC App>" link for Study "<Study A>"
	And I am in Rave Study "<Study A>" page
	And I follow the the link "My Profile"
	And I should see Username "<iMedidata User 2 ID>"
	And I should see should Email "<Email>"
	And I should see First Name "FirstName"
	And I should see Middle Name "MiddleName"
	And I should see Last Name "LastName"
	And I should see Title "Title"
	And I should  see Institution "Institution"
	And I should see Address Line 1 "AddressLine1"
	And I should see Address Line 2 "AddressLine2"
	And I should see Address Line 3 "AddressLine3"
	And I should see City "City"
	And I should see Postal Code "Postal Code"
	And I should see State "<State>"
	And I should see Country "<Country>"
    And I should see Locale "<Locale>"
	And I should see Phone "Phone"
	And I should see Fax "Fax"
	And I should see "Time Zone" is "<Time Zone>"
	And I take a screenshot
	And I follow link iMedidata
	And I follow link "Account Details"
	And I update First Name "FirstNamexx"
	And I update Middle Name "MiddleNamexx"
	And I update Last Name "LastNamexx"
	And I update Title "Titlexx"
	And I update Address Line 1 "AddressLine1xx"
	And I update Address Line 2 "AddressLine2xx"
	And I update City "Cityxx"
	And I update Locale "Eng"
	And I update time zone "<EST>"
	And I update Country "United States of America"
	And I update state "New Jersey"
	And I update Postal Code "Postal Codexx"
	And I update Fax "2837438"
	And I update Phone "1322"
	And I save my changes
	And I take a screenshot
	And I follow a "<Modules App>" link for Study "<Study A>"
	And I am in Rave Study "<Study A>" page
	When I follow the the link "My Profile"
	Then I should see Username "<iMedidata User 2 ID>"
	And I should see should Email "<Email>"
	And I should see First Name "FirstName"
	And I should see Middle Name "MiddleName"
	And I should see Last Name "LastName"
	And I should see Title "Title"
	And I should  see Institution "Institution"
	And I should see Address Line 1 "AddressLine1"
	And I should see Address Line 2 "AddressLine2"
	And I should see Address Line 3 "AddressLine3"
	And I should see City "City"
	And I should see Postal Code "Postal Code"
	And I should see State "<NJ>"
	And I should see Country "USA"
    And I should see Locale "English"
	And I should see Phone "Phone"
	And I should see Time Zone "<EST>"
	And I should see Fax "Fax"
	And I take a screenshot

@Rave 564 Patch 13
@PB2.7.5.13-02
@Validation
Scenario Outline: When a user is created or updated in iMedidata, the following User attributes are synchronized between Rave and iMedidata and displayed on the User Details page.

	Given I am a new iMedidata user with email "<iMedidata User 1 Email>"
	And I am on Account Activation page in iMedidata
	And I update the following accordingly :
    | iMedidata Field Name          | Value                                    | 
    | First Name                    | "<iMedidata>"                            | 
    | Last Name                     | <User 1>                                 | 
    | Username                      | <iMedidata User 1 ID >                   | 
    | Email                         | <iMedidata User 1 Email>                 | 
    | Locale                        | "<Locale>"                               | 
    | Phone                         | 999                                      | 
    | Time Zone                     | "<Time Zone>"                            |
    | Password                      | "<iMedidata User 1 Password>"            | 
    | Confirm Password              | "<iMedidata User 1 Password>"            |
    And I take a screenshot
	And I select "Activate"
    And I am iMedidata Log in page
    And I log in 
	And I am on 'iMedidata Terms of Use' page
	And I enter correct credentails for User "<iMedidata User 1 ID>" 
	And I am on iMedidata Home page
	And I accept invitation to Study "<Study A>" for app "<EDC App>" with Role "<EDC Role 1>" App "<Modules App>" Role "<Modules Role 1>"
	And I navigate to Rave by accessing "<EDC App>" for Study "<Study A>"
	And I navigate to User Adminstration
	And I search for User "<iMedidata User 1 ID>" with Authenticator "iMedidata"
	And I navigate to User Details page for "<iMedidata User 1 ID>"
	And I verify the following :
    | Rave  Field Name              | Value                                    | 
    | First Name                    | "<iMedidata>"                            | 
    | Last Name                     | "<User 1>"                               | 
    | Username                      | <iMedidata User 1 ID >                   | 
    | Email                         | <iMedidata User 1 Email>                 | 
    | Language                      | "<Locale>"                               | 
    | Phone                         | 999                                      | 
    | Time Zone                     | "<Time Zone>"                            |
	And I take a screenshot
	And I follow link iMedidata
	And I follow link "Account Details"
	And I save the following :
    | iMedidata Field Name          | Value                                    | 
    | First Name                    | "<iMedidata> xx"                         | 
    | Last Name                     | "<User 1>yy"                             | 
    | Middle Name                   | "<Middle Name>"                          | 
    | Institution                   | "<Institute>"                            | 
    | Title                         | "<Title>"                                | 
    | Address Line 1                | "<Address Line 1>"                       | 
    | Address Line 2                | "<Address Line 2>"                       | 
    | Address Line 3                | "<Address Line 3>"                       | 
    | City                          | "<City>"                                 | 
    | State                         | "<State>"                                | 
    | Postal Code                   | "<10001>"                                | 
    | Country                       | "<Country>"                              | 
    | Phone                         | "<329348>"                               | 
    | Fax                           | "<928439>"                               | 
    | Pager                         | "<392849>"                               | 
    | Mobile Phone                  | "<932849>"                               | 
    | Time Zone                     | "<Time Zone>"                            | 
	| Locale                        | "<Locale >"                              | 
	And I take a screenshot
	And I follow "<EDC App>" for Study "<Study A>" 
	And I navigate to User Adminstration
	When I navigate to User Details for "<iMedidata User 1 ID>"
	Then I should see the following : 
    | Rave  Field Name              | value                                    |
    | First Name                    | "<iMedidata> xx"                         | 
    | Last Name                     | "<User 1>yy"                             | 
    | Middle Name                   | "<Middle Name>"                          | 
    | Institution                   | "<Institute>"                            | 
    | Title                         | "<Title>"                                | 
    | Address Line 1                | "<Address Line 1>"                       | 
    | Address Line 2                | "<Address Line 2>"                       | 
    | Address Line 3                | "<Address Line 3>"                       | 
    | City                          | "<City>"                                 | 
    | State                         | "<State>"                                | 
    | Postal Code                   | "<10001>"                                | 
    | Country                       | "<Country>"                              | 
    | Telephone                     | "<329348>"                               | 
    | Facsimile                     | "<928439>"                               | 
    | Pager                         | "<392849>"                               | 
    | Mobile Phone                  | "<932849>"                               | 
    | Time Zone                     | "<Time Zone>"                            | 
	| Language                      | "<Locale>"                               | 
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.5.1-01
@Validation
Scenario Outline: If the user is an iMedidata user, then the fields on User Information section in My Profile page will be non-editable, and the edit link will not appear.

	Given I am an existing iMedidata user "<iMedidata User 1>" with username "<iMedidata User 1 ID>"
	And I am logged in to iMedidata
	And I have an assignment to Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>"
	And I follow app "<EDC App>" link for "<Study A>"
	And I am on Rave Study "<Study A>" page
	When I follow link "My Profile"
	Then I should see the following fields are uneditable
    |First Name  |Middle Name  |Last Name  |Title  |Institution |Address Line 1 | Address Line 2 | Address Line 3 |City |State  |Postal Code |Country |Email |Phone |Fax |Locale |
	And dropdown "Time Zone" is disabled
	And I should not see link "Edit" in User Information pane
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.5.1-02
@Validation
Scenario Outline: If the user is an iMedidata user, then the following fields on the User Details page will be non-editable.
 
  |Field Name                     | 
  | First Name                    | 
  | Last Name                     | 
  | Login                         | 
  | Email                         |
  | Language                      | 
  | Middle Name                   | 
  | Institution                   | 
  | Title                         | 
  | Salutation                    |
  | Address Line 1                | 
  | Address Line 2                | 
  | Address Line 3                | 
  | City                          | 
  | State                         | 
  | Postal Code                   | 
  | Country                       | 
  | Telephone                     | 
  | Facsimile                     | 
  | Pager                         | 
  | Mobile Phone                  | 
  | PIN                           |
  | TimeZone                      | 
  | UserGroup                     |
  | URL                           |

	Given I am an existing iMedidata user with username "<iMedidata User 1 ID>"
	And I am  logged in to iMedidata
	And I have an assignment to Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>", for app "<Modules App>" with Role "<Modules Role 1>"
	And I follow a "<EDC App>" link for Study "<study A>"
	And I am in Rave
	And I follow the the link "User Administration"
	When I navigate to the User Details page for iMedidata user with login "<iMedidata User 1 ID>"
	Then I should see the following fields are not editable:
    |Login|Title|First Name|Middle Name| Last Name| Email| telePhone |PIN|URL| User Group|Salutation| Facsimile|Institution| Address Line 1 |Address Line 2 |Address Line 3| City|State  |Postal Code|Mobile Phone |Country|Pager|Locale |TimeZone|Language|
	And I take a screenshot
	


@Rave 564 Patch 13
@PB2.4.1.1-01
@Validation
Scenario: For an iMedidata user, Rave displays “iMedidata” as the Authenticator on the My Profile page and the User Details page. Rave will display iMedidata User Name on the My Profile page and User Details page.

	Given I am an existing iMedidata user with username "<iMedidata User 1 ID>"
	And I have an assignment to Study "<Study A>" for App "<EDC App>" with role "<EDC Role 1>"
	And I have an assignment to study "<Study A>" for App "<Modules App>" with Role "<Modules Role 1>"
	And I follow the app link  "<Modules App>" for Study "<Study A>"
	And I am on Rave Study "<Study A>" page
	When I follow the the link "My Profile"
	Then I should see "<iMedidata User 1 ID>" as iMedidata User Name on My Profile page
	And I should see Authenticator:iMedidata
	And I take a screenshot
	And I navigate to User Details page for user "<iMedidata User 1 ID>" in User Adminstration
	And I should see "<iMedidata User 1 ID>" as iMedidata User Name on User Details page
	And I should see Authenticator:iMedidata
	And I take a screenshot
	
	
@Rave 564 Patch 13
@PB2.4.1.2-01
@Validation
Scenario: Rave displays a Last External Update Date field indicating when information was last updated on iMedidata. This field will appear on User Details and My Profile pages. For example My Profile page on Rave will display Last External Update Date as the date when user information of externally authenticated user was last updated on iMedidata. Important: This date is the actual iMedidata update date, not the date when the data was received by Rave.

	Given I am an existing iMedidata user with username "<iMedidata User 1 ID>"
	And I am logged in to iMedidata
	And I have assignment to Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>" for App "<Modules App>" with Role "<Modules Role 1>"
	And I follow the link "Account Details"
	And I enter <Data> in the <Fields>
	|Data			|Field					|
	|Zeus			|Middle Name			|
	|New Town		|City					|
	And I save the changes
	And I note the Time changes are saved "<Time 1>"
	And I take a screenshot
	And I follow a Modules App link for "<Study A>"
	And I am in Rave
	When I follow link "My Profile"
	Then I should note value "<Time 2>" of "Last External Update Date"
	And I take a screenshot
	And I follow the the link "User Administration"
	And I navigate to User Details page for "<iMedidata User 1 ID>"
	And I note value "<Time 3>" of "Last External Update Date"
	And I take a screenshot
	And I verify that "<Time 1>" equals "<Time 2>" equals "<Time 3>"
	
@Rave 564 Patch 13
@PB2.4.1.3-02
@Validation
Scenario: When a user accesses Rave using an external account, Rave will correctly set the current timezone to correctly match the user's timezone preference in iMedidata.

	Given I am an existing iMedidata user with username "<iMedidata User 1 ID>"
	And I am assigned to timezone "<TimeZone1>"
	And I have an assignment to Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>"
	And I have an assignment to Study "<Study A>" for App "<Modules app>" with Role "<Modules Role 1>"
	And I follow the app link "<Modules App>" for Study "<Study A>"
	And I am on Rave Study "<Study A>" page
	And I follow the the link "My Profile"
	And the user profile for that user is displayed
	And I should see timezone "<TimeZone1>"
	And I take a screenshot
	And I follow the the link "User Administration"
	And I navigate to the User Details page for iMedidata user "<iMedidata User 1 ID>"
	And I should see timezone "<TimeZone1>"
	And I take a screenshot
	And I select link "iMedidata"
	And I am on iMedidata homepage
	And I navigate to Account details page
	And I change timezone to "<TimeZone2>"
	And I follow the app link "<Modules App>" for Study "<Study A>"
	And the Rave Study Home page is displayed
	When I follow the the link "My Profile"
	Then I should see timezone is set to "<TimeZone2>"
	And I take a screenshot
	And I follow the the link "User Administration"
	And I navigate to the User Details page for iMedidata user "<iMedidata User 1 ID>"
	And I should see timezone is set to "<TimeZone2>"
	And I take a screenshot

	
@Rave 564 Patch 13
@PB2.4.1.3-03
@Validation
Scenario: When a user accesses Rave using an external account, Rave will correctly set the current locale / language to correctly match the user's language preference in iMedidata.
	
	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am assigned to local "<JPN>"
	And I select a link "<Modules App>" for Study "<Study A>"
	And I am in Rave "<Study A>" page
	And I should see Kanji Characters
	When I follow the link "My Profile"
	Then I should see in the User Information pane the locale is set to "<JPN>"
	And I take a screenshot
	And I navigate to the User Details page for login "<iMedidata User 1 ID>"
	And I see the Language is set to "<JPN>"
	And I take a screenshot	
	And I select link "iMedidata"
	And I am redirected to iMedidata
	And I follow link "Account Details"
	And I change local to "<Eng>"
	And I select a link a link "<Modules App>" for Study "<Study A>"
	And I am in Rave "<Study A>" page
	And I follow the link "My Profile"
	And I should see locale "Eng"
	And I take a screenshot
	And I navigate to the User Details page for login "<iMedidata User 1 ID>"
	And I should see Language is set to "Eng"
	And I take a screenshot
	
@Rave 564 Patch 13
@PB2.4.1.3-04
@Validation
Scenario: When a user accesses Rave using an external account, Rave will correctly set the current locale / language to correctly match the
          user's language preference in iMedidata, except in the case where the locale / language does not exist in the Rave URL.
		  In this case, the user will have the default Locale on Rave as specified on Advance Configuration page.

	Given I am a Rave user "<Rave User 1>" with username "<Rave User Name 1>" and password "<Rave Password 1>"
	And I follow link "Configuration"
	And I follow link "Other Settings"
	And I follow link "Advanced Configuration"
	And I select "Yes" on warning page
	And I set Default Locale to "English"
	And I select save
	And I log out
	And I login in to iMedidata as user with username "<iMedidata User 1 ID>"
	And I am assigned to locale "<Locale4>"
	And I have an assignment to Study "<Study A>" with app "<EDC App>" for Role "<EDC Role 1>"
	And I have an assignment to Study "<Study A>" with App "<Modules App>" for Role "<Modules Role 1>"
	And I select Modules "<Modules app>" for Study "<Study A>"
	And I am on Rave Study "<Study A>" home page
	And the locale is "English" and not locale "<Locale 4>"
	When I navigate to My Profile page 
	Then I should see Locale is set to English
	And I take a screenshot

	
@2012.1.0
@PB2.4.1.3-05
@Draft
Scenario: When a user accesses Rave using an external account, Rave will correctly set the current locale / language
          to correctly match the user's language preference in iMedidata, except in the case where the locale / language
		   has been overridden in the Rave user record. In this case, the user's locale is automatically defaulted to the
		   one set in the local user record in Rave.


@Rave 564 Patch 13
@PB2.5.5.2-01
@Validation
Scenario: If the user is not an iMedidata user, then Rave will display the Change Password link on My Profile page, allowing the user to change the password on Rave.
	
	Given I am a Rave user "<Rave User 1>" with username "<Rave User Name 1>" and password "<Rave Password 1>"
	And I login to Rave as Rave user "<Rave User 1>"
	And I follow "My Profile" link
	When I am on My Profile page
	Then I should see "Change Password" link
	And I take a screenshot
	And I follow the link "Change Password"
	And the page "Change Password" is displayed
	And I should see text box "Old Password"
	And I should see text box "New Password"
	And I should see text box "Confirm Password"
	And I should see button "Save Password And Continue"
	And I change password "<Rave Password 1>" to password "<Rave Password 1>XX"
	And I should see text "Password Changed"
	And I should see link "Click here to continue..."
	And I take a screenshot
	And I follow link "Click here to continue..."
	And the user home page is displayed

@Rave 564 Patch 13
@PB2.5.5.2-02
@Validation
Scenario: If the user is an iMedidata user, then Rave will not display the Change Password link on My Profile page.
	
	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I have an assignment to Study "<Study A>" for app  "<EDC App>" with role "<EDC Role 1>" for App "<Modules App>" with role "<Modules Role 1>"
	And I follow the app link "<EDC App>" for "<Study A>"
	And the study homepage for study "<Study A>" is displayed
	When I follow the the link "My Profile"
	Then the user profile for that user is displayed
	And I should not see the link "Change Password"
	And I take a screenshot
	
@Rave 564 Patch 13
@PB2.5.1.28-01
@Validation
Scenario: If an iMedidata user clicks on “iMedidata” link in Rave, then the user is redirected to iMedidata. 

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I have an assignment to Study "<Study A>" for app  "<EDC App>" with role "<EDC Role 1>" for App "<Modules App>" with role "<Modules Role 1>"
	And I follow the app link "<EDC App>" for "<Study A>"
	And the study homepage for study "<Study A>" is displayed
	And link "iMedidata" is available
	When I follow link "iMedidata"
	Then I should be on iMedidata home page
	And I take a screenshot
	
	
@Rave 564 Patch 13
@PB2.5.6.1-01
@Validation
Scenario: Rave will enable the user to select an Authenticator on User Administration page. By default, Internal is selected.

	Given I am a Rave user "<Rave User 1>" with username "<Rave User Name 1>" and password "<Rave Password 1>" with access to User Adminstration
	And I login to Rave as Rave user "<Rave User 1>"
	When I select link "User Administration"
	Then I should see the "Users" Page
	And I should see the dropdown "Authenticator" defaulted to "Internal"
	And I verify selection list for dropdown "Authenticator" has choice "iMedidata"
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.6.2-01
@Validation
Scenario: If the user selects “iMedidata” as the Authenticator and clicks on the Search button, then Rave will display all the users that are externally authenticated to iMedidata with the relevant role in the Role column. 
	
	Given I am a Rave user "<Rave User 1>" with username "<Rave User Name 1>" and password "<Rave Password 1>" with access to User Adminstration
	And I login to Rave as Rave user "<Rave User 1>"
	And I select link "User Administration"
	And I should see the "Users" Page
	And I should see the dropdown "Authenticator" defaulted to "Internal"
	And I select "iMedidata"  from the dropdown "Authenticator" 
	When I follow the link "Search"
	Then I should see the search results displayed
	And I should see Role column is displayed
	And I navigate to User Details page for any User in search results
	And I should see Authenticator is set to iMedidata
	And I take a screenshot
	
@Rave 564 Patch 13
@PB2.5.6.3-01
@Validation
Scenario: If the user selects “Internal” as the Authenticator and clicks on the Search button, then Rave will display all the users that are internally authenticated. 

	Given I am a Rave user "<Rave User 1>" with username "<Rave User Name 1>" and password "<Rave Password 1>"
	And I login to Rave as Rave user "<Rave User 1>"
	And I should see the user homepage
	And I select link "User Administration"
	And I should see the "Users" Page
	And I should see the dropdown "Authenticator" defaulted to "Internal"
	And I select "Internal"  from the dropdown "Authenticator" 
	When I follow the link "Search"
	Then I see the search results displayed
	And I navigate to User details page for a user in search results
	And I should see  Authenticator "Internal"
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.7.1-01
@Validation
Scenario Outline: If the user is an iMedidata user, then the following attributes are editable or non-editable on the User Details page. 

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I have an assignment to Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>" for App "<Modules App>" with Role "<Modules Role 1>"
	And I follow "<EDC App>" for Study "<Study A>"
	And I am in Rave
	And I follow link "Home"
	And I follow link "User Administration
	And I enter in Log in textbox,"<iMedidata User 1 ID>"
	And I select fron Authenticator dropdown, "iMedidata"
	And I select link "Search"
	And I should see iMedidata user "<iMedidata User 1 ID>" in the search results
	When I click details icon for Log In "<iMedidata User 1 ID>"
	Then the User Details page is displayed.
	And textbox "Credentials" is editable
	And checkbox "Account Activation" is not editable 
	And checkbox "Restrict Prod Access " is not editable 
	And checkbox "Is Clinical User" is not editable
	And checkbox "Sponsor Approval" is editable
	And checkbox "Investigator" is editable
	And textbox "Investigator Number" is editable
	And textbox "DEA Number" is editable
	And textbox "Network Mask" is editable
	And I take a screenshot
	
Examples:
	| Attribute                	| Editable        | 
	| Credentials              	| yes             | 
	| Account Activation       	| no              | 
	| Restrict Prod Access     	| no              | 
	| Is Clinical User         	| no              | 
	| Sponsor Approval         	| yes 	          | 
	| Investigator       		| yes 	          | 
	| Investigator Number       | yes  		      | 	 
	| DEA Number       			| yes	          |   
	| Network Mask       		| yes  	    	  |
		

@Rave 564 Patch 13
@PB2.5.7.2-02
@Validation
Scenario: On the User Details page, an iMedidata user may NOT removed from a study if the study is controlled from  iMedidata
	
	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I have an assignment to Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>" for App "<Modules App>" with Role "<Modules Role 1>"
	And I follow "<EDC App>" for Study "<Study A>"
	And I am in Rave
	And I follow link "Home"
	And I follow link "User Administration
	And I enter in Log in textbox,"<iMedidata User 1 ID>"
	And I select fron Authenticator dropdown, "iMedidata"
	And I select link "Search"
	And I should see iMedidata user "<iMedidata User 1 ID>" in the search results
	And I navigate to User Details page for "<iMedidata User 1 ID>"
	When I follow "Remove" for study "<Study A>" in Studies pane
	Then I should see its not editable
	And I should see "<Study A>" in Studies Pane
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.7.3-01
@Validation
Scenario: On the User Details page, an iMedidata authenticated user can be assigned to or removed from the Site Monitor project.

	Given I am an iMedidata user with username "<iMedidata User 4 ID>"
	And I am  assigned study "<Study D>" with site "<Site D1>" that has subject "<Subject 1>" with role"<EDC Role CRA create sub cannot view all sites}>"
	And I log out of iMedidata
	And I log in as Rave User "<Rave User 1>" with username "<Rave User Name 1>" and password "<Rave Password 1>"
	And I follow link "<User Administration>"
	And I search for iMedidata user "<iMedidata User 4 ID>"
	And I click details icon for iMedidata user "<iMedidata User 4 ID>"
	And I select link "Assign to Study"
	And I select from User Role Dropdown role "<EDC Role RM Monitor>"
	And I select from User Study Dropdown study "Site Monitor"
	And I select from User Environment Dropdown environment "Prod"
	And I select link "Assign User"
	And I follow sites details icon for study "Site Monitor"
	And I check "Select All"
	And I select link "Update"
	And I take a screenshot
	And I log out of Rave
	And I login to iMedidata as iMedidata user "<iMedidata User 4 ID>" with password "<iMedidata User 4 Password>"
	And I select app link "<EDC App>" with role "<EDC Role CRA create sub cannot view all sites>" fpr study "<Study D>"
	And I am in Rave
	And I should see text "Monitor Tool Kit"
	And I should see link "<Study D>"
	And I should see link "Monitor Visits"
	And I take a screenshot
	And I create a subject "< Subject 2>"
	And I select link "iMedidata"
	And I log out of iMedidata
	And I log in as Rave User "<Rave User 1>" with username "<Rave User Name 1>" and password "<Rave Password 1>"
	And I follow link "<User Administration>"
	And I search for iMedidata user "<iMedidata User 4 ID>"
	And I click details icon for iMedidata user "<iMedidata User 4 ID>"
	And remove study "Site Monitor"
	And I take a screenshot
	And i log out of Rave
	And I login to iMedidata as iMedidata user "<iMedidata User 4 ID>" with password "<iMedidata User 4 Password>"
	When I select app link "<EDC App>" with role "<EDC Role CRA create sub cannot view all sites>" fpr study "<Study D>"
	Then I am in Rave
	And I should not see text "Monitor Tool Kit"
	And I should see link "<Study D>"
	And I should not see link "Monitor Visits"
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.7.4-01
@Validation
Scenario: On the User Details page, an iMedidata user cannot be assigned to a Rave or an iMedidata Study.

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And there exists a Rave User "<Rave User Name 1>" not connected to iMedidata
	And I have an assignment to Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>", Modules App "<Modules App>" with Role "<Modules Role 1>"
	And I follow link "<Modules App>" for Study "<Study A>"
	And I am in Rave
	And I follow link "Home"
	And I follow link "User Administration"
	When I navigate to User Details page for User "<iMedidata User 1 ID>"
	Then I should not see "Assign to Study" Link
	And I take a screenshot
	And I navigate to User Adminstration
	And I search for "Internal" Users
	And I navigate to User Details page for a Rave User "<Rave User Name 1>"
	And I should see "Assign to Study" Link
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.7.4-02
@Validation
Scenario: On the User Details page, an iMedidata user cannot be assigned to a Security Group in Other Modules Section.

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And there exists a Rave User "<Rave User Name 1>" not connected to iMedidata
	And I have an assignment to Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>", Modules App "<Modules App>" with Role "<Modules Role 1>"
	And I follow link "<Modules App>" for Study "<Study A>"
	And I am in Rave
	And I follow link "Home"
	And I follow link "User Administration"
	When I navigate to User Details page for User "<iMedidata User 1 ID>"
	Then I should not see "Assign to Security Group" Link
	And I take a screenshot
	And I navigate to User Adminstration
	And I search for "Internal" Users
	And I navigate to User Details page for a Rave User "<Rave User Name 1>"
	And I should see "Assign to Security Group" Link
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.7.4-03
@Validation
Scenario: On the User Details page, an iMedidata user cannot be removed from Architect Security Group in Other Modules Section.

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And there exists a Rave User "<Rave User Name 1>" not connected to iMedidata
	And the "<Rave User Name 1>" is assigned to "<Security Group 2>"
	And I have an assignment to Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>", Modules App "<Modules App>" with Role "<Modules Role 1>" "<Security App>" with Role "<Security Group 1>"
	And I follow link "<Modules App>" for Study "<Study A>"
	And I am in Rave
	And I follow link "Home"
	And I follow link "User Administration"
	When I navigate to User Details page for User "<iMedidata User 1 ID>"
	And I should see "<Security Group 1>" displayed in Other Modules section
	And I click "Remove"
	Then I should see "<Security Group 1>" still displays
	And I take a screenshot
	And I navigate to User Adminstration
	And I search for "Internal" Users
	And I navigate to User Details page for a Rave User "<Rave User Name 1>"
	And I should see "<Security Group 2>" in Other Modules section
	And I click on Remove
	And I should see "<Security Group 2>" not displayed in Other Modules Section
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.7.5-01
@Validation
Scenario: On the User Details page, a Rave user may be assigned an iMedidata study

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I create a production study "<Study B>" in study group "<Study Group>"
	And I follow link "<Modules App>" with role "<Modules Role 1>"
	And I am in Rave
	And I follow link "Home"
	And I follow link "User Administration"
	And I enter in Log in textbox,"<Rave User Name 1>"
	And I select fron Authenticator dropdown, "Internal"
	And I select link "Search"
	And I should see Rave user "<Rave User Name 1>" in the search results
	And I click details icon for Log In "<Rave User Name 1>"
	And the User Details page is displayed
	And I follow "Assign to Study"
	And in 'Select Role" dropdown select role "<EDC Role 1>"
	And in "Assign User to Study" dropdown select study "<Study B>"
	When I select link "Assign User"
	Then I should see study "<Study B>" added to the list of assigned studies.
	And I take a screenshot

	
@Rave 564 Patch 13
@PB2.5.7.5-02
@Validation
Scenario: A Study that is linked to iMedidata, the following fields will be uneditable on Study page and Environment Set up page in Rave:
|Study Name|Enrollment Target|Description|Linked to iMedidata check box|Environment|


	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I have an assignment to Study "<Study A>" for App "<EDC App>" with Role "<EDC Role 1>", Modules App "<Modules App>" with Role "<Modules Role 1>"
	And I follow link "<Modules App>" for Study "<Study A>"
	And I am in Rave
	And I Architect 
	When I follow "<Study A>"
	Then I should see the following uneditable on "<Study A>" page
    |Study Name|Description|
	And I take a screenshot
	And I navigate to Environment Set up page
    And I should see the following uneditable
    |Enrollment Target|Linked to iMedidata check box|Environment|
	And I take a screenshot

@Rave 564 Patch 13
@PB2.5.7.5-03
@Validation
Scenario: When a user is removed from a Study Group and re invited to a study with EDC App only, then the user should be able to navigate to Rave and account should be created appropriately in Rave.

Given I am iMedidata user "<iMedidata User 1 ID>"
And I am logged in 
And I have assignment to a Study Group "<Study Group>" for App "<EDC App>" with Role "<EDC Role 1>" for App "<Modules App>" with Role "<Modules Role 1>" as Study Group owner
And Study "<Study A>", "<Study B>", "<Study C>" are assigned to "<Study Group>"
And I navigate to Rave by following "<EDC App>" for Study Group "<Study Group>"
And I am on Rave Home page
And I should see "<Study A>", "<Study B>", "<Study C>" 
And I navigate to User Adminstration
And I navigate to User Details page for "<iMedidata User 1 ID>"
And I should see "<EDC Role 1>" assigned to the user
And I should "<Study A>", "<Study B>", "<Study C>" assigned to the suer in the Studies Pane
And I navigate to iMedidata
And my assignment to "<Study Group>" is removed
And I have a new invitation to "<Study A>" for "<EDC App>" with Role "<EDC Role 1>" 
And I accept the invitation
When I follow "<EDC App>" for "<Study A>" 
Then I should be in Rave "<Study A>" page
And I take a screenshot
And I Log out
And I log in to Rave as "<Rave User Name 1>" with access to User Adminstration
And I navigate to User Details page for User "<iMedidata User 1 ID>"
And I should see "<EDC Role 1>" assigned to the user
And I should see "<Study A>" assigned to the user
And I should not see "<Study B>" , "<Study C>"
And I take a screenshot
