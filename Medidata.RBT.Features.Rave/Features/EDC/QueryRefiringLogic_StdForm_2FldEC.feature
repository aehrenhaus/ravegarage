# The logic that is used to determine when a query that has already been cancelled or closed should or should not be re-fired in Rave 
# will be examining the answered query data instead of the original query data.
#TESTING FOR STANDARD FORM WITH 2 FIELDS INVOLVED IN QUERY FIRING
#Project to be uploaded in excel spreadsheet 'Standard Study'
@ignore
Feature: QueryRefiringLogic4tgt
	As a Rave user
	When I manually close a query or cancel, the query should not re-fire if the exact same data is entered into the system
	So that I don't have to re-enter the exact same response

Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And following Study assignments exist
		| User   | Study          | Role | Site   | Site Number |
		| User 1 | Standard Study | cdm1 | Site 1 | S100        |
    And Role "cdm1" has Action "Query"
	And Draft "Draft 1" in Study "Standard Study" has been published to CRF Version "<RANDOMNUMBER>" 
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Study "Standard Study"
	And I select Study "Standard Study" and Site "Site 1"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-01A	
@validation	
Scenario: @PB-US12940-01A As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in field A, if I then entered the same bad data in field A as when the query was closed, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB               |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
	When I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct."
	And I save the CRF page 
	Then I verify Query is displayed
		| Field                      | Message                                                                               | Answered | Closed |
		| Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  | 
	And I take a screenshot
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1"		  
	And I save the CRF page  	  
	Then I verify Query is displayed
		| Field                      | Message                                                                               | Answered | Closed |
		| Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	  
	And I enter data in CRF
        | Field                     | Data |
        | Systolic Blood Pressure 1 | 100  |
	When I save the CRF page
	Then I verify Query is displayed
	    | Field                      | Message                                                                               | Answered | Closed |
		| Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot 
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 80   |
    When I save the CRF page
	Then I verify Query is not displayed
	    | Field                      | Message                                                                               | Answered | Closed |
	    | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
    And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-01B	
@validation	
Scenario: @PB-US12940-01B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I entered good data in field A, if I then entered the same bad data in field A as when the query was opened, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = false
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB               |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
    And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	  	  
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 2 | 100  |
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    |False   |	
	And I take a screenshot 
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 2 | 80   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    |False   |	
	And I take a screenshot 

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-01C	
@validation	
Scenario: @PB-US12940-01C As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in field A, if I then entered the same bad data in field A as when the query was closed, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	 And I create a Subject
	  | Field            | Data              |
	  | Subject Initials | SUB               |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 3  | 80   |
      | Diastolic Blood Pressure 3 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot 
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct."
	And I save the CRF page  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	When I enter data in CRF
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 100  |
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 80   |
    And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-01D
@validation		
Scenario: @PB-US12940-01D As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I entered good data in field A, if I then entered the same bad data in field A as when the query was opened, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = true

	Given I select Study "Standard Study" and Site "Site 1"
	 And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB               |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 4  | 80   |
      | Diastolic Blood Pressure 4 | 90   |
    And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot 
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 100  |  
	And I save the CRF page
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4"
	And I save the CRF page  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 80   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
 

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-02A	
@validation	
Scenario: @PB-US12940-02A As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in field B, if I then entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	  | Field            | Data              |
	  | Subject Initials | SUB               |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot  
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct."
	And I save the CRF page  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
    And I take a screenshot
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1"
	And I save the CRF page  	  
	Then I verify Query is displayed
     | Field                      | Query Message                                                                         | Answered | Closed |
     | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot
	When I enter data in CRF
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 70   |
	And I save the CRF page
	Then I verify Query is not displayed
     | Field                      | Query Message                                                                         | Answered | Closed |
     | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot 
	When I enter data in CRF
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page
	Then I verify Query is not displayed
	  | Field                      | Query Message                                                                         | Answered | Closed |
	  | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-02B	
@validation	
Scenario: @PB-US12940-02B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I entered good data in field B, if I then entered the same bad data in field B as when the query was opened, then the system should refire a query on field B. 
 Query with requires response = false and requires manual close = false
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	  | Field            | Data              |
	  | Subject Initials | SUB               |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
    And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 70   |
    And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	When I enter data in CRF 
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 90   |
	And I save the CRF page	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-02C	
