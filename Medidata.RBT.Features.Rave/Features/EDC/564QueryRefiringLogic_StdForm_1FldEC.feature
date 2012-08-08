# The logic that is used to determine when a query that has already been cancelled or closed should or should not be re-fired in Rave 
# will be examining the answered query data instead of the original query data.

#TESTING FOR STANDARD FORM WITH ONLY 1 FIELD INVOLVED IN QUERY FIRING

#-- project to be uploaded in excel spreadsheet 'Standard Study'

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

@release_564_Patch11
@PB_US12940_01A
@Validation		
Scenario: PB_US12940_01A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and the query is then closed, and I entered good data in field A, if I then entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = true and requires manual close = true.
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
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
	And I verify Query is displayed
	| Field | Query Message                                                                        | Closed | Answered |
	| Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_01B
@Validation		
Scenario: PB_US12940_01B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I entered good data in field A, if I then entered the same bad data in field A as when the query opened, then the system should refire a query on field A. Query with requires response = false and requires manual close = false.
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  |false     |
	And I take a screenshot	  		  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 2		|20		|
	And I verify Query is not displayed
	  | Field |Query Message                                                                        | Closed | Answered |
	  | Age 2 |Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot		  		  
	And I enter data in CRF and save
      |Field		|Data  |
      |Age 2		|17	   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_01C
@Validation		
Scenario: PB_US12940_01C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and I entered good data in field A, if I then entered the same bad data in field A, then the system should not refire a query on field A. Query with requires response = true and requires manual close = false.
    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot		  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I save the CRF page	  
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data    	|
      |Age 3		|20			|
	And I take a screenshot		  		  
	And I enter data in CRF and save
      |Field		|Data   |
      |Age 3		|17		|
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | false    |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_01D	
@Validation	
Scenario: PB_US12940_01D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I entered new bad data in field A and close the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query is closed,
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_02A
@Validation		
Scenario: PB_US12940_02A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = true.
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_02B
@Validation		
Scenario: PB_US12940_02B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = false.
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 2		|20		|
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | false    |
	And I take a screenshot		  
	And I enter data in CRF and save
      |Field		|Data   |
      |Age 2		|16		|
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_02C	
@Validation	
Scenario: PB_US12940_02C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query without changing the data, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = false.
    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I save the CRF page	  
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | false    |
	And I take a screenshot		  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 3		|20		|
	And I take a screenshot
	And I enter data in CRF and save
      |Field		|Data  |
      |Age 3		|16	   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_02D	
@Validation	
Scenario: PB_US12940_02D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I entered new bad data in field A and close the query, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = true.
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_03A	
@Validation	
Scenario: PB_US12940_03A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to good data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = true.
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
    When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1" with "Data will be changed."
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 1		|20		|
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page	
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data  |
      |Age 1		|17	   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_03B	
@Validation	
Scenario: PB_US12940_03B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I changed the data in field A to good data, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = false.
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 2		|20		|
	And I save the CRF page
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | false    |	  
	And I take a screenshot		  
	And I enter data in CRF and save
      |Field		|Data  |
      |Age 2		|17	   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_03C	
@Validation	
Scenario: PB_US12940_03C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to good data, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = false.
    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
    When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I enter data in CRF and save
      |Field		|Data  	|
      |Age 3		|20		|
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | false    |
	And I take a screenshot		  
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 17   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_03D	
@Validation	
Scenario: PB_US12940_03D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I changed the data in field A to good data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = true.
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 20   |
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot		  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 17   |
  	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_04A	
@Validation	
Scenario: PB_US12940_04A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = true and requires manual close = true
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
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
	And I verify Query is displayed
     | Field | Query Message                                                                        | Closed | Answered |
     | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 20   |
	And I verify Query is displayed
     | Field | Query Message                                                                        | Closed | Answered |
     | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 71   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_04B	
@Validation	
Scenario: PB_US12940_04B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, if I entered good data in field A and then again entered the same bad data in field A as when the query opened, then the system should refire a query on field A. Query with requires response = false and requires manual close = false.
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 71   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot		  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 20   |
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | false    |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 71   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_04C
@Validation
@ignore
# DT #14208		
Scenario: PB_US12940_04C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, if I entered good data in field A and then again entered the same bad data in field A, then the system should not refire a query on field A. Query with requires response = true and requires manual close = false.
    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 71   |
   	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
# DT #14208	
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
	| Field | Query Message                                                                        | Closed | Answered |
	| Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_04D	
