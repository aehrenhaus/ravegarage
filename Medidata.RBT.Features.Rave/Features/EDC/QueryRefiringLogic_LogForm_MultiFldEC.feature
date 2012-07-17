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

@PB_US12940_01A		
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

@PB_US12940_01B		
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

@PB_US12940_01C		
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
	And I verify Query is not displayed
      |Field		| Query Message                           | Closed |
      |Log Field 9	| Answer must be provided. Please review. | false  |	  	
	And I take a screenshot

@PB_US12940_01D
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

@PB_US12940_02A		
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
	And I verify Query is not displayed
      | Field       | Message                                 | Closed |
      | Log Field 3 | Answer must be provided. Please review. | false  |
	And I take a screenshot 
	And I open log line 1		
	And I enter data in CRF and save
      |Field		|Data  |
      |Log Field 3	|data3	|
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

@PB_US12940_02B		
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

@PB_US12940_02C		
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

@PB_US12940_02D		
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
	
@PB_US12940_03A		
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

@PB_US12940_03B		
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

@PB_US12940_03C		
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
	And I verify Query is displayed
      | Field       | Query Message                           | Closed |
      | Log Field 9 | Answer must be provided. Please review. | false  |	  
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

@PB_US12940_03D
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
	
@PB-US12940-04A		
Scenario: PB-US12940-04A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the original bad data in log field A, then the system should refire a query on log field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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
   
@PB-US12940-04B
@ignore
#Failing DT#14207		
Scenario: PB-US12940-04B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the original bad data in log field A, then the system should refire a query on log field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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

@PB-US12940-04C		
Scenario: PB-US12940-04C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the original bad data in log field A, then the system should refire a query on log field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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

@PB-US12940-04D
@ignore
#Failing DT#14207		
Scenario: PB-US12940-04D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query and I changed the data in log field A to another bad data, and the query is then closed, if I then entered the original bad data in log field A, then the system should refire a query on log field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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
  
@PB-US12940-05A		
Scenario: PB-US12940-05A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field A, then the system should refire a query on log field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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

@PB-US12940-05B		
Scenario: PB-US12940-05B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field A, then the system should refire a query on log field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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

@PB-US12940-05C		
Scenario: PB-US12940-05C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field A, then the system should refire a query on log field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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

@PB-US12940-05D		
Scenario: PB-US12940-05D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in log field A, then the system should refire a query on log field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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
  
@PB-US12940-06A		
Scenario: PB-US12940-06A As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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
	And I verify Audits exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select Form "Form 6" in "Header"
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

@PB-US12940-06B		
Scenario: PB-US12940-06B As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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
	And I verify Audits exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select Form "Form 6" in "Header"
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

@PB-US12940-06C		
Scenario: PB-US12940-06C As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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
	And I verify Audits exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select Form "Form 6" in "Header"
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

@PB-US12940-06D		
Scenario: PB-US12940-06D As an EDC user, when I entered bad data in log field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field A, if I then entered the same bad data in log field A as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = true.

	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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
	And I verify Audits exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select Form "Form 6" in "Header"
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
	  
@PB-US12940-07A		
Scenario: PB-US12940-07A As an EDC user, when I entered bad data in field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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
	#And I open log line 1
	#And I verify Query is cancelled and take screen shot
     # |Field		|Query Message  							|
      #|Log Field 3	|Answer must be provided. Please review.	|
	And I save the CRF page
	And I open log line 1
	And I click audit on Field "Log Field 3"
	And I take a screenshot	  
	And I verify Audits exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select Form "Form 6" in "Header"
	

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

@PB-US12940-07B		
Scenario: PB-US12940-07B As an EDC user, when I entered bad data in field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = false.	

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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
	And I verify Audits exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select Form "Form 6" in "Header"
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

@PB-US12940-07C		
Scenario: PB-US12940-07C As an EDC user, when I entered bad data in field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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
	And I verify Audits exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select Form "Form 6" in "Header"
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

@PB-US12940-07D		
Scenario: PB-US12940-07D As an EDC user, when I entered bad data in field A and log field B that resulted in the system opening a query on log field B, and I canceled the query, and I entered good data in log field B, if I then entered the same bad data in log field B as when the query was canceled, then the system should not refire a query on log field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
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
	#And I open log line 1
	#And I verify Query is cancelled
     # |Field		|Query Message  							|
     # |Log Field 12	|Answer must be provided. Please review.	|
	#And I take a screenshot
		And I save the CRF page
	And I open log line 1
	And I click audit on Field "Log Field 12"
	And I take a screenshot	  
	And I verify Audits exist
	| Audit Type     | Query Message                           |
	| Query Canceled | Answer must be provided. Please review. |
	And I select Form "Form 6" in "Header"
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
		