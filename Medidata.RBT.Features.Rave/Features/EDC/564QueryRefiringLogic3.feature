Feature: 3 
# Query Issue: Edit Checks with require response and no require manual close
# Open a query and answer a query, change the correct data closes the query automatically and change it back to previous data query did refires and verify there is no log
# Verifies query firing between cross forms with require response and no require manual close.

# Project to be uploaded in excel spreadsheet 'Edit Check Study 3'

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Study assignments exist
		|User		|Study		       	|Role |Site		        	|Site Number|
		|editcheck  |Edit Check Study 1	|CDM1 |Test Site 1	|30001      |
    And  Role "cdm1" has Action "Query"
	And Study "Edit Check Study 1" has Draft "Draft 1" includes Edit Checks from the table below
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
	
	And Draft "Draft 1" in Study "Edit Check Study 1" has been published to CRF Version "<RANDOMNUMBER>" 
	And CRF Version "<RANDOMNUMBER>" in Study "Edit Check Study 1" has been pushed to Site "Test Site 1" in Environment "Prod"



#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.1
@Draft
Scenario: PB_3.1.1 On a Cross Form Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed. 
   
    #Manual steps

	# And I create a subject "sub301"
	# And I navigate to folder "Test A Single Edit"
	# And I select form "Informed Consent Date Form 1"
	# And I enter and save the following data, from the table below
	    # |Field                   |Data        |
        # |Informed Consent Date 1 |09 Jan 2000 |
	    # |Informed Consent Date 2 |10 Jan 2000 |
	    # |Numeric Field 1         |10          |
	    # |Numeric Field 2         |19          |
	# And I take a screenshot 1 of 51		
	# And I navigate to form "Assessment Date Log2" within folder "Test A Single Edit"
    # And I enter and save the following data, from the table below
	    # |Field             |Data        |
        # |Assessment Date 1 |08 Jan 2000 |
	    # |Assessment Date 2 |11 Jan 2000 |
	    # |Numeric Field 1   |10          |
	    # |Numeric Field 2   |20          |	
	# And I verify "Assessment Date 1" field displays query opened with require response
    # And I verify "Numeric Field 2" field displays query opened with require response
	# And I take a screenshot 2 of 51	
	# And I answer the queries on "Assessment Date 1" and "Numeric Field 2" fields
	# And I save the form "Assessment Date Log2"
	# And I take a screenshot 3 of 51

	Given closed Query with message "" exists on Field "Assessment Date 1" in Form "Assessment Date Log2" in Folder "Test A Single Edit" in Subject "sub301" in Site "Test Site 1" in Study "Edit Check Study 1"
	And closed Query with message "" exists on Field "Numeric Field 2" in Form "Assessment Date Log2" in Folder "Test A Single Edit" in Subject "sub301" in Site "Test Site 1" in Study "Edit Check Study 1"
	

	When I am on CRF page "Assessment Date Log2" in Folder "Test A Single Edit" in Subject "sub301" in Site "Test Site 1" in Study "Edit Check Study 1"
	And I open log line 2 for edit
	And I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save the CRF page


    Then the Query with message "test1" is not displayed on Field "Assessment Date 1" on log line 1
	And the Query with message "test2" is not displayed on Field "Numeric Field 2" on log line 1
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.2
@Draft
Scenario: On a Cross Form Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that 
originally opened the query, then queries are displayed in SQL logs. 
	
    When I run SQL Script "Query Logging Script"
    Then I should see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName 	|TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub301       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2			 	 	|1                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub301       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2             	|1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.3
@Draft
Scenario: On a Cross Form Standard form to log form, When a query has been answered and closed with the different data and I enter the same data that 
originally opened the query, then queries are displayed. 
	
	Given closed queries exist on fields "Assessment Date 1" and "Numeric Field 2" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "sub301"
	And I add a new log line
	When I enter data from the table below:
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save form "Assessment Date Log2" 
	Then I verify the queries are displayed on fields "Assessment Date 1" and "Numeric Field 2"	on second logline
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.4
@Draft
Scenario: On a Cross Form Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed in SQL logs. 
	
    When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub301       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |sub301       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.2.1
