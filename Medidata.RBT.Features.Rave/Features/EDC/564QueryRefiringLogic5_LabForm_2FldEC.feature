# The logic that is used to determine when a query that has already been cancelled or closed should or should not be re-fired in Rave 
# will be examining the answered query data instead of the original query data.

#TESTING FOR LAB FORM WITH 2 FIELDS INVOLVED IN QUERY FIRING

#-- project to be uploaded in excel spreadsheet 'Standard Study'
Feature: Query Refiring Logic
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
	And I publish and push "CRF Version<RANDOMNUMBER>" to site "Site 1" 


@release_564_Patch11
@PB_5.1.1
@Draft
#@PB-US12940-01A		
Scenario: PB_5.1.1 As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = true.

	And I create a Subject
	| Field            | Value                                                          |
	| Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	| Subject Initials |SUB7001A                                                        |	
	And I am on form "Lab Form 8" for the Subject "SUB7001A"
	And I have submitted the following values for the "Lab Form 8" form
      |Field		|Value  |
      |Lab field 1	|5		|
      |Lab field 2	|3		|
	And I see open query for the following fields
      |Field		|Query Message  												|
      |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	And I take screenshot 1 of 4	  
	When I answer query
      |Field		|Query Response  		|
      |Lab field 2	|Data will be changed.	|
	And I save the CRF page    
	When I close query
      |Field		|
      |Lab field 2	|		  
	And I save the CRF page  	  
	Then I should see closed query
      |Field		|
      |Lab field 2	|
	And I take screenshot 2 of 4	  
	When I submit the following values for the "Lab Form 8" form
      |Field		|Value  |
      |Lab field 1	|2		|
	Then I should not see new open query for the following fields
      |Field		|
      |Lab field 2	|   
	When I submit the following values for the "Lab Form 8" form
      |Field		|Value  |
      |Lab field 1	|5		|
	Then I should not see new open query for the following fields
      |Field		|
      |Lab field 2	|
	And I take screenshot 3 of 4	
	When I run SQL Script "Query Logging Script" 
	Then I should see the logging data for queries 
	  |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      |Standard Study	|S100		  |Site 1	|PROD			|SUB7001A		|<null>						|Lab Form 8							|0							|Lab field 2			|3						|<null>						|Lab Form 8							|0							|Lab field 1		|5					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
	And I take screenshot 4 of 4	
	
# @PB-US12940-01B		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = false.

	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7001B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7001B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 1 of 4	      
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|2		|
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 4	| 
	# And I take screenshot 2 of 4	 
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
	# And I should see new open query for the following fields
      # |Lab field 4	|	  
	# And I take screenshot 3 of 4	
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7001B		|<null>						|Lab Form 8							|0							|Lab field 4			|3						|<null>						|Lab Form 8							|0							|Lab field 3		|5					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
	# And I take screenshot 4 of 4	 
	
# @PB-US12940-01C		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = false.

	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7001C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7001C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 5	  
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 6	|Data will be changed.	|
	# And I save the CRF page  
	# Then I should see closed query
      # |Field		|
      # |Lab field 6	|	
	# And I take screenshot 2 of 5	    
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|2		|
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 6	|	  
	# And I take screenshot 3 of 5	 
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 4 of 5	
	# When I run SQL Script "Query Logging Script" 
	# Then I should see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7001C		|<null>						|Lab Form 8							|0							|Lab field 6			|3						|<null>						|Lab Form 8							|0							|Lab field 5		|5					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5	 
	
# @PB-US12940-01D
# @ignore
# #Failing due to DT14207
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7001D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7001D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 4	  	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|2		|
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 8	| 	  
	# And I should see answered query for the following fields	
      # |Field		|	
      # |Lab field 8	| 
	# And I take screenshot 2 of 4	 
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
	# Then I should see new open query for the following fields 
      # |Lab field 8	| 
	# And I take screenshot 3 of 4	
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7001D		|<null>						|Lab Form 8							|0							|Lab field 8			|3						|<null>						|Lab Form 8							|0							|Lab field 7		|5					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 4 of 4	 	

# @PB-US12940-02A		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7002A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7002A"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	# And I take screenshot 1 of 6	    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 2	|Data will be changed.	|
	# And I save the CRF page  
	# And I take screenshot 2 of 6	  
	# When I close query
      # |Field		|
      # |Lab field 2	|			  
	# And I save the CRF page  	  
	# Then I should see closed query
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 3 of 6	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 2	|6		|
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 4 of 6	  	
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 2	|3		|
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 5 of 6		
	# When I run SQL Script "Query Logging Script" 
	# Then I should see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7002A		|<null>						|Lab Form 8							|0							|Lab field 2			|3						|<null>						|Lab Form 8							|0							|Lab field 2		|3					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
	# And I take screenshot 6 of 6

