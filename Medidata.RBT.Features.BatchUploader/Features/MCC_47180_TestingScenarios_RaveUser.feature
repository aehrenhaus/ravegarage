Feature: Batch Upload throughput monitoring

Background:

	Given I am an Rave user "<Rave User>" with username "<Rave User Name>", password "<Rave Password>" and email "<Rave Email>"
		|Rave User		|Rave User Name		|Rave Password		|Rave Email		|
		|{Rave User 1}	|{Rave User Name 1}	|{Rave Password 1}	|{Rave Email 1}	|
	    
	And there exists Rave study "<Rave Study>" 
		|{Study A}	|
   
    And there exists site "<Site>" in study "<Study>", with environment "<Environment>"	in iMedidata and with Study-Site number "<StudySiteNo>"	
		|Study		|Site		|Environment	|StudySiteNo	|
		|{Study A}	|{Site A1}	|{Env 1}		|{StudySiteNo1}	|

	And there exists a form "<DEM Form>" with form OID "<DEM>"
	And there exists a standard field "<BIRTHDATE>" with field OID "<BIRTHDAT>"  
	And there exists a standard field "<SEX>" with field OID "<SEX>" 
	And there exists a standard field "<RACE>" with field OID "<RACE>" 

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

#-----------------------------------------------------------------------------------------------------------------------------------
@Scenario MCC47180-01
@validation
Scenario: As a Rave user, I want to upload a file with large amount of data and verify intermediate tracing for every 100 records in uploadprogress.log file

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

And I select tab "<Study A>"
And I select link "Refresh Service"

And I create a txt file with more than 500 records with the following headings and data	
	 |"<SUB_INIT>"	|"<SUB_NUM>"	|"<BIRTHDAT>"	|"<SEX>"|"<RACE>"	|"<SITE>"		|
	 |"<XYZ>"		|"<123>1"		|1990 JUN 23	|1		|1			|<StudySiteNo>"	|	

And I save file "<File 1>" as "<Study A>_<Env 1>_<ete1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt"
And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed

And I access the Batch Uploader Server through the Jump Server

Then I verify that the following files exists in Batch Uploader Server
    | 			files 				|            Path         									 |
	| "Medidata.Batch.Service.log"	| "<C:\Medidata Batch Uploader - rave564conlabtesting7\Logs>"|
	| "TcpListener.log"				| "<C:\Medidata Batch Uploader - rave564conlabtesting7\Logs>"|
	| "UploadProgress.log"			| "<C:\Medidata Batch Uploader - rave564conlabtesting7\Logs>"|
	| "Log4Net"                     | "<C:\Medidata Batch Uploader - rave564conlabtesting7\>"    |

And I take screenshot

And I verify that config file "<Log4Net>"  has trace level set to <level>for "<UploadProgress.log>"
Examples:
| level   	|
|"Info"		|

And I take a screenshot
Then I verify intermediate trace for every 100 records in "<UploadProgress.log>"
And I take a screenshot

And I login to Rave
And I should see new subjects created in Rave with Initials "<SubName>"
And I take a screenshot
 
#-----------------------------------------------------------------------------------------------------------------------------------

@Scenario MCC47180-02
@validation
Scenario: Batch upload throughput monitoring when a file processed with more than 1000 records in which few error records exists and verify intermediate tracing for every 100 records in uploadprogress.log file

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

And I select tab "<Study A>"
And I select link "Refresh Service"

And I create a txt file with more than 1000 records with the following headings and data	|"<SUB_INIT>"|"<SUB_NUM>"|"<BIRTHDAT>"|"<SEX>"|"<RACE>"|"<SITE>"|

And I save file "<File 1>" as "<<Study A>_<Env 1>_<ete1>_<DataType1>_<INCR>_<yyyyMMMddmmssnn>.txt>"

And I drop file "<File 1>" into the folder "Input" of the FTP site
When file "<File 1>" is processed

And I access the Batch Uploader Server through the Jump Server
Then I verify that the following files exists in Batch Uploader Server
    | 			files 				|            Path         									 |
	| "Medidata.Batch.Service.log"	| "<C:\Medidata Batch Uploader - rave564conlabtesting7\Logs>"|
	| "TcpListener.log"				| "<C:\Medidata Batch Uploader - rave564conlabtesting7\Logs>"|
	| "UploadProgress.log"			| "<C:\Medidata Batch Uploader - rave564conlabtesting7\Logs>"|
	| "Log4Net"                     | "<C:\Medidata Batch Uploader - rave564conlabtesting7\>"    |
And I take screenshot

And I verify that config file "<Log4Net>"  has trace level set to <level>for "<UploadProgress.log>"
Examples:
| level   	|
|"Info"		|

And I take screenshot
Then I verify intermediate trace for every 100 records in UploadProgress.log
And I take a screenshot

And I access the FTP site
Then I verify that the following files exists in "<Log>" folder
    | 			files	 				|           Path												        |
	| "Filename.MachineName.log"	    |"<\\hdc505lbiswv001.lab1.hdc.mdsol.com\FTP\rave564conlabtesting7\Log>" |
	| "Filename.MachineName.err"     	|"<\\hdc505lbiswv001.lab1.hdc.mdsol.com\FTP\rave564conlabtesting7\Log>" |

And I take screenshot

And I will see a Failure email to rave user "<Rave User 1>"
And I open the email
And I take a screenshot

And I should see new subjects created in Rave with Initials "<SubName>"
And I take a screenshot
#-----------------------------------------------------------------------------------------------------------------------------------
@Scenario MCC47180-03
@Validation
Scenario: Logs are generated in system log folder when there is a change at system level configuration in BU.

Given I Log in to Batch Upload server "<HDC505LBBULV002>" through jump server
When I navigate to Start menu
And I select Administrative tools
And I select Services
And I see Services Menu
And I select Medidata Batch uploader service "<Medidata Batch Uploader - rave564conlabtesting7>"
And I click on "Stop" 
And I click on "OK"
And I take a screenshot
And I navigate to path "<\\hdc505lbiswv001.lab1.hdc.mdsol.com\FTP\rave564conlabtesting7\System Log>"
Then I should see "<Threadname.MachineName.log>" generated with latest timestamp
And I take a screenshot

And I navigate to "Services" menu
And I select Medidata Batch uploader service "<Medidata Batch Uploader - rave564conlabtesting7>"
And I click on "Start" 
And I click on "OK"
And I take a screenshot
And I navigate to path "<\\hdc505lbiswv001.lab1.hdc.mdsol.com\FTP\rave564conlabtesting7\System Log>"
Then I should see "<Threadname.MachineName.log>" generated with latest timestamp
And I take a screenshot

#-----------------------------------------------------------------------------------------------------------------------------------