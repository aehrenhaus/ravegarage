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
	And I select Study "Standard Study" and Site "Site 1"
	And following Study assignments exist
		|User	|Study		    |Role |Site	  |Site Number	|
		|User 1 |Standard Study	|cdm1 |Site 1 |S100			|
	And Role "cdm1" has Action "Query"
	And Study "Standard Study" has Draft "<Draft1>"
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Study "Standard Study"

@PB-US12940-01A		
Scenario: @PB-US12940-01A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = true.

	And I create a Subject
	| Field            | Data                                                            |
	| Subject Number   | {RndNum<num1>(5)}      |
	| Subject Initials | SUB                                                             |
    | Subject ID       | SUB {Var(num1)}                                                 |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
	And I save the CRF page    
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I save the CRF page  	  
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|2		|
	And I verify Query is not displayed
      | Field                                | Query Message                                                |Answered| Closed |
      | Lab Field 2 - WBC - rr = T ; rmc = T | Lab Field 2 must be greater than Lab Field 1. Please verify. |false   |false   |
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
	Then I verify Query is not displayed
      | Field                                | Query Message                                                |Answered| Closed |
      | Lab Field 2 - WBC - rr = T ; rmc = T | Lab Field 2 must be greater than Lab Field 1. Please verify. |false   | false  |
	And I take a screenshot

@PB-US12940-01B		
Scenario: @PB-US12940-01B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was closed, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = false.

	And I create a Subject
	| Field            | Data                                                          |
	| Subject Number   | {RndNum<num1>(5)}    |
	| Subject Initials |SUB                                                            |
    | Subject ID       | SUB {Var(num1)}                                               |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|2		|
	And I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
	Then I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F	|Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |	  
	And I take a screenshot

@PB-US12940-01C		
Scenario: @PB-US12940-01C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = false.

	And I create a Subject
	| Field            | Data                                                          |
	| Subject Number   | {RndNum<num1>(5)}    |
	| Subject Initials |SUB                                                            |
    | Subject ID       | SUB {Var(num1)}                                               |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
	And I save the CRF page 
    And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|true    |true    |	
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|2		|
	And I verify Query is not displayed
      |Field		                       |Query Message  												    |Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |  
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
	Then I verify Query is not displayed
      |Field		                       |Query Message  												    |Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |  
	And I take a screenshot

@PB-US12940-01D
@ignore
#Failing due to DT14207
Scenario: @PB-US12940-01D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was closed, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                           |
	| Subject Number   | {RndNum<num1>(5)}     |
	| Subject Initials |SUB                                                             |
    | Subject ID       | SUB {Var(num1)}                                                |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|2		|
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |	  
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered|Closed|
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|True    |false |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
	Then I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot

@PB-US12940-02A		
Scenario: @PB-US12940-02A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
	And I save the CRF page  
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T"			  
	And I save the CRF page 
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|6		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	Then I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-02B		
Scenario: @PB-US12940-02B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = false. 
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |6		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |true    |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	Then I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	
@PB-US12940-02C		
Scenario: @PB-US12940-02C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = false. 
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
	And I save the CRF page
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|true    |true    |	
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                       |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F|6	   |
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                       |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F|3	   |
	Then I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot

@PB-US12940-02D		
Scenario: @PB-US12940-02D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was closed, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|6		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered|Closed|
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 8 - WBC - rr = F ; rmc = T"
	And I save the CRF page 
	And I verify closed Query with message "Lab Field 8 must be greater than Lab Field 7. Please verify." is displayed on Field "Lab Field 8 - WBC - rr = F ; rmc = T"
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|3		|
	Then I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	
@PB-US12940-03A		
Scenario: @PB-US12940-03A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I entered good data in lab field A and then again entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = true.

	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|4		|	  
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered|Closed|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T"	
	And I save the CRF page  
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|2		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|4		|
    Then I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-03B	
@ignore
#Failing due to DT14200	
Scenario: @PB-US12940-03B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I entered good data in lab field A and then again entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = false.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|4		|	  
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   | 
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|2		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|4		|	  
	Then I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-03C	