@Validation	
Scenario: PB_US12940_04D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field A. Query with requires response = false and requires manual close = true
    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 71   |	  
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | true     |	
	And I take a screenshot
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page	
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 20   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |	
	And I take a screenshot 
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 71   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_05A	
@Validation	
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1" with "Data will be changed."
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 71   |
	And I verify Query is displayed
      | Field | Query Message                                                                        | Closed | Answered |
      | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | true     |
	And I take a screenshot		  
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page	
	And I verify Query is displayed
      | Field | Query Message                                                                        | Closed | Answered |
      | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 17   |
	And I verify Query is displayed
      | Field | Query Message                                                                        | Closed | Answered |
      | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_05B
@Validation		
Scenario: PB_US12940_05B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I changed the data in field A to another bad data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = false.
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 71   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot		  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 17   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_05C	
@Validation
@ignore
#DT #14208	
Scenario: PB_US12940_05C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = false.
    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 71   |
   	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
#DT #14208
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_05D	
@Validation	
Scenario: PB_US12940_05D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I changed the data in field A to another bad data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = true.
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 71   |
	And I save the CRF page
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | true     |	
	And I take a screenshot  
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page	
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 17   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	

@release_564_Patch11
@PB_US12940_06A	
@Validation	
Scenario: PB_US12940_06A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = true
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
    When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1" with "Data will be changed."
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 71   |
	And I save the CRF page
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | true     |  
	And I take a screenshot 
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page	
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 70   |
	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_06B	
@Validation	
Scenario: PB_US12940_06B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I changed the data in field A to another bad data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = false
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 71   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 70   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_06C	
@Validation
@ignore
#DT #14208	
Scenario: PB_US12940_06C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I answered the query and I changed the data in field A to another bad data, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = true and requires manual close = false
    And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I answer the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3" with "Data will be changed."
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 71   |
   	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
#DT #14208
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_06D	
@Validation	
Scenario: PB_US12940_06D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I changed the data in field A to another bad data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field A. Query with requires response = false and requires manual close = true
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 71   |	  
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | true     |
	And I take a screenshot 
	And I close the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 70   |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_07A	
@Validation	
Scenario: PB_US12940_07A As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = true and requires manual close = true
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 1"
	And I save the CRF page		  
	And I click audit on Field "Age 1"
	And I take a screenshot	  
	And I verify Audits exist
	| Audit Type     | Query Message                                                                        |
	| Query Canceled | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I select Form "Form 1" in "Header"
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 20   |
	And I verify Query is not displayed
      | Field | Query Message                                                                        | Closed | Answered |
      | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 1 | 17   |
	And I verify Query is not displayed
      | Field | Query Message                                                                        | Closed | Answered |
      | Age 1 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_07B	
@Validation	
Scenario: PB_US12940_07B As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = false and requires manual close = false
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
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 2"
	And I save the CRF page		  
	And I click audit on Field "Age 2"
	And I take a screenshot	  
	And I verify Audits exist
	| Audit Type     | Query Message                                                                        |
	| Query Canceled | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I select Form "Form 1" in "Header"	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 20   |
	And I verify Query is not displayed
      | Field | Query Message                                                                        | Closed | Answered |
      | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |	 	  
	And I take a screenshot	  
	And I enter data in CRF and save
      | Field | Data |
      | Age 2 | 17   |
	And I verify Query is not displayed
      | Field | Query Message                                                                        | Closed | Answered |
      | Age 2 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_07C	
@Validation	
Scenario: PB_US12940_07C As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = true and requires manual close = false
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 3		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 3"
	And I save the CRF page		  
	And I click audit on Field "Age 3"
	And I take a screenshot	  
	And I verify Audits exist
	| Audit Type     | Query Message                                                                        |
	| Query Canceled | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I select Form "Form 1" in "Header"  
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 20   |
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |	  
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 3 | 17   |
   	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 3 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_07D
@Validation		
Scenario: PB_US12940_07D As an EDC user, when I entered bad data in field A that resulted in the system opening a query on field A, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field A. Query with requires response = false and requires manual close = true
	And I create a Subject
	| Field            | Data              |
	| Subject Initials | SUB               |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 1"
	And I enter data in CRF and save
      |Field		|Data	 |
      |Age 4		|17		 |
   	And I verify Query is displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | false  | false    |
	And I take a screenshot	  
	When I cancel the Query "Age must be greater than or equal to 18 and less than or equal to 65. Please verify." on Field "Age 4"
	And I save the CRF page		  
	And I click audit on Field "Age 4"
	And I take a screenshot	  
	And I verify Audits exist
	| Audit Type     | Query Message                                                                        |
	| Query Canceled | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. |
	And I select Form "Form 1" in "Header"  
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 20   |
	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |		  
	And I take a screenshot
	And I enter data in CRF and save
      | Field | Data |
      | Age 4 | 17   |	  
   	And I verify Query is not displayed
	  | Field | Query Message                                                                        | Closed | Answered |
	  | Age 4 | Age must be greater than or equal to 18 and less than or equal to 65. Please verify. | true   | true     |
	And I take a screenshot			