# @PB-US12940-02B		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = false. 
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7002B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7002B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 1 of 4	    	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 4	|6		|
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 2 of 4	   	
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 4	|3		|
	# Then I should see new open query for the following fields	  
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 3 of 4		
	# When I run SQL Script "Query Logging Script" 
    # Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7002B		|<null>						|Lab Form 8							|0							|Lab field 4			|3						|<null>						|Lab Form 8							|0							|Lab field 4		|3					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
	# And I take screenshot 4 of 4

# @PB-US12940-02C		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = false. 
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7002C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7002C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 5	    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 6	|Data will be changed.	|
	# And I save the CRF page  
	# Then I should see closed query
      # |Field		|
      # |Lab field 6	|	
	# And I take screenshot 2 of 5	    
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 6	|6		|
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 3 of 5	  	
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 6	|3		|
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 4 of 5		
	# When I run SQL Script "Query Logging Script" 
	# Then I should see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7002C		|<null>						|Lab Form 8							|0							|Lab field 6			|3						|<null>						|Lab Form 8							|0							|Lab field 6		|3					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5

# @PB-US12940-02D		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7002D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7002D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 5	    	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 8	|6		|
	# Then I should see answered query for the following fields	
      # |Field		|	
      # |Lab field 8	| 
	# And I take screenshot 2 of 5	 
	# When I close query
      # |Field		|
      # |Lab field 8	| 	  
	# And I save the CRF page  	  
	# Then I should see closed query
      # |Field		|
      # |Lab field 8	| 	
	# And I take screenshot 3 of 5	  	
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 8	|3		|
	# And I should see new open query for the following fields	  
      # |Field		|
      # |Lab field 8	|
	# And I take screenshot 4 of 5		
	# When I run SQL Script "Query Logging Script" 
 	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7002D		|<null>						|Lab Form 8							|0							|Lab field 8			|3						|<null>						|Lab Form 8							|0							|Lab field 8		|3					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5	 		
	
# @PB-US12940-03A	
# # failing due to DT14215	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I entered good data in lab field A and then again entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = true.

	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7003A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7003A"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	# And I take screenshot 1 of 6	    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 2	|Data will be changed.	|
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 1	|4		|
	# And I save the CRF page 	  
	# Then I should see old answered query for the following fields
      # |Field		|
      # |Lab field 2	| 
	# And I take screenshot 2 of 6	  
	# When I close query
      # |Field		|
      # |Lab field 2	|
	# And I save the CRF page  	  
	# Then I should see closed query
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 3 of 6	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|2		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 4 of 6	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|4		|
# #DT14215   Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 2	|  
	# And I take screenshot 5 of 6	  
	# When I run SQL Script "Query Logging Script" 
	# Then I should see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7003A		|<null>						|Lab Form 8							|0							|Lab field 2			|3						|<null>						|Lab Form 8							|0							|Lab field 1		|4					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	||Standard Study	|S100		  |Site 1	|PROD			|SUB B7003		|<null>						|Lab Form 8							|0							|Lab field 4			|3						|<null>						|Lab Form 8							|0							|Lab field 3		|4					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
	# And I take screenshot 6 of 6

# @PB-US12940-03B	
# @ignore
# #Failing due to DT14200	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I entered good data in lab field A and then again entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = false.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7003B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7003B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 1 of 5	    
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 3	|4		|
	# And I save the CRF page 	  
	# Then I should see new open query for the following fields	 
      # |Field		|
      # |Lab field 4	| 
	# And I take screenshot 2 of 5	    
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|2		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|4		|	  
	# Then I should see new open query for the following fields	  
      # |Field		|	
      # |Lab field 4	|
	# And I take screenshot 4 of 5	  
	# When I run SQL Script "Query Logging Script" 
 	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7003B		|<null>						|Lab Form 8							|0							|Lab field 4			|3						|<null>						|Lab Form 8							|0							|Lab field 3		|4					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5 

# @PB-US12940-03C		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I entered good data in lab field A and then again entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = false. 
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7003C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7003C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 4	    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 6	|Data will be changed.	|
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 5	|4		|
	# And I save the CRF page 	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|2		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 2 of 4	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|4		|	  
	# And I should see new open query for the following fields	  
      # |Field		|	
      # |Lab field 6	|
	# And I take screenshot 3 of 4	  
	# When I run SQL Script "Query Logging Script" 
 	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7003C		|<null>						|Lab Form 8							|0							|Lab field 6			|3						|<null>						|Lab Form 8							|0							|Lab field 5		|4					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 4 of 4

# @PB-US12940-03D	
# @ignore
# #Failing due to DT14207	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I entered good data in lab field A and then again entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7003D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7003D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 6	    
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 7	|4		|  
	# And I save the CRF page 	  
	# Then I should see new open query for the following fields	 
      # |Field		|
      # |Lab field 8	|
	# And I should see old answered query for the following fields
      # |Field		|
      # |Lab field 8	| 	  
	# And I take screenshot 2 of 6	  
	# When I close query
      # |Field		|
      # |Lab field 8	| 	 
	# And I save the CRF page  	  
	# Then I should see closed query
      # |Field		|
      # |Lab field 8	| 	
	# And I take screenshot 3 of 6	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|2		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 8	|  
	# And I take screenshot 4 of 6	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|4		|  
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 8	| 		  
	# And I take screenshot 5 of 6	  
	# When I run SQL Script "Query Logging Script" 
	# Then I should see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7003D		|<null>						|Lab Form 8							|0							|Lab field 8			|3						|<null>						|Lab Form 8							|0							|Lab field 7		|4					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 6 of 6	

