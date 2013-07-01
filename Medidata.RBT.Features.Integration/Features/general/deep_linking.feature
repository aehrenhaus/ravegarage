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
Scenario : If an iMedidata user with single role and with restrictions to see subject data, subsequently accesses Rave,then the user will not be taken to the page in Rave as specified in the URL, because of the restrictions.(Deep linking support)
				  
    Given I am an iMedidata User
    And I am logged in
    And my Name is "<First Name 1>" "<Last Name 1>"
	And my username is "<iMedidata User 1 ID>"
    And my Email is "<iMedidata User 1 Email>"
    And I am connected to Rave
    And there is an iMedidata Study named "<Study A>"
    And there is a Rave Study named "<Study A>"
	And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site> for Study "<Study A>"
	And there is a form that has saved subject data
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role not see subject data "<EDC Role 3>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 1>"
	And I take a screenshot
	And I have access to the "Rave Modules" App through iMedidata
	And I have Subject ID recorded
	And I have  CRF DP recorded
	And I pass the  URL <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=CRFPage.aspx&ID=(previously recorded CRFPage ID)> 
	When I press Enter 
	Then I am on the Rave specified <CRF Form> home page
	And subject data is not visible from the page 
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
	
	
@Rave 564 Patch 13
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
	And there exists subject <Subject 1> with eCRF page <eCRF Page>" in Site <Site>
	And there is a form that has saved subject data
    And the iMedidata Study named "<Study A>" is linked to the Rave Study named "<Study A>"
    And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Edc App>" with Role "<EDC Role 1>"
	And I have an assignment to the iMedidata Study named "<Study A>" for the App link named "<Modules App>" with Role "<Modules Role 2 No Reports>"
	And I have access to the "Rave Modules" App through iMedidata
	And I pass the  URL  <https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=ReportsPage.aspx>
	When I press Enter 
	Then I am not on the Rave specified Reports page
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
	Then I see Error
	And I take a screenshot


	Example:

	| iMedidata Role |iMedidta Module Role           |iMedidata Condition         |Expected Result| URL  |

1.	| "<EDC Role 1>" |"<{Modules Role 3 No Sites}>"  |assigned Site               |Error           |<https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=Sites.aspx>|
2.  | "<EDC Role 4>" |"<{Modules Role 1}>"           |unassigned Site             |Error           |<https://<Rave URL> /MedidataRAVE/SelectRole.aspx?page=SitePage.aspx&ID=(Previously recorded StudySite ID)>|



@Rave 564 Patch 13
@PB2.5.1.74-85
@Validation
Scenario: An error message will be displayed if an iMedidata user attempts to navigate to an eCRF page that
                  has been inactivated via deep linking (Deep linking support)


	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And I follow the app link "<EDC App>" 
	And I am on the StudySite home page for study "<Study A>" and site "<Site A1>".
	And I select subject "<Subject 1>"
	And I select eCRF Page "<eCRF Page 1>"
	And the eCRF page "<eCRF Page 1>" is inactivated
	And I take a screenshot
	And I note value "<eCRF Page Number>"
	And I follow link "iMedidata"
	And I log out of iMedidata
	and I log in to iMedidata as iMedidata user "<iMedidata User 2>"
	And I am  assigned only study "<Study A>" 
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And I take a screenshot		
	When I enter in the URL Address Text Field "https://"<Rave URL 1>"/MedidataRAVE/HandleLink.aspx?page="<eCRF Page Number>""
	Then I see an "error Message"
	And I take a screenshot



@Rave 564 Patch 13
@PB2.5.1.74-86
@Validation
Scenario : An error message will be displayed if an iMedidata user attempts to navigate to subject that has been
                  inactivated via deep linking (Deep linking support)

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
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
	and I log in to iMedidata as iMedidata user "<iMedidata User 2>"
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And I take a screenshot		
	When I enter in the URL Address Text Field "https://"<Rave URL 1>"/MedidataRAVE/HandleLink.aspx?page=SubjectPage.aspx&ID="<Subject Number>""
	Then I see an "error Message"
	And I take a screenshot


@Rave 564 Patch 13
@PB2.5.1.74-04A
@Validation
Scenario : An error message will be displayed if an iMedidata user attempts to navigate to studySite to which is not
                  assigned via deep linking (Deep linking support)

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And I follow the app link "<EDC App>" 
	And I am on the StudySite home page for study "<Study A>" and site "<Site A1>".
	And I note value "<StudySite Number>"
	And I log out of iMedidata
	and I log in to iMedidata as iMedidata user "<iMedidata User 2>"
	And I am  not assigned to study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>"
	And I am assigned to study "<Study B> with site "<Site B1>"
	And I take a screenshot		
	When I enter in the URL Address Text Field "https://"<Rave URL 1>"/MedidataRAVE/HandleLink.aspx?page=SitePage.aspx&ID="<StudySite Number>""
	Then I see an "error Message"
	And I take a screenshot

	
@Rave 564 Patch 13
@PB2.5.1.74-88
@Validation
Scenario : An iMedidata user can go directly to the My Reports page in the Reports module if access to the Reports module is granted.
	
	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And study "<Study A>"has app link "<Modules App>" with role "<Modules Role 1>" to Rave Url "<Rave URL 1>"
	And I take a screenshot
	When I enter in the URL Address Text Field "https://<Rave URL 1>/MedidataRAVE/HandleLink.aspx?page=ReportsPage.aspx"
	Then I am on the "My Reports " page
	And I take a screenshot
	
@Rave 564 Patch 13
@PB2.5.1.74-89
@Validation 
Scenario : An iMedidata user will see an error message if the user attemps to navigate to the "My Reports "page in the "Reporter" module via deep linking if the user does not have access to the Reporter module.

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And study "<Study A>"has app link "<Modules App>" with role "<Modules Role 2 No Reports>" to Rave Url "<Rave URL 1>"
	And I take a screenshot		
	When I enter in the URL Address Text Field "https://<Rave URL 1>/MedidataRAVE/HandleLink.aspx?page=ReportsPage.aspx"
	Then I see an error message
	And I take a screenshot	
	
@Rave 564 Patch 13
@PB2.5.1.74-90
@Validation
Scenario: An iMedidata user can go directly to the Site Administration Page if access is granted 
	
	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And study "<Study A>"has app link "<Modules App>" with role "<Modules Role 1>" to Rave Url "<Rave URL 1>"
	And I take a screenshot		
	When I enter in the URL Address Text Field "https://<Rave URL 1>/MedidataRAVE/HandleLink.aspx?page=Sites.aspx"
	Then I am in the "Site Administration module"
	And I take a screenshot
	
@Rave 564 Patch 13
@PB2.5.1.74-91
@Validation 
Scenario : An iMedidata user will see an error message if the user attemps to navigate to the "Site Administration page  via deep linking if the user does not have access to the Site Administration module.

	Given I am an iMedidata user with username "<iMedidata User 1 ID>"
	And I am  assigned only study "<Study A>" with site "<Site A1>" that has subject "<Subject 1>" with ecrf page "<eCRF Page 1>"
	And study "<Study A>"has app link "<EDC App>" with role "<EDC Role 1>" to Rave Url "<Rave URL 1>"
	And study "<Study A>"has app link "<Modules App>" with role "<Modules Role 2 No Sites>" to Rave Url "<Rave URL 1>"
	And I take a screenshot		
	When I enter in the URL Address Text Field "https://<Rave URL 1>/MedidataRAVE/HandleLink.aspx?page=Sites.aspx"
	Then I see an error message
	And I take a screenshot		