@validation	
Scenario: @PB-US12940-02C As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in field B, if I then entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
 Query with requires response = true and requires manual close = false
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB               |
	  | Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 2"
	When I enter data in CRF 
      |Field						|Data  |
      |Systolic Blood Pressure 3	|80		|
      |Diastolic Blood Pressure 3	|90		|
    And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct"
	And I save the CRF page  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 70   |
    And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
    And I take a screenshot	
	When I enter data in CRF 
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 90   |
	And I save the CRF page
    Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-02D	
@validation	
Scenario: @PB-US12940-02D As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I entered good data in field B, if I then entered the same bad data in field B as when the query was opened, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = true
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB               |
	  | Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 4  | 80   |
      | Diastolic Blood Pressure 4 | 90   |
    And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 70   |
	And I save the CRF page
	Then I verify Query is displayed
	  | Field                      | Query Message                                                                         | Answered | Closed |
	  | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True    | False  |		  
	And I take a screenshot	
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4"
	And I save the CRF page  	  
	Then I verify Query is displayed
	  | Field                      | Query Message                                                                         | Answered | Closed |
	  | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |		  
    And I take a screenshot	
	When I enter data in CRF 
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 90   |	
    And I save the CRF page
	Then I verify Query is displayed
	  | Field                      | Query Message                                                                         | Answered | Closed |
	  | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |		  
	And I take a screenshot	


#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-03A	
@validation	
Scenario: @PB-US12940-03A As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB               |
	  | Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct"
	When I enter data in CRF	  
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 85   |	  
	And I save the CRF page 	  
	Then I verify Query is displayed	 
       | Field                      | Query Message                                                                         | Answered | Closed |
       | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot  
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1"
	And I save the CRF page  	  
    Then I verify Query is displayed	 
       | Field                      | Query Message                                                                         | Answered | Closed |
       | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 100  |
    And I save the CRF page
	Then I verify Query is not displayed	 
       | Field                      | Query Message                                                                         | Answered | Closed |
       | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False   |
	And I take a screenshot	
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 85   |	
	And I save the CRF page
	Then I verify Query is not displayed	 
       | Field                      | Query Message                                                                         | Answered | Closed |
       | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	


#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-03B	
@validation	
Scenario: @PB-US12940-03B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, if I entered good data in field A and then again entered the same bad data in field A as when the query was opened, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
	  | Field            | Data              |
	  | Subject Number   | {RndNum<num1>(5)} |
	  | Subject Initials | SUB               |
	  | Subject ID       | SUB {Var(num1)}   |		
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
    And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 2 | 100  |
    And I save the CRF page 
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |	  	 
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 2 | 80   |
	And I save the CRF page  	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |	  	 
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-03C	
@ignore	
# Dt 14208
Scenario: @PB-US12940-03C As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 3  | 80   |
      | Diastolic Blood Pressure 3 | 90   |
    And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct"
	And I enter data in CRF	  
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 85   |	  
	And I save the CRF page 	  
	Then I verify Query is displayed	 
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 100  |
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 85   |	
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	# DT 14208

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-03D
@ignore
# Due to DT 14207
Scenario: @PB-US12940-03D As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I changed the data in field A to another bad data and the system answered the query, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 4  | 80   |
      | Diastolic Blood Pressure 4 | 90   |
    And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF
	  | Field                     | Data |
      | Systolic Blood Pressure 4 | 85   |	  
	And I save the CRF page 
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	# DT 14207
	And I take a screenshot			  
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Systolic Blood Pressure 4"		  
	And I save the CRF page  	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
   	And I take a screenshot	
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 100  |
    And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
   	And I take a screenshot				
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 85   |	
    And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
   	And I take a screenshot		

	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-04A	
@validation	
Scenario: @PB-US12940-04A As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I entered good data in field B and then again entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
    And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct" 
  	And I enter data in CRF	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
    And I take a screenshot	
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" 
    And I save the CRF page
    Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 70   |	
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
    And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 85   |
	And I save the CRF page		  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
    And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-04B	
@validation	
Scenario: @PB-US12940-04B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, if I entered good data in field B and then again entered the same bad data in field B as when the query was opened, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF	  
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
  	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-04C		
@ignore
# due to DT 14208
Scenario: @PB-US12940-04C As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I entered good data in field B and then again entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 3  | 80   |
      | Diastolic Blood Pressure 3 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct" 
	And I enter data in CRF	  
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	# DT 14208
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 70   |
	And I save the CRF page 
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 85   |	
	And I save the CRF page	  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-04D	
