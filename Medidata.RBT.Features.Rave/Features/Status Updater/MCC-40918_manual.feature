@ignore
@FT_MCC-40918

Feature: MC-40918 Incorrect statuses and audit were displayed in EDC when large Status Updater Jobs are run

Background:

	Given I am an Rave user "<Rave User>" with username "<Rave User Name>", password "<Rave Password>"
		|Rave User	|Rave User Name		|Rave Password		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|
		|{Rave User 2}	|{Rave User Name 2}	|{Rave Password 2}	|
	    
	And there exists Rave study "<Rave Study>" 
		|{Study A}	|
   
    And there exists site "<Site>" in study "<Rave Study>", with environment "<Environment>" and "<CRF>" versions	
		|Study		|Site		|Environment	|StudySiteNo	|CRF			|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|{Crf Ver 1}	|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|{Crf Ver 2}	|

	And CRF Ver 1 consists of the following Forms
	And there exists a form "<Form1>" with form OID "<FormOid1>"
	And there exists a standard field "<Field1A>" with field OID "<FieldOid1A>"
	And there exists a standard field "<Field2A>" with field OID "<FieldOid2A>"
	

	And there exists a form "<PrimaryForm>" with form OID "<PrimaryForm>"
	And there exists a standard field "<SubName>" with field OID "<NameOid>" and a standard field 	"<SubNumber>" with field OID "<NumberOID>"
	
	And CRF Ver 1 consist of the following Folders
	And there exist a folder "<FolderA>" with folder OID "<FolderA>"
	And there exist a folder "<Subject>" 
	
	And CRF Ver 1 consist of the following Matrix
	And there exits a matrix "<Base>" with matrix OID "<Base>"
	And there exits "<Form1>" with folder "<FolderA>" combination
	
	
	And CRF Ver 2 consists of the following Forms	
	And there exists a form "<Form1>" with form OID "<FormOid1>"
	And there exists a standard field "<Field1A>" with field OID "<FieldOid1A>"
	And there exists a standard field "<Field2A>" with field OID "<FieldOid2A>"
	

	And there exists a form "<PrimaryForm>" with form OID "<PrimaryForm>"
	And there exists a standard field "<SubName>" with field OID "<NameOid>" and a standard field "<SubNumber>" 	with field OID "<NumberOID>"
	
	And CRF Ver 2 consist of the following Folders
	And there exist a folder "<FolderA>" with folder OID "<FolderA>"
	And there exist a folder "<Subject>" 
	
	And CRF Ver 2 consist of the following Matrix
	And there exits a matrix "<Base>" with matrix OID "<Base>"
	And there exits "<Form1>" with folder "<FolderA>" combination
		
	And I am assigned to the Status Updater Report
	And I am assigned to the Status Updater Configuration Report

	And there exists subjects "<Subject>" on site "<Site>" with "<CRF>" version
		|Subject	|Site		|CRF		|
		|{Subject 1}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 2}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 3}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 4}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 5}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 6}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 7}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 8}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 9}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 10}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 11}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 12}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 13}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 14}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 15}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 16}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 17}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 18}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 19}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 20}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 21}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 22}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 23}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 24}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 25}	|{Site A1}	|{Crf Ver 1}	|
		|{Subject 26}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 27}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 28}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 29}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 30}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 31}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 32}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 33}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 34}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 35}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 36}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 37}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 38}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 39}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 40}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 41}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 42}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 43}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 44}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 45}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 46}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 47}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 48}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 49}	|{Site A1}	|{Crf Ver 2}	|
		|{Subject 50}	|{Site A1}	|{Crf Ver 2}	|

	And there exist "<Rave URL>" 
		|Rave URL		|
		|{Rave URL 1}	|
	
	
#--------------------------------------------------------------------------------------------------------------------------------------
@Release_2013.1.0
@PB_MCC-4918-01
@HR_6.Mar.2013
@Validation
@manual

