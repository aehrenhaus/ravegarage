# The logic that is used to determine when a query that has already been cancelled or closed should or should not be re-fired in Rave 
# will be examining the answered query data instead of the original query data.

#TESTING FOR LOG FORM WITH MULTIPLE FIELDS INVOLVED IN QUERY FIRING

#-- project to be uploaded in excel spreadsheet 'Standard Study'
Feature: QueryRefiringLogic_LogForm_MultiFldEC
	As a Rave user
	When I manually close a query or cancel, the query should not re-fire if the exact same data is entered into the system
	So that I don't have to re-enter the exact same response

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Study assignments exist
		|User	|Study		    |Role |Site	  |Site Number	|
		|User 1 |Standard Study	|cdm1 |Site 1 |S100			|
	And I select Study "Standard Study" and Site "Site 1"

@release_564_Patch11
@PB_US12940_01A	
@Validation	
Scenario: PB_US12940_01A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was closed, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 1 |       |
      | Log Field 2 | data2 |
      | Log Field 3 | data3 |	
	And I open log line 1  
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot
	And I answer the Query "Answer must be provided. Please review." on Field "Log Field 3" with "Data will be changed."
	And I save the CRF page  
	And I take a screenshot
	And I open log line 1
	And I close the Query "Answer must be provided. Please review." on Field "Log Field 3"
	And I save the CRF page 
	And I open log line 1 	  
	And I verify Query is not displayed
      | Field       | Message                                 | Closed |
      | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 1 | data1 |	
	And I open log line 1
	And I verify Query is not displayed
      | Field       | Message                                 | Closed |
      | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot
	And I enter data in CRF and save
      | Field       | Data |
      | Log Field 1 |      |
	And I open log line 1
	And I verify Query is not displayed
      | Field       | Message                                 | Closed |
      | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_01B	
@Validation	
Scenario: PB_US12940_01B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was closed, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 4 |       |
      | Log Field 5 | data5 |
      | Log Field 6 | data6 | 
	And I open log line 1  
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 6 | Answer must be provided. Please review. | false  |
	And I take a screenshot
	And I enter data in CRF and save
      | Field       | Data  |
      |Log Field 4	|data4	|
	And I open log line 1
	And I verify Query is not displayed
      | Field       | Query Message                           | Closed |
      | Log Field 6 | Answer must be provided. Please review. | false  |
	And I take a screenshot
	And I enter data in CRF and save
      | Field       | Data |
      | Log Field 4 |      | 
	And I open log line 1 
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 6 | Answer must be provided. Please review. | false  |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_01C	
@Validation	
Scenario: PB_US12940_01C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was closed, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 7 |       |
      | Log Field 8 | data8 |
      | Log Field 9 | data9 |	 
	And I open log line 1  
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 9 | Answer must be provided. Please review. | false  |
	And I take a screenshot	  
	And I answer the Query "Answer must be provided. Please review." on Field "Log Field 9" with "Data will be changed."
	And I save the CRF page
	And I open log line 1
	And I verify Query is not displayed
      | Field       | Query Message                           | Closed |
      | Log Field 9 | Answer must be provided. Please review. | false  |
	And I take a screenshot
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 7 | data7 |
	And I open log line 1
	And I verify Query is not displayed
      |Field		| Query Message                           | Closed |
      |Log Field 9	| Answer must be provided. Please review. | false  |	
	And I take a screenshot
	And I enter data in CRF and save
      | Field       | Data |
      | Log Field 7 |      |
	And I open log line 1
	And I verify Query is not displayed
      |Field		| Query Message                           | Closed |
      |Log Field 9	| Answer must be provided. Please review. | false  |	  	
	And I take a screenshot