@validation	
Scenario: @PB-US12940-04D As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I changed the data in field B to another bad data, and system answered the query, and the query is then closed, if I entered good data in field B and then again entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 4  | 80   |
      | Diastolic Blood Pressure 4 | 90   |
	And I save the CRF page 
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4"
	And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 70   |
	And I save the CRF page 	
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	 
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 85   |
	And I save the CRF page 		  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	 


#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	  
@PB-US12940-05A	
@validation	
Scenario: @PB-US12940-05A As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page
    Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct" 
  	And I enter data in CRF	  
      | Field                      | Data |
      | Systolic Blood Pressure 1 | 85   |	  
	And I save the CRF page 
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot		
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1"
    And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 100  |
	And I save the CRF page 
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 80   |
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-05B	
@validation	
Scenario: @PB-US12940-05B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I enter good data into field A, if I then entered the original bad data in field A, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 2 | 100  |
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	  	 
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 2 | 80   |	
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-05C	
@ignore
# Due to DT 14208	
Scenario: @PB-US12940-05C As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 3  | 80   |
      | Diastolic Blood Pressure 3 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct"
	And I enter data in CRF  
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 85   |	
	And I save the CRF page	 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And  verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	# Dt 14208
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 100  |
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 80   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-05D	
@ignore
# Due to 14207	
Scenario: @PB-US12940-05D As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I changed the data in field A to another bad data and the system answered the query, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 4  | 80   |
      | Diastolic Blood Pressure 4 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF   
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 85   |	  
	And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	# DT 14207
	And I take a screenshot	
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4" 	  
	And I save the CRF page  	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 100  |
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 80   |
	And I save the CRF page	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	  
@PB-US12940-06A	
@validation	
Scenario: @PB-US12940-06A	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I then entered the original bad data in field B, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct"
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 85   | 
	And I save the CRF page 	
    Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot	
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" 
   	And I save the CRF page	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 70   |
	And I save the CRF page	
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page		  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	

		
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	  
@PB-US12940-06B	
@validation	
Scenario: @PB-US12940-06B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, I enter good data in Field B, if I then entered the original bad data in field B, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 70   |
	And I save the CRF page	
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 90   |		  
	And I save the CRF page	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-06C	
@ignore	
# DT14208
Scenario: @PB-US12940-06C	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I then entered the original bad data in field B, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | sub               |
	And I select Form "Form 2"
	And I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 3  | 80   |
      | Diastolic Blood Pressure 3 | 90   |
	And I save the CRF page	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct"
 	And I enter data in CRF  
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 85   |  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
# DT 14208
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 70   |	
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 90   |	  
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-06D	
@validation	
Scenario: @PB-US12940-06D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I changed the data in field B to another bad data and the system answered the query, and the query is then closed, if I then entered the original bad data in field B, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 4  | 80   |
      | Diastolic Blood Pressure 4 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot	
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4"       
	And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 70   |	
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 90   |		  
	And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	

	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-07A	
@validation	
Scenario: @PB-US12940-07A As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct"
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot	
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" 
	And I save the CRF page  	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 85   |
	And I save the CRF page  	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	

	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-07B	
@validation	
Scenario: @PB-US12940-07B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, if I then entered new bad data in field A, then the system should keep a query open on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 2 | 85   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-07C	
@validation	
Scenario: @PB-US12940-07C	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I enter data in CRF 
      | Field                      | Data |
      | Systolic Blood Pressure 3  | 80   |
      | Diastolic Blood Pressure 3 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct"
	And I save the CRF page 	
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 85   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-07D
@ignore
# Due to DT 14208		
Scenario: @PB-US12940-07D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, if I then entered new bad data in field A, then the system should answer a query on field B, and then I close query, and I enter new bad data on Field A, then system should refire query on Field B.
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 4  | 80   |
      | Diastolic Blood Pressure 4 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 85   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	# Dt 14208
	And I take a screenshot
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4" 
	And I save the CRF page 
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 70   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	  
@PB-US12940-08A		
@validation
Scenario: @PB-US12940-08A	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field B, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = true
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct"
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" 
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot
	And I enter data in CRF 
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 100  |
	And I save the CRF page 
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11		
@PB-US12940-08B	
@validation	
Scenario: @PB-US12940-08B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, if I then entered new bad data in field B, then the system should keep a query open on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	When I enter data in CRF 
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 100  |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot


#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-08C		
@validation
Scenario: @PB-US12940-08C As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field B, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 3  | 80   |
      | Diastolic Blood Pressure 3 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct"
	And I save the CRF page 
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 100  |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot


#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-08D	
@validation	
Scenario: @PB-US12940-08D	 As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, if I then entered new bad data in field B, then the system should answer a query on field B, and then I close query, and I enter new bad data on Field B, then system should refire query on Field B.
Query with requires response = false and requires manual close = true.

	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 4  | 80   |
      | Diastolic Blood Pressure 4 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot		
	When I enter data in CRF 
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 100  |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot	
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4" 
	And I save the CRF page 
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 110  |
	And I save the CRF page		
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot



#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11 
@PB-US12940-09A	
@validation	
Scenario: @PB-US12940-09A	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the new bad data in field A, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct"
	And I enter data in CRF	  
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 85   |	  
	And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot	  	  
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" 
	And I save the CRF page  	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	  
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 70   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	 

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-09B	
@validation	
Scenario: @PB-US12940-09B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, if I then entered the new bad data in field A, then the system should keep a query open on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	 
	And I enter data in CRF	  
      | Field                     | Data |
      | Systolic Blood Pressure 2 | 85   |	  
	And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	 	  	  
			
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-09C	
@ignore
# Due to DT14208	
Scenario: @PB-US12940-09C	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the new bad data in field A, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 3  | 80   |
      | Diastolic Blood Pressure 3 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct"
	And I enter data in CRF	
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 85   |	  
	And I save the CRF page 	  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	#DT 14208
	And  I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	  	  
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 70   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-09D	
@ignore	
# Due to DT # 14207
Scenario: @PB-US12940-09D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I changed the data in field A to another bad data, and the system answers query and the query is closed, if I then entered the new bad data in field A, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 4  | 80   |
      | Diastolic Blood Pressure 4 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	When I enter data in CRF	  
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 85   |	  
	And I save the CRF page 
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And  I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	 	 
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4" 
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	# DT 14207 
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 70   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-10A	
@validation	
Scenario: @PB-US12940-10A As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I then entered the new bad data in field B, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct"
	And I enter data in CRF	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot	
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" 
	And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 100  |	
	And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-10B	
@validation	
Scenario: @PB-US12940-10B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, if I then entered the new bad data in field B, then the system should keep a query open on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
	And I save the CRF page 
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot		
	When I enter data in CRF	  
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	


#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-10C	
@ignore
# Due to DT14208	
Scenario: @PB-US12940-10C As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I then entered the new bad data in field B, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 3  | 80   |
      | Diastolic Blood Pressure 3 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct"
  	And I save the CRF page
	And I enter data in CRF	  
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And  I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	#DT14208
	And I take a screenshot	
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 100  |	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	 	  
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-10D	
@validation	
Scenario: @PB-US12940-10D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I changed the data in field B to another bad data, and the system answers query and the query is closed, if I then entered the new bad data in field B, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 4  | 80   |
      | Diastolic Blood Pressure 4 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And  I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4"  
  	And I save the CRF page 
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 100  |	
	And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11 
