Feature: Feaature 3
 Query Issue: Edit Checks with require response and no require manual close
Open a query and answer a query, change the correct data closes the query automatically and change it back to previous data query did refires and verify there is no log

-- project to be uploaded in excel spreadsheet 'Edit Check Study 3'
Background:
    Given I am on Rave
	And user "User"  has study "Study" has role "Role" has site "Site" in database "<EDC>", from the table below
		|User		|Study		       |Role |Site		        |Site Number|
		|editcheck  |Edit Check Study 3|cdm1 |Edit Check Site 3 |30001      |
    And role "cdm1" has Query actions
	And study "Edit Check Study" had draft "<Draft1>"
	And I publish and push "CRF Version<RANDOMNUMBER>" to site "Edit Check Site"


Scenario: Verifies query firing between cross forms with require response and no require manual close.
Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
	
    And I create a subject "sub301"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot 1 of 51		
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 2 of 51	
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 3 of 51	
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save the form "Assessment Date Log2"
    And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 4 of 51	
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save the form "Assessment Date Log2"	
	And I verify new queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 5 of 51	
    When I run SQL Script "Query Logging Script"
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub301       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2			  |1                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub301       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 6 of 51
	
    And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I add a new log line enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |18          |	
	And I verify "Assessment Date 1" field displays query opened with require response on the second log line
    And I verify "Numeric Field 2" field displays query opened with require response on the second log line
	And I take a screenshot 7 of 51	
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields on the second log line
	And I save the form "Assessment Date Log2"
	And I take a screenshot 8 of 51	
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 9 of 51	
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save the form "Assessment Date Log2"	
	And I verify "Assessment Date 1" field query did fire with require response on the second log line
    And I verify "Numeric Field 2" field query did fire with require response on the second log line
	And I take a screenshot 10 of 51	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub301       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub301       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 11 of 51	

	
Scenario: Verifies query firing between cross folders with require response and no require manual close.
Cross Folders: Standard form to log form
Folder "Test A Single Edit" enter and save data on form "Informed Consent Date Form 1"
Folder "Test B Single Derivation" enter and save data on form "Assessment Date Log2"
			  
    And I create a subject "sub302"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |10 Jan 2000 |
	    |Informed Consent Date 2 |10 Feb 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |200         |
	And I take a screenshot 12 of 51		
	And I navigate to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Assessment Date 2 |11 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 13 of 51	
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 14 of 51	
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |	
	And I save the form "Assessment Date Log2"
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 15 of 51	
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |
	And I save the form "Assessment Date Log2"	
	And I verify new queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 16 of 51	
    When I run SQL Script "Query Logging Script" #Question: Should we see it in logs for Patch 11?
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub302       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |1                          |Assessment Date 1       |09 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub302       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |99                   |Test B Single Derivation |Assessment Date Log2             |1                          |Numeric Field 2         |99               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot 17 of 51
	
    And I navigate to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I add a new log line enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |12 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |	
	And I verify "Assessment Date 1" field displays query opened with require response on the second log line
    And I verify "Numeric Field 2" field displays query opened with require response on the second log line
	And I take a screenshot 18 of 51	
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields on the second log line
	And I save the form "Assessment Date Log2"
	And I take a screenshot 19 of 51	
    And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields on the second log line
	And I take a screenshot 20 of 51	
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |
	And I save the form "Assessment Date Log2"	
	And I verify "Assessment Date 1" field query did fire with require response on the second log line
    And I verify "Numeric Field 2" field query did fire with require response on the second log line
	And I take a screenshot 21 of 51	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub302       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 1    |08 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |2                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub302       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |98                   |Test B Single Derivation |Assessment Date Log2             |2                          |Numeric Field 2         |98               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot 22 of 51	


Scenario: Verifies query firing between cross forms in opposite direction with require response and no require manual close.
Cross Forms: log form to Standard form 
Folder "Test B Single Derivation" enter and save data on forms "Assessment Date Log2" and "Informed Consent Date Form 1"

