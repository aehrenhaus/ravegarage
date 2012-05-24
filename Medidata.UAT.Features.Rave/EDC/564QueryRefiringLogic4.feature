Feature: Feaature 4
 Query Issue: Edit Checks with no require response and require manual close
Open a query, change the data and close the query, change it back to previous data query did refire and verify there is no log

-- project to be uploaded in excel spreadsheet 'Edit Check Study 4'
Background:
    Given I login to Rave with user "DefaultUser"
	And user "User"  has study "Study" has role "Role" has site "Site" in database "<EDC>",, from the table below
		|User		|Study		       |Role |Site		        |Site Number|
		|editcheck  |Edit Check Study 4|cdm1 |Edit Check Site 4 |40001      |
    And role "cdm1" has Query actions
	And study "Edit Check Study" had draft "<Draft1>"
	And I publish and push "CRF Version<RANDOMNUMBER>" to site "Edit Check Site"

#----------------------------------------------------------------------------------------------------------------------------------------	
Scenario: Verifies query firing between  Cross Forms no require response and require manual close. Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
	
    And I create a Subject "sub401"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter data in CRF
And I save CRF
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take screenshot
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I enter data in CRF
And I save CRF
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify Field "Assessment Date 1" displays Query without Requires Response
    And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save CRF
    And I close the Query on Field "Assessment Date 1, Numeric Field 2"
	And I save CRF	
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save CRF	
	And I verify Field "Assessment Date 1" displays Query
	And I verify Field "Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub401       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2     		  |1                          |Assessment Date 1	   |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub401       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2		      |1                          |Numeric FiEeld 2        |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot
    
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I add a new Log Line
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |18          |	
	And I verify Field "Assessment Date 1" displays Query without Requires Response
    And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save CRF	
	And I verify Field "Assessment Date 1" displays Query
	And I verify Field "Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub401       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2		      |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub401       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2		      |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
Scenario: Verifies query firing between cross folders with no require response and require manual close.
Cross Folders: Standard form to log form
Folder "Test A Single Edit" enter and save data on form "Informed Consent Date Form 1"
Folder "Test B Single Derivation" enter and save data on form "Assessment Date Log2"
			  
    And I create a Subject "sub402"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter data in CRF
And I save CRF
	    |Field                   |Data        |
        |Informed Consent Date 1 |10 Jan 2000 |
	    |Informed Consent Date 2 |10 Feb 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |200         |
	And I take screenshot
	And I select Form "Assessment Date Log2" in Folder "Test B Single Derivation"
    And I enter data in CRF
And I save CRF
	    |Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Assessment Date 2 |11 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |	
	And I verify Field "Assessment Date 1" displays Query without Requires Response
    And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |	
	And I save CRF
	And I close the Query on Field "Assessment Date 1, Numeric Field 2"
	And I save CRF	
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |
	And I save CRF	
	And I verify Field "Assessment Date 1" displays Query
	And I verify Field "Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub402       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test B Single Derivation |Assessment Date Log2     		  |1                          |Assessment Date 1	   |09 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub402       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |99                   |Test B Single Derivation |Assessment Date Log2		      |1                          |Numeric Field 2         |99               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take screenshot
    
	And I select Form "Assessment Date Log2" in Folder "Test B Single Derivation"
    And I add a new Log Line
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |12 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |	
	And I verify Field "Assessment Date 1" displays Query without Requires Response
    And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |
    And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save CRF	
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |
	And I save CRF	
	And I verify Field "Assessment Date 1" displays Query
	And I verify Field "Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub402       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 1    |08 Jan 2000          |Test B Single Derivation |Assessment Date Log2      		  |2                          |Assessment Date 1	   |08 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub402       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |98                   |Test B Single Derivation |Assessment Date Log2		      |2                          |Numeric Field 2         |98               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
Scenario: Verifies query firing between  Cross Forms in opposite direction with no require response and require manual close. Cross Forms: log form to Standard form 
Folder "Test B Single Derivation" enter and save data on forms "Assessment Date Log2" and "Informed Consent Date Form 1"
			  
    And I create a Subject "sub403"
	And I navigate to folder "Test B Single Derivation"
	And I select form "Assessment Date Log2"
	And I enter data in CRF
And I save CRF
	    |Field             |Data        |
        |Assessment Date 1 |12 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |101         |	
	And I verify Field "Assessment Date 2" displays Query without Requires Response
	And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 2   |100         |
	And I save CRF
	And I close the Query on Field "Assessment Date 2, Numeric Field 2"
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 2   |101         |
	And I save CRF	
    And I verify Field "Assessment Date 2" displays Query
	And I verify Field "Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub403       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 2    |11 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |1                          |Assessment Date 2 |11 Jan 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub403       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |101                  |Test B Single Derivation |Assessment Date Log2             |1                          |Numeric Field 2   |101              |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take screenshot
	
	And I select Form "Assessment Date Log2" in Folder "Test B Single Derivation"
	And I add a new Log Line
    And I enter data in CRF