@Draft
Scenario: On a Cross Folder Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that 
originally opened the query, then queries are not displayed.
		
	Given closed queries exist on fields "Assessment Date 1" and "Numeric Field 2" in folder "Test B Single Derivation" in form "Assessment Date Log2" in subject "SUB302"
	When I enter data from the table below:
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |99          |
	And I save form "Assessment Date Log2" 
	Then I verify the queries are not displayed on fields "Assessment Date 1" and "Numeric Field 2"	on first logline
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.2.2
@Draft
Scenario: On a Cross Folder Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed in SQL logs. 

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
Scenario: On a Cross Folder Standard form to log form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed.

	Given closed queries exist on fields "Assessment Date 1" and "Numeric Field 2" in folder "Test B Single Derivation" in form "Assessment Date Log2" in subject "sub302"
	And I add a new log line
	When I enter data from the table below:
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |98          |
	And I save form "Assessment Date Log2" 
	Then I verify the queries are displayed on fields "Assessment Date 1" and "Numeric Field 2"	on second logline
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.2.4
@Draft
Scenario: On a Cross Folder Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are not displayed in SQL logs. 
	
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
Scenario: On a Cross Forms log form to Standard form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are displayed. 

	Given closed queries exist on fields "Informed Consent Date 2" and "Numeric Field 2" in folder "Test B Single Derivation" in form "Informed Consent Date Form 1" in subject "SUB303"
	When I enter data from the table below:
		|Field                   |Data        |
	    |Informed Consent Date 2 |11 Jan 2000 |
	    |Numeric Field 2         |101         |	
	And I save form "Assessment Date Log2" 
	Then I verify the queries are displayed on fields "Informed Consent Date 2" and "Numeric Field 2"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.3.2
@Draft
Scenario: On a Cross Forms log form to Standard form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed. 

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
Scenario: On a Cross Forms log form to log form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.
	
	Given closed queries exist on fields "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB304"
	When I enter data from the table below:
		|Field             |Data        |
        |Assessment Date 1 |10 Jan 2000 |
	    |Assessment Date 2 |10 Feb 2000 |
	    |Numeric Field 1   |100         |
	    |Numeric Field 2   |66          |
	And I save form "Assessment Date Log2" 
	Then I verify the queries are not displayed on fields "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" on the first logline
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.4.2
@Draft
Scenario: On a Cross Forms log form to log form, When a query has been answered and closed with the same data and I enter the same data that originally opened the query, then queries are displayed in SQL logs. .
	
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
# @release_564_Patch11
# @PB_3.4.3
# @Draft
# Scenario: On a Cross Forms log form to log form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed.
	
	# Given closed queries exist on fields "Informed Consent Date 2" and "Numeric Field 2" in folder "Test A Single Edit" in form "Assessment Date Log2" in subject "SUB304"
	# And I add a new log line
	# When I enter data from the table below:
		# |Field             |Data        |
        # |Assessment Date 1 |10 Feb 2000 |
	    # |Assessment Date 2 |10 Mar 2000 |
	    # |Numeric Field 1   |200         |
	    # |Numeric Field 2   |77          |
	# And I save form "Assessment Date Log2" 
	# Then I verify the queries are displayed on fields "Assessment Date 1", "Assessment Date 2", "Numeric Field 1" and "Numeric Field 2" on the second logline
	# And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_564_Patch11
@PB_3.4.4
@Draft
Scenario: On a Cross Forms log form to log form, When a query has been answered and closed with the different data and I enter the same data that originally opened the query, then queries are not displayed in SQL logs. .
	
	When I run SQL Script "Query Logging Script" 
    Then I should not see the logging data for queries 
		|ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName |TriggerFieldData |EditCheckName                                          |MarkingGroupName |QueryMessage                                                    |EventTime  |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |10 Feb 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1|10 Feb 2000      |*Is Less Than To Open Query Log Cross Form             |Marking Group 1  |Date can not be less than.                                      |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 2    |10 Mar 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 2|10 Mar 2000      |*Is Less Than Open Query Log Cross Form                |Marking Group 1  |Date is Less Than Date on the first log form.                   |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 1      |200                  |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 1  |200              |*Is Greater Than or Equal To Open Query Log Cross Form |Marking Group 1  |Numeric Field is greater than or Equal to Numeric Field on Log. |{DateTime} |
		|Edit Check Study 3 |30001       |Edit Check Site 3 |PROD        |SUB304       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |77                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2  |77               |*Is Not Equal To Open Query Log Cross Form             |Marking Group 1  |Numeric 2 can not equal each other.                             |{DateTime} |
	And I take a screenshot	
	
#---------------------------------------------------------------------------------------------------------------------------------------- 