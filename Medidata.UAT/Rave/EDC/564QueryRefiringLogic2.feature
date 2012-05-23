Feature: Feaature 2
 Query Issue: Edit Checks with no require response and no require manual close
Open a query, change the correct data closes the query automatically and change it back to previous data query refires and verify no log

-- project to be uploaded in excel spreadsheet 'Edit Check Study 2'

Background:
    Given I am on Rave
	And user "User"  has study "Study" has role "Role" has site "Site" in database "<EDC>", from the table below
		|User		|Study		       |Role |Site		        |Site Number|
		|editcheck  |Edit Check Study 2|cdm1 |Edit Check Site 2 |20001      |
    And role "cdm1" has Query actions
	And study "Edit Check Study" had draft "<Draft1>"
	And I publish and push "CRF Version<RANDOMNUMBER>" to site "Edit Check Site"
	
Scenario: Verifies query firing between cross forms with no require response and no require manual close.
Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
	
    And I create a subject "sub201"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot 1 of 93		
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with no require response
    And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 2 of 93	
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save the form "Assessment Date Log2"
    And I verify the queries closed automatically on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 3 of 93	
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save the form "Assessment Date Log2"	
	And I verify queries refire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 4 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub201       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2		      |1                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub201       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2		      |1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 5 of 93	
    
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I add a new log line enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |18          |	
	And I verify "Assessment Date 1" field displays query opened with no require response on the second log line
    And I verify "Numeric Field 2" field displays query opened with no require response on the second log line
	And I take a screenshot 6 of 93	
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save the form "Assessment Date Log2"
	And I verify the queries closed automatically on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 7 of 93	
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save the form "Assessment Date Log2"	
	And I verify queries refire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 8 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub201       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2		      |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub201       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2		      |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 9 of 93	
	
	
Scenario: Verifies query firing between cross folders with no require response and no require manual close.
Cross Folders: Standard form to log form
Folder "Test A Single Edit" enter and save data on form "Informed Consent Date Form 1"
Folder "Test B Single Derivation" enter and save data on form "Assessment Date Log2"
			  
    And I create a subject "sub202"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |10 Jan 2000 |
	    |Informed Consent Date 2 |10 Feb 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |200         |
	And I take a screenshot 10 of 93		
	And I navigate to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Assessment Date 2 |11 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |	
	And I verify "Assessment Date 1" field displays query opened with no require response
    And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 11 of 93	
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |	
	And I save the form "Assessment Date Log2"
	And I verify the queries closed automatically on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 12 of 93	
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |
	And I save the form "Assessment Date Log2"	
    And I verify queries refire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 13 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub202       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test A Single Edit       |Assessment Date Log2		      |1                          |Assessment Date 1	   |09 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub202       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |99                   |Test A Single Edit       |Assessment Date Log2		      |1                          |Numeric Field 2         |99               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot 14 of 93	
    
	And I navigate to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I add a new log line enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |12 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |	
	And I verify "Assessment Date 1" field displays query opened with no require response on the second log line
    And I verify "Numeric Field 2" field displays query opened with no require response on the second log line
	And I take a screenshot 15 of 93	
	And I change the data on the second log line "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |
	And I save the form "Assessment Date Log2"
    And I verify the queries closed automatically on the second log line on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 16 of 93	
	And I change the data on the second log line on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |
	And I save the form "Assessment Date Log2"	
	And I verify queries refire on the second log line on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 17 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub202       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2		      |2                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub202       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |98                   |Test A Single Edit       |Assessment Date Log2		      |2                          |Numeric Field 2         |98               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot 18 of 93	


