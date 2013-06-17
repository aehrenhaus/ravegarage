Feature: Batch Upload inactive records

Background:

	 Given I am an Rave user "<Rave User>" with username "<Rave User Name>", password "<Rave Password>" and email "<Rave Email>"
		|Rave User		|Rave User Name		|Rave Password		|Rave Email		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|.
	    
	And there exists Rave study "<Rave Study>" 
		|{Study A}	|
   
    And there exists site "<Site>" in study "<Study>", with environment "<Environment>"	and CRF version "<CRF>" in iMedidata and with Study-Site number "<StudySiteNo>"	
		|Study		|Site		|Environment	|StudySiteNo	|CRF			|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|{Crf Ver 1}	|
	
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
		|{BU Config 1}		|{Study A}	|{Env 1}			|{Source1}		|{DataType1}	|{Full}		|{yyyyMMMddmmssnn}	|
		
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
		|{BU Config 1}		|{Create Log Lines}					|checked		|
		|{BU Config 1}		|{Lock Records}						|unchecked		|
		|{BU Config 1}		|{Change Code}						|{Entry Error}	|
		|{BU Config 1}		|{Require ManualClose For Queries}	|checked		|
		|{BU Config 1}		|{Use Folder Algorithms}			|unchecked		|


#----------------------------------------------------------------------------------------------------------------------
@Scenario MCC 56368-01
@Validation
Scenario outline: When a BU configuration is set to inactivate missing records, Batch Uploader inactivates all records (log lines) which are missing from a cumulative file. When these records are submitted again, Batch Uploader  should be able to activate previously inactivated records and update them when necessary.

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And I am logged in to Rave as Rave user "<Rave User 1>"
And I am assigned to site "<Site A1>" that is connected to study "<Study A>" 
--And I create a subject "<Subject 1>" with initials <SubName> and number "<SubNum>" in site "<Site A1>" of study "<Study A>" With 
--And I verify that subject "<Subject 1>" is not assigned folder "<Folder Z>"
And I take a screenshot

And I am logged in to the Batch Upload UI
And I select project "<Study A>"
And I select BU Configuration "<BU Config 1>"
And I select link "Upload Actions"
And I modify BU configuration "<BU Configuration> with Upload Actions are "<Upload Action>", "<Condition>"
	|BU Configuration	|Upload Action						|Condition		|
	|{BU Config 1}		|{Create Subjects}					|checked		|
	|{BU Config 1}		|{Load Type}						|{Cumulative}	|
	|{BU Config 1}		|{Clear Missing Fields}				|checked		|
	|{BU Config 1}		|{Create Log Lines}					|checked		|

And I select button "Update"

And I add mappings with "<File Column>", "<Reference Type>", "<Folder OID>", Form OID>", "<Form Ordinal>", "<Field OID>"
	|File Column	|Reference Type>	|Folder OID	|Form OID>			|Form Ordinal	|Field OID		|
	|1				|Data				|blank		|"<PrimaryForm>"	|1				|"<NameOid>"	|
	|2				|Data				|blank		|"<PrimaryForm>"	|1				|"<NumberOid>"	|
	|2				|Subject reference	|blank		|blank				|blank			|"<NumberOid>"	|
	|3				|Data				|blank		|"<FormOid2>"		|1				|"<FieldOid2A>"	|
	|4				|Key data			|blank		|"<FormOid2>"		|1				|"<FieldOid2B>"	|
	|5				|Site				|blank		|blank				|blank			|blank			|

And I select tab "<Study A>"
And I select link "Refresh Service"

And I create a txt file with the following headings and data
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid2A>"	|"<FieldOid2B>"	|Site				|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<blue>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<orange>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<yellow>"		|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt>"
And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot

And I am logged on to Rave as Rave user "<Rave User 1>"
And I navigate to the form "<LogForm>" in site "<Site A1>" of study "<Study A>"
And I verify that form "<LogForm>" has 3 log lines
And I take a screenshot

