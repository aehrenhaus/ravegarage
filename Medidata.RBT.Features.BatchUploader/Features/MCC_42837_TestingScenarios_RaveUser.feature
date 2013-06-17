Feature: Batch Upload creates new log record with NeedsCVRefresh=True

Background:

	Given I am an Rave user "<Rave User>" with username "<Rave User Name>", password "<Rave Password>" and email "<Rave Email>"
		|Rave User		|Rave User Name		|Rave Password		|Rave Email		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|
	    
	And there exists Rave study "<Rave Study>" 
		|{Study A}	|
    And the project "<Study A>" Mode is set to "Do Not Run" in "Clinical views" page
	
    And there exists site "<Site>" in study "<Study>", with environment "<Environment>"	in iMedidata and with Study-Site number "<StudySiteNo>"	
		|Study		|Site		|Environment	|StudySiteNo	|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|

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

And I use SQL Routine "<SQL Routine>"
		|SQL Routine		|
		|SQL 1				|

	SQL 1
select r.NeedsCVRefresh, r.RecordPosition, fr.OID as FormOID, r.RecordID, fr.FormID, dbo.fnlocaldefault(fr.formname) as FormName, dpg.DataPageID
from Subjects s
join datapages dpg on dpg.subjectid = s. subjectid
join Forms fr on fr.FormID = dpg.FormID
join records r on r.datapageid = dpg.datapageid
where 
dpg.DataPageID in (<SUBJENR>,<DEM>,<STDFORM>,<MIXFORM>,<LOGFORM>)

#---------------------------------------------------------------------------------------------------------------------------------------

@Scenario MCC42837-01
@Validation
Scenario: As a Rave user, I want to add data to a form using Batch Upload and confirm the Record for NeedscvRefresh field as True 

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And I log in to the Batch Upload UI
And I select project "<Study A>"
And I select BU Configuration "<BU Config 1>"
And I select link "Data Mappings"
And I add mappings with "<File Column>", "<Reference Type>", "<Folder OID>", Form OID>", "<Form Ordinal>", "<Field OID>"
	|"<File Column>"|"<Reference Type>"		|"<Folder OID>"	|"<Form OID>"	|"<Form Ordinal>"	|"<Field OID>" |
	|	1			|	Data				|				|	<SUBJENR>	|	1				|"<SUB_INIT>"  | 
	|	2			|	Data				|				|	<SUBJENR>	|	1				|"<SUB_NUM>"   |
	|	2			|	Subject reference	|				|	 			|					|"<SUB_NUM>"   |
	|	3			|	Data				| "<VISIT1>"	|	"<DEM>"		|	1				|"<BIRTHDAT>"  |
	|	4			|	Data				| "<VISIT1>"	|	"<DEM>"		|	1				|"<SEX>"	   |
	|	5			|	Data				| "<VISIT1>"	|	"<DEM>"		|	1				|"<RACE>"	   |
	|	6			|	Site				|				|	 			|					|	 		   |
	|	7			|	Data				|				|	<STDFORM>	|	1				|"<FIELD1A>"   |
	|	8			|	Data				|				|	<STDFORM>	|	1				|"<FIELD1B>"   |
	|	9			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3ASTD>"|
	|	10			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3BLOG>"|
	|	11			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3CLOG>"|
	|	12			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3DSTD>"|
	|	13			|	Data				|				|	<LOGFORM>	|	1				|"<LOGFIELD2A>"|
	|	14			|	Data				|				|	<LOGFORM>	|	1				|"<LOGFIELD2B>"|

And I select tab "<Study A>"
And I select link "Refresh Service"

And I create a txt file with the following headings and data
	|"<SUB_INIT>"|"<SUB_NUM>"|"<BIRTHDAT>"|"<SEX>"|"<RACE>"|"<SITE>"|"<FIELD1A>"|"<FIELD1B>"|"<FIELD3ASTD>"|"<FIELD3BLOG>"|"<FIELD3CLOG>"|"<FIELD3DSTD>"|"<LOGFIELD2A>"|"<LOGFIELD2B>"|
|<"JA4">|<"311">|<"1978 SEP 28">|<"1">|<"1">|<"666">|<"std13">|<"std23">|<"mix3std4">|<"mix3log4">|<"mix3clog4">|<"1">|<"lgfld77">|<"lgfld7b7">|
And I save file "<File 1>" as "<<Study A>_<Env 1>_<ete1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt>"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
And I Log in to RaveUI

Then I should see a new subject created in Rave with Initials "<SubName>"
And I take a screenshot