And I save CRF
	    |Field             |Data        |
        |Assessment Date 1 |15 Feb 2000 |
	    |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 1   |1999        |
	    |Numeric Field 2   |2000        |	
	And I verify Field "Assessment Date 2" displays Query without Requires Response
	And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 2 |15 Feb 2000 |
	    |Numeric Field 2   |1999        |
	And I cancel the queries on "Assessment Date 2" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 2   |2000        |
	And I save CRF	
	And I verify Field "Assessment Date 2" displays Query
	And I verify Field "Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub403       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 2    |14 Feb 2000          |Test B Single Derivation |Assessment Date Log2             |2                          |Assessment Date 2 |14 Feb 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub403       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |2000                 |Test B Single Derivation |Assessment Date Log2             |2                          |Numeric Field 2   |2000             |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take screenshot
   
   And I select Form "Informed Consent Date Form 1" in Folder "Test B Single Derivation"
   And I enter data in CRF
And I save CRF
	    |Field                   |Data        |
        |Informed Consent Date 1 |12 Jan 2000 |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |101         |	
	And I verify Field "Informed Consent Date 2" displays Query without Requires Response
	And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
	    |Field                   |Data        |
	    |Informed Consent Date 2 |13 Jan 2000 |
	    |Numeric Field 2         |100         |	
	And I cancel the queries on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
    And I enter data in CRF
	    |Field                   |Data        |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 2         |101         |	
	And I save CRF
	And I verify Field "Informed Consent Date 2,Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName    |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                                      |MarkingGroupName |QueryMessage                  |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub403       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Informed Consent Date 2 |11 Jan 2000          |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Informed Consent Date 2 |11 Jan 2000      |*Greater Than or Equal To Open Query Log same form |Marking Group 1  |Dates are not equal.          |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub403       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Numeric Field 2         |101                  |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Numeric Field 2         |101              |*Is Not Equal To Open Query Log Same form          |Marking Group 1  |Numeric fields are not equal. |{DateTime} |
	And I take screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
 Scenario: Verifies query firing between  Cross Forms in opposite direction in different folder with no require response and require manual close. Cross Forms: log form to log form 
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
			  
    And I create a Subject "sub404"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter data in CRF
And I save CRF
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I take screenshot
	And I select Form "Assessment Date Log3" in Folder "Test A Single Edit"
    And I enter data in CRF
And I save CRF
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	    |Numeric Field 1 |101         |
	    |Numeric Field 2 |66          |
	And I take screenshot
    And I navigate to form "Assessment Date Log2"		
	And I verify Field "Assessment Date 1" displays Query without Requires Response
	And I verify Field "Assessment Date 2" displays Query without Requires Response
	And I verify Field "Numeric Field 1" displays Query without Requires Response
	And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |11 Jan 2000 |
	    |Assessment Date 2 |09 Feb 2000 |
	    |Numeric Field 1   |102         |
	    |Numeric Field 2   |65          |	
	And I save CRF
	And I close the queries on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I save CRF	
	And I verify Field "Assessment Date 1,Assessment Date 2,Numeric Field 1,Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub404       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1|10 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub404       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 2|10 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub404       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |100                  |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub404       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |66                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2  |66               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take screenshot
   
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I add a new log line,, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I take screenshot
    And I select Form "Assessment Date Log3" in Folder "Test A Single Edit"
    And I add a new log line,, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Feb 2000 |
	    |Date Field 2    |09 Mar 2000 |
	    |Numeric Field 1 |201         |
	    |Numeric Field 2 |77          |	
	And I take screenshot
    And	I navigate to form "Assessment Date Log2"
	And	I select second log line
	And I verify Field "Assessment Date 1" displays Query without Requires Response
	And I verify Field "Assessment Date 2" displays Query without Requires Response
	And I verify Field "Numeric Field 1" displays Query without Requires Response
	And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
    And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |11 Feb 2000 |
	    |Assessment Date 2 |09 Mar 2000 |
	    |Numeric Field 1   |202         |
	    |Numeric Field 2   |76          |	
	And I cancel the queries on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I save CRF	
	And I verify Field "Assessment Date 1,Assessment Date 2,Numeric Field 1,Numeric Field 2" displays Query 
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName 	|TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub404       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1    |10 Feb 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub404       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 2    |10 Mar 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 2    |10 Mar 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub404       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 1      |200                  |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 1  	|200              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub404       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |77                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2  	|77               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take screenshot
	