# @PB-US12940-04A	
# #DT14215	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I entered good data in lab field B and then again entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = true.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7004A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7004A"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	# And I take screenshot 1 of 6		    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 2	|Data will be changed.	|
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 2	|2		|
	# And I save the CRF page 	
	# Then I should see old answered query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 2 of 6		  
	# When I close query 
      # |Field		|
      # |Lab field 2	|
	# And I save the CRF page 	  
	# Then I should see closed query for the following field
      # |Field		|
      # |Lab field 2	| 
	# And I take screenshot 3 of 6		  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 2	|6		|
	# Then I should not see open query for the following field
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 4 of 6		  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 2	|2		|   
# #DT14215	Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 5 of 6		
	# When I run SQL Script "Query Logging Script" 
	# Then I should see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7004A		|<null>						|Lab Form 8							|0							|Lab field 2			|2						|<null>						|Lab Form 8							|0							|Lab field 2		|2					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
    # And I take screenshot 6 of 6

# @PB-US12940-04B		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I entered good data in lab field B and then again entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7004B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7004B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 1 of 6		    
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 4	|2		| 
	# And I save the CRF page 	
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 2 of 6		  	  
	# Then I should not see old open query for the following fields
      # |Field		|
      # |Lab field 4	| 
	# And I take screenshot 3 of 6		  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 4	|6		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 4 of 6		  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 4	|2		|   
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 5 of 6		
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7004B		|<null>						|Lab Form 8							|0							|Lab field 4			|2						|<null>						|Lab Form 8							|0							|Lab field 4		|2					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
	# And I take screenshot 6 of 6

# @PB-US12940-04C		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I entered good data in lab field B and then again entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7004C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7004C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 6		    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 6	|Data will be changed.	|
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 6	|2		| 
	# And I save the CRF page 	
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 6	|	
	# And I take screenshot 2 of 6		  	  
	# Then I should not see old open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 3 of 6		  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 6	|6		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 4 of 6		  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 6	|2		|   
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 5 of 6		
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7004C		|<null>						|Lab Form 8							|0							|Lab field 6			|2						|<null>						|Lab Form 8							|0							|Lab field 6		|2					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 6 of 6

# @PB-US12940-04D		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I entered good data in lab field B and then again entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7004D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7004D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 6		    
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 8	|2		|  
	# And I save the CRF page 	
	# Then I should see old answered query for the following fields
      # |Field		|
      # |Lab field 8	| 	
	# And I take screenshot 2 of 6		  
	# When I close query 
      # |Field		|
      # |Lab field 8	| 	
	# And I save the CRF page 	  
	# Then I should see closed query for the following field
      # |Field		|
      # |Lab field 8	|   
	# And I take screenshot 3 of 6		  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 8	|6		| 
	# Then I should not see new open query for the following field	
      # |Field		|	
      # |Lab field 8	|  
	# And I take screenshot 4 of 6		  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 8	|2		|    
# #DT#14218	
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 8	|  
	# And I take screenshot 5 of 6		
	# When I run SQL Script "Query Logging Script" 
	# Then I should see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7004D		|<null>						|Lab Form 8							|0							|Lab field 8			|2						|<null>						|Lab Form 8							|0							|Lab field 8		|2					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
 	# And I take screenshot 6 of 6		
 
# @PB-US12940-05A	
# #DT#14217	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the original bad data in lab field A, then the system should refire a query on lab field B.  Query with requires response = true and requires manual close = true.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7005A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7005A"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	# And I take screenshot 1 of 5		    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 2	|Data will be changed.	|
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 1	|4		|
	# And I save the CRF page 	  
	# Then I should see old answered query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 2 of 5		  
	# When I close query
      # |Field		|
      # |Lab field 2	|
	# And I save the CRF page  	  
	# Then I should see closed query
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 3 of 5		  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|   	
# #DT#14217	
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 2	|  
	# And I take screenshot 4 of 5		
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7005A		|<null>						|Lab Form 8							|0							|Lab field 2			|3						|<null>						|Lab Form 8							|0							|Lab field 1		|5					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
    # And I take screenshot 5 of 5

# @PB-US12940-05B	
# @ignore
# #Failing due to DT14200		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the original bad data in lab field A, then the system should refire a query on lab field B.  Query with requires response = false and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7005B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7005B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 1 of 4		    
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 3	|4		| 
	# And I save the CRF page 	  
	# Then I should see new open query for the following fields	  
      # |Field		|
      # |Lab field 4	| 
	# And I take screenshot 2 of 4		  	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		| 	
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 4	|  
	# And I take screenshot 3 of 4		
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7005B		|<null>						|Lab Form 8							|0							|Lab field 4			|3						|<null>						|Lab Form 8							|0							|Lab field 3		|5					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
    # And I take screenshot 4 of 4

