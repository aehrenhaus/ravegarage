Feature: 3 
# Query Issue: Edit Checks with require response and no require manual close
# Open a query and answer a query, change the correct data closes the query automatically and change it back to previous data query did refires and verify there is no log
# Verifies query firing between cross forms with require response and no require manual close.

# Project to be uploaded in excel spreadsheet 'Edit Check Study 3'

Background:
    Given I am logged in to Rave with username "cdm1" and password "password"
	And following Study assignments exist
		|User		|Study		       	|Role |Site		        	|Site Number|
		|editcheck  |Edit Check Study 1	|CDM1 |Edit Check Site 3	|30001      |
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
	And CRF Version "<RANDOMNUMBER>" in Study "Edit Check Study 1" has been pushed to Site "Edit Check Site 1" in Environment "Prod"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB_3.1.1
@Draft
@Web
Scenario: PB_3.1.1
On a Cross Form Standard form to log form, When a query has been answered and closed with the same data and I enter the same data that 
originally opened the query, then queries are not displayed. 
  
	Given closed Queries exist on Fields "Assessment Date 1, Numeric Field 2" in Form "Assessment Date Log2" in Folder "Test A Single Edit" in Subject "SUB301" in Site "Edit Check Site 3" in Study "Edit Check Study 3"
	And I am on CRF page "Assessment Date Log2" in Folder "Test A Single Edit" in Subject "SUB301" in Site "Edit Check Site 3" in Study "Edit Check Study 3"
	When I enter data in CRF
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save CRF
    Then I verify the Queries are not displayed on Field "Assessment Date 1" on log line 1
	Then I verify the Queries are not displayed on Field "Numeric Field 2" on log line 1
	And I take a screenshot
#----------------------------------------------------------------------------------------------------------------------------------------
