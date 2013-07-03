# As a general practice each linked study must be created on iMedidata. Linked To iMedidata checkbox will appear in the Architect module on Environment Setup page, indicating which studies are linked to iMedidata.
# Studies will connect automatically when a user creates the study in iMedidata. When the message is received for the Study create, Rave will attempt to connect using first a common UUID, and failing that, connecting if the iMedidata Study Name matches the Rave Project Name and Environment Name, using the format ‘Study Name (Environment Name)’.
# - If a common UUID cannot be found, then new Environments will be created and connected automatically if the iMedidata Study Name matches the Rave Project Name.
# - New Projects will be created and connected automatically when there is no matching Project or Environment existing that is not inactive. If Rave cannot find a matching UUID, but does find an existing and matching Project and Environment name, then Rave will connect this found Project/Environment to the iMedidata study and replace the existing UUID in Rave with the new one sent in the message.
# - The exception to this matching is if the IsProduction flag does not match between the two systems: If Rave finds a Project and Environment that matches a Study according to the above criteria but the IsProduction flag in iMedidata does not match the Production environment (‘Live flag) in Rave, the study connect fails.
# - Each study group on iMedidata displays all the studies within the Rave URL that are linked to iMedidata application. Each study displays Rave EDC link or Rave Modules link depending on whether the user has been invited to Rave EDC or Rave Modules.

Feature: Rave Integration for Studies
    In order to create and use studies in Rave
    As a User
    I want to have my studies created and synchronized between Rave and iMedidata

	Background: 
	Given I am an iMedidata user "<User>" with pin "<PIN>" password "<Password>" and user id "User ID>"
		|User						|PIN						| Password							|User ID						|Email 							|
		|{iMedidata User 1 ID}			|iMedidata	 User 1 PIN}	|{iMedidata		 User 1 Password}	|{iMedidata User 1 ID ID}			|{iMedidata	 User 1 Email}		|
		|{iMedidata New User 2}		|iMedidata New User 2 PIN}	|{iMedidata New User 2 Password}	|{iMedidata New User 2 ID}		|{iMedidata New User 2 Email}	|
		|{iMedidata New User 3}		|iMedidata New User 3 PIN}	|{iMedidata New User 3 Password}	|{iMedidata New User 3 ID}		|{iMedidata New User 3 Email}	|
		|{iMedidata New User 4}		|iMedidata New User 4 PIN}	|{iMedidata New User 4 Password}	|{iMedidata New User 4 ID}		|{iMedidata New User 4 Email}	|
		|{iMedidata New User 5}		|iMedidata New User 5 PIN}	|{iMedidata New User 5 Password}	|{iMedidata New User 5 ID}		|{iMedidata New User 5 Email}	|
		|{iMedidata New User 6}		|iMedidata New User 6 PIN}	|{iMedidata New User 6 Password}	|{iMedidata New User 6 ID}		|{iMedidata New User 6 Email}	|
		|{iMedidata Old User}		|iMedidata Old User PIN}	|{iMedidata Old User Password}		|{iMedidata Old User ID}		|{iMedidata Old User Email}		|
		|{iMedidata Base User}		|iMedidata Base User PIN}	|{iMedidata Base User Password}		|{iMedidata Base User ID}		|{iMedidata Base User Email}	|
	
	
	And there exists a Rave user "<Rave User>" with username <Rave User Name>" and password "<Rave Password>" with "<Email>" and "<Rave First Name>" and "<Rave Last "Nane>"
		|Rave User		|Rave User Name		|Rave Password		|Email			|Rave First Name 	|Rave Last Name 	|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|Rave First Name 1	|Rave Last Name 1	|	
		|{Rave User 2}	|{Rave User Name 2}	|{Rave Password 2}	|{Rave Email 2}	|Rave First Name 2	|Rave Last Name 2	|	
	
	And there exists Security Group "<Security Group>" that is associated with Security Role "<Role>"
		|Security Group		|Role				|
		|{Security Group 1}	|{Security Role 1}	|
		|{Security Group 2}	|{Security Role 2}	|

	And there exists study "<Study>" in study group "<Study Group>"
		|Study			|Study Group 	|
		|{New Study A}	|{Study Group} 	|
		|{New Study B}	|{Study Group} 	|
		|{New Study C}	|{Study Group} 	|
		|{New Study D}	|{Study Group} 	|
		|{New Study E}	|{Study Group} 	|
		|{New Study F}	|{Study Group} 	|
		|{New Study G}	|{Study Group} 	|
		|{Old Study A}	|{Study Group} 	|
		|{Old Study B}	|{Study Group} 	|
		|{Study A}		|{Study Group} 	|

	And there exists subject <Subject> with eCRF page <eCRF Page>" in Site <Site>
		|Site			|Subject		|eCRF Page		|
		|{New Site A1}	|{Subject 1}	|{eCRF Page 1}	|

	And There exists <eLearning Course> associated with "<Role>"
		|eLearning Course	|
		|{Course 1}
		
	And there exists app "<App>" associated with study "<Study>",
		|App			|
		|{Edc App}		|
		|{Modules App}	|
		|{Security App}	|
	And there exists site "<Site>" in study "<Study>", 		
		|Study			|Site			|
		|{New Study A}	|{New Site A1}	|
		|{New Study B}	|{New Site B1}	|
		|{New Study C}	|{New Site C1}	|
		|{New Study D}	|{New Site D1}	|	
		|{New Study E}	|{New Site E1}	|
		|{New Study F}	|{New Site F1}	|	
		|{New Study G}	|{New Site G1}	|	
		|{Old Study A}	|{Old Site A1}	|
	And there exists role "<Role>" in app "<App>", 		
		|App			|Role				|
		|{Edc App}		|{EDC Role 1}		|
		|{Edc App}		|{EDC Role 2}		|
		|{Edc App}		|{EDC Role DI}		|
		|{Modules App}	|{Modules Role 1}	|
		|{Security App}	|{Security Role 1}	|	
		|{Security App}	|{Security Role 2}	|
		
