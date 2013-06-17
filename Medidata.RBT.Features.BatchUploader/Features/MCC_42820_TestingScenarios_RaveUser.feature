Feature: Batch Upload UI Default inputs

Background:

	 Given I am an Rave user "<Rave User>" with username "<Rave User Name>", password "<Rave Password>" and email "<Rave Email>"
		|Rave User		|Rave User Name		|Rave Password		|Rave Email		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|
	    
	And there exists Rave study "<Rave Study>" 
		|{Study A}	|
   
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
		|{BU Config 1}		|{Load Type}						|{Incremental}	|
		|{BU Config 1}		|{Clear Missing Fields}				|checked		|
		|{BU Config 1}		|{Keep Last Manual Change}			|unchecked		|
		|{BU Config 1}		|{Matrix OID}						|{<DEFAULT>}	|
		|{BU Config 1}		|{Add If Not In Matrix}				|unchecked		|
		|{BU Config 1}		|{Create Subjects}					|checked		|
		|{BU Config 1}		|{Create Folders}					|unchecked		|	
		|{BU Config 1}		|{Create Forms}						|unchecked		|
		|{BU Config 1}		|{Create Log Lines}					|unchecked		|
		|{BU Config 1}		|{Lock Records}						|unchecked		|
		|{BU Config 1}		|{Change Code}						|blank			|
		|{BU Config 1}		|{Require ManualClose For Queries}	|unchecked		|
		|{BU Config 1}		|{Use Folder Algorithms}			|unchecked		|


#--------------------------------------------------------------------------------------------------------------------------------------------------------------

@Scenario MCC42820-01
@Validation
Scenario outline: As a Rave user, I want to add data to a standard form that has a field with a default value using Batch Upload and confirm the data upload in the audit trail (configuration 42820A)

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And there exists a form "<StdForm>" with form OID "<FormOid1>" in study "<Study A>"
And there exists a standard field "<Field1A>" with field OID "<FieldOid1A>" with a default value "<Default Value 1>" and a standard field "<Field1B>" with field OID "<FieldOid1B>" with no default value  

And I am logged in to Rave
And select link "<Study A>"
And I select link "<Site A1>"
And I create subject "<Subject 1>"
And I select link "<StdForm>"
And I verify that there exists a standard field "<Field1A>" with a default value "<default 1>" 
And I take a screenshot

And I log in to the Batch Upload UI
And I select project "<Study A>"
And I select BU Configuration "<BU Config 1>"
And I select link "Data Mappings"
And I add mappings with "<File Column>", "<Reference Type>", "<Folder OID>", Form OID>", "<Form Ordinal>", "<Field OID>"
	|File Column	|Reference Type>	|Folder OID	|Form OID>			|Form Ordinal	|Field OID		|
	|1				|Data				|blank		|"<PrimaryForm>"	|1				|"<NameOid>"	|
	|2				|Data				|blank		|"<PrimaryForm>"	|1				|"<NumberOid>"	|
	|2				|Subject reference	|blank		|blank				|blank			|"<NumberOid>"	|
	|3				|Data				|blank		|"<FormOid1>"		|1				|"<FieldOid1B>"	|
	|4				|Site				|blank		|blank				|blank			|blank			|

And I create a txt file with the following headings and data
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid1B>"	|Site				|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<ete1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt>"
And I select tab "<Study A>"
And I select link "Refresh Service"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot
And I will see a log file generated in the folder "Log" of the FTP site
And I will not see an error file in the folder "Log" of the FTP site
And I take a screenshot
And I should see a new subject created in Rave with Initials "<SubName>"
And I take a screenshot

And I follow the audit trail for the form "<PrimaryForm>"
And I verify that the subject was created by "Rave Import"
And I navigate to the form "<StdForm>"
And I verify on the audit trail that the data in field "<FieldOid1A>" is the default value "<default 1>" was entered by "Rave Import
And I verify on the audit trail that the data in field "<FieldOid1B>" was entered by "Rave Import"
And I take a screenshot
#-----------------------------------------------------------------------------------------------------------------------------------


@Scenario MCC42820-01.1
@Validation
Scenario outline: As a Rave user, I want to add data to a standard form that has a field with a default value using Batch Upload either maintaining or changing the data in the field and confirm the data upload in the audit trail  (Configuration 42820A1)

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And there exists a form "<StdForm>" with form OID "<FormOid1>" in study "<Study A>"
And there exists a standard field "<Field1A>" with field OID "<FieldOid1A>" with a default value "<Default Value 1>" and a standard field "<Field1B>" with field OID "<FieldOid1B>" with no default value  