@release_564_Patch11
@PB_US12940_01D
@Validation
@ignore
#Failing DT#14207			
Scenario: PB_US12940_01D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was closed, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field        | Data   |
      | Log Field 10 |        |
      | Log Field 11 | data11 |
      | Log Field 12 | data12 |
	And I open log line 1
	And I verify Query is displayed
      | Field        | Query Message                           | Closed |
      | Log Field 12 | Answer must be provided. Please review. | false  |
	And I take a screenshot	  	  
	And I enter data in CRF and save
      | Field        | Data   |
      | Log Field 10 | data10 |	
	And I open log line 1
	And I verify Query is displayed
         | Field        | Message                                 | Closed | Answered |
         | Log Field 12 | Answer must be provided. Please review. | false   | true     |
	And I take a screenshot
	And I close the Query "Answer must be provided. Please review." on Field "Log Field 12"
	And I open log line 1
	And I verify Query is not displayed
	  |Field		| Query Message                           | Closed |
	  |Log Field 12 | Answer must be provided. Please review. | false  |
	And I take a screenshot
	And I enter data in CRF and save
      | Field        | Data |
      | Log Field 10 |      |
	And I open log line 1		  
	And I verify Query is displayed
      |Field		| Query Message                           | Closed |		  
      |Log Field 12	| Answer must be provided. Please review. | false  |	
	And I take a screenshot 	

@release_564_Patch11
@PB_US12940_02A	
@Validation	
Scenario: PB_US12940_02A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was closed, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 1 | data1 |
      | Log Field 2 | data2 |
      | Log Field 3 |       |
	And I open log line 1
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot	    
	And I answer the Query "Answer must be provided. Please review." on Field "Log Field 3" with "Data will be changed."
	And I save the CRF page
	And I open log line 1
	And I close the Query "Answer must be provided. Please review." on Field "Log Field 3"
	And I save the CRF page  
	And I open log line 1		  
	And I verify Query is not displayed
      | Field       | Message                                 | Closed |
      | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot 
	And I open log line 1		
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 3 | data3 |
	And I open log line 1
	And I verify Query is not displayed
      | Field       | Message                                 | Closed |
      | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot
  	And I open log line 1
	And I enter data in CRF and save
      | Field       | Data |
      | Log Field 3 |      |	
	And I open log line 1
	And I verify Query is not displayed
      | Field       | Message                                 | Closed |
      | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot 	

@release_564_Patch11
@PB_US12940_02B	
@Validation	
Scenario: PB_US12940_02B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was closed, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 4 | data4 |
      | Log Field 5 | data5 |
      | Log Field 6 |       |
	And I open log line 1  
	And I verify Query is displayed
      | Field       | Query Message                           | CLosed |
      | Log Field 6 | Answer must be provided. Please review. | false  |
	And I take a screenshot 	     	  
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 6 | data6 |
	And I open log line 1 	
	And I verify Query is not displayed
      | Field       | Query Message                           | CLosed |
      | Log Field 6 | Answer must be provided. Please review. | false  |
	And I take a screenshot 	 	  	
	And I enter data in CRF and save
      | Field       | Data |
      | Log Field 6 |      |
	And I open log line 1
	And I verify Query is displayed	  
      | Field       | Query Message                           | CLosed |
      | Log Field 6 | Answer must be provided. Please review. | false  |
	And I take a screenshot 	

@release_564_Patch11
@PB_US12940_02C
@Validation		
Scenario: PB_US12940_02C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was closed, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 7 | data7 |
      | Log Field 8 | data8 |
      | Log Field 9 |       | 
	And I open log line 1  
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 9 | Answer must be provided. Please review. | false  |
	And I take a screenshot	    
	And I answer the Query "Answer must be provided. Please review." on Field "Log Field 9" with "Data will be changed."
	And I save the CRF page 
	And I open log line 1  
	And I verify Query is not displayed
      | Field       | Message                                 | Closed |
      | Log Field 9 | Answer must be provided. Please review. | false  |
	And I take a screenshot 	 	  
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 9 | data9 |
	And I open log line 1
	And I verify Query is not displayed
      | Field       | Message                                 | Closed |
      | Log Field 9 | Answer must be provided. Please review. | false  |
	And I take a screenshot	 	  	
	And I enter data in CRF and save
      | Field       | Data |
      | Log Field 9 |      |
	And I open log line 1
	And I verify Query is not displayed
      | Field       | Message                                 | Closed |
      | Log Field 9 | Answer must be provided. Please review. | false  |
	And I take a screenshot
	 	
