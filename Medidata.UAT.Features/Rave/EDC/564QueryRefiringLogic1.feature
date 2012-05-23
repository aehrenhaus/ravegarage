Feature: Query Issue: Edit Checks with require response and require manual close
Open, answer and close a query, change the data and verify that the query did re-fire and verify no log

Background:
	And Rave has user-study-site assignments from the table below:
		|User		|Study		       |Role |Site		        |Site Number |
		|editcheck  |Edit Check Study 1|cdm1 |Edit Check Site 1 |10001       |
    And  role "cdm1" has "Query" actions
	And Rave  "Edit Check Study" had draft "<Draft1>"
	And I publish and push "CRF Version<RANDOMNUMBER>" to site "Edit Check Site"

	
Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
	
    And I create a subject "sub101"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 2 of 155
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I close the queries on "Assessment Date 1" field and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 3 of 155
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save the form "Assessment Date Log2"
    And I verify the queries did not fire on "Assessment Date 1" field and "Numeric Field 2" fields
	And I take a screenshot 4 of 155
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save the form "Assessment Date Log2"	
	And I verify new queries did not fire on "Assessment Date 1" field and "Numeric Field 2" fields
	And I take a screenshot 5 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub101       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2			  |1                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub101       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 6 of 155
   
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I add a new log line, enter and save the data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |18          |
	And I verify "Assessment Date 1" field displays query opened with require response on the second log line
    And I verify "Numeric Field 2" field displays query opened with require response on the second log line
	And I take a screenshot 7 of 155
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields on the second log line
	And I save the form "Assessment Date Log2"
	And I close the queries on "Assessment Date 1" and "Numeric Field 2" fields on the second log line
	And I save the form "Assessment Date Log2"
	And I take a screenshot 8 of 155
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 9 of 155
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |
	And I save the form "Assessment Date Log2" 
	And I verify new queries did fire on "Assessment Date 1" and "Numeric Field 2" fields	
	And I take a screenshot 10 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub101       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub101       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 11 of 155	

	
Scenario: Verifies query firing between cross folders with require response and require manual close.
Cross Folders: Standard form to log form
Folder "Test A Single Edit" enter and save data on form "Informed Consent Date Form 1"
Folder "Test B Single Derivation" enter and save data on form "Assessment Date Log2"
			  
    And I create a subject "sub102"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |10 Jan 2000 |
	    |Informed Consent Date 2 |10 Feb 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |200         |
	And I take a screenshot 12 of 155	
	And I navigate to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Assessment Date 2 |11 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 13 of 155
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I close the queries on "Assessment Date 1" field and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 14 of 155
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |	
	And I save the form "Assessment Date Log2"
	And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 15 of 155
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |99          |
	And I save the form "Assessment Date Log2"	
	And I verify new queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 16 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub102       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |1                          |Assessment Date 1       |09 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub102       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |99                   |Test B Single Derivation |Assessment Date Log2             |1                          |Numeric Field 2         |99               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot 17 of 155
    
	And I navigate to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I add a new log line, enter and save the data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |12 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |	
	And I verify "Assessment Date 1" field displays query opened with require response on the second log line
    And I verify "Numeric Field 2" field displays query opened with require response on the second log line
	And I take a screenshot 18 of 155
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields on the second log line
	And I save the form "Assessment Date Log2"
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
	    |Numeric Field 2   |200         |	
	And I close the queries on "Assessment Date 1" and "Numeric Field 2" fields on the second log line
	And I save the form "Assessment Date Log2"
	And I take a screenshot 19 of 155
    And I verify the queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 20 of 155
	And I change the data on "Assessment Date 1", "Numeric Field 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
		|Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |
	And I save the form "Assessment Date Log2"
	And I verify new queries did fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 21 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub102       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 1    |08 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |2                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub102       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |98                   |Test B Single Derivation |Assessment Date Log2             |2                          |Numeric Field 2         |98               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot 22 of 155

	