And I am logged in to Rave
And select link "<Study A>"
And I select link "<Site A1>"
And I create subject "<Subject 1>"
And I select link "<StdForm>"
And I verify that there exists a standard field "<Field1A>" with a default value "<default 1>" 
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
	|3				|Data				|blank		|"<FormOid1>"		|1				|"<FieldOid1A>"	|
	|4				|Data				|blank		|"<FormOid1>"		|1				|"<FieldOid1B>"	|
	|5				|Site				|blank		|blank				|blank			|blank			|

And I create a txt file with the following headings and data
	|"<NameOid>"	|"<NumberOid>"		|"<FieldOid1A>"	|"<FieldOid1B>"	|Site				|
	|"<SubName>1"	|"<SubNum>1"		|"<red>"		|"<blue>"		|"<StudySiteNo1>"	|
	|"<SubName>2"	|"<SubNum>2"		|blank			|"<indigo>"		|"<StudySiteNo1>"	|
	|"<SubName>3"	|"<SubNum>3"		|blank			|blank			|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<ete1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt>"
And I select tab "<Study A>"
And I select link "Refresh Service"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot
And I will see a log file generated in the folder "Log" of the FTP site
And I will not see an error file in the folder "Log" of the FTP site
And I take a screenshot
And I should see a new subjects created in Rave with Initials "<SubName>"
And I take a screenshot

And I follow the audit trail for the form "<PrimaryForm>" for sunject "<SubName>1"
And I verify that the subject was created by "Rave Import"
And I navigate to the form "<StdForm>"
And I verify on the audit trail that the data in field "<FieldOid1A>" is not the default value "<default 1>"
And I verify on the audit trail that the data in field "<FieldOid1B>" was entered by "Rave Import"
And I take a screenshot

And I follow the audit trail for the form "<PrimaryForm>" for sunject "<SubName>2"
And I verify that the subject was created by "Rave Import"
And I navigate to the form "<StdForm>"
And I verify on the audit trail that the data in field "<FieldOid1A>" was entered by "Rave Import" as empty
And I verify on the audit trail that the data in field "<FieldOid1B>" was entered by "Rave Import"
And I take a screenshot

And I follow the audit trail for the form "<PrimaryForm>" for sunject "<SubName>3"
And I verify that the subject was created by "Rave Import"
And I navigate to the form "<StdForm>"
And I verify on the audit trail that the form was created by "Rave Import"
And I take a screenshot

#-----------------------------------------------------------------------------------------------------------------------------------

@Scenario MCC42820-02
@Validation
Scenario outline: As a Rave user, I want to add data to a field that is not the default value using Batch Upload and confirm the data upload in the audit trail (Configuration 42820A1)

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And there exists a form "<LogForm>" with form OID "<FormOid1>" in study "<Study A>"
And there exists a standard field "<Field1A>" with field OID "<FieldOid1A>" with a default value "<default 1>" and a standard field "<Field1B>" with field OID "<FieldOid1B>" with no default value  

And I am logged in to Rave
And select link "<Study A>"
And I select link "<Site A1>"
And I create subject "<Subject 1>"
And I select link "<StdForm>"
And I verify there exists a Log field "<FieldOid1A>" with a default value "<default 1>" 
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
	|3				|Data				|blank		|"<FormOid1>"		|1				|"<FieldOid1A>"	|
	|4				|Data				|blank		|"<FormOi1>"		|1				|"<FieldOid1B>"	|
	|5				|Site				|blank		|blank				|blank			|blank			|

And I create a txt file with the following headings and data
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid1A>"	|"<FieldOid1B>"	|Site				|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<blue>"		|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<ete1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt>"
And I select tab "<Study A>"
And I select link "Refresh Service"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot
And I will see a log file generated in the folder "Log" of the FTP site
And I will not see an error file in the folder "Log" of the FTP site
And I take a screenshot
And I should see a new subject created in Rave with Initials "<SubName>"
And I take a screenshot
And I follow the audit trail for the form "<PrimaryForm>"
And I verify that the subject was created by "Rave Import"
And I navigate to the form "<StdForm>"
And I verify on the audit trail that the data in field "<FieldOid1A>" is not the default value and was entered by "Rave Import"
And I verify on the audit trail that the data in field "<FieldOid1B>" was entered by "Rave Import"
And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------