Scenario: Verifies query firing between cross forms with no require response and no require manual close.
Cross Forms: log form to Standard form 
Folder "Test B Single Derivation" enter and save data on forms "Assessment Date Log2" and "Informed Consent Date Form 1"
			  
    And I create a subject "sub203"
	And I navigate to folder "Test B Single Derivation"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |12 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |101         |
	And I verify "Assessment Date 2" field displays query opened with no require response
	And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 19 of 93	
	And I change the data on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 2   |100         |
	And I save the form "Assessment Date Log2"
	And I verify the queries closed automatically on "Assessment Date 2" and "Numeric Field 2" fields
	And I take a screenshot 20 of 93	
	And I change the data on log line 1 on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 2   |101         |
	And I save the form "Assessment Date Log2"	
    And I verify queries refire on "Assessment Date 2" and "Numeric Field 2" fields
	And I take a screenshot 21 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 2    |11 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |1                          |Assessment Date 2 |11 Jan 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |101                  |Test B Single Derivation |Assessment Date Log2             |1                          |Numeric Field 2   |101              |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take a screenshot 22 of 93	
	
	And I add a new log line to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |15 Feb 2000 |
	    |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 1   |1999        |
	    |Numeric Field 2   |2000        |	
	And I verify "Assessment Date 2" field displays query opened with no require response on the second log line
	And I verify "Numeric Field 2" field displays query opened with no require response on the second log line
	And I take a screenshot 23 of 93	
	And I change the data on the second log line on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |15 Feb 2000 |
	    |Numeric Field 2   |1999        |
	And I save the form "Assessment Date Log2"
	And I verify the queries closed automatically on the second log line on "Assessment Date 2" and "Numeric Field 2" fields
	And I take a screenshot 24 of 93	
	And I change the data on the second log line on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 2   |2000        |
	And I save the form "Assessment Date Log2"	
	And I verify queries refire on the second log line on "Assessment Date 2" and "Numeric Field 2" fields
	And I take a screenshot 25 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 2    |14 Feb 2000          |Test B Single Derivation |Assessment Date Log2             |2                          |Assessment Date 2 |14 Feb 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |2000                 |Test B Single Derivation |Assessment Date Log2             |2                          |Numeric Field 2   |2000             |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take a screenshot 26 of 93	
    
	And I navigate to form "Informed Consent Date Form 1" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |12 Jan 2000 |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |101         |	
	And I verify "Informed Consent Date 2" field displays query opened with no require response
	And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 27 of 93	
	And I change the data on "Informed Consent Date 2" and "Numeric Field 2" fields, from the table below
	    |Field                   |Data        |
	    |Informed Consent Date 2 |13 Jan 2000 |
	    |Numeric Field 2         |100         |	
	And I save the form "Informed Consent Date Form 1"
	And I verify the queries closed automatically on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I take a screenshot 28 of 93	
    And I change the data on "Informed Consent Date 2" and "Numeric Field 2" fields, from the table below
	    |Field                   |Data        |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 2         |101         |	
	And I save the form "Informed Consent Date Form 1"
	And I verify queries refire on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I take a screenshot 29 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName    |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                                      |MarkingGroupName |QueryMessage                  |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Informed Consent Date 2 |11 Jan 2000          |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Informed Consent Date 2 |11 Jan 2000      |*Greater Than or Equal To Open Query Log same form |Marking Group 1  |Dates are not equal.          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub203       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Numeric Field 2         |101                  |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Numeric Field 2         |101              |*Is Not Equal To Open Query Log Same form          |Marking Group 1  |Numeric fields are not equal. |{DateTime} |
	And I take a screenshot 30 of 93	


 Scenario: Verifies query firing between cross forms in different folder with no require response and no require manual close.
Cross Forms: log form to log form 
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
			  
    And I create a subject "sub204"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I take a screenshot 31 of 93		
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	    |Numeric Field 1 |101         |
	    |Numeric Field 2 |66          |
	And I take a screenshot 32 of 93		
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with no require response
	And I verify "Assessment Date 2" field displays query opened with no require response
	And I verify "Numeric Field 1" field displays query opened with no require response
	And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 33 of 93	
	And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |11 Jan 2000 |
	    |Assessment Date 2 |09 Feb 2000 |
	    |Numeric Field 1   |102         |
	    |Numeric Field 2   |65          |	
	And I save the form "Assessment Date Log2"
	And I verify the queries closed automatically on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 34 of 93	
	And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I save the form "Assessment Date Log2"	
	And I verify queries refire on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 35 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1|10 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 2|10 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |100                  |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |66                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2  |66               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot 36 of 93	
    
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I add and save new log line, from the table below, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I take a screenshot 37 of 93		
    And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I add and save new log line, from the table below, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Feb 2000 |
	    |Date Field 2    |09 Mar 2000 |
	    |Numeric Field 1 |201         |
	    |Numeric Field 2 |77          |	
	And I take a screenshot 38 of 93		
    And	I navigate to form "Assessment Date Log2"
	And	I select second log line
	And I verify "Assessment Date 1" field displays query opened with no require response
	And I verify "Assessment Date 2" field displays query opened with no require response
	And I verify "Numeric Field 1" field displays query opened with no require response
	And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 39 of 93	
    And I change the data on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |11 Feb 2000 |
	    |Assessment Date 2 |09 Mar 2000 |
	    |Numeric Field 1   |202         |
	    |Numeric Field 2   |76          |	
	And I save the form "Assessment Date Log2"
	And I verify the queries closed automatically on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 40 of 93	
	And I change the data on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I save the form "Assessment Date Log2"	
	And I verify queries refire on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 41 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1|10 Feb 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 2    |10 Mar 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 2|10 Mar 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 1      |200                  |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 1  |200              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub204       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |77                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2  |77               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot 42 of 93	
	


	
 Scenario: 
 Query Issue: Edit Checks with no require response and no require manual close