Scenario: Verifies query firing between cross forms with require response and require manual close. Cross Forms: log form to Standard form 
Folder "Test B Single Derivation" enter and save data on forms "Assessment Date Log2" and "Informed Consent Date Form 1"
			  
    And I create a subject "sub103"
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
	And I take a screenshot 23 of 155
	And I answer the queries on "Assessment Date 2" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I close the queries on "Assessment Date 2" field and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 24 of 155
	And I change the data on "Assessment Date 2" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 2   |100         |
	And I save the form "Assessment Date Log2"
	And I verify the queries did not fire on "Assessment Date 2" field and "Numeric Field 2" fields
	And I take a screenshot 25 of 155
	And I change the data on log line 1 on "Assessment Date 2" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 2   |101         |
	And I save the form "Assessment Date Log2"	
    And I verify new queries did not fire on "Assessment Date 2" field and "Numeric Field 2" fields
	And I take a screenshot 26 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub103       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 2    |11 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |1                          |Assessment Date 2 |11 Jan 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub103       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |101                  |Test B Single Derivation |Assessment Date Log2             |1                          |Numeric Field 2   |101              |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take a screenshot 27 of 155
	
	And I add a new log line to form "Assessment Date Log2" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |15 Feb 2000 |
	    |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 1   |1999        |
	    |Numeric Field 2   |2000        |	
	And I verify "Assessment Date 2" field displays query opened with require response
	And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 28 of 155
	And I answer the queries on "Assessment Date 2" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I change the data on "Assessment Date 2" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 2 |15 Feb 2000 |
	    |Numeric Field 2   |1999        |
	And I close the queries on "Assessment Date 2" field and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 29 of 155
	And I verify the queries did not fire on "Assessment Date 2" field and "Numeric Field 2" fields
	And I take a screenshot 30 of 155
	And I change the data on "Assessment Date 2" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 2 |14 Feb 2000 |
	    |Numeric Field 2   |2000        |
	And I save the form "Assessment Date Log2"	
	And I verify new queries did fire on "Assessment Date 2" field and "Numeric Field 2" fields
	And I take a screenshot 31 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName               |MarkingGroupName |QueryMessage                                       |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub103       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 2    |14 Feb 2000          |Test B Single Derivation |Assessment Date Log2             |2                          |Assessment Date 2 |14 Feb 2000      |*Greater Than Log same form |Marking Group 1  |Date Field 1 can not be greater than Date Field 2. |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub103       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |2000                 |Test B Single Derivation |Assessment Date Log2             |2                          |Numeric Field 2   |2000             |*Is Less Than Log same form |Marking Group 1  |Date is Less Than Date on first Number field.      |{DateTime} |
	And I take a screenshot 32 of 155
   
	And I navigate to form "Informed Consent Date Form 1" within folder "Test B Single Derivation"
    And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |12 Jan 2000 |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |101         |	
	And I verify "Informed Consent Date 2" field displays query opened with require response
	And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 33 of 155
	And I answer the queries on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I save the form "Informed Consent Date Form 1"
	And I change the data on "Informed Consent Date 2" and "Numeric Field 2" fields from the table below:
	    |Field                   |Data        |
	    |Informed Consent Date 2 |13 Jan 2000 |
	    |Numeric Field 2         |100         |	
	And I close the queries on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I save the form "Informed Consent Date Form 1"
	And I take a screenshot 34 of 155
	And I verify the queries did not fire on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I take a screenshot 35 of 155
    And I change the data on "Informed Consent Date 2" and "Numeric Field 2" fields from the table below:
	    |Field                   |Data        |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 2         |101         |
	And I save the form "Informed Consent Date Form 1"
	And I verify new queries did fire on "Informed Consent Date 2" and "Numeric Field 2" fields
	And I take a screenshot 36 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName    |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                                      |MarkingGroupName |QueryMessage                  |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub103       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Informed Consent Date 2 |11 Jan 2000          |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Informed Consent Date 2 |11 Jan 2000      |*Greater Than or Equal To Open Query Log same form |Marking Group 1  |Dates are not equal.          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub103       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Numeric Field 2         |101                  |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Numeric Field 2         |101              |*Is Not Equal To Open Query Log Same form          |Marking Group 1  |Numeric fields are not equal. |{DateTime} |
	And I take a screenshot 37 of 155
	

