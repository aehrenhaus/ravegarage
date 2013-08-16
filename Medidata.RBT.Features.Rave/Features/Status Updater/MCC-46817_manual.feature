@ignore
@FT_MCC-46817

Feature: MCC-46817 Status Status Updater doesn't list all possible folders/forms, if subjects are in different crf versions

Background: 

	Given I am an Rave user "<Rave User>" with username "<Rave User Name>", password "<Rave Password>"
		|Rave User		|Rave User Name		|Rave Password		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|
	    
	And there exists Rave study "<Rave Study>"
		|{Study A}	|
   
    And there exists site "<Site>" in study "<Rave Study>", with environment "<Environment>" and "<CRF>" versions	
		|Study		|Site		|Environment	|StudySiteNo	|CRF			|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|{Crf Ver 1}	|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|{Crf Ver 2}	|

	And Crf Ver 1 consists of the following Forms
	And there exists a form "<Form1>" with form OID "<FormOid1>"
	And there exists a standard field "<Field1A>" with field OID "<FieldOid1A>"
	And there exists a standard field "<Field2A>" with field OID "<FieldOid2A>"
	
	And there exists a form "<Form2>" with form OID "<FormOid2>"
	And there exists a standard field "<Field1B>" with field OID "<FieldOid1B>"
	And there exists a standard field "<Field2B>" with field OID "<FieldOid2B>"

	And there exists a form "<PrimaryForm>" with form OID "<PrimaryForm>"
	And there exists a standard field "<SubName>" with field OID "<NameOid>" and a standard field "<SubNumber>" with field OID "<NumberOID>"
	
	And Crf Ver 1 consist of the following Folders
	And there exist a folder "<FolderA>" with folder OID "<FolderA>"
	And there exist a folder "<FolderB>" with folder OID "<FolderB>"
	And there exist a folder "<Subject>" 
	
	And CRF Ver 1 consist of the following Matrix
	And there exits a matrix "<Base>" with matrix OID "<BaseOid>"
	And there exits "<Form1>" and "<Form2>" with folder "<Subject>" combination
	And there exits "<Form1>" and "<Form2>" with folder "<FolderA>" combination
	And there exits "<Form2>" with folder "<FolderB>" combination
	
	And CRF Ver 2 consists of the following Forms	
	And there exists a form "<Form1>" with form OID "<FormOid1>"
	And there exists a standard field "<Field1A>" with field OID "<FieldOid1A>"
	And there exists a standard field "<Field2A>" with field OID "<FieldOid2A>"
	
	And there exists a form "<Form2>" with form OID "<FormOid2>"
	And there exists a Log field "<Field1B>" with field OID "<FieldOid1B>"
	And there exists a Log field "<Field2B>" with field OID "<FieldOid2B>"
	
	And there exists a form "<Form3>" with form OID "<FormOid3>"
	And there exists a standard field "<Field1C>" with field OID "<FieldOid1C>" 
	And there exists a standard field "<Field2C>" with field OID "<FieldOid2C>"
	
	And there exists a form "<Form4>" with form OID "<FormOid4>"
	And there exists a standard field "<Field1D>" with field OID "<FieldOid1D>"

	And there exists a form "<PrimaryForm>" with form OID "<PrimaryForm>"
	And there exists a standard field "<SubName>" with field OID "<NameOid>" and a standard field "<SubNumber>" with field OID "<NumberOID>"
	
	And CRF Ver 2 consist of the following Folders
	And there exist a folder "<FolderA>" with folder OID "<FolderA>"
	And there exist a folder "<FolderB>" with folder OID "<FolderB>"
	And there exist a folder "<FolderC>" with folder OID "<FolderC>"
	And there exist a folder "<Subject>" 
	
	And CRF Ver 2 consist of the following Matrix
	And there exits a matrix "<Base>" with matrix OID "<Base>"
	And there exits "<Form1>" "<Form2>" "<Form3>" and "<Form4>" with folder "<Subject>" combination
	And there exits "<Form1>" "<Form2>" "<Form3>" and "<Form4>" with folder "<FolderA>" combination
	And there exits "<Form2>" "<Form3>" and "<Form4>" with folder "<FolderB>" combination
	And there exits "<Form3>" and "<Form4>" with folder "<FolderC>" combination
	

	And there exist "<Rave URL>" 
		|Rave URL		|
		|{Rave URL 1}	|
		
	And I am assigned to the Status Updater Report
	And I am assigned to the Status Updater Configuration Report
	And CRF Ver 1 has been pushed to "<Site A1>"
	 