And I verify on the audit trail that the form "<LogForm>" has 3 entries 
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"1" displays audit "Record Created" and user "Rave Imnport"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record Created" and user "Rave Imnport"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"3" displays audit "Record Created" and user "Rave Imnport"
And I take a screenshot

And I logout of Rave

And I modify txt file  by deleting entry in "FieldOid2A" and "FieldOid2B" 
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid2A>"	|"<FieldOid2B>"	|Site				|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<blue>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|""				|""				|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<yellow>"		|"<StudySiteNo1>"	|

And I save file "<File 2>" as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<SALL>_<yyyyMMMddmmssnn>.txt>"
And I select tab "<Study A>"
And I select link "Refresh Service"

And I drop file "<File 2>" into the folder "Input" of the FTP site
When file "<File 2>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot

And I will see a log file generated in the folder "Log" of the FTP site
****And I will see see a "missing" file generated
And I take a screenshot

And I am logged on to Rave as Rave user "<Rave User 1>"
And I navigate to the form "<LogForm>" in site "<Site A1>" of study "<Study A>"
And I verify that form "<LogForm>" has 2 active log lines
And I verify that a log line of form "<LogForm>"  is inactive
And I take a screenshot

And I verify on the audit trail that the form "<LogForm>" has 4 entries 
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"1" displays audit "Record Created" and user "Rave Imnport" at time "<Time 1>"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record Created" and user "Rave Imnport" at time "<Time 1>"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record inactivated with code reason code "<Reason Code " and user "Rave Imnport" at time "<Time 2>"
And I take a screenshotC

And I verify on the audit trail for "Record - "<LogForm>"3" displays audit "Record Created" and user "Rave Imnport" at time "<Time 1>"
And I take a screenshot

And I modify txt file  by adding previously deleted entries in "FieldOid2A" and "FieldOid2B" 
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid2A>"	|"<FieldOid2B>"	|Site				|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<blue>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<orange>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<yellow>"		|"<StudySiteNo1>"	|

And I save file "<File 2>" as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<SALL>_<yyyyMMMddmmssnn>.txt>"
And I select tab "<Study A>"
And I select link "Refresh Service"

And I drop file "<File 2>" into the folder "Input" of the FTP site
When file "<File 2>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot

And I will see a log file generated in the folder "Log" of the FTP site
And I will not see a "missing" file generated
And I take a screenshot

And I am logged on to Rave as Rave user "<Rave User 1>"
And I navigate to the form "<LogForm>" in site "<Site A1>" of study "<Study A>"
And I verify that form "<LogForm>" has 3 active log lines
And I verify that log line 2 of form "<LogForm>"  has been reactivated
And I take a screenshot

And I verify on the audit trail that the form "<LogForm>" has 5 entries 
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"1" displays audit "Record Created" and user "Rave Imnport" at time "<Time 1>"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record Created" and user "Rave Imnport" at time "<Time 1>"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record inactivated with code reason code "<Reason Code>" and user "Rave Imnport" at time "<Time 2>"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record activated with code reason code Record found in BU file." and user "Rave Imnport" at time "<Time 2>"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"3" displays audit "Record Created" and user "Rave Imnport" at time "<Time 1>"
And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------
@Scenario MCC 56368-02
@Validation
Scenario outline: When a user inactivates a log line using the Rave UI and resubmits input file, to submitted again, Batch Uploader  should be able to activate previously inactivated records and update them when necessary.

Given I am a Rave user "<Rave User 1>" with Rave Email "<Rave Email 1>"
And I am logged in to Rave as Rave user "<Rave User 1>"
And I am assigned to site "<Site A1>" that is connected to study "<Study A>" 
--And I create a subject "<Subject 1>" with initials <SubName> and number "<SubNum>" in site "<Site A1>" of study "<Study A>" With 
--And I verify that subject "<Subject 1>" is not assigned folder "<Folder Z>"
And I take a screenshot