Scenario: Verifies query firing between cross forms with require response and require manual close.Cross Forms: log form to log form 
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
			  
    And I create a subject "sub104"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I take a screenshot 38 of 155
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	    |Numeric Field 1 |101         |
	    |Numeric Field 2 |66          |
	And I take a screenshot 39 of 155	
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I verify "Numeric Field 1" field displays query opened with require response
	And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 40 of 155
	And I answer the queries on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I close the queries on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 41 of 155
	And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields from the table below:
	    |Field             |Data        |
        |Assessment Date 1 |11 Jan 2000 |
	    |Assessment Date 2 |09 Feb 2000 |
	    |Numeric Field 1   |102         |
	    |Numeric Field 2   |65          |	
	And I save the form "Assessment Date Log2"
	And I verify the queries did not fire on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 42 of 155
	And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I save the form "Assessment Date Log2"	
	And I verify new queries did not fire on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 43 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub104       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1|10 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub104       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 2|10 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub104       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |100                  |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub104       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |66                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2  |66               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot 44 of 155
    
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I add a new log line, enter and save the data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I take a screenshot 45 of 155	
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I add a new log line, enter and save the data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Feb 2000 |
	    |Date Field 2    |09 Mar 2000 |
	    |Numeric Field 1 |201         |
	    |Numeric Field 2 |77          |	
	And I take a screenshot 46 of 155	
    And	I navigate to form "Assessment Date Log2"
	And	I select second log line
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I verify "Numeric Field 1" field displays query opened with require response
	And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 47 of 155
	And I answer the queries on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields on the second log line
	And I save the form "Assessment Date Log2"
    And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields from the table below:
	    |Field             |Data        |
        |Assessment Date 1 |11 Feb 2000 |
	    |Assessment Date 2 |09 Mar 2000 |
	    |Numeric Field 1   |202         |
	    |Numeric Field 2   |76          |		
	And I close the queries on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields on the second log line
	And I save the form "Assessment Date Log2"
	And I take a screenshot 48 of 155
	And I verify the queries did not fire on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 49 of 155
	And I change the data on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I save the form "Assessment Date Log2"	
	And I verify new queries did fire on the second log line on "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" fields
	And I take a screenshot 50 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub104       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1|10 Feb 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub104       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 2    |10 Mar 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 2|10 Mar 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub104       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 1      |200                  |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 1  |200              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub104       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |77                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2  |77               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot 51 of 155

	

Scenario: Verifies query firing between cross forms with require response and require manual close. 5th
Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
Queries fired, Answer and  Manually close queries in log fields, 
Modify Standard form to different bad data, do not touch log form - query and no logs in the Database
	
    And I create a subject "sub105"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot 52 of 155	
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 53 of 155
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I close the queries on "Assessment Date 1" field and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 54 of 155
	And I select form "Informed Consent Date Form 1"
	And I change the data on "Informed Consent Date 1" and "Numeric Field 2" fields from the table below:
		|Field                    |Data        |
        |Informed Consent Date 1  |20 Jan 2000 |
	    |Numeric Field 2          |21          |
	And I save the form "Informed Consent Date Form 1"
    And I navigate to form "Assessment Date Log2"	
	And I verify new queries did fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 55 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub105       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Informed Consent Date Form 1     |0                          |Informed Consent Date 1 |20 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub105       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Informed Consent Date Form 1     |0                          |Numeric Field 2         |21               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 56 of 155

@release_564_patch9
@PB_2.7.2.1
@Draft
Scenario: Verifies query firing between cross forms with require response and require manual close.Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
Queries fired, Cancel queries in log fields, Modify Standard form to different bad data, do not touch log form - query and no logs in the Database
	
    And I create a subject "sub106"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot 57 of 155	
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 58 of 155
	And I cancel the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 59 of 155
	And I select form "Informed Consent Date Form 1"
	And I change the data on "Informed Consent Date 1" and "Numeric Field 2" fields from the table below:
		|Field                    |Data        |
        |Informed Consent Date 1  |20 Jan 2000 |
	    |Numeric Field 2          |21          |
	And I save the form "Informed Consent Date Form 1"
    And I navigate to form "Assessment Date Log2"	
	And I verify new queries did fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 60 of 155
	When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub106       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Informed Consent Date Form 1     |0                          |Informed Consent Date 1 |20 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub106       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Informed Consent Date Form 1     |0                          |Numeric Field 2         |21               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 61 of 155

	