#-------------------------------------------------------------------------------------------------------------------------
@Release_2013.1.0
@PB_MCC-46817-01
@HR_6.Feb.2013
@Validation
@manual

Scenario: MCC-46817-01 Status Updater lists all possible folders/forms, correctly even if subjects are in different crf versions. 

Given I am a Rave user "<Rave User 1>"

And I am logged in to Rave
And I select study "<Study A>"
And I select site "<Site A1>"
And I create a subject according to the following table
|Study		|Site		|CRF		|Subject	|
|Study A	|Site A1	|Crf Ver 1	|Subject 1	|
And I take screenshot

And I select link "<Home>"
And I select link "Architect"
And I select "<Study A>"
And I publish a new CRF version "<Crf Ver 2>"
And I push the new CRF version to "<Site A1>"
And I take screenshot

And I select link "<Home>"
And select link "<Study A>"
And I select link "<Site A1>"
And I create a subject according to the following table 
|Study		|Site		|CRF		|Subject	|
|Study A	|Site A1	|Crf Ver 2	|Subject 2	|
And I take screenshot

And I select link "<Home>"
And I select link "<Reporter>" 
And I select Status Updater Configuration
And I select the following configuration

|Action					|Yes		|No		|
|Enable Veify Action	| select	|		|
|Enable Review Action	| select	|		|
|Enable Freeze Action	| select	|		|
|Enable Lock Action		| select	|		|
|Require Signature		| 	  		|select	|

And I select button "<Update>"
And I take screenshot
And I close the Status Updater Configuration window

And I go to My Reports
And I select Status Updater
And I select the following Report Patameters

|Study		|Site Group	|Sites		|Subjects			|
|Study A	|World		|Site A1	|Subject 1			|

And I take a screenshot
When I select button "<Submit Report>"
Then I should see a new Status Updater window open

And I verify that the correct study "<Study A>" is displayed
And I verify that "<Subject 1>" has been selected
And I select link "<Select All Folders>"
And I select link "<Select All Forms>"
And I select link "<Select>"
And I verify the number of Folder/Form combinations selected under Folders/ Forms is 6
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 1>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 2>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<PRIMARY>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form1>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form2>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form2>", and Subjects "1"
And I take a screenshot

And I close the Status Updater window
And I go to My Reports
And I select Status Updater
And I select the following Report Patameters

|Study		|Site Group	|Sites		|Subjects			|
|Study A	|World		|Site A1	|Subject  2			|

And I take a screenshot
When I select button "<Submit Report>"

Then I should see a new Status Updater window open

And I verify that the correct study "<Study A>" is displayed
And I verify that "<Subject 2>" has been selected
And I select link "<Select All Folders>"
And I select link "<Select All Forms>"
And I select link "<Select>"
And I verify the number of Folder/Form combinations selected under Folders/ Forms is 14
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 1>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 2>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 4>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<PRIMARY>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form1>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form2>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form4>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form2>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form4>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder C>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder C>", Form Name "<Form4>", and Subjects "1"
And I take a screenshot

And I close the Status Updater window
And I go to My Reports
And I select Status Updater
And I select the following Report Patameters

|Study		|Site Group	|Sites		|Subjects			|
|Study A	|World		|Site A1	|Subjects 1 and  2	|

And I take a screenshot
When I select button "<Submit Report>"

Then I should see a new Status Updater window open

And I verify that the correct study "<Study A>" is displayed
And I verify that "<Subject 1> and <Subject 2>"" have been selected
And I select link "<Select All Folders>"
And I select link "<Select All Forms>"
And I select link "<Select>"
And I verify the number of Folder/Form combinations selected under Folders/ Forms is 14
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 1>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 2>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 4>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<PRIMARY>", and Subjects "2"

