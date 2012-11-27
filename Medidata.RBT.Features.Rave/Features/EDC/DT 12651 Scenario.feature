# DT 12651. 
# Old range status is not cleared when the user updates data to empty in eCRF
# When user submits data out of range, range status of datapoint will be set to a value not equal to 0. 
# After that, when the user updates the data to empty, the out of range status icon will not be displayed - This is expected behavior.
# However, the range status in datapoint is not reset to 0. Also, there is no audit trail indicating this change.
# Normally, it is no harm issue because the range status will be re-calculated in Clinical Views. 
# However, if a migration is done for this subject, there is an extra audit say "Lab Range Status Changed from ... to In Range."

#******************* Another Case, 21 Jan 2011******************************

# If original data is out of range and the user then updates this data to something that system can not calculate (including missing codes), the lab status is still there which should be reset to 0.
# For example, the original data is '30' and lab status is '+' means lab status is high. 
# After that, user updates data to '30 md/gl' (if data format is number, it is non-conformant); 
# (If data format is text which is not good but allowed in our Lab system, it is conformant), but the Lab Status '+' is not cleared.
# Note: Lab Status in normal lab view is always correct because normal lab view always re-calculate lab status instead of using lab status in datapoint table directly.

# Steps
# 1.	Submit data with High Range Status
# 2.	Check Audit  saying 'Lab Range Status changed from In Range to High'
# 3.	Run query against DB
# Query = "select datapointID, data, RangeStatus, AnalyteRangeID from datapoints where recordid = <nnnn>"
# <nnnn> is recordid which can be get from CRF Page, Make sure the RangeStatus for the datapoint is 1.
# 4.	Update data to empty. 
# 5.	Check Audit
# 6.	There is an audit trail reflecting this chage
# 7.	Run query against DB
# Query: "select datapointID, data, RangeStatus, AnalyteRangeID from datapoints where recordid = <nnnn>
# <nnnn> is recordid which can be get from CRF Page
# Before fix: The range status = number
# After fix: The range status = "0"

#TESTING FOR LAB FORM 

#-- project to be uploaded in excel spreadsheet 'LabsReg'

#-- SQL Query: 
#-- select datapointID, data, RangeStatus, AnalyteRangeID from datapoints where recordid = <nnnn>
#-- <nnnn> is recordid which can be get from CRF Page, Make sure the RangeStatus for the datapoint is 1.
@ignore
Feature: US12995_DT12651 Old range status is not cleared when the user updates data to empty in eCRF
	As a Rave user
	When I change range status to clear
	Then in SQL the query result in Column RangeStatus = 0 

Background:
    Given I login to Rave with user "defuser" and password "password"
	And I select Study "LabsReg" and Site "Lab Site 1"
	And following Study assignments exist
		| User	  | Study	| Role | Site	  	| Site Number	|
		| Defuser | LabsReg	| cdm1 | Lab Site 1 | LS100			|
	And Labs are set in the study
	And Study "LabsReg" has Draft "<Draft1>"
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Labs Site 1" in Study "LabReg"
	And I navigate to study "LabReg" 
	And I navigate to site "Lab Site 1"
	
@release_563_Patch241
@PB_US12995_DT12651_01
@Validation		
Scenario: PB_US12995_DT12651_01 As an EDC user, when I entered above range data in lab field A, and I run the query "Query" in the database, then there will be value in "RangeStatus" column.

	And I create a Subject
	  | Field   			| Data              |
#	  | Subject				| {RndNum<num1>(5)} |
#	  | Subject Initials 	| SUB               |
      | Subject ID       	| SUB {Var(num1)}	|	
	And I select Form "LabDemographics"
	And I enter data in CRF and save
      | Field		|Data   |
      | Age			|22		|
      | Sex			|Male	|
	  |	Pregnant	|No		|

	And I select to LabForm form
	And I enter data in CRF and save
      |Field	|Data	|
      |WBC		|50		|
	And I hover over icon "Audit Trail Icon"  
	And I note recordID "RecordID"
	And I verify over the range icon is displayed
	And I take a screenshot
	When I click audit on Field "WBC"
	Then I verify Audit exists
	  | Audit		                                        |
	  | Lab Range Status Changed from InRange to AlertHigh.	|
	And I take a screenshot
	
	And I open "SQL Server Management Studio"
	And I navigate to database "Database"
	When I run query "Query"
	Then I verify column "RangeStatus" = "#" for datapoint id "DatapointID"
	And I take a screenshot
	
	And I select to LabForm form
	And I enter data in CRF and save
      |Field	|Data	|
      |WBC		|0		|
	And I take a screenshot
	When I click audit on Field "WBC"
	Then I verify Audit exists
	  | Audit		        |
	  | User entered empty.	|
	And I take a screenshot
	
	And I open "SQL Server Management Studio"
	And I navigate to database "Database"
	When I run query "Query"
	Then I verify column "RangeStatus" = "0" for datapoint id "DatapointID"
	And I take a screenshot
	