Scenario: Verifies query firing between cross forms with require response and require manual close. Cross Forms: log form to log form. Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3". Queries fired, Answer and  Manually close queries in log fields (second log form), 
Modify log form (first log form) to different bad data, do not touch second log form - query and no logs in the Database
			  
    And I create a subject "sub107"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	And I take a screenshot 62 of 155
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	    |Numeric Field 1 |101         |
	And I take a screenshot 63 of 155	
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I verify "Numeric Field 1" field displays query opened with require response
	And I take a screenshot 64 of 155
	And I answer the queries on "Assessment Date 1", "Assessment Date 2" and "Numeric Field 1" fields
	And I save the form "Assessment Date Log2"
	And I close the queries on "Assessment Date 1", "Assessment Date 2" and "Numeric Field 1" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 65 of 155
	And I select the form "Assessment Date Log3"
	And I change the data on "Date Field 1", "Date Field 2" and "Numeric Field 1" fields from the table below:
		|Field           |Data        |
        |Date Field 1    |12 Jan 2000 |
	    |Date Field 2    |08 Feb 2000 |
	    |Numeric Field 1 |100         |
	And I save the form "Assessment Date Log3"	
	And I navigate to form "Assessment Date Log2"
	And I verify new queries did fire on "Assessment Date 1", "Assessment Date 2" and "Numeric Field 1" fields
	And I take a screenshot 66 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub107       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 1     |12 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub107       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 2     |08 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub107       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |100                  |Test A Single Edit       |Assessment Date Log3             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	And I take a screenshot 67 of 155

	
Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: log form to log form 
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
Queries fired, cancel queries in log fields (second log form), 
Modify log form (first log form) to different bad data, do not touch second log form - query and no logs in the Database
			  
    And I create a subject "sub108"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	And I take a screenshot 68 of 155
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	    |Numeric Field 1 |101         |
	And I take a screenshot 69 of 155	
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I verify "Numeric Field 1" field displays query opened with require response
	And I take a screenshot 70 of 155
	And I cancel the queries on "Assessment Date 1", "Assessment Date 2" and "Numeric Field 1" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 71 of 155
	And I select the form "Assessment Date Log3"
	And I change the data on "Date Field 1", "Date Field 2" and "Numeric Field 1" fields from the table below:
		|Field           |Data        |
        |Date Field 1    |12 Jan 2000 |
	    |Date Field 2    |08 Feb 2000 |
	    |Numeric Field 1 |100         |
	And I save the form "Assessment Date Log3"
	And I navigate to form "Assessment Date Log2"
	And I verify new queries did fire on "Assessment Date 1", "Assessment Date 2" and "Numeric Field 1" fields
	And I take a screenshot 72 of 155
	When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub108       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 1     |12 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub108       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 2     |08 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub108       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |100                  |Test A Single Edit       |Assessment Date Log3             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	And I take a screenshot 73 of 155

	
 Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
Queries fired, Answer and  Manually close queries in log fields, 
Modify log fields to different good data, do not touch standard form - no query and no log in the Database
	
    And I create a subject "sub109"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot 74 of 155	
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 75 of 155
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I close the queries on "Assessment Date 1" field and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 76 of 155
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save the form "Assessment Date Log2"
    And I verify the new queries did not fire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 77 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName   |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub109       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1  |09 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub109       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |19                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2    |19               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 78 of 155

	