# @PB-US12940-05C	
# @ignore
# #Failing due to DT14208 and DT#14107		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the original bad data in lab field A, then the system should refire a query on lab field B.  Query with requires response = true and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7005C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7005C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 4		    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 6	|Data will be changed.	|
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 5	|4		|  
	# And I save the CRF page 	  
# #DT14208   Then I should not see new open query for the following fields	  
      # |Field		|
      # |Lab field 6	|  
	# And I take screenshot 2 of 4		  	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|	
# #DT14107	Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 6	|  
	# And I take screenshot 3 of 4		
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7005C		|<null>						|Lab Form 8							|0							|Lab field 6			|3						|<null>						|Lab Form 8							|0							|Lab field 5		|5					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 4 of 4

# @PB-US12940-05D	
# @ignore
# #Failing due to DT14208 and DT#14207		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the original bad data in lab field A, then the system should refire a query on lab field B.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7005D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7005D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 5		    
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 7	|4		|    
	# And I save the CRF page 	    
# #DT14207	And I should see old answered query for the following fields
      # |Field		|
      # |Lab field 8	|   
	# And I take screenshot 2 of 5		  
	# When I close query
      # |Field		|
      # |Lab field 8	|   
	# And I save the CRF page  	  
	# Then I should see closed query
      # |Field		|
      # |Lab field 8	| 
	# And I take screenshot 3 of 5		  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|   	
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 8	|    
	# And I take screenshot 4 of 5		
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7005D		|<null>						|Lab Form 8							|0							|Lab field 8			|3						|<null>						|Lab Form 8							|0							|Lab field 7		|5					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5		
  
# @PB-US12940-06A
# #DT14215		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the original bad data in lab field B, then the system should refire a query on lab field B.  Query with requires response = true and requires manual close = true.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7006A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7006A"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	# And I take screenshot 1 of 5			    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 2	|Data will be changed.	|
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 2	|2		|  
	# And I save the CRF page 	
	# And I should see old answered query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 2 of 5		  
	# When I close query 
      # |Field		|
      # |Lab field 2	|
	# And I save the CRF page 	  
	# Then I should see closed query for the following field
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 2	|3		|  
# #DT14215	Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 2	| 
	# And I take screenshot 4 of 5	 
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7006A		|<null>						|Lab Form 8							|0							|Lab field 2			|3						|<null>						|Lab Form 8							|0							|Lab field 2		|3					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5

# @PB-US12940-06B		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the original bad data in lab field B, then the system should refire a query on lab field B.  Query with requires response = false and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7006B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7006B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 1 of 5			    
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 4	|2		|  
	# And I save the CRF page 	
	# Then I should see new open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 2 of 5		  	  
	# Then I should not see old open query for the following fields
      # |Field		|
      # |Lab field 4	|    
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 4	|3		|  
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 4	|  
	# And I take screenshot 4 of 5	 
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7006B		|<null>						|Lab Form 8							|0							|Lab field 4			|3						|<null>						|Lab Form 8							|0							|Lab field 4		|3					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
    # And I take screenshot 5 of 5

# @PB-US12940-06C	
# @ignore
# #Failing due to DT14208
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the original bad data in lab field B, then the system should refire a query on lab field B.  Query with requires response = true and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7006C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7006C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 4			    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 6	|Data will be changed.	|
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 6	|2		|
	# And I save the CRF page 	
# DT#14208	Then I should not see new open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|	  
	# And I take screenshot 2 of 4	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 6	|3		| 
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 3 of 4	 
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7006C		|<null>						|Lab Form 8							|0							|Lab field 6			|3						|<null>						|Lab Form 8							|0							|Lab field 6		|3					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 4 of 4

# @PB-US12940-06D
# #DT14217		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the original bad data in lab field B, then the system should refire a query on lab field B.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7006D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7006D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 5			    
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 8	|2		|    
	# And I save the CRF page 	
	# Then I should see old answered query for the following fields
      # |Field		|
      # |Lab field 8	| 
	# And I take screenshot 2 of 5		  
	# When I close query 
      # |Field		|
      # |Lab field 8	| 
	# And I save the CRF page 	  
	# Then I should see closed query for the following field
      # |Field		|
      # |Lab field 8	|    
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 8	|3		|  	  
# #DT14217	Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 8	|   
	# And I take screenshot 4 of 5	 
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7006D		|<null>						|Lab Form 8							|0							|Lab field 8			|3						|<null>						|Lab Form 8							|0							|Lab field 8		|3					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5		
	  