Open a query, cancel a query, change the correct data and change it back to previous data query didn't fired and verify log
 
 Verifies query firing between cross forms with no require response and no require manual close.
Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
	
    And I create a subject "sub205"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot 43 of 93		
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with no require response
    And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 44 of 93	
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields.
	And I save the form "Assessment Date Log2"
	And I take a screenshot 45 of 93	
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save the form "Assessment Date Log2"
    And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take a screenshot 46 of 93	
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save the form "Assessment Date Log2"	
	And I verify the new queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take a screenshot 47 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub205       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub205       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 48 of 93	
    
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I add a new log line enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |18          |	
	And I verify "Assessment Date 1" field displays query opened with no require response on the second log line
    And I verify "Numeric Field 2" field displays query opened with no require response on the second log line
	And I take a screenshot 49 of 93	
	And I change the data on the second log line on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |		
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields.
	And I save the form "Assessment Date Log2"
	And I take a screenshot 50 of 93	
	And I verify the queries did not fire on the second log line on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take a screenshot 51 of 93	
	And I change the data on the second log line on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save the form "Assessment Date Log2"	
	And I verify that new queries did fire on the second log line on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take a screenshot 52 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub205       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2    		  |2                          |Assessment Date 1 	   |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub205       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2	    	  |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 53 of 93	


 Scenario: Verifies query firing between cross folders with no require response and no require manual close.
Cross Folders: Standard form to log form
Folder "Test A Single Edit" enter and save data on form "Informed Consent Date Form 1"
Folder "Test B Single Derivation" enter and save data on form "Assessment Date Log2"
			  
    And I create a subject "sub206"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |10 Jan 2000 |
	    |Informed Consent Date 2 |10 Feb 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |200         |
	And I take a screenshot 54 of 93		
	And I navigate to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Assessment Date 2 |11 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |	
	And I verify "Assessment Date 1" field displays query opened with no require response
    And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 55 of 93	
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields.
	And I save the form "Assessment Date Log2"
	And I take a screenshot 56 of 93	
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |	
	And I save the form "Assessment Date Log2"
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take a screenshot 57 of 93	
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |
	And I save the form "Assessment Date Log2"	
    And I verify the new queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take a screenshot 58 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub206       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test B Single Derivation |Assessment Date Log2		      |1                          |Assessment Date 1       |09 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub206       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |99                   |Test B Single Derivation |Assessment Date Log2     		  |1                          |Numeric Field 2         |99               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot 59 of 93	
    
	And I navigate to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I add a new log line enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |12 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |	
	And I verify "Assessment Date 1" field displays query opened with no require response on the second log line
    And I verify "Numeric Field 2" field displays query opened with no require response on the second log line
	And I take a screenshot 60 of 93
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |	
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields on the second log line
	And I save the form "Assessment Date Log2"
	And I take a screenshot 61 of 93	
    And I verify the queries did not fire on the second log line on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take a screenshot 62 of 93	
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |
	And I save the form "Assessment Date Log2"	
	And I verify the new queries did fire on the second log line on "Assessment Date 1" and "Numeric Field 2" fields.
	And I take a screenshot 63 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub206       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 1    |08 Jan 2000          |Test B Single Derivation |Assessment Date Log2     		  |2                          |Assessment Date 1	   |08 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub206       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |98                   |Test B Single Derivation |Assessment Date Log2		      |2                          |Numeric Field 2         |98               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot 64 of 93	