Queries:
	select dbo.fnlocaldefault(projectname) as ProjectName, 
    dbo.fnlocaldefault(environmentnameid) as Environment,
    s.UUID,
    * from studies s
    join projects p
    on  p.projectid = s.projectid
    where s.projectid=xxx

	or

	select dbo.fnlocaldefault(projectname) as ProjectName, 
    dbo.fnlocaldefault(environmentnameid) as Environment,
    s.UUID,
    * from studies s
    join projects p
    on  p.projectid = s.projectid
    where s.studyid=xxxx
    
	or

    Select UUID, ProjectID, ExternalID, EnrollmentTarget from dbo.Studies
    where StudyID = xxxx
	
	or (Jason message)

	select top 10 * from CentralLogging where Message like '%Incoming%' order by 1 desc


@Rave 2013.2.0.
@PB2.5.8.7-01
@Validation
Scenario: An iMedidata user can create a study in Rave.  This study creation is messaged to Rave which creates a matching,
            linked study if the project does not already exist.
    

    Given I am an iMedidata user "<iMedidata User 1 ID ID>"  logged in to iMedidata
	And I am an owner of the Study Group named “<Study Group>”
    And I am on the Study Group Manage page for the Study Group named “<Study Group>”
    And I follow "Create New Study"
    And I fill in “Name” with “<Study A>”
    And I fill in “Protocol Number” with “<Protocol Number1>”
	And I enter a number "<Enrollment Target Number>" in textbox "Enrollment Target" 
    And I check checkbox "Is Production"
    And I select button "Save"
    And I should see message “You successfully created the "<Study A>" study in the "<Study Group>" study group."
	And I invite iMedidata user "<iMedidata New User 2>" as a study owner to Study "<Study A>" with App named "<Edc App>" and the Role "<EDC Role 1>" and App named "<Modules App>" and the Role "<Modules Role 1>"and App "<Security App>" with Role "<Security Role 1>"
	And a json message is sent to Rave that will contain "uuid" and "id"
	And I take a screenshot
	And I select link "Home"
	And I log out as user "<iMedidata User 1 ID>"
	And I log in as user "<iMedidata New User 2>"
	And I am on the iMedidata Home page
	And I accept the invitation
    And I follow app link "<Edc App> that is assigned to study “<Study A>”
    And I should see there is a Project named “Study A”
	And I take a screenshot
	And i select link "Architect"
	And I select link "<Study A>'
	And I select link "Studies Environment Setup"
	And it will have enrollment target "<Enrollment Target Number>"
    And checkbox "Linked to iMedidata" is checked
	And I take a screenshot
	When I query the database for study “Study A” for "UUID" and "ExternalID" with the following query: see background
	Then I see matching "UUID"
	And I take a screenshot
	And I see "ExternalID" is the same as "id" in the json message
	And I take a screenshot
	