# @PB-US12940-07A		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field A, then the system should refire a query on lab field B.  Query with requires response = true and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7007A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7007A"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	# And I take screenshot 1 of 5	  
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 2	|Data will be changed.	|
	# And I save the CRF page  
	# And I take screenshot 2 of 5	  
	# When I close query
      # |Field		|
      # |Lab field 2	|	  
	# And I save the CRF page  	  
	# Then I should see closed query
      # |Field		|
      # |Lab field 2	|	
	# And I take screenshot 3 of 5  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|6		|
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 4 of 5	  
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7007A		|<null>						|Lab Form 8							|0							|Lab field 2			|3						|<null>						|Lab Form 8							|0							|Lab field 1		|6					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
    # And I take screenshot 5 of 5

# @PB-US12940-07B	
# @ignore
# #Failing due to DT14200
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field A, then the system should refire a query on lab field B.  Query with requires response = false and requires manual close = false.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7007B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7007B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 1 of 3	   
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|6		|
# #DT14200	Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 4	| 
	# And I take screenshot 2 of 3	  
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7007B		|<null>						|Lab Form 8							|0							|Lab field 4			|3						|<null>						|Lab Form 8							|0							|Lab field 3		|6					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
    # And I take screenshot 3 of 3

# @PB-US12940-07C		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field A, then the system should refire a query on lab field B.  Query with requires response = true and requires manual close = false.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7007C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7007C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 4	  
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 6	|Data will be changed.	|
	# And I save the CRF page  
	# Then I should see closed query
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 2 of 4	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|6		|
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 3 of 4	  
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7007C		|<null>						|Lab Form 8							|0							|Lab field 6			|3						|<null>						|Lab Form 8							|0							|Lab field 5		|6					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 4 of 4

# @PB-US12940-07D
# @ignore
# #Failing due to DT14207		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field A, then the system should refire a query on lab field B.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7007D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7007D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 3	   
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|6		|   
# #DT#14207
	# Then I should not see new open query for the following fields
      # |Field		|
      # |Lab field 8	|   
	# And I take screenshot 2 of 3	  
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7007D		|<null>						|Lab Form 8							|0							|Lab field 8			|3						|<null>						|Lab Form 8							|0							|Lab field 7		|6					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 3 of 3			
	  
# @PB-US12940-08A		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field B, then the system should refire a query on lab field B.  Query with requires response = true and requires manual close = true.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7008A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7008A"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
    # And I take screenshot 1 of 5	    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 2	|Data will be changed.	|
	# And I save the CRF page  
	# And I take screenshot 2 of 5	  
	# When I close query
      # |Field		|
      # |Lab field 2	|		  
	# And I save the CRF page  	  
	# Then I should see closed query
      # |Field		|
      # |Lab field 2	|	
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 2	|2		|  
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 2	| 
	# And I take screenshot 4 of 5	 
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7008A		|<null>						|Lab Form 8							|0							|Lab field 2			|2						|<null>						|Lab Form 8							|0							|Lab field 2		|2					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
    # And I take screenshot 5 of 5

# @PB-US12940-08B		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field B, then the system should refire a query on lab field B.  Query with requires response = false and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7008B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7008B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 1 of 3	      	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 4	|2		|
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 2 of 3	 
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7008B		|<null>						|Lab Form 8							|0							|Lab field 4			|2						|<null>						|Lab Form 8							|0							|Lab field 4		|2					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
	# And I take screenshot 3 of 3

# @PB-US12940-08C		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field B, then the system should refire a query on lab field B.  Query with requires response = true and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7008C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7008C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 4	    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 6	|Data will be changed.	|
	# And I save the CRF page  
	# Then I should see closed query
      # |Field		|
      # |Lab field 6	|	
	# And I take screenshot 2 of 4	    
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 6	|2		|
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 3 of 4	 
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7008C		|<null>						|Lab Form 8							|0							|Lab field 6			|2						|<null>						|Lab Form 8							|0							|Lab field 6		|2					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 4 of 4

# @PB-US12940-08D	
# DT# 14219	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, if I then entered new bad data in lab field B, then the system should answers the old query on lab field B. Then I should not see logging.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7008D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7008D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 3	      
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 8	|2		|  
	# Then I should see answered query for the following fields
      # |Field		|
      # |Lab field 8	|   
	# And I take screenshot 2 of 3	 
# #DT14219	
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7008D		|<null>						|Lab Form 8							|0							|Lab field 8			|2						|<null>						|Lab Form 8							|0							|Lab field 8		|2					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 3 of 3	
	
# @PB-US12940-09A	
# #DT14220	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B. And I should not see the logging.  Query with requires response = true and requires manual close = true.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7009A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7009A"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	# And I take screenshot 1 of 5	 	  
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 2	|Data will be changed.	|
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 1	|7		|
	# And I save the CRF page 	  
	# Then I should see old answered query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 2 of 5	 	  
	# When I close query
      # |Field		|
      # |Lab field 2	|
	# And I save the CRF page  	  
	# Then I should see closed query
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 3 of 5		  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|6		|
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 2	|	
	# And I take screenshot 4 of 5	
# #DT14220
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7009A		|<null>						|Lab Form 8							|0							|Lab field 2			|3						|<null>						|Lab Form 8							|0							|Lab field 1		|6					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5