@ignore
#Failing due to DT14208		
Scenario: @PB-US12940-03C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I entered good data in lab field A and then again entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = false. 
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                              |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F       |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
	And I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|4		|
	And I verify Query is not displayed
      |Field		                              |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F       |Lab Field 6 must be greater than Lab Field 5. Please verify.	|true    |true    |
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|2		|
	And I verify Query is not displayed
      |Field		                              |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F       |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|4		|	  
	And I verify Query is not displayed
      |Field		                              |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F       |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-03D	
@ignore
#Failing due to DT14207	
Scenario: @PB-US12940-03D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I entered good data in lab field A and then again entered the same bad data in lab field A as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                          |
	| Subject Number   | {RndNum<num1>(5)}    |
	| Subject Initials |SUB                                                            |
    | Subject ID       | SUB {Var(num1)}                                               |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	And I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|4		|  
	And I save the CRF page 	  
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered|Closed|
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|true    |false |	  
	And I take a screenshot
	And I close the only Query on Field "Lab Field 8 - WBC - rr = F ; rmc = T"	 
	And I save the CRF page  
	And I verify closed Query with message "Lab Field 8 must be greater than Lab Field 7. Please verify." is displayed on Field "Lab Field 8 - WBC - rr = F ; rmc = T"	
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|2		|
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|4		|  
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |	  
	And I take a screenshot

@PB-US12940-04A		
Scenario: @PB-US12940-04A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I entered good data in lab field B and then again entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
	And I enter data in CRF and save  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|2		|	
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered|Closed|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T" 
	And I save the CRF page
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|6		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|2		|   		
    And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-04B		
Scenario: @PB-US12940-04B	
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I entered good data in lab field B and then again entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
  	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |2		| 
	And I save the CRF page 	
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |true    |
	And I take a screenshot
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |6		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |true    |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |2		|   
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-04C	
@ignore
#Failing due to DT14208	
Scenario: @PB-US12940-04C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I entered good data in lab field B and then again entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
  	And I enter data in CRF and save	  
      |Field		                       |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F|2	   |  	
	And I verify Query is not displayed
      |Field		                       |Query Message  												    |Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	And I verify Query is not displayed
      |Field		                       |Query Message  												    |Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.	|true    |true    |
	And I take a screenshot
	And  I enter data in CRF and save	  
      |Field		                       |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F|6	   |
	And I verify Query is not displayed
      |Field		                       |Query Message  												    |Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.	|true    |true    |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                       |Data  |
      |Lab Field 6 - WBC - rr = T ; rmc = F|2	  |   
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot

@PB-US12940-04D		
Scenario: @PB-US12940-04D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I entered good data in lab field B and then again entered the same bad data in lab field B as when the query was closed, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
  	And I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|2		|  	
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered|Closed|
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|true    |false |	
	And I take a screenshot
	And I close the only Query on Field "Lab Field 8 - WBC - rr = F ; rmc = T"	
	And I save the CRF page 	  
	And I verify closed Query with message "Lab Field 8 must be greater than Lab Field 7. Please verify." is displayed on Field "Lab Field 8 - WBC - rr = F ; rmc = T"	
	And I take a screenshot
	And I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|6		| 
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|2		|    
#DT14218		
    And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
 
@PB-US12940-05A		
Scenario: @PB-US12940-05A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the original bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|4		|	  
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered|Closed|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T" 
	And I save the CRF page  	  
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		| 	
#DT14217		
    And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-05B	
@ignore
#Failing due to DT14200		
Scenario: @PB-US12940-05B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the original bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|4		|  	  
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		| 	
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   | 
	And I take a screenshot

@PB-US12940-05C	
@ignore
#Failing due to DT14208 and DT#14107		
Scenario: @PB-US12940-05C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the original bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
	And I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|4		|  	  
#DT14208   	
    And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|true    |true    |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|	
#DT14107		
    And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   | 
	And I take a screenshot

@PB-US12940-05D	
@ignore
#Failing due to DT14208 and DT#14207		
Scenario: @PB-US12940-05D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the original bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	And I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|4		|     	    
#DT14207		
    And I verify Query is displayed
      |Field		                       |Query Message  												|Answered|Closed|
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.| true   |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 8 - WBC - rr = F ; rmc = T"
	And I save the CRF page  	  
	And I verify closed Query with message "Lab Field 8 must be greater than Lab Field 7. Please verify." is displayed on Field "Lab Field 8 - WBC - rr = F ; rmc = T"	
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|   	
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   | 
	And I take a screenshot
  