@Rave 564 Patch 13
@PB2.5.8.9-01
@Validation
Scenario Outline: An iMedidata user can update a study in Rave. The following attributes are updated.

	Given I am logged in to iMedidata as a study owner "<iMedidata New User 2>"
	And I am assigned as study owner for study "<Study A>"
	And I edit <iMedidata Attribute> with <revised data>
	   | <iMedidata Attribute>		| <revised data>					| 
       | Enrollment Target			| Enrollment Target Number 2>		| 
       | Study Name					| "<Study A>x"						| 
	And I take a screenshot
	And a json message is sent to Rave that will contain "Study uuid" and "id"
	And I follow app link "<Edc App> that is assigned to study “<Study A>x”
    And I should see there is a Project named “<Study B>x”
	And I take a screenshot
	And i select link "Architect"
	And I select link "<Study A>x'
	And I select link "Studies Environment Setup"
	When I am on the Environment Setup page
	Then I will see that <Rave Attribute> has been updated to match the <iMedidata Attribute> on <Rave Page>
    | <Rave Attribute>          | <iMedidata Attribute>		| <Rave Page>						| 
    | Enrollment Target         | Enrollment Target			| Studies Environment Setup			| 
    | Project Name              | Study Name				| Studies Environment Setup         | 
    | Environment Name          | Study Name				| Studies Environment Setup         | 
	And I take a screenshot
	And I query the database for study “Study A” for "Study uuid" and "external id" with the following query: see background
	And I see matching "Study uuid"
	And I take a screenshot
	And I see "external id" is the same as "id" in the json message
	And I take a screenshot


@Rave 2013.2.0.
@PB2.5.8.20-01
@Validation
Scenario: If I have a project + environment in Rave that is not linked to a study in iMedidata.When the study is created in iMedidata, Rave should link that Project and Environment.

	

	Given there exists Rave Project "<Study B>" with aux environment "<Aux 1>" on Rave 
    And there is a Study Group "<Study Group>" in iMedidata
	And I am logged in to iMedidata as user <iMedidata  User 1>"
	And I am an owner of the Study Group "<Study Group>"
    And I am on the Study Group Manage page for the Study Group named "<Study Group>"
    And I follow "Create New Study"
    And I fill in Textbox “Name” with "<Study B (Aux1)>"
    And I fill in “Protocol Number” with “<Protocol Number2>”
	And I enter a number "<Enrollment Target Number>" in textbox "Enrollment Target" 
	And I select button "Save"
    And I should see message “You successfully created the "<Study B> <(Aux1)>" study in the "<Study Group>" study group."
	And a json message is sent to Rave that will contain "uuid" and "id"
	And I take a screenshot
	And I invite iMedidata user "<iMedidata New User 2>" as a study owner to Study "<Study B>" with App named "<Edc App>" and the Role "<EDC Role 1>" and App named "<Modules App>" and the Role "<Modules Role 1>" and App "<Security App>" with Role "<Security Role 1>"
	And I select link "Home"
	And I log out as user "<iMedidata User 1 ID>"
	And I log in as user "<iMedidata New User 2>"
	And I am on the iMedidata Home page
	And I accept the invitation
	And I follow EDC link to "<Study B (Aux1)>"
    And I should see there is a Project named "<Study B>"
	And I should see there is an Environment “<Aux 1>” for the Project named "<Study B>"
	And I take a screenshot
	And I select link "Architect"
	And I select link "<Study B>'
	And I select link "Studies Environment Setup"
	And I should see "<Enrollment Target Number>" for the row with environment "<Aux 1>"
    And checkbox "Linked to iMedidata" is checked for the row with environment "<Aux 1>"
    And I should see the "<Prod>" is not linked to iMedidata
	And I take a screenshot
	When I query the database for study “Study B” for "UUID" and "ExternalID"
	Then I see matching "UUID"
	And I take a screenshot
	And I see "ExternalID" is the same as "id" in the json message
	And I take a screenshot



Rave2012.2.0
@PB2.5.8.20-101
@FUTURE
Scenario: If I have a  study in iMedidata, and a project + environment in Rave that is not linked to that study, when the study is created in iMedidata (or Rave recieves a relationship , study site or user assignment, to that unlinked study), Rave should do a UUID match, and if found, link that Project and Environment and synchronize ALL OBJECTS related to that study (attributes, studysites, sites, user assignments, users.)


