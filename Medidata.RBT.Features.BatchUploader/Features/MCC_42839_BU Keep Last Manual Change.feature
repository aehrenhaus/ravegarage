Feature: Batch Upload Keep Last Manual Change (configuration 42839)

Background:

	 Given I am an Rave user "<Rave User>" with username "<Rave User Name>", password "<Rave Password>" and email "<Rave Email>"
		|Rave User		|Rave User Name		|Rave Password		|Rave Email		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|.
	    
	And there exists Rave study "<Rave Study>" 
		|{Study A}	|
   
    And there exists site "<Site>" in study "<Study>", with environment "<Environment>"	and CRF version "<CRF>" in iMedidata and with Study-Site number "<StudySiteNo>"	
		|Study		|Site		|Environment	|StudySiteNo	|CRF			|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|{Crf Ver 1}	|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|{Crf Ver 2}	|

	And there exists a form "<StdForm>" with form OID "<FormOid1>"
	And there exists a standard field "<Field1A>" with field OID "<FieldOid1A>" with a default value "<default 1>" 
	And there exists a standard field "<Field1B>" with field OID "<FieldOid1B>" with no default value
	
	And there exists a form "<LogForm>" with form OID "<FormOid2>"
	And there exists a Log field "<LogField2A>" with field OID "<FieldOid2A>" with a default value "<default 1>" 
	And there exists a Log field "<LogField2B>" with field OID "<FieldOid2B>" with no default value

	And there exists a form "<MixForm>" with form OID "<FormOid3>"
	And there exists a standard field "<Field3A>" with field OID "<FieldOid3A>" 
	And there exists a log field "<Field3B>" with field OID "<FieldOid3B>" 
	And there exists a log field "<Field3C>" with field OID "<FieldOid3C>"
	And there exists a standard field "<Field3D>" with field OID "<FieldOid3D>" that is not visible.

	And there exists a form "<PrimaryForm>" with form OID "<PrimaryForm>"
	And there exists a standard field "<SubName>" with field OID "<NameOid>" and a standard field "<SubNumber>" with field OID "<NumberOID>"

	And there exist "<Rave URL>" 
		|Rave URL		|
		|{Rave URL 1}	|
	
	Input Path	
	And there exists a BU configuration "<BU Configuration>" with input path "<Input Path>" for all environments
		|BU Configuration	|Input Path		|
		|{BU Config 1}		|{Input Path 1}	|

	Email
	And there exists a BU configuration "<BU Configuration> with"Email Settings that contain type "<Type>", environment "<Environment>", to "<To>", from "<From>", subject "<Subject>" and body "<Body>".
		|BU Configuration	|Type		|Environment	|To				|From				|Subject				|Body					|
		|{BU Config 1}		|{Success}	|{Prod}			|{Rave Email 1}	|{System@mdsol.com}	|{Successful Upload}	|{Successful Upload}	|
		|{BU Config 1}		|{Failure}	|{Prod}			|{Rave Email 1}	|{System@mdsol.com}	|{Failed Upload}		|{Failed Upload}		|

	File Format
	And there exists a BU configuration "<BU Configuration> with the File Format structure is"<Project>"_"Environment>"_"<Source>"_"<Data Type>"_"<Load Type>"_"<Date>".txt
		|BU Configuration	|Project	|Environment		|Source		|Data Type		|Load Type	|Date				|
		|{BU Config 1}		|{Study A}	|{Env 1}			|{Source1}		|{DataType1}	|{FULL}		|{yyyyMMMddmmssnn}	|
		|{BU Config 1}		|{Study B}	|{Env 1}			|{Source1}		|{DataType1}	|{FULL}		|{yyyyMMMddmmssnn}	|	
		
	And the File format structure for Delimeter "|"
	And the checkbox "Has Header" is "true"	
	And the checkbox "Has Marking Delimeter" is "false"
	And the checkbox "Use Study Site Number" is "true"	

	Upload Actions
	And there exists a BU configuration "<BU Configuration> with Upload Actions are "<Upload Action>", "<Condition>"
		|BU Configuration	|Upload Action						|Condition		|
		|{BU Config 1}		|{Load Type}						|{Incremental}	|
		|{BU Config 1}		|{Close Missing Fields}				|checked		|
		|{BU Config 1}		|{Keep Last Manual Change}			|unchecked		|
		|{BU Config 1}		|{Matrix OID}						|{<DEFAULT>}	|
		|{BU Config 1}		|{Add If Not In Matrix}				|unchecked		|
		|{BU Config 1}		|{Create Subjects}					|checked		|
		|{BU Config 1}		|{Create Folders}					|checked		|	
		|{BU Config 1}		|{Create Forms}						|unchecked		|
		|{BU Config 1}		|{Create Log Lines}					|checked		|
		|{BU Config 1}		|{Lock Records}						|unchecked		|
		|{BU Config 1}		|{Change Code}						|blank			|
		|{BU Config 1}		|{Require ManualClose For Queries}	|unchecked		|
		|{BU Config 1}		|{Use Folder Algorithms}			|unchecked		|


