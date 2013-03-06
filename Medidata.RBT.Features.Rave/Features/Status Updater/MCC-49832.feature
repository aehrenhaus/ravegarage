@ignore
@FT_MCC-49832

Feature: MCC-49832 Status Updater - Subject Sorting and processing issue

Background

	Given I am an Rave user "<Rave User>" with username "<Rave User Name>", password "<Rave Password>"
		|Rave User		|Rave User Name		|Rave Password		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|
			    
	And there exists Rave study "<Rave Study>"
		|{Study A}	|
   
    	And there exists site "<Site>" in study "< Rave Study>", with environment "<Environment>" and "<CRF>" versions	
		|Rave Study	|Site		|Environment	|StudySiteNo	|CRF		|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|{Crf Ver 1}|

	CRF Ver 1 consists of the following Forms
	And there exists a form "<Form1>" with form OID "<FormOid1>"
	And there exists a standard field "<Field1A>" with field OID "<FieldOid1A>"
	And there exists a standard field "<Field2A>" with field OID "<FieldOid2A>"
	
	And there exists a form "<Form2>" with form OID "<FormOid2>"
	And there exists a Log field "<Field1B>" with field OID "<FieldOid1B>"
	And there exists a Log field "<Field2B>" with field OID "<FieldOid2B>"

	And there exists a form "<PrimaryForm>" with form OID "<PrimaryForm>"
	And there exists a standard field "<SubName>" with field OID "<NameOid>" and a standard field "<SubNumber>" with field OID "<NumberOID>"
	
	CRF Ver 1 consist of the following Folders
	And there exist a folder "<FolderA>" with folder OID "<FolderA>"
	And there exist a folder "<FolderB>" with folder OID "<FolderB>"
	And there exist a folder "<Subject>" 
	
	CRF Ver 1 consist of the following Matrix
	And there exits a matrix "<Base>" with matrix OID "<Base>"
	And there exits "<Form1>" and "<Form2>" with folder "<Subject>" combination
	And there exits "<Form1>" and "<Form2>" with folder "<FolderA>" combination
	And there exits "<Form2>" with folder "<FolderB>" combination
	

	And I am assigned to the Status Updater Report
	And I am assigned to the Status Updater Configuration Report
	And CRF Ver 1 has been pushed to "<Site A1>"
	

	And there exist "<Rave URL>" 
		|Rave URL		|
		|{Rave URL 1}	|
	
	
#--------------------------------------------------------------------------------------------------------------------------------------
@Release 2013.1.0
@PBMCC-49832-01
@HR_18.Feb.2013
@Validation

Scenario: MCC-49832-01 Status Updater updates statuses for all datapages correctly even if a lot of forms/folders and subjects with same subject name are selected. 

Given I am a Rave user "<Rave User 1>"
And I am logged in to Rave
And I select study "<Study A>"
And I select site "<Site A1>"
And the CRF version is "<Crf Ver 1>"
And I create a subject and save data according to the following table 
And I take screenshot for each of the forms (screenshots 1a - 1c)

|Study		|Site		|CRF		|Subject	|Subject ID 	|Folder		|Form1		|Form2		|
|Study A	|Site A1	|Crf Ver 1	|Subject 1	|Subject ID 1	|FolderA	|Data 1		|Data 2		|
|Study A	|Site A1	|Crf Ver 1	|Subject 1	|Subject ID 1	|FolderB	|	N/A		|Data 2		|

And I select study "<Study A>"
And I select site "<Site A1>"
And the CRF version is "<Crf Ver 1>"
And I create a subject and save data according to the following table 
And I take screenshot for each of the forms (screenshots 2a - 2c)

|Study		|Site		|CRF		|Subject	|Subject ID 	|Folder		|Form1		|Form 2		|
|Study A	|Site A1	|Crf Ver 1	|Subject 1	|Subject ID 2	|FolderA	|Data 1		|Data 2		|
|Study A	|Site A1	|Crf Ver 1	|Subject 1	|Subject ID 2	|FolderB	|N/A		|Data 2		|

And I select link "Reporter"
And I select link "Status Updater"
And I select study "<Study A>"
And I select "<Site A1>"
When I click button "Submit Report"
Then I see the Status Updater homepage
And I should see text "<Study A>" in "Study" section
And I should see "Site Group" default "World"
And I take a screenshot 3

And I select from Site Dropdown site "<Site A1>" and click the "Search" link
When I select the following subjects "<Subject>"
	|Subject		|
	|{Subject 1}	|	
	|{Subject 1}	|	

Then I should see text "2 Subjects Selected" under Subjects
And I should see "<Subject> "<Site>"
	|Subject	|Site		|
	|{Subject 1}	|{Site A1}	|	
	|{Subject 1}	|{Site A1}	|	