When I run SQL Routine "<SQL 1>"
Then I should see the value of Record NeedsCVRefresh as 1
And I should see the value of Record NeedsCVRefresh as 0 for Header Record of LogForm 
And I take a screenshot


#-----------------------------------------------------------------------------------------------------------------------------------


@Scenario MCC42837-02
@Validation
Scenario: As a Rave user, I want to modify the existing data through Batch upload and confirm the Records for NeedscvRefresh field as true  (only the first field in each form will be changed)

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And I log in to the Batch Upload UI
And I select project "<Study A>"
And I select BU Configuration "<BU Config 1>"
And I select link "Data Mappings"
And I add mappings with "<File Column>", "<Reference Type>", "<Folder OID>", "<Form OID>", "<Form Ordinal>", "<Field OID>"
	|"<File Column>"|"<Reference Type>"		|"<Folder OID>"	|"<Form OID>"	|"<Form Ordinal>"	|"<Field OID>" |
	|	1			|	Data				|				|	<SUBJENR>	|	1				|"<SUB_INIT>"  | 
	|	2			|	Data				|				|	<SUBJENR>	|	1				|"<SUB_NUM>"   |
	|	2			|	Subject reference	|				|	 			|					|"<SUB_NUM>"   |
	|	3			|	Data				| "<VISIT1>"	|	"<DEM>"		|	1				|"<BIRTHDAT>"  |
	|	4			|	Data				| "<VISIT1>"	|	"<DEM>"		|	1				|"<SEX>"	   |
	|	5			|	Data				| "<VISIT1>"	|	"<DEM>"		|	1				|"<RACE>"	   |
	|	6			|	Site				|				|	 			|					|	 		   |
	|	7			|	Data				|				|	<STDFORM>	|	1				|"<FIELD1A>"   |
	|	8			|	Data				|				|	<STDFORM>	|	1				|"<FIELD1B>"   |
	|	9			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3ASTD>"|
	|	10			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3BLOG>"|
	|	11			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3CLOG>"|
	|	12			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3DSTD>"|
	|	13			|	Data				|				|	<LOGFORM>	|	1				|"<LOGFIELD2A>"|
	|	14			|	Data				|				|	<LOGFORM>	|	1				|"<LOGFIELD2B>"|

And I select tab "<Study A>"
And I select link "Refresh Service"

And I create a txt file with the following headings and data 
	|"<SUB_INIT>"|"<SUB_NUM>"|"<BIRTHDAT>"|"<SEX>"|"<RACE>"|"<SITE>"|"<FIELD1A>"|"<FIELD1B>"|"<FIELD3ASTD>"|"<FIELD3BLOG>"|"<FIELD3CLOG>"|"<FIELD3DSTD>"|"<LOGFIELD2A>"|"<LOGFIELD2B>"|
|<"JA4">|<"311">|<"1978 SEP 28">|<"1">|<"1">|<"666">|<"std13">|<"std23">|<"mix3std4">|<"mix3log4">|<"mix3clog4">|<"1">|<"lgfld77">|<"lgfld7b7">|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<ete1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt>"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed

And I Log in to RaveUI

And I should see the subject modified in Rave with Initials "<SubName>"
And I follow the audit trail for the form "<SUBJENR>" for subject "<SUB_INIT>"
And I verify on the audit trail that the subject Initial is modified by "Rave Import"
And I take a screenshot

And I navigate to the form "<DEM>"
And I verify on the audit trail that the data in field "<BIRTHDAT>" is modified by "Rave Import"
And I take a screenshot

And I navigate to the form "<StdForm>"
And I verify on the audit trail that the data in field "<FieldOid1A>" is modified by "Rave Import"
And I take a screenshot

And I navigate to the form "<MIXForm>"
And I verify on the audit trail that the data in field "<FIELD3ASTD>" is modified by "Rave Import"
And I take a screenshot

And I navigate to the form "<LogForm>"
And I verify on the audit trail that the data in field "<LOGFIELD2A>" is modified by "Rave Import"
And I take a screenshot

When I run SQL Routine
Then I should see the value of Record NeedsCVRefresh as 1
And I should see the value of Record NeedsCVRefresh as 0 for Header Record of LogForm 
And I take a screenshot

#-----------------------------------------------------------------------------------------------------------------------------------

