# The logic that is used to determine when a query that has already been cancelled or closed should or should not be re-fired in Rave 
# will be examining the answered query data instead of the original query data.

#TESTING FOR LAB FORM WITH 2 FIELDS INVOLVED IN QUERY FIRING

#-- project to be uploaded in excel spreadsheet 'Standard Study'
Feature: Query Refiring Logic5
	As a Rave user
	When I manually close a query or cancel, the query should not re-fire if the exact same data is entered into the system
	So that I dont have to re-enter the exact same response

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Study assignments exist
		|User	|Study		    |Role |Site	  |Site Number	|
		|User 1 |Standard Study	|cdm1 |Site 1 |S100			|
	And Role "cdm1" has Action "Query"
	And Study "Standard Study" has Draft "<Draft1>"
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Study "Standard Study"

@PB-US12940-01A		
Scenario: @PB-US12940-01A As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B. 
Query with requires response = true and requires manual close = true.

	And I create a Subject
	| Field            | Data                                                            |
	| Subject Number   | {NextSubjectNum<num1>(Standard Study,prod,Subject Number)}      |
	| Subject Initials | SUB                                                             |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                        |Response|ManualClose|Query Message  												|
      |Lab Field 2 - WBC - rr = T ; rmc = T	|true    |true       |Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	And I take a screenshot
	And I answer the Query "Data will be changed." on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I save the CRF page    
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I save the CRF page  	  
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|2		|
	And I verify Query is not displayed
      |Field		                        |Response|ManualClose|Query Message  												|
      |Lab Field 2 - WBC - rr = T ; rmc = T	|true    |true       |Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
	Then I verify Query is not displayed
      |Field		                        |Response|ManualClose|Query Message  												|
      |Lab Field 2 - WBC - rr = T ; rmc = T	|true    |true       |Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	And I take a screenshot
	When I run SQL Script "Query Logging Script" 
	Then I should see the logging data for queries 
	  |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	                        |CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	                                |TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      |Standard Study	|S100		  |Site 1	|PROD			|SUB7001A		|<null>						|Lab Form 8							|0							|Lab Field 2 - WBC - rr = T ; rmc = T			|3						|<null>						|Lab Form 8							|0							|Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T		|5					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
	And I take a screenshot