@release_564_Patch11
@PB_US12940_02D	
@Validation	
Scenario: PB_US12940_02D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was closed, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field        | Data   |
      | Log Field 10 | data10 |
      | Log Field 11 | data11 |
      | Log Field 12 |        |	 
	And I open log line 1  
	And I verify Query is displayed
      | Field        | Query Message                           | Closed |
      | Log Field 12 | Answer must be provided. Please review. | false  |
	And I take a screenshot	    	    
	And I enter data in CRF and save
      | Field        | Data   |
      | Log Field 12 | data12 |	
	And I open log line 1 
	And I verify Query is displayed
      | Field        | Query Message                           | Closed |
      | Log Field 12 | Answer must be provided. Please review. | false  |
	And I take a screenshot 	 
	And I close the Query "Answer must be provided. Please review." on Field "Log Field 12"
	And I save the CRF page  
	And I open log line 1	  
	And I verify Query is not displayed
      | Field        | Query Message                           | Closed |
      | Log Field 12 | Answer must be provided. Please review. | false  |	
	And I take a screenshot	  	
	And I enter data in CRF and save
      | Field        | Data |
      | Log Field 12 |      |
	And I open log line 1	
	And I verify Query is displayed	  
      | Field        | Query Message                           | Closed |
      | Log Field 12 | Answer must be provided. Please review. | false  |
	And I take a screenshot 

@release_564_Patch11	
@PB_US12940_03A
@Validation		
Scenario: PB_US12940_03A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I entered good data in log field A and then again entered the same bad data in log field A as when the query was closed, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 1 |       |
      | Log Field 2 | data2 |
      | Log Field 3 | data3 |
	And I open log line 1	 
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot    
	And I answer the Query "Answer must be provided. Please review." on Field "Log Field 3" with "Data will be changed."
	And I enter data in CRF and save	  
      | Field       | Data  |
      | Log Field 1 | data1 |
      | Log Field 2 |       |
	And I open log line 1  
	And I verify Query is displayed
      | Field       | Message                                 | Closed | Answered |
      | Log Field 3 | Answer must be provided. Please review. | false  | true     |	  
	And I take a screenshot  
	And I close the Query "Answer must be provided. Please review." on Field "Log Field 3"
	And I save the CRF page
	And I open log line 1  	  
	And I verify Query is not displayed
	  | Field       | Query Message                           | Closed |
	  | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot  
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 2 | Data2 |
	And I open log line 1
	And I verify Query is not displayed
	  | Field       | Query Message                           | Closed |
	  | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot  
	And I enter data in CRF and save
      | Field       | Data |
      | Log Field 2 |      |
	And I open log line 1
	And I verify Query is not displayed
	  | Field       | Query Message                           | Closed |
	  | Log Field 3 | Answer must be provided. Please review. | false  | 
	And I take a screenshot  

@release_564_Patch11
@PB_US12940_03B
@Validation		
Scenario: PB_US12940_03B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I entered good data in log field A and then again entered the same bad data in log field A as when the query was closed, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 4 |       |
      | Log Field 5 | data5 |
      | Log Field 6 | data6 |	 
	And I open log line 1  
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 6 | Answer must be provided. Please review. | false  |
	And I take a screenshot	    
	And I enter data in CRF and save	  
      | Field       | Data  |
      | Log Field 4 | data4 |
      | Log Field 5 |       |
	And I open log line 1	  
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 6 | Answer must be provided. Please review. | false  | 
	And I take a screenshot 
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 5 | Data5 |
	And I open log line 1
	And I verify Query is not displayed
      | Field       | Query Message                           | Closed |
      | Log Field 6 | Answer must be provided. Please review. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field       | Data |
      | Log Field 5 |      |	  
	And I open log line 1
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 6 | Answer must be provided. Please review. | false  |
	And I take a screenshot 	  