Scenario:  Verifies query firing between cross forms with require response and require manual close.  Cross Forms: Standard form to log form. Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2". Queries fired, Answer and  Manually close queries in log fields, Modify log fields to different bad data, do not touch standard form - query fires and no log in the Database
	
    And I create a subject "sub110"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot 79 of 155	
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 80 of 155
	And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I close the queries on "Assessment Date 1" field and "Numeric Field 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 81 of 155
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |21          |	
	And I save the form "Assessment Date Log2"
    And I verify the queries refired on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 82 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName   |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub110       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1  |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub110       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |21                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2    |21               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 83 of 155

	
Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
Queries fired on log form, Modify standard fields to different good data, 
new value results in system close of edit check on log form - queries closed by system and no log in the Database
	
    And I create a subject "sub111"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot 84 of 155	
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 85 of 155
	And I select form "Informed Consent Date Form 1"
	And I change the data on "Informed Consent Date 1" and "Numeric Field 2" fields from the table below:
		|Field                   |Data        |
        |Informed Consent Date 1 |08 Jan 2000 |
	    |Numeric Field 2         |20          |	
	And I save the form "Informed Consent Date Form 1"
	And I navigate to form "Assessment Date Log2"
    And I verify the queries closed automatically on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 86 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub111       |Test A Single Edit      |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Informed Consent Date Form 1     |0                          |Informed Consent Date 1 |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub111       |Test A Single Edit      |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Informed Consent Date Form 1     |0                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 87 of 155


Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
Queries fired on log form, Modify log fields to different good data, 
new value results in system close of edit check on log form - queries closed by system and no log in the Database
	
    And I create a subject "sub112"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot 88 of 155	
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 89 of 155
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save the form "Assessment Date Log2"
    And I verify the queries closed automatically on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 90 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName   |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub112       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1  |09 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub112       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |19                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2    |19               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 91 of 155	

	
Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
Queries fired on log form, Modify standard fields to different good data, 
new value results in system close of edit check on log form and update \
new value on standard fields in violation of edit check on log form- queries refires on log form and no log in the Database
	
    And I create a subject "sub113"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot 92 of 155	
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 93 of 155
	And I select form "Informed Consent Date Form 1"
	And I change the data on "Informed Consent Date 1" and "Numeric Field 2" fields from the table below:
		|Field                   |Data        |
        |Informed Consent Date 1 |08 Jan 2000 |
	    |Numeric Field 2         |20          |	
	And I save the form "Informed Consent Date Form 1"
	And I navigate to form "Assessment Date Log2"
    And I verify the queries closed automatically
	And I take a screenshot 94 of 155
	And I select form "Informed Consent Date Form 1"
	And I change the data on "Informed Consent Date 1" and "Numeric Field 2" fields from the table below:
		|Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Numeric Field 2         |19          |	
	And I save the form "Informed Consent Date Form 1"
	And I navigate to form "Assessment Date Log2"
    And I verify the queries refire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 95 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName    |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub113       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1       |08 Jan 2000          |Test A Single Edit       |Informed Consent Date Form 1     |0                          |Informed Consent Date 1 |09 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub113       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2         |20                   |Test A Single Edit       |Informed Consent Date Form 1     |0                          |Numeric Field 2         |19               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 96 of 155

	
Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
Queries fired on log form, Modify log fields to different good data, 
new value results in system close of edit check on log form and update new value on standard fields in violation of edit check on log form- queries refires on log form and no log in the Database
	
    And I create a subject "sub114"
	And I navigate to folder "Test A Single Edit"
	And I select form "Informed Consent Date Form 1"
	And I enter and save the following data, from the table below
	    |Field                   |Data        |
        |Informed Consent Date 1 |09 Jan 2000 |
	    |Informed Consent Date 2 |10 Jan 2000 |
	    |Numeric Field 1         |10          |
	    |Numeric Field 2         |19          |
	And I take a screenshot 97 of 155	
	And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |20          |	
	And I verify "Assessment Date 1" field displays query opened with require response
    And I verify "Numeric Field 2" field displays query opened with require response
	And I take a screenshot 98 of 155
	And I change the data on "Assessment Date 1" and "Numeric Field 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save the form "Assessment Date Log2"
    And I verify the queries closed automatically
	And I take a screenshot 99 of 155
	And I select form "Informed Consent Date Form 1"
	And I change the data on "Informed Consent Date 1" and "Numeric Field 2" fields from the table below:
		|Field                   |Data        |
        |Informed Consent Date 1 |10 Jan 2000 |
	    |Numeric Field 2         |20          |	
	And I save the form "Informed Consent Date Form 1"
	And I navigate to form "Assessment Date Log2"
    And I verify the queries refire on "Assessment Date 1" and "Numeric Field 2" fields
	And I take a screenshot 100 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub114       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test A Single Edit       |Informed Consent Date Form 1     |0                          |Informed Consent Date 1 |10 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub114       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |19                   |Test A Single Edit       |Informed Consent Date Form 1     |0                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot 101 of 155

	
Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: log form to log form
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
Queries fired, Answer and  Manually close queries on "Assessment Date Log2" form, 
Modify log fields to different good data on "Assessment Date Log3" form, do not touch "Assessment Date Log2" form - no queries on "Assessment Date Log2" and no log in the Database
	
    And I create a subject "sub115"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	And I take a screenshot 102 of 155
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	And I take a screenshot 103 of 155	
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I take a screenshot 104 of 155
	And I answer the queries on "Assessment Date 1" and "Assessment Date 2" fields
	And I save the form "Assessment Date Log2"
	And I close the queries on "Assessment Date 1" and "Assessment Date 2" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 105 of 155
	And I navigate to form "Assessment Date Log3"
	And I change the data on "Date Field 1" and "Date Field 2" fields
	    |Field           |Data        |
        |Date Field 1    |10 Jan 2000 |
	    |Date Field 2    |10 Feb 2000 |
	And I save the form "Assessment Date Log3"
	And I navigate to form "Assessment Date Log2"
    And I verify the new queries did not fire on "Assessment Date 1" and "Assessment Date 2" fields
	And I take a screenshot 106 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                              |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub115       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 1     |10 Jan 2000      |*Is Less Than To Open Query Log Cross Form |Marking Group 1  |Date can not be less than.                    |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub115       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 2     |10 Feb 2000      |*Is Less Than Open Query Log Cross Form    |Marking Group 1  |Date is Less Than Date on the first log form. |{DateTime} |
	And I take a screenshot 107 of 155
	
	
