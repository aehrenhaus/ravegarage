Feature: Feaature 2
 Query Issue: Edit Checks with no require response and no require manual close
Open a query, change the correct data closes the query automatically and change it back to previous data query refires and verify no log

-- project to be uploaded in excel spreadsheet 'Edit Check Study 2'

Background:
    Given I login to Rave with user "DefaultUser"
	And user "User"  has study "Study" has role "Role" has site "Site" in database "<EDC>", from the table below
		|User		|Study		       |Role |Site		        |Site Number|
		|editcheck  |Edit Check Study 2|cdm1 |Edit Check Site 2 |20001      |
    And role "cdm1" has Query actions
	And study "Edit Check Study" had draft "<Draft1>"
	And I publish and push "CRF Version<RANDOMNUMBER>" to site "Edit Check Site"
	
Scenario: Verifies query firing between  Cross Forms with no require response and no require manual close. Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
	
    And I create a Subject "sub201"
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
    And I verify the queries closed automatically on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save CRF	
	And I verify queries refire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub201       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2		      |1                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub201       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2		      |1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
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
	And I save CRF
	And I verify the queries closed automatically on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save CRF	
	And I verify queries refire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub201       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2		      |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub201       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2		      |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot
	
	
Scenario: Verifies query firing between cross folders with no require response and no require manual close.
Cross Folders: Standard form to log form
Folder "Test A Single Edit" enter and save data on form "Informed Consent Date Form 1"
Folder "Test B Single Derivation" enter and save data on form "Assessment Date Log2"
			  
    And I create a Subject "sub202"
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
	And I verify the queries closed automatically on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |
	And I save CRF	
    And I verify queries refire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub202       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test A Single Edit       |Assessment Date Log2		      |1                          |Assessment Date 1	   |09 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub202       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |99                   |Test A Single Edit       |Assessment Date Log2		      |1                          |Numeric Field 2         |99               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
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
	And I change the data "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |
	And I save CRF
    And I verify the queries closed automatically on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |
	And I save CRF	
	And I verify queries refire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub202       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2		      |2                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub202       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |98                   |Test A Single Edit       |Assessment Date Log2		      |2                          |Numeric Field 2         |98               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take screenshot


Scenario: Verifies query firing between  Cross Forms with no require response and no require manual close. Cross Forms: log form to Standard form 
Folder "Test B Single Derivation" enter and save data on forms "Assessment Date Log2" and "Informed Consent Date Form 1"
			  
    And I create a Subject "sub203"
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
	And I verify the queries closed automatically on "Assessment Date 2" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 2   |101         |
	And I save CRF	
    And I verify queries refire on "Assessment Date 2" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 2    |11 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |1                          |Assessment Date 2 |11 Jan 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |101                  |Test B Single Derivation |Assessment Date Log2             |1                          |Numeric Field 2   |101              |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
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
	And I save CRF
	And I verify the queries closed automatically on "Assessment Date 2" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 2   |2000        |
	And I save CRF	
	And I verify queries refire on "Assessment Date 2" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 2    |14 Feb 2000          |Test B Single Derivation |Assessment Date Log2             |2                          |Assessment Date 2 |14 Feb 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |2000                 |Test B Single Derivation |Assessment Date Log2             |2                          |Numeric Field 2   |2000             |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
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
	And I save CRF
	And I verify the queries closed automatically on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I take screenshot
    And I enter data in CRF
	    |Field                   |Data        |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 2         |101         |	
	And I save CRF
	And I verify queries refire on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName    |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                                      |MarkingGroupName |QueryMessage                  |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Informed Consent Date 2 |11 Jan 2000          |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Informed Consent Date 2 |11 Jan 2000      |*Greater Than or Equal To Open Query Log same form |Marking Group 1  |Dates are not equal.          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Numeric Field 2         |101                  |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Numeric Field 2         |101              |*Is Not Equal To Open Query Log Same form          |Marking Group 1  |Numeric fields are not equal. |{DateTime} |
	And I take screenshot


 Scenario: Verifies query firing between  Cross Forms in different folder with no require response and no require manual close. Cross Forms: log form to log form 
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
			  
    And I create a Subject "sub204"
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
	And I verify the queries closed automatically on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I save CRF	
	And I verify queries refire on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1|10 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 2|10 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |100                  |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |66                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2  |66               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take screenshot
    
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I add and save new log line, from the table below, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I take screenshot
    And I select Form "Assessment Date Log3" in Folder "Test A Single Edit"
    And I add and save new log line, from the table below, from the table below
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
	And I save CRF
	And I verify the queries closed automatically on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I save CRF	
	And I verify queries refire on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1|10 Feb 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 2    |10 Mar 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 2|10 Mar 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 1      |200                  |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 1  |200              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |77                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2  |77               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take screenshot
	


	
 Scenario: 
 Query Issue: Edit Checks with no require response and no require manual close
