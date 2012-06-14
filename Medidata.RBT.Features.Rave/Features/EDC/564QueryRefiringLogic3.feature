Feature: 3 
	As a Rave user
	I want to change data
	So I can see refired queries

# Query Issue: Edit Checks with require response and no require manual close
# Open a query and answer a query, change the correct data closes the query automatically and change it back to previous data query did refires and verify there is no log
# Verifies query firing between cross forms with require response and no require manual close.

# Project to be uploaded in excel spreadsheet 'Edit Check Study 3'

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Study assignments exist
		|User		|Study		       	|Role |Site		        	|Site Number|
		|editcheck  |Edit Check Study 3	|CDM1 |Edit Check Site 3	|30001      |
    And Role "cdm1" has Action "Query"
	And Study "Edit Check Study 3" has Draft "Draft 1" includes Edit Checks from the table below
		|Edit Check												|Folder						|Form							|Field						|Query Message		|
		|*Greater Than Log same form							|Test B Single Derivation	|Assessment Date Log2			|Assessment Date 2			|Date Field 1 can not be greater than Date Field 2.|
		|*Greater Than Open Query Cross Folder					|Test B Single Derivation	|Assessment Date Log2			|Assessment Date 1 			|Date 1 can not be greater than.|
		|*Greater Than Open Query Log Cross Form 				|Test A Single Edit			|Assessment Date Log2			|Assessment Date 1			|Informed Consent Date 1 is greater. Please revise.|
		|*Is Greater Than or Equal To Open Query Log Cross Form |Test A Single Edit			|Assessment Date Log2			|Numeric Field 1			|Numeric Field is greater than or Equal to Numeric Field on Log.|
		|*Is Less Than Log same form							|Test B Single Derivation	|Assessment Date Log2			|Numeric Field 2			|Date is Less Than Date on first Number field.|
		|*Is Less Than Open Query Log Cross Form 				|Test A Single Edit			|Assessment Date Log2			|Assessment Date 2			|Date is Less Than Date on the first log form.|
		|*Is Less Than To Open Query Log Cross Form 			|Test A Single Edit			|Assessment Date Log2			|Assessment Date 1			|Date can not be less than.|
		|*Is Not Equal to Open Query Cross Folder 				|Test B Single Derivation	|Assessment Date Log2			|Numeric Field 2			|Numeric Field 2 is not equal Numeric Field 2.|
		|*Is Not Equal To Open Query Log Cross Form 			|Test A Single Edit			|Assessment Date Log2			|Numeric Field 2			|Numeric 2 can not equal each other.|
		|*Is Not Equal to Open Query Log Cross Form*			|Test A Single Edit			|Assessment Date Log2			|Numeric Field 2			|Informed Consent numeric field 2 is not equal to assessment numeric field 2|
		|*Is Not Equal To Open Query Log Same form 				|Test B Single Derivation	|Informed Consent Date Form 1	|Numeric Field 2			|Numeric fields are not equal.|
		|*Greater Than or Equal To Open Query Log same form 	|Test B Single Derivation	|Informed Consent Date Form 1	|Informed Consent Date 2	|Dates are not equal.|

	And Draft "Draft 1" in Study "Edit Check Study 3" has been published to CRF Version "<RANDOMNUMBER>" 
	And CRF Version "<RANDOMNUMBER>" in Study "Edit Check Study 3" has been pushed to Site "Edit Check Site 3" in Environment "Prod"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.1