# Query Issue: Edit Checks with no require response and require manual close
Open a query, cancel a query, change the correct data and change it back to previous data query didn't fired and verify the log

#----------------------------------------------------------------------------------------------------------------------------------------	
 Scenario: Verifies query firing between  Cross Forms with no require response and require manual close. Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
	
    And I create a Subject "sub405"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter data in CRF
And I save CRF
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take screenshot
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I enter data in CRF
And I save CRF
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify Field "Assessment Date 1" displays Query without Requires Response
    And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields.
	And I save CRF
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save CRF
    And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save CRF	
	And I verify the new queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub405       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2		      |1                          |Assessment Date 1	   |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub405       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2		      |1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot
    
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I add a new Log Line
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |18          |	
	And I verify Field "Assessment Date 1" displays Query without Requires Response
    And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields.
	And I save CRF
	And I take screenshot
	And I verify the queries did not fire the data on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save CRF	
	And I verify the new queries did fire the data on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub405       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2		      |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub405       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2		      |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot

Scenario: Verifies query firing between cross folders with no require response and require manual close.
Cross Folders: Standard form to log form
Folder "Test A Single Edit" enter and save data on form "Informed Consent Date Form 1"
Folder "Test B Single Derivation" enter and save data on form "Assessment Date Log2"
			  
    And I create a Subject "sub406"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter data in CRF
And I save CRF
	    |Field                   |Data        |
        |Informed Consent Date 1 |10 Jan 2000 |
	    |Informed Consent Date 2 |10 Feb 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |200         |
	And I take screenshot
	And I select Form "Assessment Date Log2" in Folder "Test B Single Derivation"
    And I enter data in CRF
And I save CRF
	    |Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Assessment Date 2 |11 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |	
	And I verify Field "Assessment Date 1" displays Query without Requires Response
    And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields.
	And I save CRF
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |	
	And I save CRF
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |
	And I save CRF	
    And I verify the new queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName  |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub406       |Test B Single Derivation |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test B Single Derivation |Assessment Date Log2		       |1                          |Assessment Date 1	    |09 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub406       |Test B Single Derivation |Assessment Date Log2            |1                         |Numeric Field 2      |99                   |Test B Single Derivation |Assessment Date Log2		       |1                          |Numeric Field 2         |99               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take screenshot
    
	And I select Form "Assessment Date Log2" in Folder "Test B Single Derivation"
    And I add a new Log Line
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |12 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |	
	And I verify Field "Assessment Date 1" displays Query without Requires Response
    And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |	
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
    And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |
	And I save CRF	
	And I verify Field "Assessment Date 1,Numeric Field 2" displays Query 
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub406       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 1    |08 Jan 2000          |Test B Single Derivation |Assessment Date Log2		      |2                          |Assessment Date 1	   |08 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub406       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |98                   |Test B Single Derivation |Assessment Date Log2		      |2                          |Numeric Field 2         |98               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take screenshot

Scenario: Verifies query firing between  Cross Forms in opposite direction with no require response and require manual close. Cross Forms: log form to Standard form 
Folder "Test B Single Derivation" enter and save data on forms "Assessment Date Log2" and "Informed Consent Date Form 1"
			  
    And I create a Subject "sub407"
	And I navigate to folder "Test B Single Derivation"
	And I select form "Assessment Date Log2"
	And I enter data in CRF
And I save CRF
	    |Field             |Data        |
        |Assessment Date 1 |12 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |101         |
	And I verify Field "Assessment Date 2" displays Query without Requires Response
	And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I cancel the queries on on "Assessment Date 2" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 2   |100         |
	And I save CRF
	And I verify the queries did not fire on "Assessment Date 2" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 2   |101         |
	And I save CRF	
    And I verify the new queries did not fire on "Assessment Date 2" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub407       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 2    |11 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |1                          |Assessment Date 2 |11 Jan 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub407       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |101                  |Test B Single Derivation |Assessment Date Log2             |1                          |Numeric Field 2   |101              |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take screenshot
	
	And I select Form "Assessment Date Log2" in Folder "Test B Single Derivation"
	And I add a new Log Line
    And I enter data in CRF