@PB-US12940-06A		
Scenario: @PB-US12940-06A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the original bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
  	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|2		|  	
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered|Closed|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I save the CRF page 	  
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|  
#DT14215	
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-06B		
Scenario: @PB-US12940-06B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the original bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
  	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |2		|  	
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |true    |
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |  
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|  
	Then I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-06C	
@ignore
#Failing due to DT14208
Scenario: @PB-US12940-06C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the original bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
  	And I enter data in CRF and save	  
      |Field		                        |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F |2	    |	
#DT14208		
    And I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|true    |true    |	  
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                        |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F |3		| 
	Then I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-06D		
Scenario: @PB-US12940-06D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the original bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T |5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T         |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
  	And I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|2		|    
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered|Closed|
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 8 - WBC - rr = F ; rmc = T"
	And I save the CRF page 	  
	And I verify closed Query with message "Lab Field 8 must be greater than Lab Field 7. Please verify." is displayed on Field "Lab Field 8 - WBC - rr = F ; rmc = T"	
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|3		|  	  
#DT14217		
    Then I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |  
	And I take a screenshot
	  
@PB-US12940-07A		
Scenario: @PB-US12940-07A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
	And I save the CRF page  
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I save the CRF page  	  
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|6		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-07B	
@ignore
#Failing due to DT14200
Scenario: @PB-US12940-07B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = false.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|6		|
#DT14200		
    And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-07C		
Scenario: @PB-US12940-07C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = false.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
	And I save the CRF page 
    And I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|true    |true    |	
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|6		|
	Then I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-07D
@ignore
#Failing due to DT14207		
Scenario: @PB-US12940-07D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T |5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T         |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|6		|   
#DT14207	
    Then I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|true    |true    | 
	And I take a screenshot
	  
@PB-US12940-08A		
Scenario: @PB-US12940-08A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
    And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
	And I save the CRF page  
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T"	  
	And I save the CRF page  	  
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|2		|  
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-08B		
Scenario: @PB-US12940-08B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |2		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |true    |
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-08C		
Scenario: @PB-US12940-08C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
	And I save the CRF page  
	And I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|true    |true    |	  
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                        |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F |2		|
	And I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-08D		
Scenario: @PB-US12940-08D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, if I then entered new bad data in lab field B, then the system should answers the old query on lab field B. Then I should not see logging.Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|2		|  
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered|Closed|
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|true    |false |
	And I take a screenshot

@PB-US12940-09A		
Scenario: @PB-US12940-09A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B. And I should not see the logging.Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|7		|	  
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered|Closed|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I save the CRF page  	  
	And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|6		|
	Then I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-09B	
@ignore
#Failing due to DT14200	
Scenario: @PB-US12940-09B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|7		|	  
	And I save the CRF page 	  
#DT14200		
    And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|6		|
	Then I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-09C	
@ignore
#Failing due to DT14208	
Scenario: @PB-US12940-09C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
	And I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|7		|   
#DT14208		
    And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|true    |true    |
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|6		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot

@PB-US12940-09D	
@ignore
#Failing due to DT14207	
Scenario: @PB-US12940-09D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                          |
	| Subject Number   | {RndNum<num1>(5)}    |
	| Subject Initials |SUB                                                            |
    | Subject ID       | SUB {Var(num1)}                                               |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	And I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|7		|  	  	  
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered|Closed|
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false |	  
#DT14207		
    And I verify Query is displayed
      |Field		                       |Query Message  												|Answered|Closed|
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 8 - WBC - rr = F ; rmc = T"  
	And I save the CRF page 
    And I verify closed Query with message "Lab Field 8 must be greater than Lab Field 7. Please verify." is displayed on Field "Lab Field 8 - WBC - rr = F ; rmc = T"
	And I take a screenshot
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|6		|  
	Then I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |	
	And I take a screenshot