@Draft
Scenario: PB_3.1.1 On a Cross Form Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed. 
   
	#Manual steps
	 #Given I am a Rave user
	 #Given I create a Subject "sub301"
	 #Given I create a Subject with name: "sub", number: "301"
	
	 Given I create a Subject with name: "sub", number: "{nextNumberInStudy(Edit Check Study 3,prod,Subject Number)}"
	 And I select Folder "Test A Single Edit"
	 And I select Form "Informed Consent Date Form 1"
	 And I enter data in CRF
	     |Field                   |Data        |
         |Informed Consent Date 1 |09 Jan 2000 |
	     |Informed Consent Date 2 |10 Jan 2000 |
	     |Numeric Field 1         |10          |
	     |Numeric Field 2         |19          |
	And I save the CRF page
	And I take a screenshot
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
	And I enter data in CRF
	     |Field             |Data        |
         |Assessment Date 1 |08 Jan 2000 |
	     |Assessment Date 2 |11 Jan 2000 |
	     |Numeric Field 1   |10          |
	     |Numeric Field 2   |20          |	
	And I save the CRF page
	And I verify Query with message "Informed Consent Date 1 is greater. Please revise." with Requires Response is displayed on Field "Assessment Date 1"
	And I verify Query with message "Informed Consent numeric field 2 is not equal to assessment numeric field 2" with Requires Response is displayed on Field "Numeric Field 2"
	And I take a screenshot
	And I answer the Query "Informed Consent Date 1 is greater. Please revise." on Field "Assessment Date 1" with "."
	And I answer the Query "Informed Consent numeric field 2 is not equal to assessment numeric field 2" on Field "Numeric Field 2" with "."
	And I save the CRF page
	And I take a screenshot


	# Given closed Query with message "Informed Consent Date 1 is greater. Please revise" exists on Field "Assessment Date 1" in Form "Assessment Date Log2" in Folder "Test A Single Edit" in Subject "SUB301" in Site "Edit Check Site 3" in Study "Edit Check Study 3"
	# And closed Query with message "Informed Consent numeric field 2 is not equal to assessment numeric field 2" exists on Field "Numeric Field 2" in Form "Assessment Date Log2" in Folder "Test A Single Edit" in Subject "SUB301" in Site "Edit Check Site 3" in Study "Edit Check Study 3"
	And I am on CRF page "Assessment Date Log2" in Folder "Test A Single Edit" in Subject "SUB301" in Site "Edit Check Site 3" in Study "Edit Check Study 3"
	And I open log line 1
	When I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save the CRF page
    Then the Query with message "Informed Consent Date 1 is greater. Please revise." is not displayed on Field "Assessment Date 1" on log line 1
	And the Query with message "Informed Consent numeric field 2 is not equal to assessment numeric field 2" is not displayed on Field "Numeric Field 2" on log line 1
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.2
@Draft
Scenario: PB_3.1.2 On a Cross Form Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that 
originally opened the query, then queries are displayed in SQL logs. 
	
    When I run SQL Script "Query Logging Script"
    Then I should see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName 	|TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB301       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2			 	 	|1                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB301       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2             	|1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.3
@Draft
Scenario: PB_3.1.3 On a Cross Form Standard form to log form, When a query has been answered and closed with the different data and I enter the same data that 
originally opened the query, then queries are displayed. 
	
	Given I select a Subject "{subjectName}"
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
	And I add a new log line
	And I enter data in CRF
		 |Field             |Data        |
		 |Assessment Date 1 |07 Jan 2000 |
		 |Assessment Date 2 |12 Jan 2000 |
		 |Numeric Field 1   |10          |
		 |Numeric Field 2   |18          |
	And I save the CRF page
	And I open log line 2
	And I verify Query with message "Informed Consent Date 1 is greater. Please revise." with Requires Response is displayed on Field "Assessment Date 1"
	And I verify Query with message "Informed Consent numeric field 2 is not equal to assessment numeric field 2" with Requires Response is displayed on Field "Numeric Field 2"
    And I take a screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |
	And I answer the Query "Informed Consent Date 1 is greater. Please revise." on Field "Assessment Date 1" with "."
	And I answer the Query "Informed Consent numeric field 2 is not equal to assessment numeric field 2" on Field "Numeric Field 2" with "."
	And I save the CRF page
	And I take a screenshot	
	And I open log line 2
	And I verify Field "Assessment Date 1" has NO Query
	And I verify Field "Numeric Field 2" has NO Query
	And I take a screenshot	

	# Given closed Query with message "" exists on "Assessment Date 1" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB301"
	# And closed Query with message "" exists on "Numeric Field 2" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB301"
	And I am on CRF page "Assessment Date Log2" in Folder "Test A Single Edit" in Subject "SUB301" in Site "Edit Check Site 3" in Study "Edit Check Study 3"
	And I edit log line 2
	When I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save the CRF page
	And I open log line 2
	Then the Query with message "Informed Consent Date 1 is greater. Please revise." is displayed on Field "Assessment Date 1"
	And the Query with message "Informed Consent numeric field 2 is not equal to assessment numeric field 2" is displayed on Field "Numeric Field 2"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.4