And I save CRF
	    |Field             |Data        |
        |Assessment Date 1 |15 Feb 2000 |
	    |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 1   |1999        |
	    |Numeric Field 2   |2000        |	
	And I verify Field "Assessment Date 2" displays Query without Requires Response
	And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 2 |15 Feb 2000 |
	    |Numeric Field 2   |1999        |
	And I cancel the queries on "Assessment Date 2" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
	And I verify the queries did not fire on "Assessment Date 2" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 2   |2000        |
	And I save CRF	
	And I verify Field "Assessment Date 2,Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub407       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 2    |14 Feb 2000          |Test B Single Derivation |Assessment Date Log2             |2                          |Assessment Date 2 |14 Feb 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub407       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |2000                 |Test B Single Derivation |Assessment Date Log2             |2                          |Numeric Field 2   |2000             |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take screenshot
    
	And I select Form "Informed Consent Date Form 1" in Folder "Test B Single Derivation"
    And I enter data in CRF
And I save CRF
	    |Field                   |Data        |
        |Informed Consent Date 1 |12 Jan 2000 |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |101         |	
	And I verify Field "Informed Consent Date 2" displays Query without Requires Response
	And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I enter data in CRF
	    |Field                   |Data        |
	    |Informed Consent Date 2 |13 Jan 2000 |
	    |Numeric Field 2         |100         |	
	And I cancel the queries on "Assessment Date 2" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
	And I verify the queries did not fire on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I take screenshot
    And I enter data in CRF
	    |Field                   |Data        |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 2         |101         |	
	And I save CRF
	And I verify Field "Informed Consent Date 2,Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName    |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                                      |MarkingGroupName |QueryMessage                  |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub407       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Informed Consent Date 2 |11 Jan 2000          |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Informed Consent Date 2 |11 Jan 2000      |*Greater Than or Equal To Open Query Log same form |Marking Group 1  |Dates are not equal.          |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub407       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Numeric Field 2         |101                  |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Numeric Field 2         |101              |*Is Not Equal To Open Query Log Same form          |Marking Group 1  |Numeric fields are not equal. |{DateTime} |
	And I take screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
 Scenario: Verifies query firing between  Cross Forms in opposite direction in different folder with no require response and require manual close. Cross Forms: log form to log form 
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
			  
    And I create a Subject "sub408"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter data in CRF
And I save CRF
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I take screenshot
	And I select Form "Assessment Date Log3" in Folder "Test A Single Edit"
    And I enter data in CRF
And I save CRF
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	    |Numeric Field 1 |101         |
	    |Numeric Field 2 |66          |
	And I take screenshot
    And I navigate to form "Assessment Date Log2"		
	And I verify Field "Assessment Date 1" displays Query without Requires Response
	And I verify Field "Assessment Date 2" displays Query without Requires Response
	And I verify Field "Numeric Field 1" displays Query without Requires Response
	And I verify Field "Numeric Field 2" displays Query without Requires Response
	And I take screenshot
	And I cancel the queries on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |11 Jan 2000 |
	    |Assessment Date 2 |09 Feb 2000 |
	    |Numeric Field 1   |102         |
	    |Numeric Field 2   |65          |	
	And I save CRF
	And I verify Field "Assessment Date 1,Assessment Date 2,Numeric Field 1,Numeric Field 2" has NO Query 
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I save CRF	
	And I verify Field "Assessment Date 1,Assessment Date 2,Numeric Field 1,Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub408       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1|10 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub408       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 2|10 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub408       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |100                  |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub408       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |66                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2  |66               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take screenshot
   
    And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I add a new log line,, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I take screenshot
    And I select Form "Assessment Date Log3" in Folder "Test A Single Edit"
    And I add a new log line, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Feb 2000 |
	    |Date Field 2    |09 Mar 2000 |
	    |Numeric Field 1 |201         |
	    |Numeric Field 2 |77          |	
	And I take screenshot
    And	I navigate to form "Assessment Date Log2"
	And	I select second log line
	And I verify Field "Assessment Date 1, Assessment Date 2, Numeric Field 1, Numeric Field 2" displays Query without Requires Response
	And I take screenshot
    And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |11 Feb 2000 |
	    |Assessment Date 2 |09 Mar 2000 |
	    |Numeric Field 1   |202         |
	    |Numeric Field 2   |76          |		
	And I cancel the queries on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I save CRF
	And I take screenshot
	And I verify Field "Assessment Date 1,Assessment Date 2,Numeric Field 1,Numeric Field 2" has NO Query
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I save CRF	
	And I verify Field "Assessment Date 1,Assessment Date 2,Numeric Field 1,Numeric Field 2" displays Query
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub408       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1|10 Feb 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub408       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 2    |10 Mar 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 2|10 Mar 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub408       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 1      |200                  |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 1  |200              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 4 |40001       |Edit Check Site 4 |PROD        |sub408       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |77                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2  |77               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	