@release_564_Patch11
@PB_US12940_03C	
@Validation
@ignore
#Failing DT#14208	
Scenario: PB_US12940_03C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I entered good data in log field A and then again entered the same bad data in log field A as when the query was closed, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 7 |       |
      | Log Field 8 | data8 |
      | Log Field 9 | data9 | 
	And I open log line 1	 
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 9 | Answer must be provided. Please review. | false  |
	And I take a screenshot	    
	And I answer the Query "Answer must be provided. Please review." on Field "Log Field 9" with "Data will be changed."
	And I enter data in CRF and save	  
      | Field       | Data  |
      | Log Field 7 | data7 |
      | Log Field 8 |       |   
	And I open log line 1	 
#DT#14208	And I verify Query is not displayed
      | Field       | Query Message                           | Closed |
      | Log Field 9 | Answer must be provided. Please review. | true   |	  
	And I take a screenshot 	 	  
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 8 | Data8 |
	And I open log line 1	 
	And I verify Query is not displayed
      | Field       | Query Message                           | Closed |
      | Log Field 9 | Answer must be provided. Please review. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data  |
      |Log Field 8	|	|   
	And I open log line 1	 
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 9 | Answer must be provided. Please review. | false  |
	And I take a screenshot 	  

@release_564_Patch11
@PB_US12940_03D
@Validation
@ignore
#Failing DT#14207		
Scenario: PB_US12940_03D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I entered good data in log field A and then again entered the same bad data in log field A as when the query was closed, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      |Field		|Data  |
      |Log Field 10	|	|
      |Log Field 11	|data11	|
      |Log Field 12	|data12	|	 
	And I open log line 1	 
	And I verify Query is displayed
      | Field        | Query Message                           | Closed |
      | Log Field 12 | Answer must be provided. Please review. | false  |
	And I take a screenshot    
	And I enter data in CRF and save	  
      |Field		|Data  |
      |Log Field 10	|data10	|
      |Log Field 11	|	|	  
	And I open log line 1  
	And I verify Query is displayed
      | Field        | Message                                 | Closed | Answered |
      | Log Field 12 | Answer must be provided. Please review. | false  | true     |	 	  
	And I take a screenshot  
	And I close the Query "Answer must be provided. Please review." on Field "Log Field 12"
	And I save the CRF page  	  
	And I open log line 1	 
	And I verify Query is not displayed
      | Field        | Query Message                           | Closed |
      | Log Field 12 | Answer must be provided. Please review. | false  | 	
	And I take a screenshot  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Log Field 11	|Data11	|
	And I open log line 1	 
	And I verify Query is not displayed
      | Field        | Query Message                           | Closed |
      | Log Field 12 | Answer must be provided. Please review. | false  | 
	And I take a screenshot  
	And I enter data in CRF and save
      |Field		|Data  |
      |Log Field 11	|	|  
	And I open log line 1	 
	And I verify Query is not displayed
      | Field        | Query Message                           | Closed |
      | Log Field 12 | Answer must be provided. Please review. | false  | 	  
	And I take a screenshot

@release_564_Patch11	
@PB_US12940_04A	
@Validation	
Scenario: PB_US12940_04A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the original bad data in log field A, then the system should refire a query on log field B. Query with requires response = true and requires manual close = true.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 1 |       |
      | Log Field 2 | data2 |
      | Log Field 3 | data3 |
	And I open log line 1
    And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 3	|Answer must be provided. Please review.	|false   |false   |	  
	And I take a screenshot	
	And I answer the Query "Answer must be provided. Please review." on Field "Log Field 3" with "Data will be changed."
	And I enter data in CRF and save  
      | Field       | Data  |
      | Log Field 1 | data1 |
      | Log Field 2 |       |
	And I open log line 1  
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 3	|Answer must be provided. Please review.	|true    |false   |
	And I take a screenshot
	And I close the only Query on Field "Log Field 3"	  
	And I save the CRF page 
	And I open log line 1 
	And I verify closed Query with message "Answer must be provided. Please review." is displayed on Field "Log Field 3"
	And I take a screenshot		  
	When I enter data in CRF and save  
      | Field       | Data  |
      | Log Field 1 |       |
      | Log Field 2 | data2 |
	And I open log line 1  
	Then I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 3	|Answer must be provided. Please review.	|false   |false   |
	And I take a screenshot  