@Draft
Scenario: PB_3.1.4 On a Cross Form Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed in SQL logs. 
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB301       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB301       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.2.1
@Draft
Scenario: PB_3.2.1 On a Cross Folder Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that 
originally opened the query, then queries are not displayed.
		
	 Given I create a Subject with name: "sub", number: "{nextNumberInStudy(Edit Check Study 3,prod,Subject Number)}"
	 And I select Folder "Test A Single Edit"
	 And I select Form "Informed Consent Date Form 1"
	 And I enter data in CRF
	   |Field                   |Data        |
       |Informed Consent Date 1 |10 Jan 2000 |
	   |Informed Consent Date 2 |10 Feb 2000 |
	   |Numeric Field 1         |100         |
	   |Numeric Field 2         |200         |
	And I save the CRF page
	And I take a screenshot
	And I select Form "Assessment Date Log2" in Folder "Test B Single Derivation"
	And I enter data in CRF
		| Field					| Data        |
		| Assessment Date 1		| 09 Jan 2000 |
		| Assessment Date 2		| 11 Feb 2000 |
		|Numeric Field 1		|100          |
		|Numeric Field 2		|99           |	
	And I save the CRF page
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Assessment Date 1"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Numeric Field 2"
	And I take a screenshot
	And I open log line 1
	And I answer the Query "{message}" on Field "Assessment Date 1" with "{answer}"
	And I answer the Query "{message}" on Field "Numeric Field 2" with "{answer}"
	And I save the CRF page
	And I take a screenshot	

	# Given closed Query with message "" exists on "Assessment Date 1" in folder "Test B Single Derivation" in form "Assessment Date Log2" in subject "SUB302"
	# And closed Query with message "" exists on "Numeric Field 2" in folder "Test B Single Derivation" in form "Assessment Date Log2" in subject "SUB302"
	And I open log line 1
	When I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |99          |
	And I save the CRF page
	Then the Query with message "" is not displayed on Field "Assessment Date 1"
	And the Query with message "" is not displayed on Field "Numeric Field 2"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.2.2
@Draft
Scenario: PB_3.2.2 On a Cross Folder Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed in SQL logs. 

    When I run SQL Script "Query Logging Script"
    Then I should see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB302       |Test B Single Derivation    |Assessment Date Log2            |1                         |Assessment Date 1    |09 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |1                          |Assessment Date 1       |09 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB302       |Test B Single Derivation    |Assessment Date Log2            |1                         |Numeric Field 2      |99                   |Test B Single Derivation |Assessment Date Log2             |1                          |Numeric Field 2         |99               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.2.3
@Draft
Scenario: PB_3.2.3 On a Cross Folder Standard form to log form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.
	
	Given I select a Subject "{subjectName}"
	And I select Form "Assessment Date Log2" in Folder "Test B Single Derivation"
	And I add a new log line
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |12 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |98          |	
	And I save the CRF page
	And I open log line 2
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Assessment Date 1"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Numeric Field 2"
	And I take a screenshot	
	And I enter data in CRF
		|Field             |Data        |
		|Assessment Date 1 |10 Jan 2000 |
		|Numeric Field 1   |201         |
		|Numeric Field 2   |200         |
	And I answer the Query "{message}" on Field "Assessment Date 1" with "{answer}"
	And I answer the Query "{message}" on Field "Numeric Field 2" with "{answer}"
	And I save the CRF page
	And I take a screenshot
	And I verify Field "Assessment Date 1" has NO Query
	And I verify Field "Numeric Field 2" has NO Query
	And I take a screenshot

	# Given closed Query with message "" exists on "Assessment Date 1" in folder "Test B Single Derivation" in form "Assessment Date Log2" in subject "SUB302"
	# And closed Query with message "" exists on "Numeric Field 2" in folder "Test B Single Derivation" in form "Assessment Date Log2" in subject "SUB302"
	And I add a new log line
	And I open log line 2
	When I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |98          |
	And I save the CRF page
	Then the Query with message "" is displayed on Field "Assessment Date 1"
	And the Query with message "" is displayed on Field "Numeric Field 2"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.2.4
@Draft
Scenario: PB_3.2.4 On a Cross Folder Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed in SQL logs. 
	
	When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                            |MarkingGroupName |QueryMessage                                  |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB302       |Test B Single Derivation    |Assessment Date Log2            |2                         |Assessment Date 1    |08 Jan 2000          |Test B Single Derivation |Assessment Date Log2             |2                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Cross Folder    |Marking Group 1  |Date 1 can not be greater than.               |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB302       |Test B Single Derivation    |Assessment Date Log2            |2                         |Numeric Field 2      |98                   |Test B Single Derivation |Assessment Date Log2             |2                          |Numeric Field 2         |98               |*Is Not Equal to Open Query Cross Folder |Marking Group 1  |Numeric Field 2 is not equal Numeric Field 2. |{DateTime} |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.3.1
