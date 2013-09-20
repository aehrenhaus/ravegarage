# Deeplinking capability is supported, allowing a URL deep link for iMedidata authenticated users to a study, site, subject, eCRF page, site administration and reports modules.

Feature: Deep Linking
    In order to access exactly where I want to go in Rave
	As a User
	I need to be able to deep link into studies, sites, eCRFs, and other locations in Rave
	  
  	Background:

	Given I am an iMedidata user with first name "<Fname>" and last name "<Lname>" with pin "<PIN>" password "<Password>" and user id "<User ID/Name>"
	|Fname								|Lname								|PIN						| Password							|User ID/Name						|Email 							|
	|{First Name 1}						|{Last Name 1}						|iMedidata User 1 PIN}		|{iMedidata User 1 Password}		|{iMedidata User 1 ID}			|{iMedidata User 1 Email}		|
	|{New User ID}					|{New User Email}				|
	And there exists a Rave user "<Rave User>" with username <Rave User Name>" and password "<Rave Password>" with "<Email>" and "<Rave First Name>" and "<Rave Last "Nane>"
		|Rave User		|Rave User Name		|Rave Password		|Email			|Rave First Name 	|Rave Last Name 	|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|Rave First Name 1	|Rave Last Name 1	|
	And there exists study "<Study>" in study group "<Study Group>"
		|Study		|Study Group 	|
		|{Study A}	|{Study Group} 	|
	And there exists Rave study "<Rave Study>" 
		|{Rave Study 1}	|
	And there exists app "<App>" associated with study 
		|{Edc App}		|
		|{Modules App}	|
		|{Security App}	|
	And there exists site "<Site>" in study "<Study>", 		
		|Study		|Site		|
		|{Study A}	|{Site A1}	|
	And there exists subject <Subject> with eCRF page <eCRF Page>" in Site <Site>
		|Site		|Subject		|eCRF Page		|
		|{Site A1}	|{Subject 1}	|{eCRF Page 1}	|
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role												        |
		|{Edc App}		|{EDC Role 1}										        |
		|{Edc App}		|{EDC Role 2}										        |
		|{Edc App}		|{EDC Role 3 that does not allow see subject entry data}	|
		|{Edc App}		|{EDC Role 4 CRA cannot view all sites}	                    |
		|{Edc App}		|{EDC Role 5 CRS cannot view subjects with any status}      |
		|{Modules App}	|{Modules Role 1}									        |
		|{Modules App}	|{Modules Role 2 No Reports}						        |
		|{Modules App}	|{Modules Role 3 No Sites}							        |
		|{Security App}	|{Security Role 1}									        |		
	And there exist <Rave URL> with <URL Name>
		|Rave URL		|URL Name							|
		|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
		|{Rave URL 2}	|{rave564conlabtesting2.mdsol.com	|
		|{Rave URL 3}	|{rave564conlabtesting3.mdsol.com	|
		|{Rave URL 4}	|{rave564conlabtesting4.mdsol.com	|
	

@Rave 564 Patch 13
@PB2.5.1.74-80
@Validation
Scenario : If an iMedidata user with single role in one or more EDC studies subsequently accesses Rave,
then the user will be taken to the page in Rave as specified in the URL.  (Deep linking support)

Examples:
  | Deep Link Type                      | Deep Link URL                                                  | Rave Target Page            | 
  | StudySite Link                      | studies/12412/yyy.zzz                                          | StudySite page              | 
  | Subject Link                        | studies/12412/yyy.zzz                                          | Subject page                | 
  | eCRF Link                           | studies/12412/yyy.zzz                                          | Subject eCRF page           | 
  | Reports Link                        | studies/12412/yyy.zzz                                          | Reports page                | 	

	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I am connected to Rave
    And there is an iMedidata Study named "<Study A>"
    And there is a Rave Study named "<Study A>"
	And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site>
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I have access to the "Rave Modules" App through iMedidata
	And I am assigned to the Audit Trail Report
	And I have StudySite ID recorded
	And I have Subject ID recorded
	And I have  CRF DP recorded
	And I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>
	When I press Enter 
	Then I am on the Rave specified <StudySite> page
	And I take a screenshot
	And I navigate back to iMedidata
	And I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SubjectPage.aspx&ID=(previously recorded Subject ID)> 
	And I press Enter 
	And I am on the Rave specified <Subject> page
	And I take a screenshot
	And I navigate back to iMedidata
	And I pass the  URL < https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=CRFPage.aspx&DP=(Previously recorded CRF DP)>
	And I press Enter
	And I am on the Rave specified Subject eCRF page
	And I take a screenshot 
	And I navigate back to iMedidata
	And I pass the  URL  <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=ReportsPage.aspx>
	And I press Enter 
	And I am on the Rave specified Reports page
	And I take a screenshot
	And I navigate back to iMedidata
	And I pass the  URL   <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=Sites.aspx>
	And I press Enter 
	And I am on the Rave specified Site Administration page
	And I take a screenshot 
	
@Rave 2013.2.0
@PB2.5.1.74-81
@Validation
Scenario : If an iMedidata user with single role and with restrictions to see subject data, subsequently accesses Rave,then the user will be taken to the page in Rave as specified in the URL, but not see restricted subject data because of the restrictions.(Deep linking support)
				  
    Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I am connected to Rave
    And there is an iMedidata Study named "<Study A>"
    And there is a Rave Study named "<Study A>"
	And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site> for Study "<Study A>"
	And there is a form that has restriced subject data
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role not see subject data "<EDC Role 3>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I take a screenshot
	And I have access to the "Rave Modules" App through iMedidata
	And I have  CRF DP recorded
	And I Log out
	When I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=CRFPage.aspx&ID=(previously recorded CRFPage ID)> 
	And I press Enter
	Then I am on iMedidata Login page
	And I entered correct iMedidata user credentials
	When I press Enter
	Then I am on the Rave specified <CRF Form> home page
	And restricted subject data is not visible
	And I take a screenshot
	
@Rave 564 Patch 13
@PB2.5.1.74-82
@Validation

Scenario: If an iMedidata user with single role subsequently accesses Rave,but with iMedidata incorrect credentials,then the user
           will not be taken to the page in Rave as specified in the URL.(Deep linking support)
	Given I am an iMedidata User
    And I am not logged in
	And I am on iMedidata Sign In page
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I am connected to Rave
    And there is an iMedidata Study named "<Study A>"
    And there is a Rave Study named "<Study A>"
	And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site>
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I have access to the "Rave Modules" App through iMedidata
	And I have StudySite ID recorded
	And I have Subject ID recorded
	And I have  CRF DP recorded
	And I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>
	When I press Enter 
	Then I am not on the Rave specified <StudySite> page
	And I am on iMedidata Login page
    And I take a screenshot
	And I entered incorrect credentials 
	And I press Enter 
	And I am not on the Rave specified page
	And I see the message "You tried to log in with a username and password that is not recognized. To continue, type the correct username or password. Otherwise, click I forgot my username or password on the Login page to reset your username."
	And I take a screenshot 
	And I entered correct iMedidata user credentials
	And I press Enter
	And I am on the Rave specified <StudySite> page
	And I take a screenshot 
	And I navigate back to iMedidata
	And I am logged out of iMedidata
	And I am on iMedidata Sign In page
    And I pass the  URL <And I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SubjectPage.aspx&ID=(previously recorded Subject ID)> 
	And I press Enter 
	And I am not on the Rave specified <Subject> page
	And I am on iMedidata Login page
	And I take a screenshot
	And I entered incorrect credentials 
	And I press Enter 
	And I am not on the Rave specified page
	And I see the message "You tried to log in with a username and password that is not recognized. To continue, type the correct username or password. Otherwise, click I forgot my username or password on the Login page to reset your username."
	And I take a screenshot 
	And I entered correct iMedidata user credentials
	And I press Enter
	And I am on the Rave specified <Subject> page
	And I take a screenshot
	
	
@Rave 2013.2.0.1
@PB2.5.1.74-83
@Validation
Scenario : If an iMedidata user with single role and with restrictions to access All Modules (No Reports),subsequently accesses Rave, 
                  then the user will not be taken to the page in Rave as specified in the URL, because of the restrictions.(Deep linking support)
				  
				  
	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I am connected to Rave
    And there is an iMedidata Study named "<Study A>"
    And there is a Rave Study named "<Study A>"
	And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 2 No Reports>"
	And I have access to the "Rave Modules" App through iMedidata
	And I am log out
	When I pass the  URL  <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=ReportsPage.aspx>
	And I press Enter
	Then I am on iMedidata Login page
	And I entered correct iMedidata user credentials
	When I press Enter
	Then I am not on the Rave specified Reports page
	And I see an error message
	And I take a screenshot

	
	
	
@Rave 564 Patch 13
@PB2.5.1.74-84
@Validation
Scenario Outline: If an iMedidata user with single role and with restrictions to access all sites,subsequently accesses Rave, 
                  then the user will not be taken to the page in Rave as specified in the URL, because of the restrictions.(Deep linking support)
				  		  
				  
	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I am connected to Rave
    And there is an iMedidata Study named "<Study A>"
    And there is a Rave Study named "<Study A>"
	And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site>
	And there is a form that has saved subject data
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<{Modules Role 3 No Sites}>"
	And I have access to the "Rave Modules" App through iMedidata
	And I pass the  URL  "<url>"
	When I press Enter 
	Then I see an error message
	And I take a screenshot


	Example:

	| iMedidata Role |iMedidta Module Role           |iMedidata Condition         |Expected Result| URL  |

1.	| "<EDC Role 1>" |"<{Modules Role 3 No Sites}>"  |assigned Site               |Error           |<https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=Sites.aspx>|
2.  | "<EDC Role 4>" |"<{Modules Role 1}>"           |unassigned Site             |Error           |<https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>|



@Release_2013.3.0
@PB2.5.1.74-85
@IZ18.SEP.2013
@BUG_MCC-79931
Scenario : 2.5.1.74-85 An error message will be displayed if an iMedidata user attempts to navigate to an eCRF page that
                  has been restricted via deep linking (Deep linking support)


	Given I am an Rave defuser
	And I logged in 
	And I create new Project "<Study A>"
	And I create new site <Site A1> assigned to "<Study A>"
	And I create new draft <Draft 1>
	And I create restriction for a <Form 1> for "<EDC Role 2>" in Draft <Draft 1>
	And I take a screenshot
	And I publish and pushing
	And I naviagte to the "<Study A>"
	And I create a subject "<Subject 1>" with entered and saved data in restricted form "<eCRF Page 1>"
	And I take a screenshot
	And I logged out 
	And there is iMedidata user with username "<iMedidata User 1 ID>"
	And I am logged in iMedidata as "<iMedidata User 1 ID>"
	And there is iMedidata "<Study A>"
	And Rave "<Study A>" has linked to iMedidata "<Study A>"
	And I have assigment to study "<Study A>" app link "<EDC App>" with role "<EDC Role 2>"
	And I take a screenshot
	And I have assigment to site <Site A1>
	And I log out of iMedidata	as "<iMedidata User 1 ID>"
	When I enter "https://"<Rave URL 1>"/MedidataRAVE/SelectRole.aspx?page=CRFPage.aspx&DP=<CRF DP>
	And I take a screenshot
	And I press Enter
	Then I see iMedidata Login page
	And I take a screenshot
	When I enter "<iMedidata User 1 ID>" credentials
	Then I see an error message
	And I take a screenshot


@Release_2013.3.0
@PB2.5.1.74-86
@IZ18.SEP.2013
@Validation 
Scenario : 2.5.1.74-86  An error message will be displayed if an iMedidata user with single role attempts to navigate to subject that has been
                  inactivated via deep linking (Deep linking support)

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am logged in 
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And study "<Study A>"has app link "<Modules App>" with role "<Modules Role 1>" to Rave Url "<Rave URL 1>"
	And I follow the app link "<EDC App>" 
	And I am on the StudySite home page for study "<Study A>" and site "<Site A1>".
	And I select subject "<Subject 1>"
	And I note value "<Subject Number>"
	And I select link "Home"
	And I select link "Site Administration
	And I select site "<Site 1A>"
	And I inactivate subject "<Subject 1>"
	And I take a screenshot
	And I follow link "iMedidata"
	And I log out of iMedidata
	When I enter <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SubjectPage.aspx&ID=(previously recorded Subject ID)>
	And I take a screenshot
	And I press Enter 
	Then I am on iMedidata Login page
	And I take a screenshot
	When I enter iMedidata user "<iMedidata User 1 ID>" correct credentials
	Then I see an error message
	And I take a screenshot

@Release_2013.3.0
@PB2.5.1.74-04A
@IZ18.SEP.2013
@Validation 
Scenario : 2.5.1.74-04A  An error message will be displayed if an iMedidata user  with single role attempts to navigate to studySite to which is not
                  assigned via deep linking (Deep linking support)

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And I follow the app link "<EDC App>" 
	And I am on the StudySite home page for study "<Study A>" and site "<Site A1>".
	And I note value "<StudySite Number>"
	And I take a screenshot
	And I am navigate back to iMedidata
	And I log out of iMedidata
	And there is iMedidata user "<iMedidata User 2>"
	And iMedidata user "<iMedidata User 2>" is logged in to iMedidata
	And iMedidata user "<iMedidata User 2>" am  not assigned to study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>"
	And iMedidata user "<iMedidata User 2>" is assigned to study "<Study B> with site "<Site B1>"
	And I take a screenshot
	And iMedidata user "<iMedidata User 2>" is logged out of iMedidata
	When I enter in the URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>
	Then I am on iMedidata Login page
	And I take a screenshot
	When I enter iMedidata user "<iMedidata User 2 ID>" correct credentials
	Then I see an error message
	And I take a screenshot



	
@Release_2013.3.0
@PB2.5.1.74-88
@IZ18.SEP.2013
@Validation 
Scenario : 2.5.1.74-88 An iMedidata user with single role can go directly to the My Reports page in the Reports module if access to the Reports module is granted.
	
	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am logged in
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And study "<Study A>"has app link "<Modules App>" with role "<Modules Role 1>" to Rave Url "<Rave URL 1>"
	And I take a screenshot 
	And I log out from iMedidata
	When I enter in the URL Address Text Field <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=ReportsPage.aspx>
	And I take a screenshot 
	And I press Enter 
	And I am on iMedidata Login page
	When I enter iMedidata user "<iMedidata User 1 ID>" correct credentials
	Then I am on the "My Reports " page
	And I take a screenshot 


	
@Release_2013.3.0
@PB2.5.1.74-89
@IZ18.SEP.2013
@Validation 
Scenario : 2.5.1.74-89 An iMedidata user will see an error message if the user attemps to navigate to the "My Reports "page
                        in the "Reporter" module via deep linking if the user does not have access to the Reporter module.

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am logged in
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And study "<Study A>"has app link "<Modules App>" with role "<Modules Role 2 No Reports>" to Rave Url "<Rave URL 1>"
	And I take a screenshot
	And I log out from iMedidata	
	When I enter in the URL Address Text Field <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=ReportsPage.aspx>
	And I take a screenshot 
	And I press Enter 
	And I am on iMedidata Login page
	When I enter iMedidata user "<iMedidata User 1 ID>" correct credentials
	Then I see an error message
	And I take a screenshot	
	
@Release_2013.3.0
@PB2.5.1.74-90
@IZ18.SEP.2013
@Validation 
Scenario : 2.5.1.74-90 An iMedidata user with single role can go directly to the Site Administration Page if access is granted 
	
	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And study "<Study A>"has app link "<Modules App>" with role "<Modules Role 1>" to Rave Url "<Rave URL 1>"
	And I take a screenshot
	And I log out from iMedidata		
	When I pass the  URL   <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=Sites.aspx>
	And I take a screenshot 
	And I press Enter 
	Then I am on iMedidata Login page
	And I take a screenshot
	When I enter iMedidata user "<iMedidata User 1 ID>" correct credentials
	Then I am in the "Site Administration" page
	And I take a screenshot
	
@Release_2013.3.0
@PB2.5.1.74-91
@IZ18.SEP.2013
@Validation 
Scenario : 2.5.1.74-91 An iMedidata user will see an error message if the user attemps to navigate to the "Site Administration page  via deep linking
                       if the user does not have access to the Site Administration module.

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am logged in
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And study "<Study A>"has app link "<Modules App>" with role "<Modules Role 2 No Sites>" to Rave Url "<Rave URL 1>"
	And I take a screenshot		
	And I log out from iMedidata		
	When I pass the  URL   <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=Sites.aspx>
	And I take a screenshot 
	And I press Enter 
	Then I am on iMedidata Login page
	And I take a screenshot
	When I enter iMedidata user "<iMedidata User 1 ID>" correct credentials
	Then I see an error message
	And I take a screenshot
	
	
	
	
	

@Release_2013.3.0
@PB2.5.1.74-92
@IZ18.SEP.2013
@Validation 
Scenario : 2.5.1.74-92 If an iMedidata user, with single role and invited to the URL, subsequently accesses Rave by deeplinking SelectRole URL, then the user will be taken to the Rave
           (Deep linking support)
				  		  

	
	Given I am an iMedidata User
    And I am not logged in iMedidata
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
	And there is an iMedidata Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I have access to the "Rave Modules" App through iMedidata
    When I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx>
	And I take a screenshot 1 of 3
	And I press Enter 
	Then I am not on Role Selection page
	And I am on iMedidata Login page
	And I take a screenshot 2 of 3
	And I enter iMedidata user's correct credentials
	And I login 
	And I am on Rave Study Home page
	And I take a screenshot 3 of 3


@Release_2013.3.0
@PB2.5.1.74-93
@IZ18.SEP.2013
@Validation 
Scenario : 2.5.1.74-93 If an iMedidata user, with multiple roles and invited to the URL, subsequently accesses Rave by deeplinking SelectRole URL, then the user will be taken to the Selection Role
           (Deep linking support)
				  		  

	
	Given I am an iMedidata User
    And I am not logged in in iMedidata
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
	And there is an iMedidata Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role "<EDC Role 1>" and "<EDC Role 2>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I have access to the "Rave Modules" App through iMedidata
    When I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx>
	And I take a screenshot 1 of 3
	And I press Enter 
	And I am on iMedidata Login page
	And I take a screenshot 2 of 3
	And I enter iMedidata user's correct credentials
	And I select login button
	Then I am on Role Selection page
	And I take a screenshot 3 of 3




	
@Release_2013.3.0
@PB2.5.1.74-94
@IZ18.SEP.2013
@Validation 
Scenario :2.5.1.74-94 If an iMedidata user, with multiple roles and invited to the multiple URL, subsequently accesses Rave by deeplinking SelectRole URL,
            then the user will be taken to the Selection Role page and then to Rave Home page (Deep linking support)
				  		  

	
	Given I am an iMedidata User
    And I am not logged in in iMedidata
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
	And there is an iMedidata Studies named "<Study A>" and "<Study B>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role "<EDC Role 1>" and "<EDC Role 2>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I have access to the "Rave Modules" App through iMedidata
	And I have an assignment to the iMedidata Study named "<Study B>" for the App link named "<Edc App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study B>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I have access to the "Rave Modules" App through iMedidata
    When I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx>
	And I take a screenshot 1 of 9
	And I press Enter 
	And I am on iMedidata Login page
	And I take a screenshot 2 of 9
	And I enter iMedidata user's correct credentials
	And I select login button
	Then I am on Role Selection page
	And I take a screenshot 3 of 9
	And I select Role  "<EDC Role 1>" 
	And press button Continue
	And I am on Rave Home page
	And I should see the two assigned studies  "<Study A>" and "<Study B>" listed
	And I take a screenshot 4 of 9
	And I navigate back to iMedidata
	and I logout
	And I take a screenshot 5 of 9
	And I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx>
	And I take a screenshot 6 of 9
	And I press Enter 
	And I am on iMedidata Login page
	And I take a screenshot 7 of 9
	And I enter iMedidata user's correct credentials
	And I select login button
	And I am on Role Selection page
	And I take a screenshot 8 of 9
	And I select Role  "<EDC Role 2>" 
	And press button Continue
	And I am on Rave "<Study B>" Home page
	And I take a screenshot 9 of 9


@Release_2013.3.0
@PB2.5.1.74-95
@IZ18.SEP.2013
@Validation 
Scenario :2.5.1.74-95 If an iMedidata user, with multiple roles and invited to the URL but not accepted the invitation and subsequently accesses Rave
           by deeplinking SelectRole URL, then the user will be taken to the iMedidata Home page
           (Deep linking support)
				  		  

	
	Given I am an iMedidata User
	And there is an iMedidata Study Group
	And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
	And I have an assignment to the iMedidata Study Group for the App link named "<Edc App>" with Role "<EDC Role 1>" and "<EDC Role 2>"
	And I have an assignment to the iMedidata Study Group for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I have access to the "Rave Modules" App through iMedidata
	And I have not accepted the invitation
	And I take a screenshot 1 of 5
	And I am not logged in in iMedidata
    When I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx>
	And I take a screenshot 2 of 5
	And I press Enter 
	Then I am on iMedidata Login page
	And I take a screenshot 3 of 5
	When I enter iMedidata user's correct credentials
	And I select login button
	Then I am on iMedidata Home page
	And I see the Study Group invitation on invitation section
	And I take a screenshot 4 of 5
	And I accept the invitation
	And I am on am on iMedidata Home page
	And I take a screenshot 5 of 5




@Release_2013.3.0
@PB2.5.1.74-96
@IZ18.SEP.2013
@Validation 
Scenario : 2.5.1.74-96 If an iMedidata user with multiple role in EDC study subsequently accesses Rave,
             then the user will be asking to select a role and then will be taken to the page in Rave as specified in the URL(Deep linking support)

	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I am connected to Rave
    And there is an iMedidata Study named "<Study A>"
    And there is a Rave Study named "<Study A>"
	And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site>
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role "<EDC Role 1>" and "<EDC Role 2>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I have access to the "Rave Modules" App through iMedidata
	And I am assigned to the Audit Trail Report
	And I have StudySite ID recorded
	And I have Subject ID recorded
	And I have  CRF DP recorded

	And I am log out 
	When I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>
	And I press Enter
	Then I am on iMedidata Login page
	When I enter iMedidata user's correct credentials
	And press Enter
	Then I am on Role Selection page
	And I take a screenshot 1 of 10
	And I select the role "<EDC Role 1>"
	And I am on the Rave specified <StudySite> page
	And I take a screenshot 2 of 10
	And I navigate back to iMedidata
	And I am log out

	When I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SubjectPage.aspx&ID=(previously recorded Subject ID)> 
	And I press Enter
	Then I am on iMedidata Login page
	When I enter iMedidata user's correct credentials
	And press Enter
	Then I am on Role Selection page
	And I take a screenshot 3 of 10
	And I select the role "<EDC Role 1>"
	And I am on the Rave specified <Subject> page
	And I take a screenshot 4 of 10
	And I navigate back to iMedidata
	And I am log out

	When I pass the  URL < https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=CRFPage.aspx&DP=(Previously recorded CRF DP)>
	And I press Enter
	Then I am on iMedidata Login page
	When I enter iMedidata user's correct credentials
	And press Enter
	Then I am on Role Selection page
	And I take a screenshot 5 of 10
	And I select the role "<EDC Role 1>"
	And I am on the Rave specified Subject eCRF page
	And I take a screenshot  6 of 10
	And I navigate back to iMedidata
	And I am log out

	When I pass the  URL  <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=ReportsPage.aspx>
	And I press Enter
	Then I am on iMedidata Login page
	When I enter iMedidata user's correct credentials
	And press Enter
	Then I am on Role Selection page
	And I take a screenshot 7 of 10
	And I select the role "<EDC Role 1>"
	And I am on the Rave specified Reports page
	And I take a screenshot 8 of 10
	And I navigate back to iMedidata

	When I pass the  URL   <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=Sites.aspx>
	Then I am on iMedidata Login page
	When I enter iMedidata user's correct credentials
	And press Enter
	Then I am on Role Selection page
	And I take a screenshot 9 of 10
	And I select the role "<EDC Role 1>"
	And I am on the Rave specified Site Administration page
	And I take a screenshot  10 of 10


@Release_2013.3.0
@PB2.5.1.74-97
@IZ18.SEP.2013
@Validation 
Scenario : 2.5.1.74-97 An error message will be displayed if an iMedidata user with multple roles attempts to navigate to subject that has been
                  inactivated via deep linking (Deep linking support)

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with roles "<EDC Role 1>" and "<EDC Role 2>" to Rave Url "<Rave URL 1>"
	And study "<Study A>"has app link "<Modules App>" with role "<Modules Role 1>" to Rave Url "<Rave URL 1>"
	And I follow the app link "<EDC App>" 
	And I am on the StudySite home page for study "<Study A>" and site "<Site A1>".
	And I select subject "<Subject 1>"
	And I note value "<Subject Number>"
	And I follow link "iMedidata"
	And I log out of iMedidata
	And I login in Rave as Rave defuser
	And I select link "Home"
	And I select link "Site Administration
	And I select site "<Site 1A>"
	And I inactivate subject "<Subject 1>"
	And I take a screenshot
	And  I logout as Rave user
	When I enter in the URL Address Text Field "https://"<Rave URL 1>"/MedidataRAVE/HandleLink.aspx?page=SubjectPage.aspx&ID="<Subject Number>""
	And I press Enter
	Then I am on iMedidata Login page
	When I enter iMedidata user's correct credentials
	And press Enter
	Then I am on Role Selection page
	And I take a screenshot 
	And I select the role "<EDC Role 1>"
	And I see an error message
	And I take a screenshot


@Release_2013.3.0
@PB2.5.1.74-98
@IZ18.SEP.2013
@Validation 
Scenario : 2.5.1.74-98 If an iMedidata user with multple role and with restrictions to access All Modules (No Reports),subsequently accesses Rave, 
                  then the user will not be taken to the page in Rave as specified in the URL, because of the restrictions.(Deep linking support)
				  
				  
	Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I am connected to Rave
    And there is an iMedidata Study named "<Study A>"
    And there is a Rave Study named "<Study A>"
	And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role "<EDC Role 1>" and Role "<EDC Role 2>" 
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 2 No Reports>"
	And I take a screenshot
	And I am log out
	When I pass the  URL  <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=ReportsPage.aspx>
	And I take a screenshot
	And I press Enter
	Then I am on iMedidata Login page
	And I take a screenshot
	When I entered correct "<iMedidata User 1 ID>" credentials
	And I press Enter
	Then I am on Role Selection page
	And I take a screenshot
	When I select Role "<EDC Role 2>"
	Then I am not on the Rave specified Reports page
	And I see an error message
	And I take a screenshot