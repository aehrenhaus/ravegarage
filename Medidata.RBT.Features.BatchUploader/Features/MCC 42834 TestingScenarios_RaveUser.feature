Feature: Batch Upload UI Delete a Log Line (configuration 42834)

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
	And there exists a standard field "<Field3A>" with field OID "<FieldOid3A>" and a log field "<Field3B>" with field OID "<FieldOid3B>" 

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
		|BU Configuration	|Project	|Environment		|Source			|Data Type		|Load Type	|Date				|
		|{BU Config 1}		|{Study A}	|{Env 1}			|{Source1}		|{DataType1}	|{INCR}		|{yyyyMMMddmmssnn}	|
		|{BU Config 1}		|{Study B}	|{Env 1}			|{Source1}		|{DataType1}	|{INCR}		|{yyyyMMMddmmssnn}	|	
		
	And the File format structure for Delimeter "|"
	And the checkbox "Has Header" is "true"	
	And the checkbox "Has Marking Delimeter" is "false"
	And the checkbox "Use Study Site Number" is "true"	

	Upload Actions
	And there exists a BU configuration "<BU Configuration> with Upload Actions are "<Upload Action>", "<Condition>"
		|BU Configuration	|Upload Action						|Condition		|
		|{BU Config 1}		|{Load Type}						|{Cumulative}	|
		|{BU Config 1}		|{Missing Records}					|{Delete}		|
		|{BU Config 1}		|{Clear Missing Fields}				|checked		|
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


	SQL Queries
	"<SQL 1>"
	Select r.RecordPosition, r.Deleted, r.RecordActive, dp.*
	from DataPoints dp
	inner join Records r on r.RecordID = dp.RecordID
	where r.DataPageID = <>

	"<SQL 2>"
	 select *
	 from vAudits
	where ObjectID = <RecordID>
	and ObjectTypeID = 
	(select ObjectTypeID from ObjectTypeR where ObjectName like '%Record' )
	and Locale = 'eng'
	order by AuditTime
#----------------------------------------------------------------------------------------------------------------------

@Scenario MCC42834-01
@Validation
Scenario outline: As a Rave user, I want to add data to a field in a log form with a full file using Batch Upload and later upload the same file with a missing log line and confirm in the audit trail

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And there exists a form "<LogForm>" with form OID "<FormOid2>" in study "<Study A>"
And there exists a Log field "<LogField2A>" with field OID "<FieldOid2A>" with a default value "<default 1>" 
And there exists a Log field "<LogField2B>" with field OID "<FieldOid2B>" with no default value



And I am logged in to the Batch Upload UI
And I select project "<Study A>"
And I select BU Configuration "<BU Config 1>"
And I select link "Upload Actions"
And I modify BU configuration "<BU Configuration> with Upload Actions are "<Upload Action>", "<Condition>"
	|BU Configuration	|Upload Action						|Condition		|
	|{BU Config 1}		|{Create Subjects}					|checked		|
	|{BU Config 1}		|{Load Type}						|{Cumulative}	|
	|{BU Config 1}		|{Missing Records}					|{Delete}		|
	|{BU Config 1}		|{Clear Missing Fields}				|checked		|	

And I select button "Update"


And I format the input file name as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<FULL>_<yyyyMMMddmmssnn>.txt>"


And I add mappings with "<File Column>", "<Reference Type>", "<Folder OID>", Form OID>", "<Form Ordinal>", "<Field OID>"
	|File Column	|Reference Type>	|Folder OID	|Form OID>			|Form Ordinal	|Field OID		|
	|1				|Data				|blank		|"<PrimaryForm>"	|1				|"<NameOid>"	|
	|2				|Data				|blank		|"<PrimaryForm>"	|1				|"<NumberOid>"	|
	|2				|Subject reference	|blank		|blank				|blank			|"<NumberOid>"	|
	|3				|Data				|blank		|"<FormOid2>"		|1				|"<FieldOid2A>"	|
	|4				|Key data			|blank		|"<FormOid2>"		|1				|"<FieldOid2B>"	|
	|5				|Site				|blank		|blank				|blank			|blank			|