@release_564_Patch11   
@PB_US12940_04B
@Validation
@ignore
#Failing DT#14207		
Scenario: PB_US12940_04B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the original bad data in log field A, then the system should refire a query on log field B. Query with requires response = false and requires manual close = false.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 4 |       |
      | Log Field 5 | data5 |
      | Log Field 6 | data6 | 
	And I open log line 1
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 6	|Answer must be provided. Please review.	|false   |false   |
	And I take a screenshot		    
	And I enter data in CRF and save 
      | Field       | Data  |
      | Log Field 4 | data4 |
      | Log Field 5 |       |
	And I open log line 1	    
	Then I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 6	|Answer must be provided. Please review.	|false   |false   |
	And I take a screenshot		  	  
	When I enter data in CRF and save 
      |Field		|Data   |
      |Log Field 4	||
      |Log Field 5	|data5	|
	And I open log line 1  
	Then I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 6	|Answer must be provided. Please review.	|false   |false   | 
	And I take a screenshot		 

@release_564_Patch11
@PB_US12940_04C	
@Validation	
Scenario: PB_US12940_04C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the original bad data in log field A, then the system should refire a query on log field B. Query with requires response = true and requires manual close = false.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 7 |       |
      | Log Field 8 | data8 |
      | Log Field 9 | data9 |
	And I open log line 1 
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|false   |false   |	  
	And I take a screenshot
	And I answer the Query "Answer must be provided. Please review." on Field "Log Field 9" with "Data will be changed."
	And I enter data in CRF and save	  
      | Field       | Data  |
      | Log Field 7 | data7 |
      | Log Field 8 |       |
	And I open log line 1	
    And I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|true    |true    |	  	  
	And I take a screenshot		  	  
	When I enter data in CRF and save
      | Field       | Data  |
      | Log Field 7 |       |
      | Log Field 8 | data8 |
	And I open log line 1  	  
	Then I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|false   |false   |	 
	And I take a screenshot		 

@release_564_Patch11
@PB_US12940_04D
@Validation
@ignore
#Failing DT#14207		
Scenario: PB_US12940_04D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the original bad data in log field A, then the system should refire a query on log field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field        | Data   |
      | Log Field 10 |        |
      | Log Field 11 | data11 |
      | Log Field 12 | data12 |
	And I open log line 1
    And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 12	|Answer must be provided. Please review.	|false   |false   |	  
	And I take a screenshot		    
	And I enter data in CRF and save	  
      | Field        | Data   |
      | Log Field 10 | data10 |
      | Log Field 11 |        |
	And I open log line 1
	And I verify Query is displayed
      | Field        | Query Message                           | Answered | Closed |
      | Log Field 12 | Answer must be provided. Please review. | false    | false  |	  
	And I take a screenshot	
	And I close the only Query on Field "Log Field 12"
	And I close the Query "Answer must be provided. Please review." on Field "Log Field 12"
	And I save the CRF page
	And I open log line 1 
	And I verify closed Query with message "Answer must be provided. Please review." is displayed on Field "Log Field 12"
	And I take a screenshot		  
	When I enter data in CRF and save
      | Field        | Data   |
      | Log Field 10 |        |
      | Log Field 11 | data11 |
	And I open log line 1	  
	Then I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 12	|Answer must be provided. Please review.	|false   |false   |	   
	And I take a screenshot		 