16th Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: log form to log form
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
Queries fired, Answer and  Manually close queries on "Assessment Date Log2" form, 
Modify log fields to different bad data on "Assessment Date Log3" form, do not touch "Assessment Date Log2" form - queries fire on "Assessment Date Log2" and no log in the Database
	
    And I create a subject "sub116"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	And I take a screenshot 108 of 155
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	    |Numeric Field 1 |101         |
	And I take a screenshot 109 of 155	
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I verify "Numeric Field 1" field displays query opened with require response
	And I take a screenshot 110 of 155
	And I answer the queries on "Assessment Date 1", "Assessment Date 2" and "Numeric Field 1" fields
	And I save the form "Assessment Date Log2"
	And I close the queries on "Assessment Date 1", "Assessment Date 2" and "Numeric Field 1" fields
	And I save the form "Assessment Date Log2"
	And I take a screenshot 111 of 155
	And I change the data on "Assessment Date 1", "Assessment Date 2" and "Numeric Field 1" fields
	    |Field              |Data        |
        |Assessment Date 1  |09 Jan 2000 |
	    |Assessment Date 2  |11 Feb 2000 |
	    |Numeric Field 1    |99         |
	And I save the form "Assessment Date Log2"
    And I verify the queries refire on "Assessment Date 1", "Assessment Date 2" and "Numeric Field 1" fields
	And I take a screenshot 112 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName  |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                    |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub116       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1 |09 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub116       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |11 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 2 |11 Feb 2000      |*Is Not Equal to Open Query Log Cross Form* |Site             |Date is Less Than Date on the first log form.                   |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub116       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |99                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 1   |99               |*Is Not Equal to Open Query Log Cross Form* |Site             |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
	  And I take a screenshot 113 of 155

	  
17th Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: log form to log form
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
Queries fired on second log form, Modify log fields on first log form to different good data, 
new value results in system close of edit check on second log form - queries closed by system on second log form and no log in the Database
	
    And I create a subject "sub117"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	And I take a screenshot 114 of 155
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	And I take a screenshot 115 of 155	
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I take a screenshot 116 of 155
	And I select form "Assessment Date Log3"
	And I change the data on "Date Field 1" and "Date Field 2" fields from the table below:
		|Field        |Data        |
        |Date Field 1 |10 Jan 2000 |
	    |Date Field 2 |10 Feb 2000 |	
	And I save the form "Assessment Date Log3"
	And I navigate to form "Assessment Date Log2"
    And I verify the queries closed automatically on "Assessment Date 1" and "Assessment Date 2" fields
	And I take a screenshot 117 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub117       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 1     |10 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Date can not be less than.                    |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub117       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 2     |10 Feb 2000      |*Is Not Equal to Open Query Log Cross Form* |Site             |Date is Less Than Date on the first log form. |{DateTime} |
	And I take a screenshot 118 of 155

	
18th Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: log form to log form
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
Queries fired on second log form, Modify log fields on same second log form to different good data, 
new value results in system close of edit check on second log form - queries closed by system on second log form and no log in the Database
	
    And I create a subject "sub118"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	And I take a screenshot 119 of 155
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	And I take a screenshot 120 of 155	
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I take a screenshot 121 of 155
	And I change the data on "Assessment Date 1" and "Assessment Date 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |11 Jan 2000 |
	    |Assessment Date 2 |09 Feb 2000 |	
	And I save the form "Assessment Date Log2"
    And I verify the queries closed automatically on "Assessment Date 1" and "Assessment Date 2" fields
	And I take a screenshot 122 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub118       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |11 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1       |11 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Date can not be less than.                    |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub118       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |09 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 2       |09 Feb 2000      |*Is Not Equal to Open Query Log Cross Form* |Site             |Date is Less Than Date on the first log form. |{DateTime} |
	And I take a screenshot 123 of 155
	
	
