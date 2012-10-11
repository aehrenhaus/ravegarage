# The logic that is used to determine when a query that has already been cancelled or closed should or should not be re-fired in Rave 
# will be examining the answered query data instead of the original query data.

#TESTING FOR LOG FORM WITH 2 FIELDS INVOLVED IN QUERY FIRING

# project to be uploaded in excel spreadsheet 'Standard Study'

Feature: 564QueryRefiringLogic_LogForm_2FldEC
    Query Refiring Logic
	As a Rave user
	When I manually close a query or cancel, the query should not re-fire if the exact same data is entered into the system
	So that I don't have to re-enter the exact same response

Background:  
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Study assignments exist
		| User   | Stud           | Role | Site   | Site Number |
		| User 1 | Standard Study | cdm1 | Site 1 | S100        |
	And Role "cdm1" has Action "Query"
	And Study "Standard Study" has Draft "<Draft1>"
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Study "Standard Study"
	And I select Study "Standard Study" and Site "Site 1"	

@release_564_Patch11
@PB-US12940-01A
@validation	
Scenario: @PB-US12940-01A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I entered good data in log field B and then again entered the same bad data in log field B as when the query was closed, then the system should not refire a query on log field B. 
Query with requires response = true and requires manual close = true.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB               |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	And I enter data in CRF
	  |Field		|Data   |
      |Log Field 1	|5		|
      |Log Field 2	|4		|
	When I save the CRF page
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  |  
	And I take a screenshot
	When I answer the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2" with "Data will be changed."
	And I enter data in CRF	  
      | Field       | Data |
      | Log Field 2 | 3    |		  
	And I save the CRF page  
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | True     | False  |
	And I take a screenshot 	  
	When I close the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2"
	And I save the CRF page 
	And I open log line 1	  
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | True     | True   |
	And I take a screenshot 	  
	When I enter data in CRF
       | Field       | Data |
       | Log Field 2 | 5    |	   
	And I save the CRF page
	And I open log line 1
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered  | Closed  |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False     | False   |
	And I take a screenshot	
	When I enter data in CRF
      | Field       | Data |
      | Log Field 2 | 3    |
	And I save the CRF page	
	And I open log line 1	 
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed  |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False     | False  |	
	And I take a screenshot 	
 
@release_564_Patch11
@PB-US12940-01B
@validation
Scenario: @PB-US12940-01B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I changed the data in log field B to another bad data, and the new query will open, if I entered good data in log field B and then again entered the same bad data in log field B as when the query was closed, then the system should refire a query on log field B. 
Query with requires response = false and requires manual close = false.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB               |
	  | Subject ID       | SUB {Var(num1)}   |                                         
	And I select Form "Form 9"
	And I enter data in CRF	
      | Field       | Data |
      | Log Field 3 | 5    |
      | Log Field 4 | 4    |
	When I save the CRF page
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |  
	And I take a screenshot 	  	
	When I enter data in CRF  
      | Field       | Data |
      | Log Field 4 | 3    |
	And I save the CRF page
	And I open log line 1	
	Then I verify Query is displayed	   
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |
	And I take a screenshot 		  
	And  I enter data in CRF	  
      | Field       | Data |
      | Log Field 4 | 5    |
	When I save the CRF page
	And I open log line 1		
	Then I verify Query is not displayed
	  | Field       | Message                                                  |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | 
	And I take a screenshot 		  
	And  I enter data in CRF	  
      | Field       | Data |
      | Log Field 4 | 3    |
	When I save the CRF page
	And I open log line 1		
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |
	And I take a screenshot 	

@release_564_Patch11
@PB-US12940-01C	
@ignore
# Due to DT 14208 
Scenario: @PB-US12940-01C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I entered good data in log field B and then again entered the same bad data in log field B as when the query was closed, then the system should refire a query on log field B. 
Query with requires response = true and requires manual close = false.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9001C          |
	  | Subject ID       | SUB {Var(num1)}   | 
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 5 | 5    |
      | Log Field 6 | 4    |
    And I save the CRF page 
	And I open log line 1 
	Then I verify Query is displayed	   
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |
	And I take a screenshot 
	When I answer the Query "Log field 6 must be equal to Log field 5. Please verify." on Field "Log Field 6" with "Data will be changed."
	And I enter data in CRF	  
      | Field       | Data |
      | Log Field 6 | 3    |	  
    And I save the CRF page 
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |
	And I take a screenshot 	
	When I enter data in CRF    		  	  
      | Field       | Data |
      | Log Field 6 | 5    |
	And I save the CRF page 
	And I open log line 1
	Then I verify Query is not displayed
	 | Field       | Message                                                  | Answered | Closed |
	 | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  | 
	And I take a screenshot 
	And I enter data in CRF    		  	  
      | Field       | Data |
      | Log Field 6 | 3    |
	And I save the CRF page 
	And I open log line 1		  
	Then I verify Query is not displayed
	 | Field       | Message                                                  | Answered | Closed |
	 | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |
	And I take a screenshot 	