Scenario: MCC-4918-01 Incorrect statuses and audit were displayed in EDC when large Status Updater Jobs are run 

Given I am a Rave user "<Rave User 1>"
And I launch IE browser
And I am logged in to Rave
And I select link "Reporter"
And I select link "Status Updater"
And I select study "<Study A>"
When I click button "Submit Report"
Then I see the Status Updater homepage
And I should see text "<Study A>" in "Study" section
And I should see "Site Group" default "World"
And I take a screenshot

And I select from Site Dropdown site "<Site A1>"
When I select the following subjects "<Subject>"
	|Subject		|
	|{Subject 1}	|	
	|{Subject 2}	|	
	|{Subject 3}	|	
	|{Subject 4}	|	
	|{Subject 5}	|	
	|{Subject 6}	|	
	|{Subject 7}	|
	|{Subject 8}	|	
	|{Subject 9}	|
	|{Subject 10}	|	
	|{Subject 11}	|	
	|{Subject 12}	|	
	|{Subject 13}	|	
	|{Subject 14}	|	
	|{Subject 15}	|	
	|{Subject 16}	|	
	|{Subject 17}	|
	|{Subject 18}	|	
	|{Subject 19}	|
	|{Subject 20}	|
	|{Subject 21}	|	
	|{Subject 22}	|	
	|{Subject 23}	|	
	|{Subject 24}	|	
	|{Subject 25}	|	
	|{Subject 26}	|	
	|{Subject 27}	|
	|{Subject 28}	|	
	|{Subject 29}	|
	|{Subject 30}	|
	|{Subject 31}	|	
	|{Subject 32}	|	
	|{Subject 33}	|	
	|{Subject 34}	|	
	|{Subject 35}	|	
	|{Subject 36}	|	
	|{Subject 37}	|
	|{Subject 38}	|	
	|{Subject 39}	|
	|{Subject 40}	|
	|{Subject 41}	|	
	|{Subject 42}	|	
	|{Subject 43}	|	
	|{Subject 44}	|	
	|{Subject 45}	|	
	|{Subject 46}	|	
	|{Subject 47}	|
	|{Subject 48}	|	
	|{Subject 49}	|
	|{Subject 50}	|

Then I should see text "50" Subjects Selected
And I should see "<Subject> "<Site>"
	|Subject		|Site		|
	|{Subject 1}	|{Site A1}	|	
	|{Subject 2}	|{Site A1}	|	
	|{Subject 3}	|{Site A1}	|	
	|{Subject 4}	|{Site A1}	|	
	|{Subject 5}	|{Site A1}	|	
	|{Subject 6}	|{Site A1}	|	
	|{Subject 7}	|{Site A1}	|
	|{Subject 8}	|{Site A1}	|
	|{Subject 9}	|{Site A1}	|
	|{Subject 10}	|{Site A1}	|	
	|{Subject 11}	|{Site A1}	|
	|{Subject 12}	|{Site A1}	|	
	|{Subject 13}	|{Site A1}	|	
	|{Subject 14}	|{Site A1}	|	
	|{Subject 15}	|{Site A1}	|	
	|{Subject 16}	|{Site A1}	|	
	|{Subject 17}	|{Site A1}	|
	|{Subject 18}	|{Site A1}	|
	|{Subject 19}	|{Site A1}	|
	|{Subject 20}	|{Site A1}	|	
	|{Subject 21}	|{Site A1}	|
	|{Subject 22}	|{Site A1}	|	
	|{Subject 23}	|{Site A1}	|	
	|{Subject 24}	|{Site A1}	|	
	|{Subject 25}	|{Site A1}	|	
	|{Subject 26}	|{Site A1}	|	
	|{Subject 27}	|{Site A1}	|
	|{Subject 28}	|{Site A1}	|
	|{Subject 29}	|{Site A1}	|
	|{Subject 30}	|{Site A1}	|	
	|{Subject 31}	|{Site A1}	|
	|{Subject 32}	|{Site A1}	|	
	|{Subject 33}	|{Site A1}	|	
	|{Subject 34}	|{Site A1}	|	
	|{Subject 35}	|{Site A1}	|	
	|{Subject 36}	|{Site A1}	|	
	|{Subject 37}	|{Site A1}	|
	|{Subject 38}	|{Site A1}	|
	|{Subject 39}	|{Site A1}	|
	|{Subject 40}	|{Site A1}	|	
	|{Subject 41}	|{Site A1}	|
	|{Subject 42}	|{Site A1}	|	
	|{Subject 43}	|{Site A1}	|	
	|{Subject 44}	|{Site A1}	|	
	|{Subject 45}	|{Site A1}	|	
	|{Subject 46}	|{Site A1}	|	
	|{Subject 47}	|{Site A1}	|
	|{Subject 48}	|{Site A1}	|
	|{Subject 49}	|{Site A1}	|
	|{Subject 50}	|{Site A1}	|		
		