@Rave 2013.2.0.
@PB2.5.8.7-03
@Validation
Scenario: If I have a project with an aux environment in Rave that is not linked to study in iMedidata,  when the study is created in iMedidata, Rave should do a name match from the Rave project name and environment name against the iMedidata study and link the two automatically.  When doing the project name and/or environment name match, care must be taken to trim both of extra spaces and disallowed punctuation and invisible characters.


	Given there exists Rave Project "<Study C>" with aux environment "<Aux 2>" 
	And there is a Study Group named "<Study Group>" in iMedidata
	And I am logged in to iMedidata as user <iMedidata  User 1>"
	And I am an owner of the Study Group named “<Study Group>”
    And I am on the Study Group Manage page for the Study Group “<Study Group>”
    And I follow "Create New Study"
    And I fill in Textbox “Name” with "<Study C  (Aux 2)>  "(2 extra spaces at end and 2 spaces betewwn c and ()
    And I fill in “Protocol Number” with “<Protocol Number3>”
	And I enter a number "<Enrollment Target Number>" in textbox "Enrollment Target" 
	And I select button "Save"
	And I should see message “You successfully created the "<Study C> <(Aux2)>" study in the "<Study Group>" study group."
	And I invite iMedidata user "<iMedidata New User 2>" as a study owner to Study "<Study C>" with App named "<Edc App>" and the Role "<EDC Role 1>" and App named "<Modules App>" and the Role "<Modules Role 1>"and App "<Security App>" with Role "<Security Role 1>"
	And I select link "Home"
	And I am on the iMedidata Home page
	And I log out as user "<iMedidata User 1 ID>"
	And I log in as user "<iMedidata New User 2>"
	And I am on the iMedidata Home page
	And I accept the invitation
	When I follow EDC link to "<Study C (Aux2)>"
  	Then I should see there is a Project named "<Study C>"
    And I should see there is an Environment “<Aux 2>” for the Project named "<Study C>"
	And i take a screenshot
	And i select link "Architect"
	And I select link "<Study C>'
	And I select link "Studies Environment Setup"
	And it will have enrollment target "<Enrollment Target Number>"
    And checkbox "Linked to iMedidata" is checked
	And I take a screenshot



@Rave 2013.2.0.
@PB2.5.8.7-03A
@Validation
Scenario: If I a project + environment in Rave that is not linked to a study in iMedidata. When the study is created in iMedidata, Rave should do a name match from the Rave project name and environment name against the iMedidata study and link the two automatically.  When doing the project name and/or environment name match, care must be taken to allow for cases where there may be a word or phrase already in the study name that is surrounded by parens, for example Study A (1424) (UAT)



	Given there exists Rave Project "<Study D>(zx)" with aux envitonment "<Aux 2>" on Rave 
	And there is a Study Group named "<Study Group>" in iMedidata
	And I am logged in to iMedidata as user <iMedidata  User 1>"
	And I am an owner of the Study Group named “<Study Group>”
    And I am on the Study Group Manage page for the Study Group named “<Study Group>”
	And I follow "Create New Study"
    And I fill in Textbox “Name” with "<Study D(zx) (Aux 2)>"
    And I fill in “Protocol Number” with “<Protocol Number4>”
	And I enter a number "<Enrollment Target Number>" in textbox "Enrollment Target" 
	And I select button "Save"
	And I should see message “You successfully created the "<Study D(zx)> <(Aux2)>" study in the "<Study Group>" study group."
	And I invite iMedidata user "<iMedidata New User 2>" as a study owner to Study "<Study D(zx)>" with App named "<Edc App>" and the Role "<EDC Role 1>" and App named "<Modules App>" and the Role "<Modules Role 1>"and App "<Security App>" with Role "<Security Role 1>"
	And I select link "Home"
	And I am on the iMedidata Home page
	And I log out as user "<iMedidata User 1 ID>"
	And I log in as user "<iMedidata New User 2>"
	And I am on the iMedidata Home page
	And I accept the invitation
	When I follow EDC link to "<Study D(zx) (Aux 2)>"
	Then I should see there is a Project named "<Study D(zx)>"
    And I should see there is an Environment “<Aux 2>” for the Project named "<Study D(zx)>"
	And i take a screenshot
	And i select link "Architect"
	And I select link "<Study D(zx)>'
	And I select link "Studies Environment Setup"
	And it will have enrollment target "<Enrollment Target Number>"
    And checkbox "Linked to iMedidata" is checked
	And I take a screenshot


@Rave 2013.2.0.
@PB2.5.8.7-04
@Validation
Scenario: If I have a project in Rave that is not linked to study in iMedidata,when the study is created in iMedidata with spaces before and after the study name,
         Rave will not link to the matching study name ( with no spaces) in Rave, instead it will create a new study in Rave.
	
	Given there exists Rave Project "<Study E>" 
	And there is a Study Group named "<Study Group>" in iMedidata
	And I am logged in to iMedidata as user "<iMedidata User 1 ID>"
	And I am an owner of the Study Group named "<Study Group>"
    And I am on the Study Group Manage page for the Study Group named "<Study Group>"
    And I follow "Create New Study"
    And I fill in Textbox "Name" with "<  Study E  >"(2 extra spaces at end and 2 spaces before )
    And I fill in "Protocol Number" with "<Protocol Number3>"
	And I enter a number "<Enrollment Target Number>" in textbox "Enrollment Target" 
	And I check checkbox "Is Production"
	And I select button "Save"
	And I should see message “You successfully created the "<Study C>" study in the "<Study Group>" study group."
    And I have an assignment to study "<  Study E  >" with App named "<EDC App>" and the Role "<EDC Role 1>" and App named "<Modules App>" and the Role "<Modules Role 1>"and App "<Security App>" with Role "<Security Group 1>"
	And I select link "Home"
	When I follow EDC link to "<Study E>"
  	Then I should see there is a Project named "<Study E>"
	And I take a screenshot
	And I select link "Architect"
	And I should see two projects "<Study E>"
	And I select link "<  Study E  >"
	And I follow Edit 
	And I should see "<  Study E  >"
	And I should see Study Information is uneditable
	And I take a screenshot
	And I select link "Studies Environment Setup"
	And I should see enrollment target "<Enrollment Target Number>"
    And I should see checkbox "Linked to iMedidata" is checked
	And I take a screenshot
	And I navigate back to Architect
	And I follow "<Study E>"
	And I click on Edit 
	And I should see "<Study E>" with no spaces
	And I should see Study Information is editable
	And I select link "Studies Environment Setup"
    And I should see checkbox "Linked to iMedidata" is un checked
	And I take a screenshot


@Rave 2013.2.0.
@PB2.5.8.7-05
@Validation
Scenario: If I have a project in Rave that is not linked to study in iMedidata,when the study is created in iMedidata with spaces before the study name,
            Rave will not link to the matching study name ( with no spaces) in Rave, instead it will create a new study in Rave.
	
	Given there exists Rave Project "<Study F>" 
	And there is a Study Group named "<Study Group>" in iMedidata
	And I am logged in to iMedidata as user "<iMedidata User 1 ID>"
	And I am an owner of the Study Group named "<Study Group>"
    And I am on the Study Group Manage page for the Study Group named "<Study Group>"
    And I follow "Create New Study"
    And I fill in Textbox "Name" with "<  Study F>"(2 spaces before )
    And I fill in "Protocol Number" with "<Protocol Number3>"
	And I enter a number "<Enrollment Target Number>" in textbox "Enrollment Target" 
	And I check checkbox "Is Production"
	And I select button "Save"
    And I should see message “You successfully created the "<Study F>" study in the "<Study Group>" study group."
	And I have an assignment to study "<  Study C>" with App named "<EDC App>" and the Role "<EDC Role 1>" and App named "<Modules App>" and the Role "<Modules Role 1>"and App "<Security App>" with Role "<Security Group 1>"
	And I select link "Home"
	When I follow EDC link to "<Study F>"
  	Then I should see there is a Project named "<Study F>"
	And i take a screenshot
	And i select link "Architect"
	And I should see two projects "<Study F>"
	And I select link "<  Study F>"
	And I follow Edit 
	And I should see "<  Study F>" with spaces before study name
	And I should see Study Information is uneditable
	And I take a screenshot
	And I select link "Studies Environment Setup"
	And it will have enrollment target "<Enrollment Target Number>"
    And checkbox "Linked to iMedidata" is checked
	And I take a screenshot
	And I navigate back to Architect
	And I follow "<Study F>"
	And I click on Edit 
	And I should see "<Study F>" with no spaces
	And I should see Study Information is editable
	And I select link "Studies Environment Setup"
    And checkbox "Linked to iMedidata" is un checked
	And I take a screenshot	


@Rave 2013.2.0.
@PB2.5.8.7-06
@Validation
Scenario: If I have a project in Rave that is not linked to study in iMedidata,when the study is created in iMedidata with spaces after the study name,
          Rave will link to the matching study name ( with no spaces) in Rave.
	
	Given there exists Rave Project "<Study G>" 
	And there is a Study Group named "<Study Group>" in iMedidata
	And I am logged in to iMedidata as user "<iMedidata User 1 ID>"
	And I am an owner of the Study Group named "<Study Group>"
    And I am on the Study Group Manage page for the Study Group named "<Study Group>"
    And I follow "Create New Study"
    And I fill in Textbox "Name" with "<Study G>  "(2 spaces after )
    And I fill in "Protocol Number" with "<Protocol Number3>"
	And I enter a number "<Enrollment Target Number>" in textbox "Enrollment Target" 
	And I check checkbox "Is Production
	And I select button "Save"
    And I should see message “You successfully created the "<Study G>" study in the "<Study Group>" study group."
	And I have an assignment to study "<Study G>  " with App named "<EDC App>" and the Role "<EDC Role 1>" and App named "<Modules App>" and the Role "<Modules Role 1>"and App "<Security App>" with Role "<Security Group 1>"
	And I select link "Home"
	When I follow EDC link to "<Study G>  "
  	Then I should see there is only one Project named "<Study G>  "
	And I take a screenshot
	And I select link "Architect"
	And I should see one project "<Study G>"
	And I select link "<Study G>"
	And I follow Edit 
	And I should see "<Study G>  " with spaces after study name
	And I should see Study Information is uneditable
	And I take a screenshot
	And I select link "Studies Environment Setup"
	And I should see  enrollment target "<Enrollment Target Number>"
    And checkbox "Linked to iMedidata" is checked
	And I take a screenshot
	
@Rave 2013.2.0.
@PB2.5.8.19-01
@Validation
Scenario: If I a project + environment in Rave that is not linked to a study in iMedidata.
          When the study is created in iMedidata, Rave should do a name match on a case insensitive basis.


	Given I am an iMedidata user
	And there exists Rave Project "<Study H>ZqA>" on Rave 
	And there is a Study Group named "<Study Group>" in iMedidata
	And I am logged in to iMedidata as user <iMedidata  User 1>"
	And I am an owner of the Study Group named “<Study Group>”
    And I am on the Study Group Manage page for the Study Group named “<Study Group>”
	And I follow "Create New Study"
    And I fill in Textbox “Name” with "<Study H>zqA>"
    And I fill in “Protocol Number” with “<Protocol Number5>”
	And I enter a number "<Enrollment Target Number>" in textbox "Enrollment Target" 
	And I check checkbox "Is Production"
	And I select button "Save"
 	And I should see message “You successfully created the "<Study H>zqA>" study in the "<Study Group>" study group."
	And I invite iMedidata user "<iMedidata New User 2>" as a study owner to Study "<Study H>zqA" with App named "<Edc App>" and the Role "<EDC Role 1>" and App named "<Modules App>" and the Role "<Modules Role 1>"and App "<Security App>" with Role "<Security Role 1>"
	And I select link "Home"
	And I am on the iMedidata Home page
	And I log out as user "<iMedidata User 1 ID>"
	And I log in as user "<iMedidata New User 2>"
	And I am on the iMedidata Home page
	And I accept the invitation
	When I follow EDC link to "<Study H>zqA"
	Then I should see Project named "<Study H>zqA"
 	And i take a screenshot
	And i select link "Architect"
	And I select link "<"<Study H>zqA">'
	And I select link "Studies Environment Setup"
	And it will have enrollment target "<Enrollment Target Number>"
    And checkbox "Linked to iMedidata" is checked
	And I take a screenshot
		


@Rave 2013.2.0.
@PB2.5.8.16-01
@Validation
Scenario: If I have an unlinked study in iMedidata, when the study is created in iMedidata, Rave should do a UUID match, and failing that a name match against the iMedidata study and, on a match against only the project name, link the found project and create the new environment that maps to that study.


	Given there exists Rave Project "<Study J>" with aux environment "<Aux 2>"
	And I have access to the Rave Module named “Architect” 
	And there is a Study Group named "<Study Group>" in iMedidata
	And I am logged in to iMedidata as user <iMedidata  User 1>"
	And I am an owner of the Study Group named “<Study Group>”
    And I am on the Study Group Manage page for the Study Group named “<Study Group>”
	And I follow "Create New Study"
	And I fill in Textbox “Name” with "<Study J (Aux 3)> 
    And I fill in “Protocol Number” with “<Protocol Number6>”
	And I enter a number "<Enrollment Target Number>" in textbox "Enrollment Target" 
	And I select button "Save"
	And I should see message “You successfully created the "<Study J>""(<Aux 3>)" Study Jn the "<Study Group>" study group."
	And I invite iMedidata user "<iMedidata New User 2>" as a study owner to Study "<Study J (Aux 3)>" with App named "<Edc App>" and the Role "<EDC Role 1>" and App named "<Modules App>" and the Role "<Modules Role 1>"and App "<Security App>" with Role "<Security Role 1>"
	And I select link "Home"
	And I am on the iMedidata Home page
	And I log out as user "<iMedidata User 1 ID>"
	And I log in as user "<iMedidata New User 2>"
	And I am on the iMedidata Home page
	And I accept the invitation
	And I am on the iMedidata Home page
	When I follow EDC link to "<Study J (Aux3)>"
	Then I see the page "<Study J (Aux3)>"
	And I select link "Architect"
	Then I should see there is a Project named "<Study J>"
	And I select link "<Study J>"
	And I select link "Studies Environment Setup"
    And I should see there is an Environment “<Aux 2>” for the Project named "<Study J>"
	And I should see there is an Environment “<Aux 3>” for the Project named "<Study J>"
	And i take a screenshot
'	And it will have enrollment target "<Enrollment Target Number>"
	And I will see environment "<Aux 3>"
    And checkbox "Linked to iMedidata" is checked
	And I take a screenshot


@Rave 2013.2.0.
@PB2.5.8.15-02
@Validation
Scenario: If I have an unlinked study in iMedidata, when the study is created in iMedidata, Rave should do a UUID match, and failing that a name match against the iMedidata study and, if the project and environment name matches but the environment is inactive in Rave, create and link a new environment.

	Given there exists Rave Project "<Study K>"
	And Rave Project "<Study K>" is inactive
	And there is a Study Group named "<Study Group>" in iMedidata
	And I am logged in to iMedidata as user <iMedidata  User 1>"
	And I am an owner of the Study Group named “<Study Group>”
    And I am on the Study Group Manage page for the Study Group named “<Study Group>”
	And I follow "Create New Study"
    And I fill in Textbox “Name” with "<Study K> 
    And I fill in “Protocol Number” with “<Protocol Number6>”
	And I enter a number "<Enrollment Target Number>" in textbox "Enrollment Target" 
	And I check checkbox "Is Production"
	And I select button "Save"
	And I should see message “You successfully created the "<Study K>" study in the "<Study Group>" study group."
	And I invite iMedidata user "<iMedidata New User 2>" as a study owner to Study "<Study K>" with App named "<Edc App>" and the Role "<EDC Role 1>" and App named "<Modules App>" and the Role "<Modules Role 1>"and App "<Security App>" with Role "<Security Role 1>"
	And I select link "Home"
	And I am on the iMedidata Home page
	And I log out as user "<iMedidata User 1 ID>"
	And I log in as user "<iMedidata New User 2>"
	And I am on the iMedidata Home page
	And I accept the invitation
	When I follow EDC link to "<Study K>"
	And I select link "Architect"
	And I select link "<Study K>'
	And I select link "Studies Environment Setup"
	And it will have enrollment target "<Enrollment Target Number>"
    Then I should see checkbox "Linked to iMedidata" is checked
	And I take a screenshot




@releaseRave2012.2.0

@PB2.5.8.39-2
@FUTURE
Scenario: If I have an unlinked, deleted study in iMedidata, and a project + environment in Rave that is not linked to that study, when Rave receives a studysite or user assignment to that unlinked deleted study, Rave should ignore it, logging the message as not processed.

#IS this even possible? How is an iMedidata user supposed to access a deleted study in order to make assignments?