And I am logged in to the Batch Upload UI
And I select project "<Study A>"
And I select BU Configuration "<BU Config 1>"
And I select link "Upload Actions"
And I modify BU configuration "<BU Configuration> with Upload Actions are "<Upload Action>", "<Condition>"
	|BU Configuration	|Upload Action						|Condition		|
	|{BU Config 1}		|{Create Subjects}					|checked		|
	|{BU Config 1}		|{Load Type}						|{Cumulative}	|
	|{BU Config 1}		|{Clear Missing Fields}				|checked		|
	|{BU Config 1}		|{Create Log Lines}					|checked		|

And I select button "Update"

And I add mappings with "<File Column>", "<Reference Type>", "<Folder OID>", Form OID>", "<Form Ordinal>", "<Field OID>"
	|File Column	|Reference Type>	|Folder OID	|Form OID>			|Form Ordinal	|Field OID		|
	|1				|Data				|blank		|"<PrimaryForm>"	|1				|"<NameOid>"	|
	|2				|Data				|blank		|"<PrimaryForm>"	|1				|"<NumberOid>"	|
	|2				|Subject reference	|blank		|blank				|blank			|"<NumberOid>"	|
	|3				|Data				|blank		|"<FormOid2>"		|1				|"<FieldOid2A>"	|
	|4				|Key data			|blank		|"<FormOid2>"		|1				|"<FieldOid2B>"	|
	|5				|Site				|blank		|blank				|blank			|blank			|

And I select tab "<Study A>"
And I select link "Refresh Service"

And I create a txt file with the following headings and data
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid2A>"	|"<FieldOid2B>"	|Site				|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<blue>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<orange>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<yellow>"		|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt>"
And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed
Then I will see a Success email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot

And I am logged on to Rave as Rave user "<Rave User 1>"
And I navigate to the form "<LogForm>" in site "<Site A1>" of study "<Study A>"
And I verify that form "<LogForm>" has 3 log lines
And I take a screenshot

And I verify on the audit trail that the form "<LogForm>" has 3 entries 
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"1" displays audit "Record Created" and user "Rave Imnport"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record Created" and user "Rave Imnport"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"3" displays audit "Record Created" and user "Rave Imnport"
And I take a screenshot

And I inactivate log line 2

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record Created" and user "Rave Imnport"
And I take a screenshot

And I logout of Rave

And I resubmit the txt file previously submitted.
	|"<NameOid>"	|"<NumberOid>"	|"<FieldOid2A>"	|"<FieldOid2B>"	|Site				|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<blue>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<orange>"		|"<StudySiteNo1>"	|
	|"<SubName>"	|"<SubNum>"		|"<red>"		|"<yellow>"		|"<StudySiteNo1>"	|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<Source1>_<DataType1>_<SALL>_<yyyyMMMddmmssnn>.txt>"
And I select tab "<Study A>"
And I select link "Refresh Service"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed

Then will see a log file generated in the folder "Log" of the FTP site

And I take a screenshot

And I am logged on to Rave as Rave user "<Rave User 1>"
And I navigate to the form "<LogForm>" in site "<Site A1>" of study "<Study A>"
And I verify that form "<LogForm>" has 3 active log lines
And I verify that a log line of form "<LogForm>"  is inactive
And I take a screenshot


And I verify on the audit trail that the form "<LogForm>" has 4 entries 
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"1" displays audit "Record Created" and user "Rave Imnport" at time "<Time 1>"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record Created" and user "Rave Imnport" at time "<Time 1>"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record inactivated with code reason code "<Reason Code>" and user "Rave User" at time "<Time 2>"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"2" displays audit "Record activated with code reason code Record found in BU file." and user "Rave Imnport" at time "<Time 2>"
And I take a screenshot

And I verify on the audit trail for "Record - "<LogForm>"3" displays audit "Record Created" and user "Rave Imnport" at time "<Time 1>"
And I take a screenshot