# DT 14208
		
@release_564_Patch11
@PB-US12940-01D
@validation 
Scenario: @PB-US12940-01D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I entered good data in log field B and then again entered the same bad data in log field B as when the query was closed, then the system should not refire a query on log field B. 
Query with requires response = false and requires manual close = true
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9001D          |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |  
      | Log Field 7 | 5    |
      | Log Field 8 | 4    |
	And I save the CRF page 
	And I open log line 1		  
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  |
	And I take a screenshot 	  
	When I enter data in CRF	  
      | Field       | Data |
      | Log Field 8 | 3    |		  
	And I save the CRF page 
	And I open log line 1 
	Then I verify Query is displayed
      | Field       | Message                                                  | Answered | Closed |
      | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | False  |
	And I take a screenshot 		  
	When I close the Query "Log field 8 must be equal to Log field 7. Please verify." on Field "Log Field 8"
	And I save the CRF page 
	And I open log line 1 	  
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | True   |	  
	And I take a screenshot 
	When I enter data in CRF	  
      | Field       | Data |
      | Log Field 8 | 5    |	 
	And I save the CRF page 
	And I open log line 1 	
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  | 
	And I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | True   | 
	And I take a screenshot 	  
	When I enter data in CRF	  
      | Field       | Data |
      | Log Field 8 | 3    |	 
	And I save the CRF page 
	And I open log line 1 
	Then I verify Query is displayed  
      | Field       | Message                                                  | Answered | Closed |
      | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | True   |	 	 	  
	And I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  | 
	And I take a screenshot	
	 
@release_564_Patch11
@PB-US12940-02A
@validation
Scenario: @PB-US12940-02A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I then entered the original bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = true and requires manual close = true
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9002A          |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |  
      | Log Field 1 | 5    |
      | Log Field 2 | 4    |
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  |	                                                      
	And I take a screenshot 
	When I answer the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2" with "Data will be changed."
	And I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 2 | 3    |		  
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
      | Field       | Message                                                  | Answered | Closed |
      | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | True     | False  |
	And I take a screenshot 
	When I close the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2"
	And I save the CRF page 
	And I open log line 1
	Then I verify Query is displayed
      | Field       | Message                                                  | Answered | Closed |
      | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | True     | True   |	 		  
    And I take a screenshot		  
	When I enter data in CRF  
      | Field       | Data |
      | Log Field 2 | 5    |
	And I save the CRF page 
	And I open log line 1
	Then I verify Query is not displayed
      | Field       | Message                                                  | Answered | Closed | 
      | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  | 	 
	And I take a screenshot 		  
	When I enter data in CRF  
      | Field       | Data |
      | Log Field 2 | 4    | 
    And I save the CRF page 
	And I open log line 1
	Then I verify Query is displayed
      | Field       | Message                                                  | Answered | Closed |
      | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  |	  		  
	And I take a screenshot 
	
@release_564_Patch11
@PB-US12940-02B
@validation		
Scenario: @PB-US12940-02B	As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I then entered the original bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = false and requires manual close = false.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9002B          |
	  | Subject ID       | SUB {Var(num1)}   |  
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 3 | 5    |
      | Log Field 4 | 4    |                                        
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |	                                                      
	And I take a screenshot 
	When I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 4 | 3    |		  
	And I save the CRF page 
	And I open log line 1	  
    Then I verify Query is displayed
      | Field       | Message                                                  | Answered  | Closed |
      | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False     | False  |
	When I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 4 | 5    |		  
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is not displayed
      | Field       | Message                                                  | Answered  | Closed |
      | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False     | False  | 	  
	And I take a screenshot		  
	When I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 4 | 4    |		  
	And I save the CRF page 
	And I open log line 1	  
    Then I verify Query is displayed
      | Field       | Message                                                  | Answered  | Closed |
      | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False     | False  |
    And I take a screenshot 
			