And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form1>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form2>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form4>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form2>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form4>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder C>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder C>", Form Name "<Form4>", and Subjects "1"

And I take a screenshot

#-----------------------------------------------------------------------------------------------------------------------------------
@Release_2013.1.0
@PB_MCC-46817-02
@HR_6.Feb.2013
@Validation
@manual

Scenario: MCC-46817_002 Status Updater lists all possible folders/forms, correctly even if subjects are in different crf versions. 

Given I am a Rave user "<Rave User 1>"

And I am logged in to Rave
And I select study "<Study A>"
And I select site "<Site A1>"
And I create a subject according to the following table
|Study		|Site		|CRF		|Subject	|
|Study A	|Site A1	|Crf Ver 1	|Subject 1	|
And I take screenshot

And I select link "<Home>"
And I select link "Architect"
And I select "<Study A>"
And I publish a new CRF version "<Crf Ver 2>"
And I push the new CRF version to "<Site A1>"
And I take screenshot

And I select link "<Home>"
And select link "<Study A>"
And I select link "<Site A1>"
And I create a subject according to the following table 
|Study		|Site		|CRF		|Subject	|
|Study A	|Site A1	|Crf Ver 2	|Subject 2	|
And I take screenshot

And I select link "<Home>"
And I select link "<Reporter>" 
And I select Status Updater Configuration
And I select the following configuration

|Action					|Yes		|No		|
|Enable Veify Action	| select	|		|
|Enable Review Action	| select	|		|
|Enable Freeze Action	| select	|		|
|Enable Lock Action		| select	|		|
|Require Signature		| 	  		|select	|

And I select button "<Update>"
And I take screenshot
And I close the Status Updater Configuration window

And I go to My Reports
And I select Status Updater
And I select the following Report Patameters

|Study		|
|Study A	|

And I take a screenshot
When I select button "<Submit Report>"
Then I should see a new Status Updater window open

And I select "<Site A1>" from Site field
And I select link "<Search>"
And I select "<Subject 1>"
And I select link "<Select>"
And I verify that "<Subject 1>" has been selected
And I select link "<Select All Folders>"
And I select link "<Select All Forms>"
And I select link "<Select>"
And I verify the number of Folder/Form combinations selected under Folders/ Forms is 6
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 1>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 2>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<PRIMARY>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form1>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form2>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form2>", and Subjects "1"
And I take a screenshot

And I remove the subject previously selected
And I select "<Site A1>" from Site field
And I select link "<Search>"
And I select "<Subject 2>"
And I select link "<Select>"
And I verify that "<Subject 2>" has been selected
And I select link "<Select All Folders>"
And I select link "<Select All Forms>"
And I select link "<Select>"
And I verify the number of Folder/Form combinations selected under Folders/ Forms is 14
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 1>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 2>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 4>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<PRIMARY>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form1>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form2>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form4>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form2>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form4>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder C>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder C>", Form Name "<Form4>", and Subjects "1"
And I take a screenshot

And I remove the subject previously selected
And I select "<Site A1>" from Site field
And I select link "<Search>"
And I select "<Subject 1>" and "<Subject 2>"
And I select link "<Select>"
And I verify that "<Subject 1>" and "<Subject 2>" has been selected
And I select link "<Select All Folders>"
And I select link "<Select All Forms>"
And I select link "<Select>"
And I verify the number of Folder/Form combinations selected under Folders/ Forms is 14
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 1>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 2>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<Form 4>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Subject Level>", Form Name "<PRIMARY>", and Subjects "2"

And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form1>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form2>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder A>", Form Name "<Form4>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form2>", and Subjects "2"
And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder B>", Form Name "<Form4>", and Subjects "1"

And I see row in Folders/Forms pane with Folder Name "<Folder C>", Form Name "<Form3>", and Subjects "1"
And I see row in Folders/Forms pane with Folder Name "<Folder C>", Form Name "<Form4>", and Subjects "1"
And I take a screenshot

#-----------------------------------------------------------------------------------------------------------------------------------