And I create a txt file "<File 1>" with the following headings and data
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid2A>"	|"<FieldOid2B>"	|Site				|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<blue>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<orange>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<yellow>"		|"<StudySiteNo1>"	|


And I save file "<File 1>" as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<FULL>_<yyyyMMMddmmssnn>.txt>"
And I select tab "<Study A>"
And I select link "Refresh Service"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot

And I am logged on to Rave as Rave user "<Rave User 1>"
And I navigate to the form "<LogForm>" in site "<Site A1>" of study "<Study A>"
And I verify that form "<LogForm>" has 3 log lines
And I take a screenshot

And I verify on the audit trail that the form "<LogForm>" has 4 entries 
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"" displays audit "Record Created" and user "Rave Imnport"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"1" displays audit "Record Created" and user "Rave Imnport"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record Created" and user "Rave Imnport"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"3" displays audit "Record Created" and user "Rave Imnport"
And I take a screenshot

And I logout of Rave

When I execute SQL Query "<SQL 1>"
Then I see 2  entries for all 3 record positions 
And the "Deleted" value for all is "0"
And I take a screenshot

And I modify txt file "<File 1>" by deleting the 2nd entry 
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid2A>"	|"<FieldOid2B>"	|Site				|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<blue>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<yellow>"		|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<SALL>_<yyyyMMMddmmssnn>.txt>"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot

And I will see a log file generated in the folder "Log" of the FTP site
And I will see a "missing" file generated
And I take a screenshot

And I am logged on to Rave as Rave user "<Rave User 1>"
And I navigate to the form "<LogForm>" in site "<Site A1>" of study "<Study A>"
And I verify that form "<LogForm>" has 2 active log lines
And I take a screenshot

And I verify on the audit trail that the form "<LogForm>" has 3 entries 
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"" displays audit "Record Created" and user "Rave Imnport" 

And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"1" displays audit "Record Created" and user "Rave Imnport" 
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record Created" and user "Rave Imnport" 
And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record position 3 renumbered to record position 2" and user "Rave Imnport" 
And I take a screenshot

And I logout of Rave

When I execute SQL Query "<SQL 1>"
Then I see 2  entries for record position 1 with deleted value =  "0"
And I see 2  entries for record position 2 with deleted value =  "1"
And I see 2  entries for record position 2 with deleted value =  "0"
And I take a screenshot


And I modify txt file "<File 1>" with the following headings and data to include deleted row
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid2A>"	|"<FieldOid2B>"	|Site				|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<blue>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<orange>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<yellow>"		|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<SALL>_<yyyyMMMddmmssnn>.txt>"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot

And I will see a log file generated in the folder "Log" of the FTP site
And I will see a "missing" file generated
And I take a screenshot

And I am logged on to Rave as Rave user "<Rave User 1>"
And I navigate to the form "<LogForm>" in site "<Site A1>" of study "<Study A>"
And I verify that form "<LogForm>" has 2 active log lines
And I take a screenshot

And I verify on the audit trail that the form "<LogForm>" has 4 entries 
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"" displays audit "Record Created" and user "Rave Imnport" 

And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"1" displays audit "Record Created" and user "Rave Imnport" 
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record Created" and user "Rave Imnport" 
And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record position 3 renumbered to record position 2" and user "Rave Imnport" 
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"3" displays audit "Record Created" and user "Rave Imnport" 
And I take a screenshot

And I logout of Rave

When I execute SQL Query "<SQL 1>"
Then I see 2  entries for record position 1 with deleted value =  "0"
And I see 2  entries for record position 2 with deleted value =  "1"
And I see 2  entries for record position 2 with deleted value =  "0"
And I see 2  entries for record position 3 with deleted value =  "0"
And I take a screenshot


When I execute SQL Query "<SQL 2>" with record ID for deleted record 
Then I see the Audit trail for the deleted record
And I see entry for record created
And I see entry for record deleted
And I see no other entry
And I take a screenshot