19th Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: log form to log form
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
Queries fired on second log form, Modify log fields on first log form to different good data, 
new value results in system close of edit check on second log form. Navigate to first log form and enter new value in violation of edit check - queries refired on second log form and no log in the Database
	
    And I create a subject "sub119"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	And I take a screenshot 124 of 155
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	And I take a screenshot 125 of 155	
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I take a screenshot 126 of 155
	And I select form "Assessment Date Log3"
	And I change the data on "Date Field 1" and "Date Field 2" fields from the table below:
		|Field        |Data        |
        |Date Field 1 |10 Jan 2000 |
	    |Date Field 2 |10 Feb 2000 |	
	And I save the form "Assessment Date Log3"
	And I navigate to form "Assessment Date Log2"
    And I verify the queries closed automatically
	And I take a screenshot 127 of 155
	And I select form "Assessment Date Log3"
	And I change the data on "Date Field 1" and "Date Field 2" fields from the table below:
		|Field        |Data        |
        |Date Field 1 |11 Jan 2000 |
	    |Date Field 2 |09 Feb 2000 |	
	And I save the form "Assessment Date Log3"
	And I navigate to form "Assessment Date Log2"
    And I verify the queries refired on "Assessment Date 1" and "Assessment Date 2" fields
	And I take a screenshot 128 of 155	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub119       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 1     |11 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Date can not be less than.                    |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub119       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 2     |09 Feb 2000      |*Is Not Equal to Open Query Log Cross Form* |Site             |Date is Less Than Date on the first log form. |{DateTime} |
	And I take a screenshot 129 of 155

	
20th Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: log form to log form
Folder "Test A Single Edit" enter and save data on forms "Assessment Date Log2" and "Assessment Date Log3"
Queries fired on second log form, Modify log fields on second log form to different good data, 
new value results in system close of edit check on second log form. Navigate to first log form and enter new value in violation of edit check - queries refired on second log form and no log in the Database
	
    And I create a subject "sub120"
	And I navigate to folder "Test A Single Edit"
	And I select form "Assessment Date Log2"
	And I enter and save the following data, from the table below
	    |Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	And I take a screenshot 130 of 155
	And I navigate to form "Assessment Date Log3" within folder "Test A Single Edit"
    And I enter and save the following data, from the table below
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	And I take a screenshot 131 of 155	
    And I navigate to form "Assessment Date Log2"		
	And I verify "Assessment Date 1" field displays query opened with require response
	And I verify "Assessment Date 2" field displays query opened with require response
	And I take a screenshot 132 of 155
	And I change the data on "Assessment Date 1" and "Assessment Date 2" fields from the table below:
		|Field             |Data        |
        |Assessment Date 1 |11 Jan 2000 |
	    |Assessment Date 2 |09 Feb 2000 |	
	And I save the form "Assessment Date Log2"
    And I verify the queries closed automatically on "Assessment Date 1" and "Assessment Date 2" fields
	And I take a screenshot 133 of 155
	And I select form "Assessment Date Log3"
	And I change the data on "Date Field 1" and "Date Field 2" fields from the table below:
		|Field        |Data        |
        |Date Field 1 |12 Jan 2000 |
	    |Date Field 2 |08 Feb 2000 |	
	And I save the form "Assessment Date Log3"
	And I navigate to form "Assessment Date Log2"
    And I verify the queries refired on "Assessment Date 1" and "Assessment Date 2" fields
	And I take a screenshot 134 of 155	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                  |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub120       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 1     |12 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Date can not be less than.                    |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub120       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log3             |1                          |Date Field 2     |08 Feb 2000      |*Is Not Equal to Open Query Log Cross Form* |Site             |Date is Less Than Date on the first log form. |{DateTime} |
	And I take a screenshot 135 of 155

	
21st Scenario: Verifies query firing on Mixed Form with require response and require manual close.
Queries fired, Answer and  Manually close query on log field, Modify Standard field to different bad data, 
do not touch log field - query and no logs in the Database

    And I create a subject "sub121"
	And I select form "Mixed Form"
	And I enter and save the following data, from the table below
	    |Field       |Data |
        |Standard 1  |5    |
	    |Log Field 1 |4    |
	    |Log Field 2 |3    |
	And I take a screenshot 136 of 155		
	And I verify "Log Field 1" field displays query opened with require response
	And I take a screenshot 137 of 155
	And I answer the query on "Log Field 1" field
	And I save the form "Mixed Form"
	And I close the query on "Log Field 1" field
	And I save the form "Mixed Form"
	And I take a screenshot 138 of 155
	And I change the data on "Standard 1" field from the table below:
		|Field       |Data |
        |Standard 1  |6    |
	And I save the form "Mixed Form"
	And I verify new query did fire on "Log Field 1" field
	And I take a screenshot 139 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber |SiteName          |Environment |SubjectName |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName    |MarkingGroupName |QueryMessage                |EventTime  |
      |Edit Check Study 1 |10001      |Edit Check Site 1 |PROD        |sub121      |NULL                    |Mixed Form                      |1                         |Log Field 1          |4                    |NULL                     |Mixed Form                       |0                          |Standard 1       |6                |Mixed Form Query |Site             |Query Opened on Log Field 1 |{DateTime} |
	And I take a screenshot 140 of 155

	