@release_564_Patch11  
@PB_US12940_05A
@Validation		
Scenario: PB_US12940_05A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field A, then the system should refire a query on log field B. Query with requires response = true and requires manual close = true.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 1 |       |
      | Log Field 2 | data2 |
      | Log Field 3 | data3 |
	And I open log line 1 
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 3	|Answer must be provided. Please review.	|false   |false   |
	And I take a screenshot	
	And I answer the Query "Answer must be provided. Please review." on Field "Log Field 3" with "Data will be changed."
	And I save the CRF page  
	And I take a screenshot
	And I open log line 1
	And I close the only Query on Field "Log Field 3"	  
	And I save the CRF page 
	And I open log line 1 
	And I verify closed Query with message "Answer must be provided. Please review." is displayed on Field "Log Field 3"
	And I take a screenshot 
	When I enter data in CRF and save
      | Field       | Data  |
      | Log Field 1 | data1 |
      | Log Field 2 |       |
	And I open log line 1
	Then I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 3	|Answer must be provided. Please review.	|false   |false   |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_05B
@Validation		
Scenario: PB_US12940_05B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field A, then the system should refire a query on log field B. Query with requires response = false and requires manual close = false.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 4 |       |
      | Log Field 5 | data5 |
      | Log Field 6 | data6 |
	And I open log line 1
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 6	|Answer must be provided. Please review.	|false   |false   |	  
	And I take a screenshot	       
	When I enter data in CRF and save
      | Field       | Data  |
      | Log Field 4 | data4 |
      | Log Field 5 |       |
	And I open log line 1
	Then I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 6	|Answer must be provided. Please review.	|false   |false   |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_05C	
@Validation	
Scenario: PB_US12940_05C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field A, then the system should refire a query on log field B. Query with requires response = true and requires manual close = false.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 7 |       |
      | Log Field 8 | data8 |
      | Log Field 9 | data9 |
	And I open log line 1
    And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|false   |false   |	  
	And I take a screenshot	
	And I answer the Query "Answer must be provided. Please review." on Field "Log Field 9" with "Data will be changed."
	And I save the CRF page
	And I open log line 1
    And I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|true    |true    |		
	And I take a screenshot	  
	When I enter data in CRF and save
      | Field       | Data  |
      | Log Field 7 | data7 |
      | Log Field 8 |       |
	And I open log line 1
	Then I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|false   |false   |	  
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_05D
@Validation		
Scenario: PB_US12940_05D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field A, then the system should refire a query on log field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field        | Data   |
      | Log Field 10 |        |
      | Log Field 11 | data11 |
      | Log Field 12 | data12 |
	And I open log line 1
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 12	|Answer must be provided. Please review.	|false   |false   |	  
	And I take a screenshot	  
	When I enter data in CRF and save
      | Field        | Data   |
      | Log Field 10 | data10 |
      | Log Field 11 |        |
	And I open log line 1
	Then I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 12	|Answer must be provided. Please review.	|false   |false   |	 
	And I take a screenshot	

@release_564_Patch11  
@PB_US12940_06A
@Validation		
Scenario: PB_US12940_06A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = true.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 1 |       |
      | Log Field 2 | data2 |
      | Log Field 3 | data3 |
	And I open log line 1 
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 3	|Answer must be provided. Please review.	|false   |false   |	  
	And I take a screenshot
	And I cancel the Query "Answer must be provided. Please review." on Field "Log Field 3"
	And I save the CRF page
	And I open log line 1
	And I click audit on Field "Log Field 3"
	And I take a screenshot	  
	And I verify last audit exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select link "Form 6" in "Header"
	And I open log line 1	  
	And I enter data in CRF and save	  
      |Field		|Data   |
      |Log Field 1	|data1	|
	And I open log line 1 
    And I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 3	|Answer must be provided. Please review.	|false   |false   |		    
	And I take a screenshot	  
	When I enter data in CRF and save  
      | Field       | Data |
      | Log Field 1 |      |
	And I open log line 1 
	Then I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 3	|Answer must be provided. Please review.	|false   |false   |	
	And I take a screenshot	  