#Have to check with team, as this scenario is not doing log form to std form verification
			  
    And I create a subject "sub303"
	And I navigate to folder "Test B Single Derivation"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |12 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |101         |
	And I verify "Assessment Date 2" field displays query opened with require response
	And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 23 of 51	
	And I answer the queries on "Assessment Date 2" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 24 of 51	
	And I change the data on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 2   |100         |
	And I save the form "Assessment Date Log2"
	And I verify the queries did not fire on "Assessment Date 2" and "Numeric Field 2" fields
	And I take a screenshot 25 of 51	
	And I change the data on log line 1 on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 2   |101         |
	And I save the form "Assessment Date Log2"	
    And I verify new queries did not fire on "Assessment Date 2" and "Numeric Field 2" fields
	And I take a screenshot 26 of 51	
    When I run SQL Script "Query Logging Script"
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub303       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 2    |11 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |1                          |Assessment Date 2 |11 Jan 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub303       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |101                  |Test B Single Derivation |Assessment Date Log2             |1                          |Numeric Field 2   |101              |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take a screenshot 27 of 51
	
	And I add a new log line to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |15 Feb 2000 |
	    |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 1   |1999        |
	    |Numeric Field 2   |2000        |	
	And I verify "Assessment Date 2" field displays query opened with require response on the second log line
	And I verify "Numeric Field 2" field displays query opened with require response on the second log line
	And I take a screenshot 28 of 51
	And I change the data on the second log line on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |15 Feb 2000 |
	    |Numeric Field 2   |1999        |
	And I answer the queries on "Assessment Date 2" and "Numeric Field 2" fields on the second log line
	And I save the form "Assessment Date Log2"
	And I take a screenshot 29 of 51	
	And I verify the queries did not fire on the second log line on "Assessment Date 2" and "Numeric Field 2" fields
	And I take a screenshot 30 of 51	
	And I change the data on the second log line on "Assessment Date 2" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 2   |2000        |
	And I save the form "Assessment Date Log2"	
	And I verify "Assessment Date 2" field query did fire with require response on the second log line
	And I verify "Numeric Field 2" field query did fire with require response on the second log line	
	And I take a screenshot 31 of 51	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub303       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 2    |14 Feb 2000          |Test B Single Derivation |Assessment Date Log2             |2                          |Assessment Date 2 |14 Feb 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub303       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |2000                 |Test B Single Derivation |Assessment Date Log2             |2                          |Numeric Field 2   |2000             |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take a screenshot 32 of 51	
    
	And I navigate to form "Informed Consent Date Form 1" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |12 Jan 2000 |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |101         |	
	And I verify "Informed Consent Date 2" field displays query opened with require response
	And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 33 of 51
	And I change the data on "Informed Consent Date 2" and "Numeric Field 2" fields, from the table below
	    |Field                   |Data        |
	    |Informed Consent Date 2 |13 Jan 2000 |
	    |Numeric Field 2         |100         |		
	And I answer the queries on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I save the form "Informed Consent Date Form 1"
	And I take a screenshot 34 of 51
	And I verify the queries did not fire on "Informed Consent Date 2" and "Numeric Field 2" fields 
	And I take a screenshot 35 of 51	
    And I change the data on "Informed Consent Date 2" and "Numeric Field 2" fields, from the table below
	    |Field                   |Data        |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 2         |101         |	
	And I save the form "Informed Consent Date Form 1"
	And I verify "Informed Consent Date 2" field query did fire with require response
	And I verify "Numeric Field 2" field query did fire with require response	
	And I take a screenshot 36 of 51	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName    |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                                      |MarkingGroupName |QueryMessage                  |EventTime  |
      |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub303       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Informed Consent Date 2 |11 Jan 2000          |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Informed Consent Date 2 |11 Jan 2000      |*Greater Than or Equal To Open Query Log same form |Marking Group 1  |Dates are not equal.          |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub303       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Numeric Field 2         |101                  |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Numeric Field 2         |101              |*Is Not Equal To Open Query Log Same form          |Marking Group 1  |Numeric fields are not equal. |{DateTime} |
	And I take a screenshot 37 of 51	

	
 Scenario: Verifies query firing between cross forms in opposite direction in different folder with require response and no require manual close.
Cross Forms: log form to log form 
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
			  
    And I create a subject "sub304"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I take a screenshot 38 of 51		
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	    |Numeric Field 1 |101         |
	    |Numeric Field 2 |66          |
	And I take a screenshot 39 of 51		
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I verify "Numeric Field 1" field displays query opened with require response
	And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 40 of 51	
	And I answer the queries on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 41 of 51	
	And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |11 Jan 2000 |
	    |Assessment Date 2 |09 Feb 2000 |
	    |Numeric Field 1   |102         |
	    |Numeric Field 2   |65          |	
	And I save the form "Assessment Date Log2"
	And I verify the queries did not fire on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 42 of 51	
	And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I save the form "Assessment Date Log2"	
	And I verify new queries did not fire on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 43 of 51	
    When I run SQL Script "Query Logging Script" #Q
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub304       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1|10 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub304       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 2|10 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub304       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |100                  |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub304       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |66                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2  |66               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot 44 of 51	
    
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I add a new log line as follows:
	    |Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I take a screenshot 45 of 51		
    And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I add a new log line as follows:
	    |Field           |Data        |
        |Date Field 1    |11 Feb 2000 |
	    |Date Field 2    |09 Mar 2000 |
	    |Numeric Field 1 |201         |
	    |Numeric Field 2 |77          |	
	And I take a screenshot 46 of 51		
    And	I navigate to form "Assessment Date Log2"
	And	I select second log line
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I verify "Numeric Field 1" field displays query opened with require response
	And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 47 of 51
    And I change the data on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |11 Feb 2000 |
	    |Assessment Date 2 |09 Mar 2000 |
	    |Numeric Field 1   |202         |
	    |Numeric Field 2   |76          |		
	And I answer the queries on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields on the second log line
	And I save the form "Assessment Date Log2"
	And I take a screenshot 48 of 51	
	And I verify the queries did not fire on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 49 of 51	
	And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields, from the table below
		|Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I save the form "Assessment Date Log2"	
	And I verify queries did fire on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 50 of 51	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub304       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1|10 Feb 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub304       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 2    |10 Mar 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 2|10 Mar 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub304       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 1      |200                  |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 1  |200              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub304       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |77                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2  |77               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot 51 of 51	

	