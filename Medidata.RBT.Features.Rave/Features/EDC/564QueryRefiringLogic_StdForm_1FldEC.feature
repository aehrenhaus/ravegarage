Feature: 564QueryRefiringLogic_StdForm_1FldEC
	As a Rave user
	When I manually close a query or cancel, the query should not re-fire if the exact same data is entered into the system
	So that I don't have to re-enter the exact same response

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Study assignments exist
		|User	 |Study		        |Role |Site	  |Site Number	|
		|Defuser |Standard Study	|cdm1 |Site 1 |S100			|
	And I select Study "Standard Study" and Site "Site 1"

	#And Role "cdm1" has Action "Query"
	#And study "Standard Study" had draft "<Draft1>"
	#And I publish and push "CRF Version<RANDOMNUMBER>" to site "Site 1"

@PB_US12940_01A		
Scenario: PB_US12940_01A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and the query is then closed, and I entered good data in field A, if I then entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. 
Query with requires response = true and requires manual close = true.
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 1		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1" with "Data will be changed."
	And I save the CRF page	  
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page
	Then I verify closed Query with message "Data will be changed." is displayed on Field "Age 1"
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 1		|20		|
	And I take a screenshot	  		  
	And I enter data in CRF and save
      |Field		|Data   |
      |Age 1		|17		|
	And I take a screenshot
	And I verify Query is not displayed
	| Field   | Query Message                                                                        | Closed |
	| Age 1   | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_01B		
Scenario: PB_US12940_01B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and the query is then closed, and I entered good data in field A, if I then entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = false and requires manual close = false.
    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 2		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  		  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 2		|20		|
	And I verify Query is not displayed
	  | Field |
	  | Age 2 |
	And I take a screenshot		  		  
	And I enter data in CRF and save
      |Field		|Data  |
      |Age 2		|17	   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	

@PB_US12940_01C		
Scenario: PB_US12940_01C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and the query is then closed, and I entered good data in field A, if I then entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = true and requires manual close = false.
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot		  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I save the CRF page	  
	And I verify Query is not displayed
	  | Field |
	  | Age 3 |
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data    	|
      |Age 3		|20			|
	And I take a screenshot		  		  
	And I enter data in CRF and save
      |Field		|Data   |
      |Age 3		|17		|
	And I verify Query is not displayed
	| Field   | Query Message                                                                        | Closed |
	| Age 3   | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	

@PB_US12940_01D		
Scenario: PB_US12940_01D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and the query is then closed, and I entered good data in field A, if I then entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = false and requires manual close = true.
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  	  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 4		|20		|	  
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page
	And I verify closed Query with message "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." is displayed on Field "Age 4"
	And I take a screenshot			  
	And I enter data in CRF and save
      |Field		|Data  |
      |Age 4		|17	   |
  	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	

@PB_US12940_02A		
Scenario: PB_US12940_02A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. 
Query with requires response = true and requires manual close = true.
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 1		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
    When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1" with "Data will be changed."
	And I save the CRF page	  
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page
	Then I verify closed Query with message "Data will be changed." is displayed on Field "Age 1"
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 1		|20		|
	And I take a screenshot
	And I enter data in CRF and save
      |Field		|Data  |
      |Age 1		|16	   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	

@PB_US12940_02B		
Scenario: PB_US12940_02B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = false.
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 2		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 2		|20		|
	And I verify Query is not displayed
      |Field		|
      |Age 2		|
	And I take a screenshot		  
	And I enter data in CRF and save
      |Field		|Data   |
      |Age 2		|16		|
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	

@PB_US12940_02C		
Scenario: PB_US12940_02C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = false.
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I save the CRF page	  
	And I verify Query is not displayed
	  | Field |
	  | Age 3 |
	And I take a screenshot		  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 3		|20		|
	And I take a screenshot
	And I enter data in CRF and save
      |Field		|Data  |
      |Age 3		|16	   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	

@PB_US12940_02D		
Scenario: PB_US12940_02D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = true.
	And I create a Subject
	| Field            | Data                                                     |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 4		|20		|
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page
	And I verify closed Query with message "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." is displayed on Field "Age 4"
	And I take a screenshot			  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 16   |
  	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	

@PB_US12940_03A		
Scenario: PB_US12940_03A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to good data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = true.
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 1		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
    When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1" with "Data will be changed."
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 1		|20		|
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page	
	Then I verify closed Query with message "Data will be changed." is displayed on Field "Age 1"
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data  |
      |Age 1		|17	   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	

@PB_US12940_03B		
Scenario: PB_US12940_03B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to good data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = false.
    And I create a Subject
	| Field            | Data                                                     |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 2		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 2		|20		|
	And I save the CRF page
	And I verify Query is not displayed
      |Field		|
      |Age 2		|	  
	And I take a screenshot		  
	And I enter data in CRF and save
      |Field		|Data  |
      |Age 2		|17	   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_03C		
Scenario: PB_US12940_03C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to good data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = false.
    And I create a Subject
	| Field            | Data                                                     |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
    When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 3		|20		|
	And I verify Query is not displayed
      | Field |
      | Age 3 |
	And I take a screenshot		  
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 17   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_03D		
Scenario: PB_US12940_03D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to good data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = true.
	And I create a Subject
	| Field            | Data                                                     |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 20   |
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page
	And I verify closed Query with message "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." is displayed on Field "Age 4"
	And I take a screenshot		  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 17   |
  	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_04A		