@release_564_Patch11
@PB_US12940_06B	
@Validation	
Scenario: PB_US12940_06B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = false.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 4 |       |
      | Log Field 5 | data5 |
      | Log Field 6 | data6 |
	And I open log line 1 
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 6	|Answer must be provided. Please review.	|false   |false   |	  
	And I take a screenshot
	And I cancel the Query "Answer must be provided. Please review." on Field "Log Field 6"
	And I save the CRF page
	And I open log line 1
	And I click audit on Field "Log Field 6"
	And I take a screenshot	  
	And I verify last audit exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select link "Form 6" in "Header"
	And I open log line 1	  
	And I enter data in CRF and save	  
      |Field		|Data   |
      |Log Field 4	|data4	|
	And I open log line 1
    And I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 6	|Answer must be provided. Please review.	|false   |false   |	  	  
	And I take a screenshot	  
	When I enter data in CRF and save	  
      | Field       | Data |
      | Log Field 4 |      |
	And I open log line 1 
	Then I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 6	|Answer must be provided. Please review.	|false   |false   |	
	And I take a screenshot	  

@release_564_Patch11
@PB_US12940_06C	
@Validation	
Scenario: PB_US12940_06C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = false.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 7 |       |
      | Log Field 8 | data8 |
      | Log Field 9 | data9 |
	And I open log line 1 
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|false   |false   |	  
	And I take a screenshot
	And I cancel the Query "Answer must be provided. Please review." on Field "Log Field 9"
	And I save the CRF page
	And I open log line 1
	And I click audit on Field "Log Field 9"
	And I take a screenshot	  
	And I verify last audit exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select link "Form 6" in "Header"
	And I open log line 1  
	And I enter data in CRF and save	  
      | Field       | Data  |
      | Log Field 7 | data7 |
	And I open log line 1	
	And I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|false   |false   |	  	  
	And I take a screenshot	  
	When I enter data in CRF and save	  
      | Field       | Data |
      | Log Field 7 |      |
	And I open log line 1
	Then I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|false   |false   |
	And I take a screenshot	  

@release_564_Patch11
@PB_US12940_06D	
@Validation	
Scenario: PB_US12940_06D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = true.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field        | Data   |
      | Log Field 10 |        |
      | Log Field 11 | data11 |
      | Log Field 12 | data12 |
	And I open log line 1
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 12	|Answer must be provided. Please review.	|false   |false   |	    
	And I take a screenshot
	And I cancel the Query "Answer must be provided. Please review." on Field "Log Field 12"
	And I save the CRF page
	And I open log line 1
	And I click audit on Field "Log Field 12"
	And I take a screenshot	  
	And I verify last audit exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select link "Form 6" in "Header"
	And I open log line 1
	And I enter data in CRF and save  
      |Field		|Data   |
      |Log Field 10	|data10	|
	And I open log line 1
    And I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 12	|Answer must be provided. Please review.	|false   |false   |		   	  
	And I take a screenshot	  
	When I enter data in CRF and save	  
      | Field        | Data |
      | Log Field 10 |      |
	And I open log line 1	 
	Then I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 12	|Answer must be provided. Please review.	|false   |false   |	
	And I take a screenshot	  

@release_564_Patch11	  
@PB_US12940_07A	
@Validation	
Scenario: PB_US12940_07A As an EDC user, when I entered bad data in field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = true.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 1 | data1 |
      | Log Field 2 | data2 |
      | Log Field 3 |       |
	And I open log line 1
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 3	|Answer must be provided. Please review.	|false   |false   |	    
	And I take a screenshot
	And I cancel the Query "Answer must be provided. Please review." on Field "Log Field 3"
	And I save the CRF page
	And I open log line 1
	And I click audit on Field "Log Field 3"
	And I take a screenshot	  
	And I verify last audit exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select link "Form 6" in "Header"
	And I open log line 1
	And I enter data in CRF and save	  
      |Field		|Data   |
      |Log Field 3	|data3	|
	And I open log line 1	
	And I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 3	|Answer must be provided. Please review.	|false   |false   |	
	And I take a screenshot	  
	When I enter data in CRF and save  
      | Field       | Data |
      | Log Field 3 |      |
	And I open log line 1
	Then I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 3	|Answer must be provided. Please review.	|false   |false   |
	And I take a screenshot    