# @PB-US12940-09B	
# @ignore
# #Failing due to DT14200	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B.  Query with requires response = false and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7009B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7009B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 1 of 4	 	  
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 3	|7		|	  
	# And I save the CRF page 	  
# #DT14200	Then I should see new open query for the following fields	 
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 2 of 4	 	  		  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|6		|
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 3 of 4	
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7009B		|<null>						|Lab Form 8							|0							|Lab field 4			|3						|<null>						|Lab Form 8							|0							|Lab field 3		|6					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
    # And I take screenshot 4 of 4

# @PB-US12940-09C	
# @ignore
# #Failing due to DT14208	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B.  Query with requires response = true and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7009C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7009C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 4	 	  
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 6	|Data will be changed.	|
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 5	|7		| 
	# And I save the CRF page 	  
# #DT14208
	# Then I should not see new open query for the following fields	 
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 2 of 4	 	  	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|6		|
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 3 of 4	
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7009C		|<null>						|Lab Form 8							|0							|Lab field 6			|3						|<null>						|Lab Form 8							|0							|Lab field 5		|6					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 4 of 4

# @PB-US12940-09D	
# @ignore
# #Failing due to DT14207	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7009D                                                            |	
	# And I am on form "Lab Form 8" for the Subject "SUB7009D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 5	 	  
	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 7	|7		|  	  
	# And I save the CRF page 	  
	# Then I should see not new open query for the following fields	 
      # |Field		|
      # |Lab field 8	|  	  
# #DT14207
	# And I should see old answered query for the following fields
      # |Field		|
      # |Lab field 8	|
	# And I take screenshot 2 of 5	 	  
	# When I close query
      # |Field		|
      # |Lab field 8	|	  
	# And I save the CRF page  	  
	# Then I should see closed query
      # |Field		|
      # |Lab field 8	|
	# And I take screenshot 3 of 5		  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|6		|  
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 8	|  	
	# And I take screenshot 4 of 5
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7009D		|<null>						|Lab Form 8							|0							|Lab field 8			|3						|<null>						|Lab Form 8							|0							|Lab field 7		|6					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5		

# @PB-US12940-10A	
# #DT14220	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the new bad data in lab field B, then the system should refire a query on lab field B.  Query with requires response = true and requires manual close = true.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7010A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7010A"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	# And I take screenshot 1 of 5	    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 2	|Data will be changed.	|
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 2	|2		|  
	# And I save the CRF page 	
	# Then I should see old answered query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 2 of 5	  
	# When I close query 
      # |Field		|
      # |Lab field 2	|
	# And I save the CRF page 	  
	# Then I should see closed query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 2	|1		| 
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 2	| 
	# And I take screenshot 4 of 5
# #DT14220
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7010A		|<null>						|Lab Form 8							|0							|Lab field 2			|1						|<null>						|Lab Form 8							|0							|Lab field 2		|1					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
    # And I take screenshot 5 of 5

# @PB-US12940-10B		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the new bad data in lab field B, then the system should refire a query on lab field B.  Query with requires response = false and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7010B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7010B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 1 of 5	    
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 4	|2		|	  
	# And I save the CRF page 	
	# Then I should see new open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 2 of 5	  		  
	# Then I should not see old open query for the following fields
      # |Field		|
      # |Lab field 4	| 
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 4	|1		|	  
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 4	|  
	# And I take screenshot 4 of 5
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7010B		|<null>						|Lab Form 8							|0							|Lab field 4			|1						|<null>						|Lab Form 8							|0							|Lab field 4		|1					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5

# @PB-US12940-10C
# @ignore
# #Failing due to DT14208		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the new bad data in lab field B, then the system should refire a query on lab field B.  Query with requires response = true and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7010C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7010C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 4	    
	# When I answer query
      # |Field		|Query Response  		|
      # |Lab field 6	|Data will be changed.	|
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 6	|2		|  
	# And I save the CRF page 	
# #DT14208
	# Then I should not see new open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 2 of 4	   	    
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 6	|1		| 
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 6	|  
	# And I take screenshot 3 of 4
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7010C		|<null>						|Lab Form 8							|0							|Lab field 6			|1						|<null>						|Lab Form 8							|0							|Lab field 6		|1					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 4 of 4

# @PB-US12940-10D
# #DT14219		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the new bad data in lab field B, then the system should refire a query on lab field B.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7010D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7010D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 5	    
  	# And I enter the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 8	|2		|  	  
	# And I save the CRF page 	
	# Then I should not see new open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I should see answered query for the following fields
      # |Field		|
      # |Lab field 8	|
	# And I take screenshot 2 of 5	  
	# When I close query 
      # |Field		|
      # |Lab field 8	|
	# And I save the CRF page 	  
	# Then I should see closed query for the following field
      # |Field		|
      # |Lab field 8	|  
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 8	|1		|  	  
	# Then I should see new open query for the following fields
      # |Field		|
      # |Lab field 8	|  	  
	# And I take screenshot 4 of 5