@PB-US12940-11A		
@validation
Scenario: @PB-US12940-11A	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Initials | SUB               |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	When I cancel the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1"  
	And I save the CRF page
	Then I verify Query is not displayed 
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I click audit on Field "Diastolic Blood Pressure 1"
	And I verify last audit exist
	| Audit Type     | Query Message                                                                         |
	| Query Canceled | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. |
	And I take a screenshot
	And I select link "Form 2" in "Header"
	When I enter data in CRF 	  
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 100  |
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	And I enter data in CRF 	  
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 80   |
	And I save the CRF page	
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-11B		
@validation
Scenario: @PB-US12940-11B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot		
	When I cancel the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 2"  
	And I save the CRF page	  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	And I click audit on Field "Diastolic Blood Pressure 2"
	And I verify last audit exist
	| Audit Type     | Query Message                                                                         |
	| Query Canceled | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. |
	And I take a screenshot
	And I select link "Form 2" in "Header"	
	When  I enter data in CRF 	  
      | Field                     | Data |
      | Systolic Blood Pressure 2 | 100  |
	And I save the CRF page	
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 	  
      | Field                     | Data |
      | Systolic Blood Pressure 2 | 80   |
	And I save the CRF page		
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-11C	
@validation	
Scenario: @PB-US12940-11C	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 3  | 80   |
      | Diastolic Blood Pressure 3 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I cancel the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3"  
	And I save the CRF page	  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I click audit on Field "Diastolic Blood Pressure 3"
	And I verify last audit exist
	| Audit Type     | Query Message                                                                         |
	| Query Canceled | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. |
	And I take a screenshot
	And I select link "Form 2" in "Header"	
	When I enter data in CRF 	  
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 100  |
	And I save the CRF page	
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	And I enter data in CRF 	  
      | Field                     | Data |
      | Systolic Blood Pressure 3 | 80   |	
	And I save the CRF page	
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-11D	
@validation	
Scenario: @PB-US12940-11D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 4  | 80   |
      | Diastolic Blood Pressure 4 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I cancel the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4"  
	And I save the CRF page	  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I click audit on Field "Diastolic Blood Pressure 4"
	And I verify last audit exist
	| Audit Type     | Query Message                                                                         |
	| Query Canceled | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. |
	And I take a screenshot
	And I select link "Form 2" in "Header"	
	When I enter data in CRF 	  
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 100  |
	And I save the CRF page	
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 	  
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 80   |	
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	  
@PB-US12940-12A	
@validation	
Scenario: @PB-US12940-12A	 As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field B, if I then entered the same bad data in field B as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 1  | 80   |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I cancel the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1"  
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	And I click audit on Field "Diastolic Blood Pressure 1"
	And I verify last audit exist
	| Audit Type     | Query Message                                                                         |
	| Query Canceled | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. |
	And I take a screenshot
	And I select link "Form 2" in "Header"	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 75   |	
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 90   |	
	And I save the CRF page	
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-12B	
@validation	
Scenario: @PB-US12940-12B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field B, if I then entered the same bad data in field B as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	When I enter data in CRF
      | Field                      | Data |
      | Systolic Blood Pressure 2  | 80   |
      | Diastolic Blood Pressure 2 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I cancel the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 2"  
	And I save the CRF page
	Then I verify Query is not displayed
	  | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I click audit on Field "Diastolic Blood Pressure 2"
	And I verify last audit exist
	| Audit Type     | Query Message                                                                         |
	| Query Canceled | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. |
	And I take a screenshot
	And I select link "Form 2" in "Header"
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 75   |	
	And I save the CRF page
	Then I verify Query is not displayed
	  | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot		
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 90   |	
	And I save the CRF page
	Then I verify Query is not displayed
	  | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-12C
@validation		
Scenario: @PB-US12940-12C	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field B, if I then entered the same bad data in field B as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = false
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	When I enter data in CRF
		| Field                      | Data |
		| Systolic Blood Pressure 3  | 80   |
		| Diastolic Blood Pressure 3 | 90   |
	And I save the CRF page
	Then I verify Query is displayed
		 | Field                      | Query Message                                                                         | Answered | Closed |
		 | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I cancel the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3"  
	And I save the CRF page
	Then I verify Query is not displayed
	    | Field                      | Query Message                                                                         | Answered | Closed |
        | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I click audit on Field "Diastolic Blood Pressure 3"
	And I verify last audit exist
	| Audit Type     | Query Message                                                                         |
	| Query Canceled | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. |
	And I take a screenshot
	And I select link "Form 2" in "Header"
	When I enter data in CRF 	  
        | Field                      | Data |
        | Diastolic Blood Pressure 3 | 75   |	
	And I save the CRF page
	Then I verify Query is not displayed
	    | Field                      | Query Message                                                                         | Answered | Closed |
        | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 90   |	
	And I save the CRF page
	Then I verify Query is not displayed
	    | Field                      | Query Message                                                                         | Answered | Closed |
        | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-12D	
@validation	
Scenario: @PB-US12940-12D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field B, if I then entered the same bad data in field B as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I enter data in CRF
      |Field						|Data  |
      |Systolic Blood Pressure 4	|80		|
      |Diastolic Blood Pressure 4	|90		|
	And I save the CRF page
	Then I verify Query is displayed
		 | Field                      | Query Message                                                                         | Answered | Closed |
		 | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I cancel the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4"  
	And I save the CRF page
	Then I verify Query is not displayed
	    | Field                      | Query Message                                                                         | Answered | Closed |
        | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I click audit on Field "Diastolic Blood Pressure 4"
	And I verify last audit exist
	| Audit Type     | Query Message                                                                         |
	| Query Canceled | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. |
	And I take a screenshot
	And I select link "Form 2" in "Header"
	When I enter data in CRF 	  
        | Field                      | Data |
        | Diastolic Blood Pressure 4 | 75   |	
	And I save the CRF page
	Then I verify Query is not displayed
	    | Field                      | Query Message                                                                         | Answered | Closed |
        | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 90   |	
	And I save the CRF page
	Then I verify Query is not displayed
	    | Field                      | Query Message                                                                         | Answered | Closed |
        | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
