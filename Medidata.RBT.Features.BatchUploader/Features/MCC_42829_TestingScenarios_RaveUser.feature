Feature: Batch Upload inactive subjects


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
	And there exists a standard field "<Field1A>" with field OID "<FieldOid1A>" with no default value  
	And there exists a standard field "<Field1B>" with field OID "<FieldOid1B>" with no default value
	And there exists a standard field "<Field1A>" with field OID "<FieldOid1C>" with no default value 
	And there exists a standard field "<Field1B>" with field OID "<FieldOid1D>" with no default value	


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
		|{BU Config 1}		|{Study A}	|{Env 1}			|{Source1}		|{DataType1}	|{FULL}		|{yyyyMMMddmmssnn}	|	
		
	And the File format structure for Delimeter "|"
	And the checkbox "Has Header" is "true"	
	And the checkbox "Has Marking Delimeter" is "false"
	And the checkbox "Use Study Site Number" is "true"	

	Upload Actions
	And there exists a BU configuration "<BU Configuration> with Upload Actions are "<Upload Action>", "<Condition>"
		|BU Configuration	|Upload Action						|Condition		|
		|{BU Config 1}		|{Load Type}						|{Cumulative}	|
		|{BU Config 1}		|{Missing Records}					|{Inactivate}	|
		|{BU Config 1}		|{Close Missing Fields}				|checked		|
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


#--------------------------------------------------------------------------------------------------------------------------------------

@Scenario MCC42829-01
@Validation
Scenario outline: When a BU configuration is set to inactivate missing subject records, Batch Uploader inactivates all records which are missing from a cumulative file. When these records are submitted again, Batch Uploader does not activate previously inactivated subject records 

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And there exists a form "<StdForm>" with form OID "<FormOid1>" in study "<Study A>"

And there exists a standard field "<Field1A>" with field OID "<FieldOid1A>" and a standard field "<Field1B>" with field OID "<FieldOid1B>" 
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
	|"<NameOid>"	|"<NumberOid>"		|"<FieldOid1A>"			|"<FieldOid1B>"	|Site				|
	|"<SubName>"	|"<SubNum>1"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>2"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>3"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>4"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>5"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>6"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<FULL>_<yyyyMMMddmmssnn>.txt>"
And I select tab "<Study A>"
And I select link "Refresh Service"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot

When I navigate to Rave
Then I verify that the new subjects were uploaded 
and verify data were uploaded on form "<StdForm>"
And I take a screenshot

And I modify the txt file by eliminating two rows
	|"<NameOid>"	|"<NumberOid>"		|"<FieldOid1A>"			|"<FieldOid1B>"	|Site			|
	|"<SubName>"	|"<SubNum>1"		|"<1994 FEB 19>"		|"<1>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>2"		|"<1994 FEB 19>"		|"<1>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>3"		|"<1994 FEB 19>"		|"<1>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>4"		|"<1994 FEB 19>"		|"<1>"		|"<StudySiteNo1>"	|

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then in Rave I see 2 subjects were inactinated in site "<StudySiteNo1>" for Study "<Study A>". 
And I take a screenshot

And I navigate to "Site Administration>" module
And I navigate to site "<StudySiteNo1>"
When I select subjects
Then I see that 2 subjects were inactivated
And I take a screenshot

And I create a txt file including the data of the 2 inactivated subjects

And I add the following to the input file follows
	|"<NameOid>"	|"<NumberOid>"		|"<FieldOid1A>"			|"<FieldOid1B>"	|Site				|
	|"<SubName>"	|"<SubNum>1"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>2"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>3"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>4"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>5"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>6"		|"<1994 FEB 19>"		|"<1>"			|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<FULL>_<yyyyMMMddmmssnn>.txt>"

And I drop file "<File 1>" into the folder "Input" of the FTP site
And file "<File 1>" is processed

When I navigate to the Log file 
Then I see an error file.
And I open the error file and see the subjects were deactivated.
And I take a screenshot

When I navigate to site "<StudySiteNo1>"of study "<Study A>" 
Then I verify that the two subjects were not reactivated
And I take a screenshot

And I navigate to "Site Administration>" module
And I navigate to site "<StudySiteNo1>"
When I select subjects
Then I see that 2 subjects werenot  reactivated
And I take a screenshot