@Scenario MCC42820-03
@Validation
Scenario outline: As a Rave user, ,I want to add data to a field in a log form that is not the default value using Batch Upload and confirm the data upload in the audit trail (configuration 42829B)

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And there exists a form "<LogForm>" with form OID "<FormOid2>" in study "<Study A>"

And I am logged in to Rave
And select link "<Study A>"
And I select link "<Site A1>"
And I create subject "<Subject 1>"
And I select link "<LogForm>"
And I verify there exists a Log field "<LogField2A>" with a default value "<default 1>" 
And I take a screenshot

And I am logged in to the Batch Upload UI
And I select project "<Study A>"
And I select BU Configuration "<BU Config 1>"

And I sellect Link "Upload Actions"
	And there exists a BU configuration "<BU Configuration> with Upload Actions are "<Upload Action>", "<Condition>"
		|BU Configuration	|Upload Action						|Condition		|
		|{BU Config 1}		|{Load Type}						|{Incremental}	|
		|{BU Config 1}		|{Clear Missing Fields}				|checked		|
		|{BU Config 1}		|{Keep Last Manual Change}			|unchecked		|
		|{BU Config 1}		|{Matrix OID}						|{<DEFAULT>}	|
		|{BU Config 1}		|{Add If Not In Matrix}				|unchecked		|
		|{BU Config 1}		|{Create Subjects}					|checked		|
		|{BU Config 1}		|{Create Folders}					|unchecked		|	
		|{BU Config 1}		|{Create Forms}						|unchecked		|
		|{BU Config 1}		|{Create Log Lines}					|checked		|
		|{BU Config 1}		|{Lock Records}						|unchecked		|
		|{BU Config 1}		|{Change Code}						|blank			|
		|{BU Config 1}		|{Require ManualClose For Queries}	|unchecked		|
		|{BU Config 1}		|{Use Folder Algorithms}			|unchecked		|
		
And I select link "Data Mappings"
And I add mappings with "<File Column>", "<Reference Type>", "<Folder OID>", Form OID>", "<Form Ordinal>", "<Field OID>"
	|File Column	|Reference Type>	|Folder OID	|Form OID>			|Form Ordinal	|Field OID		|
	|1				|Data				|blank		|"<PrimaryForm>"	|1				|"<NameOid>"	|
	|2				|Data				|blank		|"<PrimaryForm>"	|1				|"<NumberOid>"	|
	|2				|Subject reference	|blank		|blank				|blank			|"<NumberOid>"	|
	|3				|Data				|blank		|"<FormOid2>"		|1				|"<FieldOid2A>"	|
	|4				|Data				|blank		|"<FormOid2>"		|1				|"<FieldOid2B>"	|
	|5				|Site				|blank		|blank				|blank			|blank			|

And I create a txt file with the following headings and data
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid2A>"	|"<FieldOid2B>"	|Site				|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<blue>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<car>"		|blank			|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<default>"	|"<cat>"		|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<ete1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt>"
And I select tab "<Study A>"
And I select link "Refresh Service"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot
And I will see a log file generated in the folder "Log" of the FTP site
And I will not see an error file in the folder "Log" of the FTP site
And I take a screenshot
And I should see a new subject created in Rave with Initials "<SubName>"
And I should see three loglines created on form "<LogForm>" with three log lines
And I take a screenshot
And I follow the audit trail for the form "<PrimaryForm>"
And I verify that the subject was created by "Rave Import"
And I navigate to the form "<LogForm>"
And I verify on the audit trail that the data in field "<FieldOid2A>" in log line 1 is not the default value and was entered by "Rave Import"
And I take a screenshot
And I verify on the audit trail that the data in field "<FieldOid2B>" in log line 1 was entered by "Rave Import"
And I take a screenshot
And I verify on the audit trail that the data in field "<FieldOid2A>" in log line 2 is not the default value and was entered by "Rave Import"
And I take a screenshot
And I verify on the audit trail that the data in field "<FieldOid2B>" is empty in log line 2 was entered by "Rave Import"
And I take a screenshot
And I verify on the audit trail that the data in field "<FieldOid2A>" in log line 3 is the default value and was entered by "Rave Import"
And I take a screenshot
And I verify on the audit trail that the data in field "<FieldOid2B>" in log line 3 was entered by "Rave Import"
And I take a screenshot