@release_564_Patch11
@PB-US12940-02C
@ignore
# Failed due to DT 14208		
Scenario: @PB-US12940-02C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I then entered the original bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = true and requires manual close = false.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9002C          |
	  | Subject ID       | SUB {Var(num1)}   | 
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 5 | 5    |
      | Log Field 6 | 4    |       	
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |
	And I take a screenshot
	When I answer the Query "Log field 6 must be equal to Log field 5. Please verify." on Field "Log Field 6" with "Data will be changed."
	And I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 6 | 3    |		  
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
      | Field       | Message                                                  | Answered | Closed |
      | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |	  
	And I take a screenshot
	# DT 14208	
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 6 | 5    | 	  
    And I save the CRF page 
	And I open log line 1
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed |
      | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  | 		
    And I take a screenshot 
	When I enter data in CRF		    
      | Field       | Data |
      | Log Field 6 | 4    |	
	And I save the CRF page 
	And I open log line 1
	Then I verify Query is displayed 
	   | Field       | Message                                                  | Answered | Closed |
	   | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |
	And I take a screenshot    
			
@release_564_Patch11
@PB-US12940-02D
@validation	
Scenario: @PB-US12940-02D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I then entered the original bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Initials | SUB9002D          |	  
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject ID       | SUB {Var(num1)}   | 
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 7 | 5    |
      | Log Field 8 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  |
    And I take a screenshot
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 8 | 3    |
	And I save the CRF page 
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | False  |
    And I take a screenshot
	When I close the Query "Log field 8 must be equal to Log field 7. Please verify." on Field "Log Field 8"
	And I save the CRF page 
	And I open log line 1
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  |
    And I take a screenshot
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 8 | 5    | 	  
    And I save the CRF page 
	And I open log line 1
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  |
    And I take a screenshot
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 8 | 4    | 	  
    And I save the CRF page 
	And I open log line 1 
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  |   

@release_564_Patch11
@PB-US12940-03A
@validation
Scenario: @PB-US12940-03A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = true and requires manual close = true.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9003A          |
	  | Subject ID       | SUB {Var(num1)}   |  	
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 1 | 5    |
      | Log Field 2 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2" with "Data will be changed."
	And I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 2 | 3    |		  
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | True     | False  |
    And I take a screenshot  
	When I close the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2" 
    And I save the CRF page 
	And I open log line 1
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  |
    And I take a screenshot
	And I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 2 | 5    |		  
	And I save the CRF page 
	And I open log line 1
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  |
    And I take a screenshot
	And I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 2 | 7    |		  
	And I save the CRF page 
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  |		
	And I take a screenshot	 

@release_564_Patch11
@PB-US12940-03B
@validation		
Scenario: @PB-US12940-03B	 As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = false and requires manual close = false.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9003B          |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 3 | 5    |
      | Log Field 4 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |  	
	And I take a screenshot	  
	And I enter data in CRF	  	  	  
      | Field       | Data |
      | Log Field 4 | 7    |		  
	And I save the CRF page 
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |
	And I take a screenshot  

@release_564_Patch11
@PB-US12940-03C
@validation	
Scenario: @PB-US12940-03C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = true and requires manual close = false
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9003C          |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 5 | 5    |
      | Log Field 6 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |
	And I take a screenshot
	When I answer the Query "Log field 6 must be equal to Log field 5. Please verify." on Field "Log Field 6" with "Data will be changed."
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  | 
	And I take a screenshot	 
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 6 | 7    |
    And I save the CRF page 
	And I open log line 1	   
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |
	And I take a screenshot 

@release_564_Patch11
@PB-US12940-03D
@validation	
Scenario: @PB-US12940-03D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9003D          |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 7 | 5    |
      | Log Field 8 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  |	
    And I take a screenshot	
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 8 | 7    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed  
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | False  |
	And I take a screenshot 

@release_564_Patch11
@PB-US12940-04A	
@validation	
Scenario: @PB-US12940-04A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the new bad data in log field A, then the system should refire a query on log field B. 
Query with requires response = true and requires manual close = true
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9004A          |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 1 | 5    |
      | Log Field 2 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  |
    And I take a screenshot	
	When I answer the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2" with "Data will be changed."
	And I enter data in CRF	
      | Field       | Data |
      | Log Field 1 | 3    |
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | True     | False  |   
    And I take a screenshot 		  
	When I close the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2" 
    And I save the CRF page 
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | True     | True   |   	  
	And I take a screenshot 
	And I enter data in CRF	
      | Field       | Data |
      | Log Field 1 | 7    |
	And I save the CRF page 
	And I open log line 1			  
    Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  | 
	And I take a screenshot

@release_564_Patch11
@PB-US12940-04B
@ignore
# DT14207		
Scenario: @PB-US12940-04B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the new bad data in log field A, then the system should refire a query on log field B. 
Query with requires response = false and requires manual close = false
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9004B          |
	  | Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 3 | 5    |
      | Log Field 4 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |
	And I take a screenshot 
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 3 | 3    |
    And I save the CRF page 
	And I open log line 1
	#DT 14207	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |
	And I take a screenshot 	  
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 3 | 7    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |
	And I takea screenshot 