@PB-US12940-10A		
Scenario: @PB-US12940-10A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T" with "Data will be changed."
  	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|2		|  
	And I save the CRF page 	
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered|Closed|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 2 - WBC - rr = T ; rmc = T" 
	And I save the CRF page 
    And I verify closed Query with message "Lab Field 2 must be greater than Lab Field 1. Please verify." is displayed on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|1		| 
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-10B		
Scenario: @PB-US12940-10B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
  	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |2		|	  
	And I save the CRF page 
    And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |true    |
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |1		|	  
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-10C
@ignore
#Failing due to DT14208		
Scenario: @PB-US12940-10C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot
	And I answer the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F" with "Data will be changed."
  	And I enter data in CRF and save	  
      |Field		                        |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F |2		|  	
#DT14208		
    And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|true    |true    |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                        |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F |1		| 
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot

@PB-US12940-10D	
Scenario: @PB-US12940-10D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
  	And I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|2		|  	  	
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered|Closed|
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|true    |false |
	And I take a screenshot
	And I close the only Query on Field "Lab Field 8 - WBC - rr = F ; rmc = T" 
	And I save the CRF page 
	And I verify closed Query with message "Lab Field 8 must be greater than Lab Field 7. Please verify." is displayed on Field "Lab Field 8 - WBC - rr = F ; rmc = T"
    And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|1		|  	  
	Then I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   | 
	And I take a screenshot
@PB-US12940-11A		
Scenario: @PB-US12940-11A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
    And I take a screenshot
	And I cancel the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I save the CRF page
	And I click audit on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 2 must be greater than Lab Field 1. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|2		| 	
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot


@PB-US12940-11B		
Scenario: @PB-US12940-11B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 4 must be greater than Lab Field 3. Please verify." on Field "Lab Field 4 - WBC - rr = F ; rmc = F"  	  
	And I save the CRF page
	And I click audit on Field "Lab Field 4 - WBC - rr = F ; rmc = F"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 4 must be greater than Lab Field 3. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|2		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
	Then I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |	
	And I take a screenshot


@PB-US12940-11C	
Scenario: @PB-US12940-11C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F"  
	And I save the CRF page
	And I click audit on Field "Lab Field 6 - WBC - rr = T ; rmc = F"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 6 must be greater than Lab Field 5. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|2		|
	And I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
	Then I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	
@PB-US12940-11D		
Scenario: @PB-US12940-11D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field A, if I then entered the same bad data in lab field A as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = true.

	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 8 must be greater than Lab Field 7. Please verify." on Field "Lab Field 8 - WBC - rr = F ; rmc = T"   	  
	And I save the CRF page
	And I click audit on Field "Lab Field 8 - WBC - rr = F ; rmc = T"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 8 must be greater than Lab Field 7. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|2		|  	
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |	  
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|  
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |  		
	And I take a screenshot
		  
@PB-US12940-12A		
Scenario: @PB-US12940-12A
As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T"   	  
	And I save the CRF page
	And I click audit on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 2 must be greater than Lab Field 1. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|6		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		| 
	Then I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-12B		
Scenario: @PB-US12940-12B 
As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
    And I take a screenshot
	And I cancel the Query "Lab Field 4 must be greater than Lab Field 3. Please verify." on Field "Lab Field 4 - WBC - rr = F ; rmc = F"   	  
	And I save the CRF page
	And I click audit on Field "Lab Field 4 - WBC - rr = F ; rmc = F"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 4 must be greater than Lab Field 3. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |6		|
	And I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	Then I verify Query is not displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |	
	And I take a screenshot

@PB-US12940-12C		
Scenario: @PB-US12940-12C 
As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F"   	  
	And I save the CRF page
	And I click audit on Field "Lab Field 6 - WBC - rr = T ; rmc = F"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 6 must be greater than Lab Field 5. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                        |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F |6		|
	And I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                       |Data   |
      |Lab Field 6 - WBC - rr = T ; rmc = F|3	   |
	And I verify Query is not displayed
      |Field		                        |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F |Lab Field 6 must be greater than Lab Field 5. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-12D		