And I take a screenshot

And I select folder "<All folders>" and form "<All forms>"
When I click link "Select"
Then I see text "2 folder/Form Combination Selected"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Primary>", and Subjects "50"
And I see row in Folders/Forms pane with Folder Name "<FolderA>", Form Name "<Form1>", and Subjects "50"
And I take a screenshot

And in Choose Actions Pane I check "Set Freeze" checkbox
When I click link "Select"
Then the "Confirm" pane is displayed
And I take a screenshot


When I select link "Confirm"
Then the Status Updater Job file is displayed
And I should see the following text

 * Status Update Job:  Completed

 And I take a screenshot

Given I am a Rave user "<Rave User 1>"
And I launch IE browser
And I am logged in to Rave
And I select link "Reporter"
And I select link "Status Updater"
And I select study "<Study A>"
When I click button "Submit Report"
Then I see the Status Updater homepage
And I should see text "<Study A>" in "Study" section
And I should see "Site Group" default "World"
And I take a screenshot

And I select from Site Dropdown site "<Site A1>"
When I select the following subjects "<Subject>"
	|Subject		|
	|{Subject 1}	|	
	|{Subject 2}	|	
	|{Subject 3}	|	
	|{Subject 4}	|	
	|{Subject 5}	|	
	|{Subject 6}	|	
	|{Subject 7}	|
	|{Subject 8}	|	
	|{Subject 9}	|
	|{Subject 10}	|	
	|{Subject 11}	|	
	|{Subject 12}	|	
	|{Subject 13}	|	
	|{Subject 14}	|	
	|{Subject 15}	|	
	|{Subject 16}	|	
	|{Subject 17}	|
	|{Subject 18}	|	
	|{Subject 19}	|
	|{Subject 20}	|
	|{Subject 21}	|	
	|{Subject 22}	|	
	|{Subject 23}	|	
	|{Subject 24}	|	
	|{Subject 25}	|	
	|{Subject 26}	|	
	|{Subject 27}	|
	|{Subject 28}	|	
	|{Subject 29}	|
	|{Subject 30}	|
	|{Subject 31}	|	
	|{Subject 32}	|	
	|{Subject 33}	|	
	|{Subject 34}	|	
	|{Subject 35}	|	
	|{Subject 36}	|	
	|{Subject 37}	|
	|{Subject 38}	|	
	|{Subject 39}	|
	|{Subject 40}	|
	|{Subject 41}	|	
	|{Subject 42}	|	
	|{Subject 43}	|	
	|{Subject 44}	|	
	|{Subject 45}	|	
	|{Subject 46}	|	
	|{Subject 47}	|
	|{Subject 48}	|	
	|{Subject 49}	|
	|{Subject 50}	|