And I take a screenshot 4

And I select folder "<All folders>" and form "<All forms>"
When I click link "Select"
Then I see text "6 folder/Form Combinations Selected"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Primary>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form1>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form1>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<FolderA>", Form Name "<Form1>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<FolderA>", Form Name "<Form2>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<FolderB>", Form Name "<Form2>", and Subjects "2"
And I take a screenshot 5a, 5b

And in Choose Actions Pane I check "Set Lock" checkbox
When I click link "Select"
Then the "Confirm" pane is displayed
And I take a screenshot 6

When I select link "Confirm"
Then the Status Updater Job file is displayed
And I should see the following text

 * Status Update Job Started
 * "<sujbect 2>" - [Subject Level]/Form2 [Lock] processed
 * "<sujbect 2>" - Folder A/Form2 [Lock] processed
 * "<sujbect 2>" - Folder B/Form2 [Lock] processed
 * "<sujbect 2>" - [Subject Level]/Form1 [Lock] processed
 * "<sujbect 2>" - Folder A/Form1 [Lock] processed
 * "<sujbect 2>" - [Subject Level]/Primary [Lock] processed
 * "<sujbect 1>" - [Subject Level]/Form2 [Lock] processed
 * "<sujbect 1>" - Folder A/Form2 [Lock] processed
 * "<sujbect 1>" - Folder B/Form2 [Lock] processed
 * "<sujbect 1>" - [Subject Level]/Form1 [Lock] processed
 * "<sujbect 1>" - Folder A/Form1 [Lock] processed
 * "<sujbect 1>" - [Subject Level]/Primary [Lock] processed
 * Status Update Job:  Completed
And I take a screenshot 7

And I navigate to Rave 
And I navigate to site "<Site A1>" in study "<Study A>"
And I see subject "<subject 1>" with status icon "Lock"
When I select subject "<Subject 1>" with "<Subject ID 1>"
Then I see folder "<FolderA>" with status icon "Lock"
And I see folder "<FolderB>" with status icon "Lock"
And I take a screenshot 8

And I navigate to Rave 
And I navigate to site "<Site A1>" in study "<Study A>"
And I see subject "<subject 1>" with status icon "Lock"
When I select subject "<Subject 1>" with "<Subject ID 2>"
Then I see folder "<FolderA>" with status icon "Lock"
And I see folder "<FolderB>" with status icon "Lock"
And I take a screenshot 9

And I select subject "<Subject 1>" with "<Subject ID 1>"
And I select "Form 1" in FolderA
When I select the datapage audit icon
Then I should see "DataPage created"
And I should see "Data hard locked"
And I take screenshot 10

And I select tab "Form 1" 
When I select the audit icon for "Field 1A"
Then I should see "User entered "<data>"
And I should see "Data hard locked"
And I take screenshot 11

And I select tab "Form 1" 
When I select the audit icon for "Field 2A"
Then I should see "User entered "<data>"
And I should see "Data hard locked"
And I take screenshot 12

And I select "Form 2" in FolderB
And I verify that all data points are locked
When I select the datapage audit icon
Then I should see "DataPage created"
And I should see "Data hard locked"
And I take screenshot 13

And I select tab "Form 2" 
When I select the audit icon for "Field 1B"
Then I should see "User entered "<data>"
And I should see "Data hard locked"
And I take screenshot 14

And I select tab "Form 2" 
When I select the audit icon for "Field 2B"
Then I should see "User entered "<data>"
And I should see "Data hard locked"
And I take screenshot 15

And I select subject "<Subject 1>" with "<Subject ID 2>"
And I select "Form 1" in FolderA
When I select the datapage audit icon
Then I should see "DataPage created"
And I should see "Data hard locked"
And I take screenshot 16

And I select tab "Form 1" 
When I select the audit icon for "Field 1A"
Then I should see "User entered "<data>"
And I should see "Data hard locked"
And I take screenshot 17

And I select tab "Form 1" 
When I select the audit icon for "Field 2A"
Then I should see "User entered "<data>"
And I should see "Data hard locked"
And I take screenshot 18

And I select "Form 2" in FolderB
And I verify that all data points are locked
When I select the datapage audit icon
Then I should see "DataPage created"
And I should see "Data hard locked"
And I take screenshot 19

And I select tab "Form 2" 
When I select the audit icon for "Field 1B"
Then I should see "User entered "<data>"
And I should see "Data hard locked"
And I take screenshot 14

And I select tab "Form 2" 
When I select the audit icon for "Field 2B"
Then I should see "User entered "<data>"
And I should see "Data hard locked"
And I take screenshot 24

And I log out of site