# #DT14219
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7010D		|<null>						|Lab Form 8							|0							|Lab field 8			|1						|<null>						|Lab Form 8							|0							|Lab field 8		|1					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5			
  
# @PB-US12940-11A	
# DT# 14201	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was canceled, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = true.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7011A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7011A"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
    # And I take screenshot 1 of 5	    
	# When I cancel query
      # |Field		|
      # |Lab field 2	| 	  
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 2	|  
	# And I take screenshot 2 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 1	|2		| 	
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 2	| 	  
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 1	|5		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 2	| 		
	# And I take screenshot 4 of 5	  
# DT# 14201	When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7011A		|<null>						|Lab Form 8							|0							|Lab field 2			|3						|<null>						|Lab Form 8							|0							|Lab field 1		|5					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
    # And I take screenshot 5 of 5

# @PB-US12940-11B
# DT# 14201		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was canceled, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7011B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7011B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 1 of 5	    
	# When I cancel query
      # |Field		|
      # |Lab field 4	|  
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 2 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 3	|2		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 4	| 
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 3	|5		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 4	|	
	# And I take screenshot 4 of 5	  
# DT# 14201	When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7011B		|<null>						|Lab Form 8							|0							|Lab field 4			|3						|<null>						|Lab Form 8							|0							|Lab field 3		|5					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5

# @PB-US12940-11C	
# DT# 14201	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was canceled, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7011C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7011C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 5	    
	# When I cancel query
      # |Field		|
      # |Lab field 6	|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 2 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 5	|2		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 5	|5		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 4 of 5	  
# DT# 14201	When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7011C		|<null>						|Lab Form 8							|0							|Lab field 6			|3						|<null>						|Lab Form 8							|0							|Lab field 5		|5					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5
	
# @PB-US12940-11D	
# DT# 14201	
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was canceled, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = true.

	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7011D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7011D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 5	    
	# When I cancel query
      # |Field		|
      # |Lab field 8	|  	  
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 8	|  
	# And I take screenshot 2 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 7	|2		|  	
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 8	|  	  
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 7	|5		|  
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 8	|  		
	# And I take screenshot 4 of 5	  
# DT# 14201	When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7011D		|<null>						|Lab Form 8							|0							|Lab field 8			|3						|<null>						|Lab Form 8							|0							|Lab field 7		|5					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5	
	  
# @PB-US12940-12A	
# DT# 14201	
# Scenario: As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = true.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7012A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7012A"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	# And I take screenshot 1 of 5	    
	# When I cancel query
      # |Field		|
      # |Lab field 2	| 
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 2 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 2	|6		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 2	|  
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 2	|3		| 
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 2	|	
	# And I take screenshot 4 of 5    
# DT# 14201	When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7012A		|<null>						|Lab Form 8							|0							|Lab field 2			|3						|<null>						|Lab Form 8							|0							|Lab field 2		|3					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
    # And I take screenshot 5 of 5

# @PB-US12940-12B	
# DT# 14201	
# Scenario: As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7012B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7012B"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
    # And I take screenshot 1 of 5	    
	# When I cancel query
      # |Field		|
      # |Lab field 4	|  
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 2 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 4	|6		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 4	|3		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 4	|	
	# And I take screenshot 4 of 5    
# DT# 14201	When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
	  # |Standard Study	|S100		  |Site 1	|PROD			|SUB7012B		|<null>						|Lab Form 8							|0							|Lab field 4			|3						|<null>						|Lab Form 8							|0							|Lab field 4		|3					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5

# @PB-US12940-12C	
# DT# 14201	
# Scenario: As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B.  Query with requires response = true and requires manual close = false.

    # And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7012C                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7012C"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 1 of 5	    
	# When I cancel query
      # |Field		|
      # |Lab field 6	|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 2 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 6	|6		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 6	|3		|
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 6	|
	# And I take screenshot 4 of 5    
# DT# 14201	When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7012C		|<null>						|Lab Form 8							|0							|Lab field 6			|3						|<null>						|Lab Form 8							|0							|Lab field 6		|3					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5

# @PB-US12940-12D	
# DT# 14201	
# Scenario: As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7012D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7012D"
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 1 of 5	    
	# When I cancel query
      # |Field		|
      # |Lab field 8	|    
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 8	| 
	# And I take screenshot 2 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 8	|6		|  
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 8	|   
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form	  
      # |Field		|Value  |
      # |Lab field 8	|3		|  
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 8	|  	
	# And I take screenshot 4 of 5    
# DT# 14201	When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName	|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7012D		|<null>						|Lab Form 8							|0							|Lab field 8			|3						|<null>						|Lab Form 8							|0							|Lab field 8		|3					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5
	
