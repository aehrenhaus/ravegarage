# iMedidata managed studies allow users to create new sites for a study. This action must trigger a response in Rave to create the same site and asscoicate it to the Study so that users can view the site when entering Rave from iMedidata.
# When study on Rave is linked to a study on iMedidata then the study sites are pulled from iMedidata to Rave for that study. Rave will display “iMedidata” as a Source on the Site page if the site is created on iMedidata and pulled in Rave.
# Using the existing notification framework, iMedidata can post a notification to SNS that contains the create event along with the study assignment in a way that Rave can consume by subscribing to an SNS topic. Rave will receive a json notification from SNS with instructions that will define the create event. The json message that Rave consumes will also have auditable information in the form of a unique transaction id, the study id, study UUID, user id, user uuid, site name, site UUID, creation timestamp, username (for the user that initiated the event) and other auditable information.
# There must be some information captured in a log that will help identify successfully transmitted messages and which can be used to troubleshoot message failures.

Feature: Rave Integration for Sites
    In order to create and use sites in Rave
    As a User
    I want to have my sites created and synchronized between Rave and iMedidata
	
Background:
    Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>" and user id "<User ID>"
		|User						|PIN						| Password							|User ID						|Email 							|
		|{iMedidata User 1}			|iMedidata User 1 PIN}		|{iMedidata User 1 Password}		|{iMedidata User 1 ID}			|{iMedidata User 1 Email}		|
	And there exists a Rave user "<Rave User>" with username "<Rave User Name>" and password "<Rave Password>"
		|Rave User		|Rave User Name		|Rave Password		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|
	    |{Rave User 2}	|{Rave User Name 2}	|{Rave Password 2}	|
	And there exists study "<Study>" in study group "<Study Group>"
		|Study		|Study Group 	|
		|{Study A}	|{Study Group} 	| 
		|{Study B}	|{Study Group} 	| 
		|{Study C}	|{Study Group} 	| 
		|{Study D}	|{Study Group} 	| 
		|{Study E}	|{Study Group} 	| 
	And there exists Rave study "<Rave Study>" 
		|{Study A}	|
        |{Study B}	|
		|{Study C}	|
		|{Study D}	|
    And there exists site "<Site>" in study "<Study>", with site number "<Site Number>" and Syudy-Site number "<StudySiteNumber>"	in iMedidata	
	|Study		|Site		|Site Number		|StudySiteNumber		|
	|{Study A}	|{Site A1}	|{Site Number A1}	|{StudySiteNumber A1}	|
	|{Study B}	|{Site B1}	|{Site Number B1}	|{StudySiteNumber B1}	|
	|{Study B}	|{Site B2}	|{Site Number B2}	|{StudySiteNumber B2}	|
	|{Study B}	|{Site B3}	|{Site Number B3}	|{StudySiteNumber B3}	|
	|{Study B}	|{Site B4}	|{Site Number B4}	|{StudySiteNumber B4}	|
	And there exists User Group " <All Modules>" , "<iMedidata EDC>", "<EDC>"
	And there exists app "<App>" associated with study in iMedidata
		|App			|
		|{Edc App}		|
		|{Modules App}	|
		|{Security App}	|
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role												|
		|{Edc App}		|{EDC Role 1}										|
		|{Edc App}		|{EDC Role 2}										|
		|{Edc App}		|{EDC Role Data Manager}						    |
		|{Edc App}		|{EDC Role CRA create sub cannot view all sites}	|
		|{Edc App}		|{EDC Role RM Monitor}								|
		|{Modules App}	|{Modules Role 1}									|
		|{Modules App}	|{Modules Role 2 No Reports}						|
		|{Modules App}	|{Modules Role 3 No Sites}	
		|{Modules App}  |{Modules Role 4 All Sites}                         |
		|{Security App}	|{Security Role 1}									|		
	And there exist "<Rave URL>" with "<URL Name>"
		|Rave URL		|URL Name							|
		|{Rave URL 1}	|{rave564conlabtesting1.mdsol.com	|
		
	Note: SQL query to get UUID based on Site Number: Select SiteActive,ExternalID,UUID from dbo.Sites Where SiteNUmber =""

@Rave 2013.2.0
@PB2.5.9.42-01
@Validation
Scenario: If I create a site in iMedidata, when Rave receives the site it will create a new site and link it to the iMedidata site 
          if no matching site exists in Rave.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave
    And there is an iMedidata Study  "<Study A>"
	And there is a Rave Study  "<Study A>"
	And I am the owner of the Study "<Study A>" in iMedidata
    And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Edc App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
	And I create a Site "<Site A1>" with Study Site Number "<StudySiteNumber A1>" Site Number "<SiteNumber A1>" for Study "<Study A>" in iMedidata
	And the Site "<Site A1>" with Site Number "<SiteNumber A1>" doesnt exist in Rave
	And I click on Assign Sites for User "<iMedidata user 1 ID>"
	And I assign Site "<Site A1>" to the User
	And I take a screenshot
	When I follow "<Modules App>" for Study "<Study A>"
	Then I should be on "<Site A1>" for Study "<Study A>" page
	And I take a screenshot
	And I navigate to Site Adminstration
	And I navigate to Site Details page for Site "<Site A1>"
	And I should see Source is "iMedidata"
	And I take a screenshot

@Rave 2013.2.0.
@PB2.5.9.42-02
@Validation
Scenario: If I update a site in iMedidata, when Rave receives the site it will create a new site and link it to the iMedidata site
           if no matching site exists in Rave

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave
    And there is an iMedidata Study  "<Study A>"
	And there is a Rave Study  "<Study A>"
	And I am the owner of the Study "<Study A>" in iMedidata
    And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Edc App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
	And the Site "<Site A1>" with Site Number "<SiteNumber A1>" doesnt exist in Rave
	And I create a Site "<Site A1>" with Study Site Number "<StudySiteNumber>" Site Number "<SiteNumber>" for Study "<Study A>" in iMedidata
	And I am owner of the Site "<Site A1>"
	And I navigate to Manage Site page for Site "<Site A1>"
	And I update Site "<Site A1>" with the following information:
	|iMedidata Attribute     |Value						|
	|Address Line 1          |<Address Line 1>			|
	|City                    |<City>					|
	|Country                 |United Stated of America	|
	|Postal Code             |<Postal Code>				|
	And I take a screenshot
	And I follow "<EDC App>" for Study "<Study A>"
	And I am on Site "<Site A1> for Study "<Study A>" page
	And I navigate to Site Adminstration
    When I navigate to Site Details page for Site "<Site A1>"
	Then I should see the following information updated
	|Rave Field Name         |Value				|
	|Address Line 1          |<Address Line 1>	|
	|City                    |<City>		    |
	|Country                 |USA				|
	|Postal Code             |<Postal Code>	    |
	And I should see Source "iMedidata"
	And I take a Screenshot


@Rave 2013.2.0.
@PB2.5.9.27-01
@Validation
Scenario: If I create a site in iMedidata, and an unlinked site in Rave (that is not linked to the iMedidata site),
           when Rave receives the site it will link it to the iMedidata site, matching it based on UUID first.

	Given I am an Rave User with username "<iMedidata User 1 ID>"
	And  there is a Rave Study "<Study A>"
	And there is a Rave Site Name "<Site A1>" and Site Number <Site Number Rave>
	And "<Site A1>" is assigned to the Rave Study "<Study A>"
	And I take a screenshot
	And I run query to get Rave Site UUID value
	And I take a screenshot
	And there is a iMedidata user with username "<iMedidata User 1 ID>"
	And my iMedidata User email address is "<iMedidata User 1 Email>"
	And there is an iMedidata Study named "<Study A>"
	And there is a iMedidata "<Site A1>" and Site Number <Site Number Rave>
	And I take a screenshot
	When I run query to get Rave Site UUID value(based on site number)
	Then I should see that previoesly UUID for the Rave site does not exist
    And the site has new UUID
	And the site has External ID 
	And I take a screenshot
	And I am on Rave Site Details page for the "<Site A1>" in Rave
	And I should see Source is iMedidata
	And I should see the updated Last External Update Date
	And I take a screenshot
	
@Rave 2013.2.0.
@PB2.5.9.27-02
@Validation
Scenario: If I create a site in iMedidata, and an unlinked site in Rave (that is not linked to the iMedidata site), when Rave receives
          the site it will link it to the iMedidata site, matching it based on UUID first, and failing that site number.

	Given I am an Rave User with username "<iMedidata User 1 ID>"
	And  there is a Rave Study "<Study A>"
	And there is a Rave Site Name "<Site A1>" and Site Number <Site Number Rave>
	And "<Site A1>" is assigned to the Rave Study "<Study A>"
	And I take a screenshot
	And I run query to get Rave Site UUID value
	And I take a screenshot
	And there is a iMedidata user with username "<iMedidata User 1 ID>"
	And my iMedidata User email address is "<iMedidata User 1 Email>"
	And there is an iMedidata Study named "<Study A>"
	And there is a iMedidata "<Site A1>" and Site Number <Site Number Rave>
	And I take a screenshot
	And I run query to get Rave Site UUID value(based on site number)
	And I should see that previoesly UUID for the Rave site does not exist
    And the site has new UUID
	And the site has External ID 
	And I take a screenshot
	And I am on Rave Site Details page for the "<Site A1>" in Rave
	And I should see Source is iMedidata
	And I should see the updated Last External Update Date
	And I take a screenshot
	And I am on  Manage Study iMedidata page
	And I select Sites tab
	And I change the site number
	And I take a screenshot
	When navigate to Rave "<Site A1>" Site Details page
	Then I shlould see the Site Number is updated
	And I take a screenshot



@Rave 2013.2.0
@PB2.5.9.27-03
@Validation
Scenario: When matching sites in order to link them, the matching is case insensitive, and trimmed of a extraenous spaces.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave
    And there is an iMedidata Study  "<Study A>"
	And there is a Rave Study  "<Study A>"
	And I create a new Site with Site Name <Site Name Rave> and Site Number <Site Number Rave> in Rave for study "<Study A>"
		|Site Name Rave		|Site Number Rave								|
		|<site 1 XXzzAA>	|<4 digit number>								|
		|<Site 2 aaBBCc		|<4 digit number w space between each digit	>	|
	And site <Site Name Rave> is assigned to Study "<Study A>"
	And I take a screenshot
	And I am the owner of the Study "<Study A>" in iMedidata
    And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
	And there is iMedidata site with Site Name <Site Name iMedidata> and Site Number <Site Number iMedidata> assigned for Study "<Study A>"
		|Site Name iMedidata	|Site Number iMedidata							|
		|<site 1 xxzzaa>		|<4 digit number w space between each digit		|
		|<Site 2 Aa	Bb Cc>		|<4 digit number>								|
	And I take a screenshot
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Edc App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
	And I follow App "<EDC App>" For Study "<Study A>"
	And I navigate to Site Adminstration
	When I search for Site Name <Site Name Rave>
	Then I should see <Site Name> ans <Site Number>
		|Site Name				|Site Number									|
		|<site 1 xxzzaa>		|<4 digit number w space between each digit		|
		|<site 1 XXzzAA>		|<4 digit number>								|
		|<Site 2 Aa	Bb Cc>		|<4 digit number>								|
		|<Site 2 aaBBCc			|<4 digit number w space between each digit	>	|
	And I navigate to Site Details for the Site <Site Name iMedidata> 
	And I should see Source "iMedidata"
	And I take a screenshot

	
@Rave 2013.2.0
@PB2.5.9.43-01
@Validation
Scenario: If I have a linked site in iMedidata, and I change the site number in iMedidata, when Rave receives the updated site,
          Rave will update the site number to match with the iMedidata site number.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave
    And there is an iMedidata Study  "<Study A>"
	And there is an iMedidata Site  "<Site A1>" assigned to "<Study A>"
	And there is a Rave Study  "<Study A>"
	And there is a Rave Site  "<Site A1>" with Site Number "<SiteNumber1>" for "<Study A>"
	And I am the owner of the Study "<Study A>" in iMedidata
    And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
	And the iMedidata Site  "<Site A1>" with Site Number "<SiteNumber1>" is connected to the Rave Site  "<Site A1>" with Site Number "<SiteNumber1>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Edc App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
	And I navigate to Manage Study-Site page for Site "<Site A1>" in iMedidata
	And site "<Site A1> is assigned Site Number "<SiteNumber1>"
	And I take a screenshot
    And I update the Site Number to "<SiteNumber2>"
	And I save
	And I take a screenshot
    And I follow "<Edc App>" for Study "<Study A>"
	And I should see Site "<Site A1>" page
	And I navigate to Site Adminstration 
	And I search for Study "<Study A>"
	When I navigate to Site Details page for "<Site A1>"
	Then I should see SiteNumber "<SiteNumber2>"
	And I should see Source "iMedidata"
	And I should see Last External Update Date is recent
	And I take a screenshot
	
@Rave 2013.2.0.
@PB2.5.9.46-01
@Validation
Scenario: If I have a linked site in iMedidata, and I change the site name in iMedidata, when Rave receives the updated site,
             Rave will update the site name to match with the iMedidata site name.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave
    And there is an iMedidata Study  "<Study A>"
	And there is an iMedidata Site  "<Site A1>" with Site Number "<SiteNumber2>" assigned to Study "<Study A>"
	And there is a Rave Study  "<Study A>"
	And there is a Rave Site  "<Site A1>" with Site Number "<SiteNumber2>" for "<Study A>"
	And I am the owner of the Study "<Study A>" in iMedidata
    And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
	And the iMedidata Site  "<Site A1>" with Site Number "<SiteNumber2>" is connected to the Rave Site  "<Site A1>" with Site Number "<SiteNumber2>'
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Edc App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
	And I navigate to Manage Study-Site page for Site "<Site A1>"
	And I take a screenshot
    And I update the Site Name to "<Site A1>xx"
	And I save
	And I take a screenshot
	And I follow "<Edc App>" for Study "<Study A>"
	And I should see Site "<Site A1>xx" page
	And I navigate to Site Adminstration 
	And I search for Study "<Study A>"
	When I navigate to Site Details page for "<Site A1>xx"
	Then I should see SiteName is "<Site A1>xx"
	And I should see Source "iMedidata"
	And I should see Last External Update Date is recent
	And I take a screenshot

@Rave 2013.2.0.
@PB2.5.9.1-01
@Validation
Scenario Outline: The following Site attributes are synchronized between Rave and iMedidata and displayed on the Site Details page in Rave
                   when a site is created or updated in iMedidata.
Examples:
  | iMedidata Field Name                            | Rave Field Name                          | 
  | Name                                            | SiteName                                 | 
  | Site Number                                     | SiteNumber                               | 
  | Address Line 1                                  | Address Line 1                           | 
  | Address Line 2                                  | Address Line 2                           | 
  | Address Line 3                                  | Address Line 3                           | 
  | City                                            | City                                     | 
  | State                                           | State                                    | 
  | Postal Code                                     | Postal Code                              | 
  | Country                                         | Country                                  | 
  | Contact Phone                                   | Telephone                                | 
  | Fax                                             | Facsimile                                | 
  
    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave
    And there is an iMedidata Study  "<Study A>"
	And there are no Sites assigned to the Study "<Study A>" in iMedidata
	And there is a Rave Study  "<Study A>"
	And there are no Sites assigned to the Study "<Study A>" in Rave
	And I take a screenshot
	And I am the owner of the Study "<Study A>" in iMedidata
    And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Edc App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
	And I navigate to Sites page in Manage Study :"<Study A>" page
    And I follow Create New Sites
	And I save the following information :
	| iMedidata Field Name                            | Value									| 
    | Name                                            | <SiteName 4>                            | 
    | Site Number                                     | <SiteNumber 4>                          | 
    | Study-Site Number                               | <StudySiteNumber 4>                     | 
    | Notes                                           | <MySite Notes>                          | 
	And I take a screenshot
	And I follow App "<EDC App>" for Study "<Study A>"
	And I navigate to Site Details page for Site "<SiteName>"
	And I should see Site Name "<SiteName>"
	And I Should see SiteNumber "<SiteNumber>"
	And I should see Study Site Number "<StudySiteNumber>"
	And I should see following information is blank:
   | Rave Field Name     | 
   | Address Line 1      |   
   | Address Line 2      | 
   | Address Line 3      |                    
   | City                |                       
   | State               |                      
   | Postal Code         |                          
   | Country             |                 
   | Telephone           |                     
   | Facsimile           |                         
	And I take a screenshot
	And I follow iMedidata
	And I am on iMedidata home page
	And I follow Site "<SiteName 4>" in Sites pane
	And I update the "<iMedidata Field Name>" with "<Value>" as following:
	| iMedidata Field Name                            |Value                                    |  
    | Address Line 1                                  |<Address Line 1>                         | 
    | Address Line 2                                  |<Address Line 2>                         | 
    | Address Line 3                                  |<Address Line 3>                         | 
    | City                                            |<City>                                   | 
    | State                                           |<State>                                  | 
    | Postal Code                                     |<Postal Code>                            | 
    | Country                                         | United States of America                | 
    | Contact Phone                                   |<Phone Number>                           | 
    | Fax                                             |<Fax Number>                             |         
	And I take a screenshot
	And I follow "<Edc App>" for Study "<Study A>"
	And I should see Site "<SiteName>" page
	And I navigate to Site Adminstration 
	And I search for Study "<Study A>"
	When I navigate to Site Details page for "<SiteName>"
	Then I should see the following:
	| Rave Field Name                                 | Value                                    | 
    | SiteName                                        | <SiteName 4>                             | 
    | SiteNumber                                      | <SiteNumber 4>                           | 
    | Address Line 1                                  |<Address Line 1>                          | 
    | Address Line 2                                  |<Address Line 2>                          | 
    | Address Line 3                                  |<Address Line 3>                          | 
    | City                                            |<City>                                    | 
    | State                                           |<State>                                   | 
    | Postal Code                                     |<Postal Code>                             | 
    | Country                                         |USA                                       | 
    | Telephone                                       |<Phone Number>                            | 
    | Facsimile                                       |<Fax Number>                              | 
	And I should see Source "iMedidata"
	And I take a screenshot

@release2012.2.0
@PB2.5.9.1-02
@Draft
Scenario: For an iMedidata managed site, Rave will display the iMedidata UUID on the site page.

@Rave 2013.2.0
@PB2.5.9.44-01
@Validation
Scenario: If I have a Rave site that is not linked to a Site in iMedidata, I can change the Site Number and Site Name in Rave.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave
    And there is an iMedidata Study  "<Study A>"
    And there is a Rave Study  "<Study A>"
    And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Edc App>" and the Role "<EDC Role 1>"
	And there exists a Site "<Site A1>" with Site Number "<SiteNumber A1>" for Study "<Study A>" in Rave
	And I take a screenshot
	And the Site "<Site A1>" in Rave is not connected to any Site in iMedidata
	And I follow app "<Edc App>" for Study "<Study A>"
    And I navigate to Site Adminstration 
	And I search for Site "<Site A1>"
	When I update the SiteNumber to "<SiteNumber A1>abc"
	And I update the SiteName to "<Site A1>zx"
	And I take a screenshot
	And I navigate to Site Adminstration 
	And I search for Study "<Study A>"
	And I navigate to Site Details page for Site "<Site A1>zx"
	Then I should see SiteNumber is "<SiteNumber A1>abc"
	And I should see SiteName is "<Site A1 New>"
	And I should not see Source 
	And I take a screenshot

@Rave 2013.2.0.
@PB2.5.9.45-01
@Validation
Scenario: If I have a Rave site that is linked to a Site in iMedidata,I cannot change the Site Name and Site Number in Rave.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave
    And there is an iMedidata Study  "<Study A>"
	And there is a Rave Study  "<Study A>"
	And there is a Rave Site  "<Site A1>" with Site Number "<SiteNumber A1>" for Study "<Study A>"
	And I take a screenshot
	And I am the owner of the Study "<Study A>" in iMedidata
    And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
	And the iMedidata Site  "<Site A1>" with Site Number "<SiteNumber A1>" is connected to the Rave Site "<Site A1>" with Site Number "<SiteNumber A1>"
	And I take a screenshot
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Edc App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
	And I follow "<Edc App>" for Study "<Study A>"
	And I should see Site "<Site A1>" Home page
	And I navigate to Site Adminstration 
	And I search for Study "<Study A>"
	When I navigate to Site Details page for "<Site A1>"
	Then I should see SiteName is not editable 
	And I should see SiteNumber is not editable
	And I should see Source "iMedidata"
	And I take a screenshot


@Rave 2013.2.0
@PB2.5.9.23-01
@Validation
Scenario: Rave will display "iMedidata" as the Source on Site Details page for the site that is linked to a site on iMedidata.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave
    And there is an iMedidata Study  "<Study A>"
	And study "<Study A>" has an iMedidata site "<Site A1>"
	And the iMedidata User is the owner of iMedidata site "<Site A1>"
    And there is a Rave Study  "<Study A>"
    And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" app  "<EDC App>" and the Role "<Edc Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
    And I have an assignment to the iMedidata Site  "<Site A1>" with Site Number "<SiteNumber A1>" for the iMedidata Study  "<Study A>"
	And I follow "<EDC App>" for Study "<Study A>"
	And I am in Rave
	And I see site "<Site A1>"
	And I navigate to Site Adminstration
    When I navigate to Site Details page for "<Site A1>" in Rave
    Then I should see "Source" is iMedidata
	And I take a screenshot

@Rave 2013.2.0.
@PB2.5.9.24-01
@Validation
Scenario: Rave will not display the Source on Site Details page for the site that is not linked to a site on iMedidata.

    Given I am an Rave User
    And I am logged in to Rave
    And my Username is "<Rave User Name 1>" in Rave
    And I have an assignment to User Group of "<All Modules>"
    And there is a Rave Study  "<Study A>"
	And there exists a Site "<Site A1>" for Study "<Study A>" in Rave
	And the Site "<Site A1>" with Site Number "<SiteNumber A1>" is not connected to iMedidata
	And I navigate to Site Adminstration
    When I navigate to the Site Details page for Site "<Site A1>" in Rave
    Then I should see Site details for Site "<Site A1>"
    And I should not see "Source"
	And I take a screenshot

@Rave 2013.2.0.
@PB2.5.9.28-01
@Validation
Scenario: If the Source is set to "iMedidata" then Rave will display these fields as non-editable: SiteName, SiteNumber, Address Line 1,
          Address Line  2, Address Line 3, City, State, PostalCode, Country, Telephone, Facsimile

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And I am connected to Rave
    And there is an iMedidata Study  "<Study A>"
	And study "<Study A>" has an iMedidata site "<Site A1>"
	And the iMedidata User is the owner of iMedidata site "<Site A1>"
	And there is a Rave Study  "<Study A>"
	And there is a Rave Site  "<Site A1>" with Site Number "<SiteNumber A1>" for "<Study A>"
	And I am the owner of the Study "<Study A>" in iMedidata and Site "<Site A1>"
	And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
	And the iMedidata Site  "<Site A1>" with Site Number "<SiteNumber A1>" is connected to the Rave Site  "<Site A1>" with Site Number "<SiteNumber A1>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Edc App>" and the Role "<EDC Role 1>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
	And I enter data <Input Data> in following fields <iMedidata Site Fields> on the Site Details page in iMedidata
	|iMedidata Site Fields	|Inpuut Data		|
	| SiteName				|<Site A1>			|                           
    | SiteNumber			|<SiteNumber A1>	|                                   
    | Address Line 1		|<Address Line 1>	|
    | Address Line 2		|<Address Line 2>	|							                                
    | Address Line 3		|<Address Line 3>	|							                                 
    | City					|<City>				|                                        
    | State					|<State>			|	                                        
    | PostalCode			|<PostalCode>		|                              
    | Country				|<Country>			|                             
    | Contact Phone			|<Telephone>		|	                                    
    | Fax					|<Facsimile>		|                                     
	And I take a screenshot

    And I follow app "<Edc App>" for Study "<Study A>"
	And I should see "<Site A1>" on the Rave page
	And I navigate to Site Adminstration
	When I navigate to Site Details page for Site "<Site A1>" for Study "<Study A>"
    Then I should see the following fields are not editable:
    | Rave Field Name                                 |
    | SiteName                                        | 
    | SiteNumber                                      | 
    | Address Line 1                                  | 
    | Address Line 2                                  | 
    | Address Line 3                                  | 
    | City                                            | 
    | State                                           | 
    | PostalCode                                      |
    | Country                                         |
    | Telephone                                       | 
    | Facsimile                                       | 
	And I should see Source "iMedidata"
	And I take a screenshot

@Rave 2013.2.0
@PB2.5.9.30-01
@Validation
Scenario: When the user selects the New Site link from the Site Administration module in Rave then a message will be displayed
         "Please Note:Sites created here will not appear on iMedidata".

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
	And I am connected to Rave
    And there is an iMedidata Study  "<Study A>"
	And there is a iMedidata Site "<Site A1>" with site number "<SiteNumber A1>" assigned to Study "<Study A>"
	And the iMedidata User is the owner of iMedidata site "<Site A1>"
    And there is a Rave Study "<Study A>"
    And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" and the Role "<Edc Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
	And I follow app "<EDC app>" for "<Study A>"
	And I see study "<Study A>"
	And I navigate to Site Adminstration page
    When I select link "New Site"
    Then I should see the message "Please note:Sites created here will not appear on iMedidata."
	And I take a screenshot

@Rave 2013.2.0.
@PB2.5.9.31-01
@Validation
Scenario: Rave will allow an iMedidata user to create a site on Rave that is not linked to iMedidata.

    Given I am an iMedidata User
    And I am logged in to iMedidata
    And my Username is "<iMedidata User 1 ID>" in iMedidata
    And there is a Rave User  "<Rave User Name 1>"
    And there is an iMedidata Study  "<Study A>"
    And there is a Rave Study  "<Study A>"
    And the iMedidata Study  "<Study A>" is connected to the Rave Study  "<Study A>"
    And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<EDC App>" and the Role "<Edc Role 1>"
	And I have an assignment to the iMedidata Study  "<Study A>" for the App  "<Modules App>" and the Role "<Modules Role 1>"
	And I follow app "<EDC app>" for "<Study A>"
	And I am on Study "<Study A>" home page in Rave
    And I navigate to the Site Administration page
    And I follow "New Site" link
    And I am on the Site Details page in Rave
    And I enter "<Site A1>" in textbox labeled "SiteName"
    And I enter "<SiteNumber A1>" in textbox labeled "SiteNumber"
    And I update
	And I take a screenshot
	When I navigate to Site Adminstration
	And I search for "<Site A1>"
	Then I should see Site "<Site A1>" in results
	And I navigate to Site Details page for Site "<Site A1>"
	And I should not see "Source"
	And I take a screenshot

@Rave 2013.2.0.
@PB2.5.9.31-02
@Validation
Scenario: Rave will allow a Rave user to create a site on Rave.

    Given I am an Rave User
    And I am logged in
    And my Username is "<Rave User Name 1>" in Rave
    And there is a Rave Study  "<Study A>"
    And I have an assignment to the Rave Study  "<Study A>"
	And I have access to All Modules in Rave
    And I navigate to the Site Administration page
    And I follow New Site link
    And I am on the Site Details page in Rave
    And I enter "<Site A1>" in textbox labeled "SiteName"
    And I enter "<SiteNumber A1>" in textbox labeled "SiteNumber"
    And I can click update
	And I take a screenshot
	When I navigate to Site Adminstration
	And I search for "<Site A1>"
	Then I should see Site "<Site A1>" in results
	And I take a screenshot

@Rave 2013.2.0
@PB2.5.9.31-03
@Validation
Scenario: If the user is invited to All Sites via the Sites dropdown in invitation pane to a Study that is linked to iMedidata and when
 the user navigates to Rave user should see All Sites assigned , if a new site is added to the Study in iMedidata then
  All Sites including the New should also be displayed in Rave.

Given I am an iMedidata User
And I am logged in to iMedidata
And my Username is "<iMedidata User 1 ID>" in iMedidata
And there is a Rave User named "<iMedidata User 1 ID>"
And there is an iMedidata Study named "<Study B>"
And the iMedidata Study named "<Study B>" has Site "<Site B1>" <Site B2>" "<Site B3>"
And there is a Rave Study named "<Study B>"
And the iMedidata Study named "<Study B>" is connected to the Rave Study named "<Study B>"
And I have been invited to the iMedidata Study named "<Study B>" for the App named "<Edc App>" and the Role "<EDC Role 1>" App named "<Modules App>" Role "<Modules Role 1>" with "All Sites" as Study Owner
And I accept the invitations
And I follow app named "<EDC App>" for "<Study B>"
And I am on Study "<Study B>" home page 
And I should see "<Site B1>" "<Site B2>" "<Site B3>" on Rave home page
And I take a screenshot
And I follow iMedidata link
And I am on iMedidata home page
And I navigate to Manage Study page
And I navigate to Sites tab for Study "<Study B>"
And I follow 'Create New Sites'
And I add a new Site "<Site B4> with Site Number "<SiteNumber B4>" Study Site Number "<StudySiteNumber B4>"
And I take a screenshot
And I assign site to the iMedidata User
And I accept the Site invitation
And I take a screenshot
And I navigate to the Home page
And I follow "<EDC App>" for Study "<Study B>"
And I should see "<Site B1>", "<Site B2>", "<Site B3>" , "<Site B4>" on Rave home page
And I take a screenshot

@release2012.2.0
@PB2.5.9.42-03
@Draft
Scenario: If I create or update a study in iMedidata, all the study-sites associated with that study are updated as part of that association,
           and all the sites are updated, possibly instigating the creation and or linking of the related sites in Rave.