@release_564_Patch11	
@PB-US12940-04C
@ignore 
# failing due to DT 14208	
Scenario: @PB-US12940-04C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the new bad data in log field A, then the system should refire a query on log field B. 
Query with requires response = true and requires manual close = false
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9004C          |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 5 | 5    |
      | Log Field 6 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Log field 6 must be equal to Log field 5. Please verify." on Field "Log Field 6" with "Data will be changed."
    And I enter data in CRF	
      | Field       | Data |
      | Log Field 5 | 3    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | True     | True   |
	# DT 14208
	And I take a screenshot
	And I enter data in CRF	
      | Field       | Data |
      | Log Field 5 | 7    |
    And I save the CRF page 
	And I open log line 1	  		  
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |
	And I take a screenshot 		

@release_564_Patch11		
@PB-US12940-04D	
@ignore	
# Failed due to DT 14207
Scenario: @PB-US12940-04D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the new bad data in log field A, then the system should refire a query on log field B. 
Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9004D          |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 7 | 5    |
      | Log Field 8 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  |
	And I take a screenshot
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 7 | 3    |  
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | False  |
	And I take a screenshot 
	When I close the Query "Log field 8 must be equal to Log field 7. Please verify." on Field "Log Field 8"
	  # DT 14207
	And I save the CRF page 
	Then I verify Query is not displayed
	  | Field       | Message                                                  | Answered  | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False     | False  |	  
	And I take a screenshot
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 7 | 7    | 
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  |	  	  
	And I take a screenshot 
	
@release_564_Patch11
@PB-US12940-05A
@validation	
Scenario: @PB-US12940-05A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I then entered the new bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = true and requires manual close = true.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Initials | SUB9005A          |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 1 | 5    |
      | Log Field 2 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2" with "Data will be changed."
    And I enter data in CRF	
      | Field       | Data |
      | Log Field 2 | 3    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed  |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | True     | False   |  
	And I take a screenshot		  
	When I close the Query "Log field 2 must be equal to Log field 1. Please verify." on Field "Log Field 2" 
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed  |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | True     | True    |
	And I take a screenshot		
	And I enter data in CRF	
      | Field       | Data |
      | Log Field 2 | 7    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed  |
	  | Log Field 2 | Log field 2 must be equal to Log field 1. Please verify. | False    | False   |  
	And I take a screenshot	

@release_564_Patch11
@PB-US12940-05B
@validation	
Scenario: @PB-US12940-05B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I then entered the new bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = false and requires manual close = false
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Initials | SUB9005B          |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 3 | 5    |
      | Log Field 4 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |
	And I take a screenshot	 
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 4 | 3    | 
	And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |
	And I take a screenshot		
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 4 | 7    |
    And I save the CRF page 
	And I open log line 1	  
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 4 | Log field 4 must be equal to Log field 3. Please verify. | False    | False  |	  
	And I take a screenshot	

@release_564_Patch11		
@PB-US12940-05C	
@ignore
# failing due to DT 14208	
Scenario: @PB-US12940-05C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I then entered the new bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = true and requires manual close = false.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9005C          |
	  | Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 5 | 5    |
      | Log Field 6 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |
	And I take a screenshot	 
	When I answer the Query "Log field 6 must be equal to Log field 5. Please verify." on Field "Log Field 6" with "Data will be changed."
    And I enter data in CRF	
      | Field       | Data |
      | Log Field 6 | 3    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | True     | True   |
	And I take a screenshot	 
	#DT 14208
	 And I enter data in CRF	
      | Field       | Data |
      | Log Field 6 | 7    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed		  	  
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 6 | Log field 6 must be equal to Log field 5. Please verify. | False    | False  |
	And I take a screenshot	

@release_564_Patch11
@PB-US12940-05D
@validation	
Scenario: @PB-US12940-05D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field B to another bad data, and the query is then closed, if I then entered the new bad data in log field B, then the system should refire a query on log field B. 
Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB9005D          |
	  | Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 9"
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 7 | 5    |
      | Log Field 8 | 4    |
    And I save the CRF page 
	And I open log line 1	
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 8 | 3    |
    And I save the CRF page 
	And I open log line 1	  
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | False  |
	And I take a screenshot	
	When I close the Query "Log field 8 must be equal to Log field 7. Please verify." on Field "Log Field 8"
	And I save the CRF page 
	And I open log line 1
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | True     | True   |
	And I take a screenshot		  
	When I enter data in CRF	
      | Field       | Data |
      | Log Field 8 | 7    |
    And I save the CRF page 
	And I open log line 1	  
	Then I verify Query is displayed
	  | Field       | Message                                                  | Answered | Closed |
	  | Log Field 8 | Log field 8 must be equal to Log field 7. Please verify. | False    | False  |
	And I take a screenshot		