@release_564_Patch11
@PB_US12940_07B		
@Validation
Scenario: PB_US12940_07B As an EDC user, when I entered bad data in field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = false.	

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 4 | data4 |
      | Log Field 5 | data5 |
      | Log Field 6 |       |
	And I open log line 1
    And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 6	|Answer must be provided. Please review.	|false   |false   |	   	  
	And I take a screenshot
	And I cancel the Query "Answer must be provided. Please review." on Field "Log Field 6"
	And I save the CRF page
	And I open log line 1
	And I click audit on Field "Log Field 6"
	And I take a screenshot	  
	And I verify last audit exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select link "Form 6" in "Header"
	And I open log line 1
	And I enter data in CRF and save	  
      |Field		|Data   |
      |Log Field 6	|data6	|
	And I open log line 1
    And I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 6	|Answer must be provided. Please review.	|false   |false   |	  
	And I take a screenshot	  
	When I enter data in CRF and save	  
      | Field       | Data |
      | Log Field 6 |      |
	And I open log line 1	
	Then I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 6	|Answer must be provided. Please review.	|false   |false   |	 
	And I take a screenshot    

@release_564_Patch11
@PB_US12940_07C
@Validation		
Scenario: PB_US12940_07C As an EDC user, when I entered bad data in field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = false.

	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field       | Data  |
      | Log Field 7 | data7 |
      | Log Field 8 | data8 |
      | Log Field 9 |       |
	And I open log line 1 
	And I verify Query is displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|false   |false   |	    
	And I take a screenshot	    
	And I cancel the Query "Answer must be provided. Please review." on Field "Log Field 9"
	And I save the CRF page
	And I open log line 1
	And I click audit on Field "Log Field 9"
	And I take a screenshot	  
	And I verify last audit exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select link "Form 6" in "Header"
	And I open log line 1
	And I enter data in CRF and save	  
      |Field		|Data   |
      |Log Field 9	|data9	|
	And I open log line 1
	And I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|false   |false   |
	And I take a screenshot	  
	When I enter data in CRF and save		  
      | Field       | Data |
      | Log Field 9 |      |
	And I open log line 1
	Then I verify Query is not displayed
      |Field		|Query Message  							|Answered| Closed |
      |Log Field 9	|Answer must be provided. Please review.	|false   |false   |
	And I take a screenshot   

@release_564_Patch11
@PB_US12940_07D	
@Validation	
Scenario: PB_US12940_07D As an EDC user, when I entered bad data in field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 6"
	And I enter data in CRF and save
      | Field        | Data   |
      | Log Field 10 | data10 |
      | Log Field 11 | data11 |
      | Log Field 12 |        |
	And I open log line 1
    And I verify Query is displayed
       |Field		    |Query Message  							|Answered| Closed |
       |Log Field 12	|Answer must be provided. Please review.	|false   |false   |		  
	And I take a screenshot	
	And I cancel the Query "Answer must be provided. Please review." on Field "Log Field 12"
	And I save the CRF page
	And I open log line 1
	And I click audit on Field "Log Field 12"
	And I take a screenshot	  
	And I verify last audit exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select link "Form 6" in "Header"
	And I open log line 1
	And I enter data in CRF and save	  
      |Field		|Data   |
      |Log Field 12	|data12	|
	And I open log line 1
    And I verify Query is not displayed
       |Field		    |Query Message  							|Answered| Closed |
       |Log Field 12	|Answer must be provided. Please review.	|false   |false   |		  
	And I take a screenshot
	When I enter data in CRF and save  
      | Field        | Data |
      | Log Field 12 |      |
	And I open log line 1	
	Then I verify Query is not displayed
       |Field		    |Query Message  							|Answered| Closed |
       |Log Field 12	|Answer must be provided. Please review.	|false   |false   |
	And I take a screenshot   
		