Scenario: PB_US12940_04A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = true and requires manual close = true
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 1		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
    When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1" with "Data will be changed."
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 1		|71		|
	And I verify Query is displayed
     | Field | Query Message                                                                        | Closed | Answered |
     | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | true     |
	And I take a screenshot
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page
	Then I verify closed Query with message "Data will be changed." is displayed on Field "Age 1"
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 20   |
	And I verify Query is not displayed
      |Field		|
      |Age 1		|
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 71   |
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   |
	And I take a screenshot	

@PB_US12940_04B		
Scenario: PB_US12940_04B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = false and requires manual close = false.
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 2		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 71   |
	And I verify Query is displayed
      |Field		|
      |Age 2		|
	And I take a screenshot		  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 20   |
	And I verify Query is not displayed
      |Field		|
      |Age 2		|
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 71   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	

@PB_US12940_04C		
Scenario: PB_US12940_04C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = true and requires manual close = false.
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 71   |
	And I save the CRF page
	And I verify Query is displayed
      |Field		|
      |Age 3		|
	And I take a screenshot
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I save the CRF page
	And I verify Query is not displayed
      |Field		|
      |Age 3		|	  
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 20   |
	And I verify Query is not displayed
      |Field		|
      |Age 3		|
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 71   |
	And I verify Query is not displayed
	| Field   | Query Message                                                                        | Closed |
	| Age 3   | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_04D		
Scenario: PB_US12940_04D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = false and requires manual close = true
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 71   |	  
	And I verify Query is displayed
      |Field		|	  
      |Age 4		|	
	And I take a screenshot
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page	
	And I verify closed Query with message "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." is displayed on Field "Age 4"
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 20   |
	And I verify Query is not displayed
      |Field		|
      |Age 4		|	
	And I take a screenshot 
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 71   |
	And I verify Query is not displayed
	| Field | Query Message                                                                        | Closed |
	| Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   |
	And I take a screenshot

@PB_US12940_05A		
Scenario: PB_US12940_05A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = true.
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 1		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1" with "Data will be changed."
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 71   |
	And I verify Query is displayed
         | Field | Query Message                                                                        | Closed | Answered |
         | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false     |
	And I take a screenshot		  
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page	
	And I verify Query is displayed
         | Field | Query Message                                                                        | Closed |
         | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 17   |
	And I verify Query is displayed
	| Field   | Query Message                                                                        | Closed |
	| Age 1   | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_05B		
Scenario: PB_US12940_05B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = false.
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 2		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 71   |
	And I verify Query is displayed
      |Field		|
      |Age 2		|
	And I take a screenshot		  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 17   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_05C		
Scenario: PB_US12940_05C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = false.
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 71   |
	And I verify Query is displayed
      |Field		|
      |Age 3		|
	And I take a screenshot
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I save the CRF page
	Then I verify Query is not displayed
      |Field		|
      |Age 3		|	  
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 17   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_05D		
Scenario: PB_US12940_05D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = true.
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 71   |
	And I save the CRF page
	And I verify Query is displayed
      |Field		|	  
      |Age 4		|	
	And I take a screenshot  
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page	
	And I verify Query is displayed
         | Field | Query Message                                                                        | Closed |
         | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 17   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	

@PB_US12940_06A		
Scenario: PB_US12940_06A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = true
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 1		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
    When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1" with "Data will be changed."
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 71   |
	And I save the CRF page
	And I verify Query is displayed
         | Field | Query Message                                                                        | Closed |
         | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |false   |  
	And I take a screenshot 
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page	
	Then I verify closed Query with message "Data will be changed." is displayed on Field "Age 1"
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 70   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_06B		
Scenario: PB_US12940_06B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = false
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 2		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 71   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 70   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_06C		
Scenario: PB_US12940_06C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = false
    And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |	
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 71   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I save the CRF page
	And I verify Query is not displayed
      |Field		|
      |Age 3		|	  
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 70   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_06D		
Scenario: PB_US12940_06D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = true
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 71   |	  
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |	
	And I take a screenshot 
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 70   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot

@PB_US12940_07A		
Scenario: PB_US12940_07A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = true and requires manual close = true
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 1		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page		  
	Then I verify Query is not displayed
      |Field		|
      |Age 1		|
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 20   |
	And I verify Query is not displayed
      | Field | Query Message                                                                        | Closed |
      | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   |

	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 17   |
	And I verify Query is not displayed
      | Field | Query Message                                                                        | Closed |
      | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   |
	And I take a screenshot

@PB_US12940_07B		
Scenario: PB_US12940_07B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = false and requires manual close = false
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 2		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 2"
	And I save the CRF page		  
	Then I verify Query is not displayed
      |Field		|
      |Age 2		|	 	  
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 20   |
	And I verify Query is not displayed
      |Field		|
      |Age 2		|	 	  
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 17   |
	And I verify Query is not displayed
      | Field | Query Message                                                                        | Closed |
      | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   |
	And I take a screenshot

@PB_US12940_07C		
Scenario: PB_US12940_07C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = true and requires manual close = false
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3"
	And I save the CRF page		  
	And I verify Query is not displayed
      |Field		|
      |Age 3		|	  
	And I take a screenshot  
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 20   |
	And I verify Query is not displayed
      |Field		|
      |Age 3		|	  
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 17   |
   	And I verify Query is not displayed
	  | Field |
	  | Age 3 |

@PB_US12940_07D		
Scenario: PB_US12940_07D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = false and requires manual close = true
	And I create a Subject
	| Field            | Data                                                       |
	| Subject Initials | SUB                                                        |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}                                            |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page		  
	And I verify Query is not displayed
      |Field		|
      |Age 4		|	  
	And I take a screenshot  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 20   |
	And I verify Query is not displayed
      |Field		|
      |Age 4		|		  
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 17   |	  
   	And I verify Query is not displayed
	  | Field |
	  | Age 4 |
	And I take a screenshot