22nd Scenario: Verifies query firing on Mixed Form with require response and require manual close.
Queries fired, cancel query on log field, 
Modify Standard field to different bad data, do not touch log field - query re-fires and no logs in the Database
Modify log field to different bad data, do not touch standard field - query re-fires and no logs in the Database

    And I create a subject "sub122"
	And I select form "Mixed Form"
	And I enter and save the following data, from the table below
	    |Field       |Data |
        |Standard 1  |6    |
	    |Log Field 1 |5    |
	    |Log Field 2 |2    |
	And I take a screenshot 141 of 155		
	And I verify "Log Field 1" field displays query opened with require response
	And I take a screenshot 142 of 155
	And I cancel the query on "Log Field 1" field
	And I save the form "Mixed Form"
	And I take a screenshot 143 of 155
	And I change the data on "Standard 1" field from the table below:
		|Field       |Data |
        |Standard 1  |7    |
	And I save the form "Mixed Form"
	And I verify new query did fire on "Log Field 1" field
	And I take a screenshot 144 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName    |MarkingGroupName |QueryMessage                |EventTime  |
      |Edit Check Study 1 |10001      |Edit Check Site 1 |PROD        |sub122       |NULL                    |Mixed Form                      |1                         |Log Field 1          |5                    |NULL                     |Mixed Form                       |0                          |Standard 1       |7                |Mixed Form Query |Site             |Query Opened on Log Field 1 |{DateTime} |
	And I take a screenshot 145 of 155
	
	And I navigate to form "Mixed Form"
    And I add a new log line, enter and save the data, from the table below	    
		|Field       |Data |
	    |Log Field 1 |4    |
	    |Log Field 2 |2    |
	And I take a screenshot 146 of 155		
	And I verify "Log Field 1" field displays query opened with require response
	And I take a screenshot 147 of 155
	And I change the data on "Log Field 1" field from the table below:
		|Field       |Data |
        |Log Field 1 |8    |
	And I cancel the query on "Log Field 1" field
	And I save the form "Mixed Form"
	And I take a screenshot 148 of 155
	And I change the data on "Log Field 1" field from the table below:
		|Field       |Data |
        |Log Field 1 |4    |
	And I save the form "Mixed Form"
	And I verify new query did fire on "Log Field 1" field
	And I take a screenshot 149 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName    |MarkingGroupName |QueryMessage                |EventTime  |
      |Edit Check Study 1 |10001      |Edit Check Site 1 |PROD        |sub122       |NULL                    |Mixed Form                      |2                         |Log Field 1          |4                    |NULL                     |Mixed Form                       |0                          |Standard 1       |7                |Mixed Form Query |Site             |Query Opened on Log Field 1 |{DateTime} |
	And I take a screenshot 150 of 155	

	And I navigate to form "Mixed Form"
    And I add a new log line, enter and save the data, from the table below	    
		|Field       |Data |
	    |Log Field 1 |4    |
	    |Log Field 2 |2    |
	And I take a screenshot 151 of 155		
	And I verify "Log Field 1" field displays query opened with require response
	And I take a screenshot 152 of 155
	And I change the data on "Standard 1" field from the table below:
		|Field       |Data |
        |Log Field 1 |8    |
	And I cancel the query on "Log Field 1" field
	And I save the form "Mixed Form"
	And I take a screenshot 153 of 155
	And I change the data on "Standard 1" field from the table below:
		|Field       |Data |
        |Standard 1	 |10   |
	And I save the form "Mixed Form"
	And I verify new query did fire on "Log Field 1" field
	And I take a screenshot 154 of 155
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
      |ProjectName        |SiteNumber |SiteName          |Environment |SubjectName  |CheckActionInstanceName |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName    |MarkingGroupName |QueryMessage                |EventTime  |
      |Edit Check Study 1 |10001      |Edit Check Site 1 |PROD        |sub122       |NULL                    |Mixed Form                      |3                         |Log Field 1          |10                    |NULL                     |Mixed Form                       |0                          |Standard 1       |8                |Mixed Form Query |Site             |Query Opened on Log Field 1 |{DateTime} |
	And I take a screenshot 155 of 155	
	