Scenario: @PB-US12940-12D 
As an EDC user, when I entered bad data in field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, and I entered good data in lab field B, if I then entered the same bad data in lab field B as when the query was canceled, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 8 must be greater than Lab Field 7. Please verify." on Field "Lab Field 8 - WBC - rr = F ; rmc = T"   	    
	And I save the CRF page
	And I click audit on Field "Lab Field 8 - WBC - rr = F ; rmc = T"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 8 must be greater than Lab Field 7. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	And I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|6		|  
	And I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |  
	And I take a screenshot
	When I enter data in CRF and save	  
      |Field		                       |Data    |
      |Lab Field 8 - WBC - rr = F ; rmc = T|3		|  
	Then I verify Query is not displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   | 	
	And I take a screenshot
	
@PB-US12940-13A		
Scenario: @PB-US12940-13A 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, if I then entered bad data in lab field A, then the system should refire a query on lab field B, then the system should not log a record in the database for those queries that refired.Query with requires response = true and requires manual close = true.

	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|5		|
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 2 must be greater than Lab Field 1. Please verify." on Field "Lab Field 2 - WBC - rr = T ; rmc = T"   	      
	And I save the CRF page
	And I click audit on Field "Lab Field 2 - WBC - rr = T ; rmc = T"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 2 must be greater than Lab Field 1. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 1 - NEUTROPHILS - rr = T ; rmc = T	|7		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 2 - WBC - rr = T ; rmc = T      	|Lab Field 2 must be greater than Lab Field 1. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-13B		
Scenario: @PB-US12940-13B 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, if I then entered bad data in lab field A, then the system should refire a query on lab field B, then the system should not log a record in the database for those queries that refired.Query with requires response = false and requires manual close = false.

	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|5		|
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |3		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 4 must be greater than Lab Field 3. Please verify." on Field "Lab Field 4 - WBC - rr = F ; rmc = F"   	        
	And I save the CRF page 
	And I click audit on Field "Lab Field 4 - WBC - rr = F ; rmc = F"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 4 must be greater than Lab Field 3. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	When I enter data in CRF and save
      |Field		                                |Data   |
      |Lab Field 3 - NEUTROPHILS - rr = F ; rmc = F	|7		|
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot

@PB-US12940-13C		
Scenario: @PB-US12940-13C 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, if I then entered bad data in lab field A, then the system should refire a query on lab field B, then the system should not log a record in the database for those queries that refired.Query with requires response = true and requires manual close = false.

	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|5		|
      |Lab Field 6 - WBC - rr = T ; rmc = F        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 6 must be greater than Lab Field 5. Please verify." on Field "Lab Field 6 - WBC - rr = T ; rmc = F"   	        	  
	And I save the CRF page
	And I click audit on Field "Lab Field 6 - WBC - rr = T ; rmc = F"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 6 must be greater than Lab Field 5. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 5 - NEUTROPHILS - rr = T ; rmc = F|7		|
	Then I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 6 - WBC - rr = T ; rmc = F|Lab Field 6 must be greater than Lab Field 5. Please verify.|false   |false   |
	And I take a screenshot

@PB-US12940-13D		
Scenario: @PB-US12940-13D 
As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I canceled the query, if I then entered bad data in lab field A, then the system should refire a query on lab field B, then the system should not log a record in the database for those queries that refired.Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials |SUB                                                         |
    | Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Lab Form 8"
	And I take a screenshot
	And I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|5		|
      |Lab Field 8 - WBC - rr = F ; rmc = T        |3		|
	And I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot
	And I cancel the Query "Lab Field 8 must be greater than Lab Field 7. Please verify." on Field "Lab Field 8 - WBC - rr = F ; rmc = T"   	        	  		  
	And I save the CRF page
	And I click audit on Field "Lab Field 8 - WBC - rr = F ; rmc = T"
	And I verify Audits exist
	| Audit Type     | Query Message                                                      |
	| Query Canceled | Lab Field 8 must be greater than Lab Field 7. Please verify.       |
	And I take a screenshot
	And I select Form "Lab Form 8" in "Header"
	When I enter data in CRF and save
      |Field		                               |Data    |
      |Lab Field 7 - NEUTROPHILS - rr = F ; rmc = T|7		|
	Then I verify Query is displayed
      |Field		                       |Query Message  												|Answered| Closed |
      |Lab Field 8 - WBC - rr = F ; rmc = T|Lab Field 8 must be greater than Lab Field 7. Please verify.|false   |false   |
	And I take a screenshot