@Draft
Scenario: PB_3.3.1 On a Cross Forms log form to Standard form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed. 

	Given I create a Subject with name: "sub", number: "{nextNumberInStudy(Edit Check Study 3,prod,Subject Number)}"
	And I select Folder "Test B Single Derivation"
	And I select Form "Assessment Date Log2"
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |12 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |101         |
	And I save the CRF page
	And I take a screenshot
	And I select Form "Informed Consent Date Form 1" in Folder "Test B Single Derivation"
	And I enter data in CRF
	    |Field                   |Data        |
        |Informed Consent Date 1 |12 Jan 2000 |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 1         |100         |
	    |Numeric Field 2         |101         |	
	And I save the CRF page
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Informed Consent Date 2"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Numeric Field 2"
	And I take a screenshot
	And I enter data in CRF
		|Field                   |Data        |
	    |Informed Consent Date 2 |13 Jan 2000 |
	    |Numeric Field 2         |100         |	
	And I answer the Query "{message}" on Field "Informed Consent Date 2" with "{answer}"
	And I answer the Query "{message}" on Field "Numeric Field 2" with "{answer}"
	And I save the CRF page
	And I verify Field "Informed Consent Date 2" has NO Query
	And I verify Field "Numeric Field 2" has NO Query
	And I take a screenshot	

	# Given closed Query with message "" exists on "Informed Consent Date 2" in folder "Test B Single Derivation" in form "Informed Consent Date Form 1" in subject "SUB303"
	# And closed Query with message "" exists on "Numeric Field 2" in folder "Test B Single Derivation" in form "Informed Consent Date Form 1" in subject "SUB303"
	When I enter data in CRF
		|Field                   |Data        |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 2         |101         |	
	And I save the CRF page
	Then the Query with message "" is displayed on Field "Informed Consent Date 2"
	And the Query with message "" is displayed on Field  "Numeric Field 2"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.3.2
@Draft
Scenario: PB_3.3.2 On a Cross Forms log form to Standard form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed. 

    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName    |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                                      |MarkingGroupName |QueryMessage                  |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB303       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Informed Consent Date 2 |11 Jan 2000          |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Informed Consent Date 2 |11 Jan 2000      |*Greater Than or Equal To Open Query Log same form |Marking Group 1  |Dates are not equal.          |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB303       |Test B Single Derivation    |Informed Consent Date Form 1    |0                         |Numeric Field 2         |101                  |Test B Single Derivation |Informed Consent Date Form 1     |0                          |Numeric Field 2         |101              |*Is Not Equal To Open Query Log Same form          |Marking Group 1  |Numeric fields are not equal. |{DateTime} |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.4.1
@Draft
Scenario: PB_3.4.1 On a Cross Forms log form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed.

	Given I create a Subject with name: "sub", number: "{nextNumberInStudy(Edit Check Study 3,prod,Subject Number)}"
	And I select Folder "Test A Single Edit"
	And I select Form "Assessment Date Log2"
	And I enter data in CRF
	    |Field             |Data        |
	    |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I take a screenshot
	And I select Form "Assessment Date Log3" in Folder "Test A Single Edit"
	And I enter data in CRF
	    |Field           |Data        |
        |Date Field 1    |11 Jan 2000 |
	    |Date Field 2    |09 Feb 2000 |
	    |Numeric Field 1 |101         |
	    |Numeric Field 2 |66          |
	And I take a screenshot
	And I select Form ""Assessment Date Log2"
	And I open log line 1
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Assessment Date 1""
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Assessment Date 2"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Numeric Field 1"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Numeric Field 2"
	And I take a screenshot
	And I answer the Query "{message}" on Field "Assessment Date 1" with "{answer}"
	And I answer the Query "{message}" on Field "Assessment Date 2" with "{answer}"
	And I answer the Query "{message}" on Field "Numeric Field 1" with "{answer}"
	And I answer the Query "{message}" on Field "Numeric Field 2" with "{answer}"
	And I save the CRF page
	And I take a screenshot
	And I enter data in CRF
	  |Field             |Data        |
      |Assessment Date 1 |11 Jan 2000 |
	  |Assessment Date 2 |09 Feb 2000 |
	  |Numeric Field 1   |102         |
	  |Numeric Field 2   |65          |	
	And I save the CRF page
	And I verify Field "Assessment Date 1" has NO Query
	And I verify Field "Assessment Date 2" has NO Query
	And I verify Field "Numeric Field 1" has NO Query
	And I verify Field "Numeric Field 2" has NO Query
	And I take a screenshot	

	# Given closed Query with message "" exists on "Assessment Date 1" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB304"
	# And closed Query with message "" exists on "Assessment Date 2" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB304"
	# And closed Query with message "" exists on "Numeric Field 1" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB304"
	# And closed Query with message "" exists on "Numeric Field 2" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB304"

	And I open log line 1
	When I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I save the CRF page
	Then the Query with message "" is not displayed on Field "Assessment Date 1"
	And the Query with message "" is not displayed on Field "Assessment Date 2"
	And the Query with message "" is not displayed on Field "Numeric Field 1"
	And the Query with message "" is not displayed on Field "Numeric Field 2"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.4.2