Open a query, cancel a query, change the correct data and change it back to previous data query didn't fired and verify log
 
 Verifies query firing between  Cross Forms with no require response and no require manual close. Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
	
    And I create a Subject "sub205"
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
    And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save CRF	
	And I verify the new queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub205       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub205       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
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
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save CRF	
	And I verify that new queries did fire on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub205       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2    		  |2                          |Assessment Date 1 	   |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub205       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2	    	  |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot


 Scenario: Verifies query firing between cross folders with no require response and no require manual close.
Cross Folders: Standard form to log form
Folder "Test A Single Edit" enter and save data on form "Informed Consent Date Form 1"
Folder "Test B Single Derivation" enter and save data on form "Assessment Date Log2"
			  
    And I create a Subject "sub206"
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
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields.
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
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub206       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test B Single Derivation |Assessment Date Log2		      |1                          |Assessment Date 1       |09 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub206       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |99                   |Test B Single Derivation |Assessment Date Log2     		  |1                          |Numeric Field 2         |99               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
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
    And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |
	And I save CRF	
	And I verify Field "Assessment Date 1,Numeric Field 2" displays Query.
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud NOT see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub206       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 1    |08 Jan 2000          |Test B Single Derivation |Assessment Date Log2     		  |2                          |Assessment Date 1	   |08 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub206       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |98                   |Test B Single Derivation |Assessment Date Log2		      |2                          |Numeric Field 2         |98               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take screenshot


Scenario: Verifies query firing between  Cross Forms with no require response and no require manual close. Cross Forms: log form to Standard form 
Folder "Test B Single Derivation" enter and save data on forms "Assessment Date Log2" and "Informed Consent Date Form 1"
			  
    And I create a Subject "sub207"
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
	And I cancel the queries on "Assessment Date 2" and "Numeric Field 2" fields
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
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 2    |11 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |1                          |Assessment Date 2 |11 Jan 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |101                  |Test B Single Derivation |Assessment Date Log2             |1                          |Numeric Field 2   |101              |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
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
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 2    |14 Feb 2000          |Test B Single Derivation |Assessment Date Log2             |2                          |Assessment Date 2 |14 Feb 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |2000                 |Test B Single Derivation |Assessment Date Log2             |2                          |Numeric Field 2   |2000             |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
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
	And I verify the new queries did not fire on "Informed Consent Date 2" and "Numeric Field 2" fields
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
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Informed Consent Date 2 |11 Jan 2000          |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Informed Consent Date 2 |11 Jan 2000      |*Greater Than or Equal To Open Query Log same form |Marking Group 1  |Dates are not equal.          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Numeric Field 2         |101                  |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Numeric Field 2         |101              |*Is Not Equal To Open Query Log Same form          |Marking Group 1  |Numeric fields are not equal. |{DateTime} |
	And I take screenshot

	
 Scenario: Verifies query firing between  Cross Forms with no require response and no require manual close. Cross Forms: log form to log form 
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
			  
    And I create a Subject "sub208"
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
	And I verify the new queries did not fire on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields 
	And I take screenshot
    When I run SQL Script "Query Logging Script.sql"  
    Then I shoud see SQL result 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1|10 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 2|10 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |100                  |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |66                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2  |66               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take screenshot
    
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I add and save new log line, from the table below, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I take screenshot
    And I select Form "Assessment Date Log3" in Folder "Test A Single Edit"
    And I add and save new log line, from the table below, from the table below
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
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1|10 Feb 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 2    |10 Mar 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 2|10 Mar 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 1      |200                  |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 1  |200              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |77                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2  |77               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take screenshot
	
	