Then I should see text "50" Subjects Selected
And I should see "<Subject> "<Site>"
	|Subject		|Site		|
	|{Subject 1}	|{Site A1}	|	
	|{Subject 2}	|{Site A1}	|	
	|{Subject 3}	|{Site A1}	|	
	|{Subject 4}	|{Site A1}	|	
	|{Subject 5}	|{Site A1}	|	
	|{Subject 6}	|{Site A1}	|	
	|{Subject 7}	|{Site A1}	|
	|{Subject 8}	|{Site A1}	|
	|{Subject 9}	|{Site A1}	|
	|{Subject 10}	|{Site A1}	|	
	|{Subject 11}	|{Site A1}	|
	|{Subject 12}	|{Site A1}	|	
	|{Subject 13}	|{Site A1}	|	
	|{Subject 14}	|{Site A1}	|	
	|{Subject 15}	|{Site A1}	|	
	|{Subject 16}	|{Site A1}	|	
	|{Subject 17}	|{Site A1}	|
	|{Subject 18}	|{Site A1}	|
	|{Subject 19}	|{Site A1}	|
	|{Subject 20}	|{Site A1}	|	
	|{Subject 21}	|{Site A1}	|
	|{Subject 22}	|{Site A1}	|	
	|{Subject 23}	|{Site A1}	|	
	|{Subject 24}	|{Site A1}	|	
	|{Subject 25}	|{Site A1}	|	
	|{Subject 26}	|{Site A1}	|	
	|{Subject 27}	|{Site A1}	|
	|{Subject 28}	|{Site A1}	|
	|{Subject 29}	|{Site A1}	|
	|{Subject 30}	|{Site A1}	|	
	|{Subject 31}	|{Site A1}	|
	|{Subject 32}	|{Site A1}	|	
	|{Subject 33}	|{Site A1}	|	
	|{Subject 34}	|{Site A1}	|	
	|{Subject 35}	|{Site A1}	|	
	|{Subject 36}	|{Site A1}	|	
	|{Subject 37}	|{Site A1}	|
	|{Subject 38}	|{Site A1}	|
	|{Subject 39}	|{Site A1}	|
	|{Subject 40}	|{Site A1}	|	
	|{Subject 41}	|{Site A1}	|
	|{Subject 42}	|{Site A1}	|	
	|{Subject 43}	|{Site A1}	|	
	|{Subject 44}	|{Site A1}	|	
	|{Subject 45}	|{Site A1}	|	
	|{Subject 46}	|{Site A1}	|	
	|{Subject 47}	|{Site A1}	|
	|{Subject 48}	|{Site A1}	|
	|{Subject 49}	|{Site A1}	|
	|{Subject 50}	|{Site A1}	|			
		
And I take a screenshot

And I select folder "<All folders>" and form "<All forms>"
When I click link "Select"
Then I see text "2 folder/Form Combination Selected"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Primary>", and Subjects "50"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form1>", and Subjects "50"
And I take a screenshot

And in Choose Actions Pane I check "Set Lock" checkbox
When I click link "Select"
Then the "Confirm" pane is displayed
And I take a screenshot

Given I am a Rave user "<Rave User 2>"
And I launch FF browser
And I am logged in to Rave
And I select link "Reporter"
And I select link "Status Updater"
And I select study "<Study A>"
When I click button "Submit Report"
Then I see the Status Updater homepage
And I should see text "<Study A>" in "Study" section
And I should see "Site Group" default "World"
And I take a screenshot