Scenario: Verifies query firing between cross forms with no require response and no require manual close.
Cross Forms: log form to Standard form 
Folder "Test B Single Derivation" enter and save data on forms "Assessment Date Log2" and "Informed Consent Date Form 1"
			  
    And I create a subject "sub207"
	And I navigate to folder "Test B Single Derivation"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |12 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |101         |
	And I verify "Assessment Date 2" field displays query opened with no require response
	And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 65 of 93	
	And I cancel the queries on "Assessment Date 2" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 66 of 93	
	And I change the data on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 2   |100         |
	And I save the form "Assessment Date Log2"
	And I verify the queries did not fire on "Assessment Date 2" and "Numeric Field 2" fields
	And I take a screenshot 67 of 93	
	And I change the data on log line 1 on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 2   |101         |
	And I save the form "Assessment Date Log2"	
    And I verify the new queries did not fire on "Assessment Date 2" and "Numeric Field 2" fields
	And I take a screenshot 68 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 2    |11 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |1                          |Assessment Date 2 |11 Jan 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |101                  |Test B Single Derivation |Assessment Date Log2             |1                          |Numeric Field 2   |101              |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take a screenshot 69 of 93
	
	And I add a new log line to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |15 Feb 2000 |
	    |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 1   |1999        |
	    |Numeric Field 2   |2000        |	
	And I verify "Assessment Date 2" field displays query opened with no require response on the second log line
	And I verify "Numeric Field 2" field displays query opened with no require response on the second log line
	And I take a screenshot 70 of 93
	And I change the data on the second log line on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |15 Feb 2000 |
	    |Numeric Field 2   |1999        |	
	And I cancel the queries on the second log line on "Assessment Date 2" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 71 of 93	
	And I verify the queries did not fire on the second log line on "Assessment Date 2" and "Numeric Field 2" fields
	And I take a screenshot 72 of 93	
	And I change the data on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 2   |2000        |
	And I save the form "Assessment Date Log2"	
	And I verify the new queries did fire on the second log line on "Assessment Date 2" and "Numeric Field 2" fields
	And I take a screenshot 73 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 2    |14 Feb 2000          |Test B Single Derivation |Assessment Date Log2             |2                          |Assessment Date 2 |14 Feb 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |2000                 |Test B Single Derivation |Assessment Date Log2             |2                          |Numeric Field 2   |2000             |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take a screenshot 74 of 93	
   
	And I navigate to form "Informed Consent Date Form 1" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |12 Jan 2000 |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |101         |	
	And I verify "Informed Consent Date 2" field displays query opened with no require response
	And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 75 of 93	
	And I change the data on "Informed Consent Date 2" and "Numeric Field 2" fields, from the table below
	    |Field                   |Data        |
	    |Informed Consent Date 2 |13 Jan 2000 |
	    |Numeric Field 2         |100         |	
	And I cancel the queries on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I save the form "Informed Consent Date Form 1"
	And I take a screenshot 76 of 93	
	And I verify the new queries did not fire on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I take a screenshot 77 of 93	
    And I change the data on "Informed Consent Date 2" and "Numeric Field 2" fields, from the table below
	    |Field                   |Data        |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 2         |101         |	
	And I save the form "Informed Consent Date Form 1"
	And I verify the new queries did fire on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I take a screenshot 78 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName    |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                                      |MarkingGroupName |QueryMessage                  |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Informed Consent Date 2 |11 Jan 2000          |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Informed Consent Date 2 |11 Jan 2000      |*Greater Than or Equal To Open Query Log same form |Marking Group 1  |Dates are not equal.          |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub207       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Numeric Field 2         |101                  |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Numeric Field 2         |101              |*Is Not Equal To Open Query Log Same form          |Marking Group 1  |Numeric fields are not equal. |{DateTime} |
	And I take a screenshot 79 of 93	

	
 Scenario: Verifies query firing between cross forms with no require response and no require manual close.
Cross Forms: log form to log form 
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
			  
    And I create a subject "sub208"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I take a screenshot 80 of 93		
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	    |Numeric Field 1 |101         |
	    |Numeric Field 2 |66          |
	And I take a screenshot 81 of 93		
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with no require response
	And I verify "Assessment Date 2" field displays query opened with no require response
	And I verify "Numeric Field 1" field displays query opened with no require response
	And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 82 of 93	
	And I cancel the queries on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 83 of 93	
	And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |11 Jan 2000 |
	    |Assessment Date 2 |09 Feb 2000 |
	    |Numeric Field 1   |102         |
	    |Numeric Field 2   |65          |	
	And I save the form "Assessment Date Log2"
	And I verify the queries did not fire on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields 
	And I take a screenshot 84 of 93	
	And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I save the form "Assessment Date Log2"	
	And I verify the new queries did not fire on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields 
	And I take a screenshot 85 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1|10 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 2|10 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |100                  |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |66                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2  |66               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot 86 of 93	
    
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I add and save new log line, from the table below, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I take a screenshot 87 of 93		
    And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I add and save new log line, from the table below, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Feb 2000 |
	    |Date Field 2    |09 Mar 2000 |
	    |Numeric Field 1 |201         |
	    |Numeric Field 2 |77          |	
	And I take a screenshot 88 of 93		
    And	I navigate to form "Assessment Date Log2"
	And	I select second log line
	And I verify "Assessment Date 1" field displays query opened with no require response
	And I verify "Assessment Date 2" field displays query opened with no require response
	And I verify "Numeric Field 1" field displays query opened with no require response
	And I verify "Numeric Field 2" field displays query opened with no require response
	And I take a screenshot 89 of 93	
   And I change the data on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |11 Feb 2000 |
	    |Assessment Date 2 |09 Mar 2000 |
	    |Numeric Field 1   |202         |
	    |Numeric Field 2   |76          |		
	And I cancel the queries on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 90 of 93	
	And I verify the queries did not fire on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 91 of 93	
	And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I save the form "Assessment Date Log2"	
	And I verify the new queries did fire on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 92 of 93	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1|10 Feb 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 2    |10 Mar 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 2|10 Mar 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 1      |200                  |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 1  |200              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 2 |20001       |Edit Check Site 2 |PROD        |sub208       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |77                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2  |77               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot 93 of 93
	
	