# @PB-US12940-13A		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, if I then entered bad data in lab field A, then the system should refire a query on lab field B, then the system should not log a record in the database for those queries that refired.  Query with requires response = true and requires manual close = true.

	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7013A                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7013A"	
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|5		|
      # |Lab field 2	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 2	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|
	# And I take screenshot 1 of 4	  
	# When I cancel query
      # |Field		|
      # |Lab field 2	|	  
	# And I save the form "Lab Form 8"  
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 2 of 4	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 1	|7		|
	# Then I should see open query for the following fields
      # |Field		|
      # |Lab field 2	|
	# And I take screenshot 3 of 4	  
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName		|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7013A		|<null>						|Lab Form 8							|0							|Lab field 2				|3						|<null>						|Lab Form 8							|0							|Lab field 1		|7					|EC37			|Site				|Lab Field 2 must be greater than Lab Field 1. Please verify.	|{DateTime}	|
    # And I take screenshot 4 of 4	

# @PB-US12940-13B		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, if I then entered bad data in lab field A, then the system should refire a query on lab field B, then the system should not log a record in the database for those queries that refired.  Query with requires response = false and requires manual close = false.

	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7013B                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7013B"
	# And I take screenshot 1 of 5	
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|5		|
      # |Lab field 4	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 4	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|
	# And I take screenshot 2 of 5	  
	# When I cancel query
      # |Field		|
      # |Lab field 4	|	  
	# And I save the form "Lab Form 8"  
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 4	|	 
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 3	|7		|
	# Then I should see open query for the following fields
      # |Field		|
      # |Lab field 4	|
	# And I take screenshot 4 of 5	  
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName		|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7013B		|<null>						|Lab Form 8							|0							|Lab field 4				|3						|<null>						|Lab Form 8							|0							|Lab field 3		|7					|EC38			|Site				|Lab Field 4 must be greater than Lab Field 3. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5

# @PB-US12940-13C		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, if I then entered bad data in lab field A, then the system should refire a query on lab field B, then the system should not log a record in the database for those queries that refired.  Query with requires response = true and requires manual close = false.

	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7013C                                                        |		
	# And I am on form "Lab Form 8" for the Subject "SUB7013C"
	# And I take screenshot 1 of 5	
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|5		|
      # |Lab field 6	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 6	|Lab Field 6 must be greater than Lab Field 5. Please verify.	|
	# And I take screenshot 2 of 5	  
	# When I cancel query
      # |Field		|
      # |Lab field 6	|		  
	# And I save the form "Lab Form 8"  
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 6	| 
	# And I take screenshot 3 of 5	  
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 5	|7		|
	# Then I should see open query for the following fields
      # |Field		|
      # |Lab field 6	|	
	# And I take screenshot 4 of 5	  
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName		|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7013C		|<null>						|Lab Form 8							|0							|Lab field 6				|3						|<null>						|Lab Form 8							|0							|Lab field 5		|7					|EC39			|Site				|Lab Field 6 must be greater than Lab Field 5. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5

# @PB-US12940-13D		
# Scenario: As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, if I then entered bad data in lab field A, then the system should refire a query on lab field B, then the system should not log a record in the database for those queries that refired.  Query with requires response = false and requires manual close = true.
	
	# And I create a Subject
	# | Field            | Value                                                          |
	# | Subject Number   | {NextSubjectNum<num1>(Edit Check Study 3,prod,Subject Number)} |
	# | Subject Initials |SUB7013D                                                        |	
	# And I am on form "Lab Form 8" for the Subject "SUB7013D"
	# And I take screenshot 1 of 5	
	# And I have submitted the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|5		|
      # |Lab field 8	|3		|
	# And I see open query for the following fields
      # |Field		|Query Message  												|
      # |Lab field 8	|Lab Field 8 must be greater than Lab Field 7. Please verify.	|
	# And I take screenshot 2 of 5
	# When I cancel query
      # |Field		|
      # |Lab field 8	|		  
	# And I save the form "Lab Form 8"  
	# Then I should not see open query for the following fields
      # |Field		|
      # |Lab field 8	|	 
	# And I take screenshot 3 of 5
	# When I submit the following values for the "Lab Form 8" form
      # |Field		|Value  |
      # |Lab field 7	|7		|
	# Then I should see open query for the following fields
      # |Field		|
      # |Lab field 8	|	
	# And I take screenshot 4 of 5
	# When I run SQL Script "Query Logging Script" 
	# Then I should not see the logging data for queries 
	  # |ProjectName		|SiteNumber   |SiteName	|Environment	|SubjectName	|CheckActionInstanceName	|CheckActionInstanceDataPageName	|CheckActionRecordPosition	|CheckActionFieldName		|CheckActionFieldData	|TriggerFieldInstanceName	|TriggerFieldInstanceDatapageName	|TriggerFieldRecordPosition	|TriggerFieldName	|TriggerFieldData	|EditCheckName	|MarkingGroupName	|QueryMessage													|EventTime	|
      # |Standard Study	|S100		  |Site 1	|PROD			|SUB7013D		|<null>						|Lab Form 8							|0							|Lab field 8				|3						|<null>						|Lab Form 8							|0							|Lab field 7		|7					|EC40			|Site				|Lab Field 8 must be greater than Lab Field 7. Please verify.	|{DateTime}	|
	# And I take screenshot 5 of 5