And I select from Site Dropdown site "<Site A1>"
When I select the following subjects "<Subject>"
	|Subject		|
	|{Subject 1}	|	
	|{Subject 2}	|	
	|{Subject 3}	|	
	|{Subject 4}	|	
	|{Subject 5}	|	
	|{Subject 6}	|	
	|{Subject 7}	|
	|{Subject 8}	|	
	|{Subject 9}	|
	|{Subject 10}	|	
	|{Subject 11}	|	
	|{Subject 12}	|	
	|{Subject 13}	|	
	|{Subject 14}	|	
	|{Subject 15}	|	
	|{Subject 16}	|	
	|{Subject 17}	|
	|{Subject 18}	|	
	|{Subject 19}	|
	|{Subject 20}	|
	|{Subject 21}	|	
	|{Subject 22}	|	
	|{Subject 23}	|	
	|{Subject 24}	|	
	|{Subject 25}	|	
	|{Subject 26}	|	
	|{Subject 27}	|
	|{Subject 28}	|	
	|{Subject 29}	|
	|{Subject 30}	|
	|{Subject 31}	|	
	|{Subject 32}	|	
	|{Subject 33}	|	
	|{Subject 34}	|	
	|{Subject 35}	|	
	|{Subject 36}	|	
	|{Subject 37}	|
	|{Subject 38}	|	
	|{Subject 39}	|
	|{Subject 40}	|
	|{Subject 41}	|	
	|{Subject 42}	|	
	|{Subject 43}	|	
	|{Subject 44}	|	
	|{Subject 45}	|	
	|{Subject 46}	|	
	|{Subject 47}	|
	|{Subject 48}	|	
	|{Subject 49}	|
	|{Subject 50}	|

Then I should see text "50" Subjects Selected
And I should see "<Subject> "<Site>"
	|Subject		|Site		|
	|{Subject 1}	|{Site A1}	|	
	|{Subject 2}	|{Site A1}	|	
	|{Subject 3}	|{Site A1}	|	
	|{Subject 4}	|{Site A1}	|	
	|{Subject 5}	|{Site A1}	|	
	|{Subject 6}	|{Site A1}	|	
	|{Subject 7}	|{Site A1}	|
	|{Subject 8}	|{Site A1}	|
	|{Subject 9}	|{Site A1}	|
	|{Subject 10}	|{Site A1}	|	
	|{Subject 11}	|{Site A1}	|
	|{Subject 12}	|{Site A1}	|	
	|{Subject 13}	|{Site A1}	|	
	|{Subject 14}	|{Site A1}	|	
	|{Subject 15}	|{Site A1}	|	
	|{Subject 16}	|{Site A1}	|	
	|{Subject 17}	|{Site A1}	|
	|{Subject 18}	|{Site A1}	|
	|{Subject 19}	|{Site A1}	|
	|{Subject 20}	|{Site A1}	|	
	|{Subject 21}	|{Site A1}	|
	|{Subject 22}	|{Site A1}	|	
	|{Subject 23}	|{Site A1}	|	
	|{Subject 24}	|{Site A1}	|	
	|{Subject 25}	|{Site A1}	|	
	|{Subject 26}	|{Site A1}	|	
	|{Subject 27}	|{Site A1}	|
	|{Subject 28}	|{Site A1}	|
	|{Subject 29}	|{Site A1}	|
	|{Subject 30}	|{Site A1}	|	
	|{Subject 31}	|{Site A1}	|
	|{Subject 32}	|{Site A1}	|	
	|{Subject 33}	|{Site A1}	|	
	|{Subject 34}	|{Site A1}	|	
	|{Subject 35}	|{Site A1}	|	
	|{Subject 36}	|{Site A1}	|	
	|{Subject 37}	|{Site A1}	|
	|{Subject 38}	|{Site A1}	|
	|{Subject 39}	|{Site A1}	|
	|{Subject 40}	|{Site A1}	|	
	|{Subject 41}	|{Site A1}	|
	|{Subject 42}	|{Site A1}	|	
	|{Subject 43}	|{Site A1}	|	
	|{Subject 44}	|{Site A1}	|	
	|{Subject 45}	|{Site A1}	|	
	|{Subject 46}	|{Site A1}	|	
	|{Subject 47}	|{Site A1}	|
	|{Subject 48}	|{Site A1}	|
	|{Subject 49}	|{Site A1}	|
	|{Subject 50}	|{Site A1}	|			
		
And I take a screenshot

And I select folder "<All folders>" and form "<All forms>"
When I click link "Select"
Then I see text "2 folder/Form Combination Selected"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Primary>", and Subjects "50"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form1>", and Subjects "50"
And I take a screenshot