@Draft
Scenario: PB_3.4.2 On a Cross Forms log form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed in SQL logs. .
	
	When I run SQL Script "Query Logging Script" 
    Then I should see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |10 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 1|10 Jan 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 2    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |1                          |Assessment Date 2|10 Feb 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 1      |100                  |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 1  |100              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |66                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2  |66               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------	

#THIS IS DUPLICATE of @PB_3.4.1, please confirm
@release_564_Patch11
@PB_3.4.3
@Draft
Scenario: PB_3.4.3 On a Cross Forms log form to log form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.

	Given I select a Subject "{subjectName}"
	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
	And I add a new log line
	And I enter data in CRF
	    |Field             |Data        |
        |Assessment Date 1 |10 Feb 2000 |
	    |Assessment Date 2 |10 Mar 2000 |
	    |Numeric Field 1   |200         |
	    |Numeric Field 2   |77          |
	And I save the CRF page
	And I take a screenshot	
	And I select Form "Assessment Date Log3" in Folder "Test A Single Edit"
	And I add a new log line
	And I enter data in CRF
	    |Field           |Data        |
	    |Date Field 1    |11 Feb 2000 |
	    |Date Field 2    |09 Mar 2000 |
	    |Numeric Field 1 |201         |
	    |Numeric Field 2 |77          |	
	And I take a screenshot	
	And I select Form ""Assessment Date Log2"
	And I open log line 2
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Assessment Date 1""
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Assessment Date 2"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Numeric Field 1"
	And I verify Query with message "{message}" with Requires Response is displayed on Field "Numeric Field 2"
	And I take a screenshot
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |11 Feb 2000 |
	    |Assessment Date 2 |09 Mar 2000 |
	    |Numeric Field 1   |202         |
	    |Numeric Field 2   |76          |	
	And I answer the Query "{message}" on Field "Assessment Date 1" with "{answer}"
	And I answer the Query "{message}" on Field "Assessment Date 2" with "{answer}"
	And I answer the Query "{message}" on Field "Numeric Field 1" with "{answer}"
	And I answer the Query "{message}" on Field "Numeric Field 2" with "{answer}"
	And I save the CRF page
	And I verify Field "Assessment Date 1" has NO Query
	And I verify Field "Assessment Date 2" has NO Query
	And I verify Field "Numeric Field 1" has NO Query
	And I verify Field "Numeric Field 2" has NO Query
	And I take a screenshot	

	# Given closed Query with message "" exists on "Assessment Date 1" in folder "Test B Single Derivation" in form "Assessment Date Log2" in subject "SUB302"
	# And closed Query with message "" exists on "Numeric Field 2" in folder "Test B Single Derivation" in form "Assessment Date Log2" in subject "SUB302"

	# Given closed Query with message "" exists on "Assessment Date 1" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB304"
	# And closed Query with message "" exists on "Assessment Date 2" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB304"
	# And closed Query with message "" exists on "Numeric Field 1" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB304"
	# And closed Query with message "" exists on "Numeric Field 2" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB304"
	
	And I open log line 2
	When I enter data in CRF
		 |Field             |Data        |
         |Assessment Date 1 |10 Feb 2000 |
	     |Assessment Date 2 |10 Mar 2000 |
	     |Numeric Field 1   |200         |
	     |Numeric Field 2   |77          |
	And I save the CRF page
	Then the Query with message "" is displayed on Field "Assessment Date 1"
	And the Query with message "" is displayed on Field "Assessment Date 2"
	And the Query with message "" is displayed on Field "Numeric Field 1" 
	And the Query with message "" is displayed on Field "Numeric Field 2"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.4.4
@Draft
Scenario: PB_3.4.4 On a Cross Forms log form to log form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed in SQL logs. .
	
	When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1|10 Feb 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 2    |10 Mar 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 2|10 Mar 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 1      |200                  |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 1  |200              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |77                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2  |77               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot	
	
#---------------------------------------------------------------------------------------------------------------------------------------- 