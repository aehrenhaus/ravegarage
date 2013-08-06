Feature: Batch UploadInvisible Fields  

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
	And there exists a standard field "<Field3A>" with field OID "<FieldOid3A>" that is not visible. 
	And there exists a log field "<Field3B>" with field OID "<FieldOid3B>" that is visible. 
	And there exists a log field "<Field3C>" with field OID "<FieldOid3C>" that is visible.
	And there exists a standard field "<Field3D>" with field OID "<FieldOid3D>" that is visible.

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
		|{BU Config 1}		|{Study A}	|{Env 1}			|{ete1}		|{DataType1}	|{INCR}		|{yyyyMMMddmmssnn}	|
		|{BU Config 1}		|{Study B}	|{Env 1}			|{ete1}		|{DataType1}	|{INCR}		|{yyyyMMMddmmssnn}	|	
		
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

@Scenario MCC42830-01
@Validation
Scenario outline: As a Rave user, I want to add data to an invisible field in a MixForm that is not the default value using Batch Upload and confirm the data upload in the audit trail 

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And I am logged in to Rave as Rave user "<Rave User 1>"
And I create a subject "<Subject 1>" in site "<Site A1>" of study "<Study A>" with CRF version "<Crf Ver 1>"
And there exists a form "<MixForm>" with form OID "<FormOid3>" in site "<Site A1>" in study "<Study A>" on the subject level
And I take a screenshot

And I navigate to form "<MixForm>"
And I verify that Standard field "<Field3A>" is not visible
And I verify that log field "<Field3B>" is visible
And I verify that log field "<Field3C>" is visible
And I verify that Standard field "<Field3B>" is visible
And I take a screenshot

And I am logged in to the Batch Upload UI
And I select project "<Study A>"
And I select BU Configuration "<BU Config 1>"
And I select link "Data Mappings"
And I add mappings with "<File Column>", "<Reference Type>", "<Folder OID>", Form OID>", "<Form Ordinal>", "<Field OID>"
	|File Column	|Reference Type>	|Folder OID	|Form OID>			|Form Ordinal	|Field OID		|
	|1				|Data				|blank		|"<PrimaryForm>"	|1				|"<NameOid>"	|
	|2				|Data				|blank		|"<PrimaryForm>"	|1				|"<NumberOid>"	|
	|2				|Subject reference	|blank		|blank				|blank			|"<NumberOid>"	|
	|3				|Data				|blank		|"<FormOid3>"		|1				|"<FieldOid3A>"	|
	|4				|Data				|blank		|"<FormOid3>"		|1				|"<FieldOid3B>"	|
	|5				|Data				|blank		|"<FormOid3>"		|1				|"<FieldOid3C>"	|
	|6				|Data				|blank		|"<FormOid3>"		|1				|"<FieldOid3D>"	|
	|7				|Site				|blank		|blank				|blank			|blank			|

And I select tab "<Study A>"
And I select link "Refresh Service"

And I create a txt file with the following headings and data
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid3A>"	|"<FieldOid3B>"	|"<FieldOid3C>"	|"<FieldOid3D>"	|"Site				|
	|"<SubName>"	|"<SubNum>"		|"<Red>"		|"<Blue>"		|"<Green>"		|1				|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<Study A>_<Env 1>_<ete1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt>"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot

And I navigate to Rave
And I select site "<Site A1>" in study "<Study A>"
And I select subject with Subject name "<SubName>""<SubNum>"	
When I follow link "<MixForm>"
Then I should see 4 fields with data entereed from Batch Upload
And I take a screenshot

And I verify that Standard field "<Field3A>" is now visible
And I verify that log field "<Field3B>" is visible
And I verify that log field "<Field3C>" is visible
And I verify that Standard field "<Field3B>" is visible
And I take a screenshot

And I verify on the audit trail that the DataPoint for standard field "<Field3A>" has been set to visible by "System"
And I take a screenshot

And I verify on the audit trail that the data in standard field "<Field3A>" with data "<Red>" was entered by "Rave Import"
And I take a screenshot

And I verify on the audit trail that the data in log line 1 where field "<Field3B>" has data "<Blue>" was entered by "Rave Import"
And I take a screenshot

And I verify on the audit trail that the data in log line 1 where field "<Field3C>" has data "<Green>" was entered by "Rave Import"
And I take a screenshot

And I verify on the audit trail that the data in standard field "<Field3D>" with data "<1>" was entered by "Rave Import"
And I take a screenshot