And in Choose Actions Pane I check "Clear Freeze" checkbox
When I click link "Select"
Then the "Confirm" pane is displayed
And I take a screenshot

When I select link "Confirm" on both IE and FF browsers at almost the same time
Then the Status Updater Job file is displayed
And I should see the following text for both browsers

 * Status Update Job:  Completed
 
 And I take a screenshot (take screenshot from both browsers)

And I navigate to Rave using IE browser
When I navigate to site "<Site A1>" in study "<Study A>"
Then I see subjects "<sujbect 1> - <subject 50> with correct status icon (Hard Lock)
And I take a screenshot

And I select form "<PrimaryForm>" for subject "<Subject n>"

And I select form "<PrimaryForm>" for subject "<Subject n>"
When I select audit trail for form "<PrimaryForm>"
Then I should see
	|Audit					|User				|
	|Data hard locked.		|"<Rave User 1>"	|
	|Data entry unlocked	|"<Rave User 2>"	|
	|Data entry locked.		|"<Rave User 1>"	|
	|Data Page created.		|"<Rave User 1>"	|
And I take a screenshot

When I select audit trail for field "<SubName>"
Then I see
	|Audit					|User				|
	|Data hard locked.		|"<Rave User 1>"	|
	|Data entry unlocked	|"<Rave User 2>"	|
	|Data entry locked.		|"<Rave User 1>"	|
	|User entered 'data'	|"<Rave User 1>"	|
And I take a screenshot

And I select form "<Form1>" for subject "<Subject n>"
When I select audit trail for form "<Form1>"
Then I should see
	|Audit					|User				|
	|Data hard locked.		|"<Rave User 1>"	|
	|Data entry unlocked	|"<Rave User 2>"	|
	|Data entry locked.		|"<Rave User 1>"	|
	|Data Page created.		|"<Rave User 1>"	|
And I take a screenshot

When I select audit trail for field "<Field1A>"
Then I should see
	|Audit					|User				|
	|Data hard locked.		|"<Rave User 1>"	|
	|Data entry unlocked	|"<Rave User 2>"	|
	|Data entry locked.		|"<Rave User 1>"	|
And I take a screenshot

And I navigate to Rave using FF browser
When I navigate to site "<Site A1>" in study "<Study A>"
Then I see subjects "<sujbect 1> - <subject 50> with correct status icon (Hard Lock)
And I take a screenshot

And I select form "<PrimaryForm>" for subject "<Subject n>"

And I select form "<PrimaryForm>" for subject "<Subject n>"
When I select audit trail for form "<PrimaryForm>"
Then I should see
	|Audit					|User				|
	|Data hard locked.		|"<Rave User 1>"	|
	|Data entry unlocked	|"<Rave User 2>"	|
	|Data entry locked.		|"<Rave User 1>"	|
	|Data Page created.		|"<Rave User 1>"	|
And I take a screenshot

When I select audit trail for field "<SubName>"
Then I see
	|Audit					|User				|
	|Data hard locked.		|"<Rave User 1>"	|
	|Data entry unlocked	|"<Rave User 2>"	|
	|Data entry locked.		|"<Rave User 1>"	|
	|User entered 'data'	|"<Rave User 1>"	|
And I take a screenshot

And I select form "<Form1>" for subject "<Subject n>"
When I select audit trail for form "<Form1>"
Then I should see
	|Audit					|User				|
	|Data hard locked.		|"<Rave User 1>"	|
	|Data entry unlocked	|"<Rave User 2>"	|
	|Data entry locked.		|"<Rave User 1>"	|
	|Data Page created.		|"<Rave User 1>"	|
And I take a screenshot

When I select audit trail for field "<Field1A>"
Then I should see
	|Audit					|User				|
	|Data hard locked.		|"<Rave User 1>"	|
	|Data entry unlocked	|"<Rave User 2>"	|
	|Data entry locked.		|"<Rave User 1>"	|
And I take a screenshot