#--------------------------------------------------------------------------------------------------------------------------------------

@Scenario MCC42839-01
@Validation
Scenario outline: As a Rave user, I want to change the data in a data field and keep that value after a file is batch uploaded

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"

And there exists a form "<StdForm>" with form OID "<FormOid1>" in site "<Site A1>" in study "<Study A>"
And there exists a form "<LogForm>" with form OID "<FormOid2>" in site "<Site A1>" in study "<Study A>"
And there exists a form "<MixForm>" with form OID "<FormOid3>" in site "<Site A1>" in study "<Study A>"

And I am logged in to the Batch Upload UI
And I select project "<Study A>"
And I select BU Configuration "<BU Config 1>"
And I select link "Upload Actions"
And I modify the upload actions page as follows
	|BU Configuration	|Upload Action						|Condition		|
	|{BU Config 1}		|{Keep Last Manual Change}			|checked		|
	|{BU Config 1}		|{Load Type}						|Cumulative		|
And I take a screenshot
And I select button "Update

And I select link "Data Mappings"
And I add mappings with "<File Column>", "<Reference Type>", "<Folder OID>", Form OID>", "<Form Ordinal>", "<Field OID>"
	|File Column	|Reference Type>	|Folder OID	|Form OID>			|Form Ordinal	|Field OID		|
	|1				|Data				|blank		|"<PrimaryForm>"	|1				|"<NameOid>"	|
	|2				|Data				|blank		|"<PrimaryForm>"	|1				|"<NumberOid>"	|
	|2				|Subject reference	|blank		|blank				|blank			|"<NumberOid>"	|
	|3				|Data				|blank		|"<FormOid1>"		|1				|"<FieldOid1A>"	|
	|4				|Data				|blank		|"<FormOid1>"		|1				|"<FieldOid1B>"	|
	|5				|Site				|blank		|blank				|blank			|blank			|

And I create a txt file with the following headings and data
	|"<NameOid>"	|"<NumberOid>"		|"<FieldOid1A>"		|"<FieldOid1B>"	|"Site				|
	|"<SubName>"	|"<SubNum>1"		|"<Data 1A>"		|"<Data 1B>"	|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>2"		|"<Data 1A>"		|"<Data 1B>"	|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>3"		|"<Data 1A>"		|"<Data 1B>"	|"<StudySiteNo1>"	|


And I save file "<File 1>" as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<FULL>_<yyyyMMMddmmssnn>.txt>"
And I select tab "<Study A>"
And I select link "Refresh Service"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot

And I navigate to Rave
And I select site "<Site A1>" in study "<Study A>"
And I select subject with Subject name "<SubName>""<SubNum>"	
When I follow link "<StdForm>"
Then I should data in all fields
And I take a screenshot

And in the form "<StdForm>" I change the data in field "<FieldOid1A>" to data "<Data 1A>x"
And I take a screenshot

And I verify on the audit trail that the data in standard field "<FieldOid1A>"" has data "<Data 1>" was entered by "Rave Import"
And I verify on the audit trail that the data in standard field "<FieldOid1A>"" has data "<Data 1>x" was entered by "<Rave User 1>"
And I take a screenshot

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I take a screenshot

And I navigate to Rave
And I select site "<Site A1>" in study "<Study A>"
And I select subject with Subject name "<SubName>""<SubNum>"	
When I follow link "<StdForm>"
Then I should see that the data in field "<FieldOid1A>" is data "<Data 1>x"
And I take a screenshot

And I verify on the audit trail that the data in standard field "<FieldOid1A>" has data "<Data 1>" was entered by "Rave Import"
And I verify on the audit trail that the data in standard field "<FieldOid1A>" has data "<Data 1>x" was entered by "<Rave User 1>"