@Scenario MCC42837-03
@Validation
Scenario: As a Rave user, I want to modify data with both Batch upload and EDC confirm the Record for NeedscvRefresh field as true (only the first field in each form will be changed)

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And I log in to the Batch Upload UI
And I select project "<Study A>"
And I select BU Configuration "<BU Config 1>"
And I select link "Data Mappings"
And I add mappings with "<File Column>", "<Reference Type>", "<Folder OID>", "<Form OID>", "<Form Ordinal>", "<Field OID>"
	|"<File Column>"|"<Reference Type>"		|"<Folder OID>"	|"<Form OID>"	|"<Form Ordinal>"	|"<Field OID>" |
	|	1			|	Data				|				|	<SUBJENR>	|	1				|"<SUB_INIT>"  | 
	|	2			|	Data				|				|	<SUBJENR>	|	1				|"<SUB_NUM>"   |
	|	2			|	Subject reference	|				|	 			|					|"<SUB_NUM>"   |
	|	3			|	Data				| "<VISIT1>"	|	"<DEM>"		|	1				|"<BIRTHDAT>"  |
	|	4			|	Data				| "<VISIT1>"	|	"<DEM>"		|	1				|"<SEX>"	   |
	|	5			|	Data				| "<VISIT1>"	|	"<DEM>"		|	1				|"<RACE>"	   |
	|	6			|	Site				|				|	 			|					|	 		   |
	|	7			|	Data				|				|	<STDFORM>	|	1				|"<FIELD1A>"   |
	|	8			|	Data				|				|	<STDFORM>	|	1				|"<FIELD1B>"   |
	|	9			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3ASTD>"|
	|	10			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3BLOG>"|
	|	11			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3CLOG>"|
	|	12			|	Data				|				|	<MIXFORM>	|	1				|"<FIELD3DSTD>"|
	|	13			|	Data				|				|	<LOGFORM>	|	1				|"<LOGFIELD2A>"|
	|	14			|	Data				|				|	<LOGFORM>	|	1				|"<LOGFIELD2B>"|

And I select tab "<Study A>"
And I select link "Refresh Service"

And the following field OIS's "<Field OID>" will be changed by "<User>"
	|Field OID		|User			|
	|"<SUB_INIT>"	|Rave Import	|
	|"<BIRTHDAT>"	|Rave Import	|
	|"<SEX>"		|<Default User>	|
	|"<FIELD1A>"	|Rave Import	|
	|"<FIELD1B>"	|<Default User>	|
	|"<FIELD3ASTD>"	|Rave Import	|
	|"<FIELD3BLOG>"	|<Default User>	|
	|"<LOGFIELD2A>"	|Rave Import	|
	|"<LOGFIELD2B>"	|<Default User>	|

And I create a txt file with the following headings and data
	|"<SUB_INIT>"|"<SUB_NUM>"|"<BIRTHDAT>"|"<SEX>"|"<RACE>"|"<SITE>"|"<FIELD1A>"|"<FIELD1B>"|"<FIELD3ASTD>"|"<FIELD3BLOG>"|"<FIELD3CLOG>"|"<FIELD3DSTD>"|"<LOGFIELD2A>"|"<LOGFIELD2B>"|
|<"JA4">|<"311">|<"1978 SEP 28">|<"1">|<"1">|<"666">|<"std13">|<"std23">|<"mix3std4">|<"mix3log4">|<"mix3clog4">|<"1">|<"lgfld77">|<"lgfld7b7">|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<ete1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt>"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed

And I Log in to RaveUI

And I should see the subject modified in Rave with Initials "<SubName>"
And I follow the audit trail for the form "<SUBJENR>" for subject "<SUB_INIT>"
And I verify on the audit trail that the subject Initial is modified by "Rave Import"
And I take a screenshot

And I navigate to the form "<DEM>"
And I verify on the audit trail that the data in field "<BIRTHDAT>" is modified by "Rave Import"
And I verify on the audit trail that the data in field "<SEX>" is modified by "<Default User>"
And I take a screenshot

And I navigate to the form "<StdForm>"
And I verify on the audit trail that the data in field "<FIELD1A>" is modified by "Rave Import"
And I verify on the audit trail that the data in field "<FIELD1B>" is modified by "<Default User>"
And I take a screenshot

And I navigate to the form "<MIXForm>"
And I verify on the audit trail that the data in field "<FIELD3ASTD>" is modified by "Rave Import"
And I verify on the audit trail that the data in field "<FIELD3BLOG>" is modified by "<Default User>"
And I take a screenshot

And I navigate to the form "<LogForm>"
And I verify on the audit trail that the data in field "<LOGFIELD2A>" is modified by "Rave Import"
And I verify on the audit trail that the data in field "<LOGFIELD2B>" is modified by "<Default User>"
And I take a screenshot

When I run SQL Routine
Then I should see the value of Record NeedsCVRefresh as 1
And I should see the value of Record NeedsCVRefresh as 0 for Header Record of LogForm 
And I take a screenshot



