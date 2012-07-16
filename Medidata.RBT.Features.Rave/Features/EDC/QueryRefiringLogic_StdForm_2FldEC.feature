# The logic that is used to determine when a query that has already been cancelled or closed should or should not be re-fired in Rave 
# will be examining the answered query data instead of the original query data.
#TESTING FOR STANDARD FORM WITH 2 FIELDS INVOLVED IN QUERY FIRING
#Project to be uploaded in excel spreadsheet 'Standard Study'

Feature: QueryRefiringLogic
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
@Draft	
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
@Draft	
Scenario: @PB-US12940-01B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in field A, if I then entered the same bad data in field A as when the query was closed, then the system should not refire a query on field B. 
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
#Investigate: query is refiring
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    |False   |	
	And I take a screenshot 

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-01C	
@Draft	
Scenario: @PB-US12940-01C As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in field A, if I then entered the same bad data in field A as when the query was closed, then the system should not refire a query on field B. 
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
@Draft		
Scenario: @PB-US12940-01D As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in field A, if I then entered the same bad data in field A as when the query was closed, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = true
# Verify with Lily	
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
	Then I verify Query is displayed
      |Field						|
      |Diastolic Blood Pressure 4	|	
	And I take a screenshot 
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 80   |
	And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot 
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4"
	And I save the CRF page  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-02A	
@Draft	
Scenario: As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in field B, if I then entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
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
	When I answer the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct."
	And I save the CRF page  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
    And I take a screenshot
	When I  close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1"
	And I save the CRF page  	  
	Then I verify Query is displayed
     | Field                      | Query Message                                                                         | Answered | Closed |
     | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot
	When I enter data in CRF
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 70   |
	And I save the CRF page
	# Verify with Lily
	Then I verify Query is not displayed
     | Field                      | Query Message                                                                         | Answered | Closed |
     | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
    #Then I verify Query is displayed
    #  |Field						|
    #  |Diastolic Blood Pressure 1	|
	And I take a screenshot 
	When I enter data in CRF and
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 90   |
	And I save the CRF page
	Then I verify Query is not displayed
	  | Field                      | Query Message                                                                         | Answered | Closed |
	  | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	#verify with Lily


#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-02B	
@Draft	
Scenario: @PB-US12940-02B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in field B, if I then entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
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
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 70   |
    And I save the CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
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
@Draft	
Scenario:@PB-US12940-02C As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in field B, if I then entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
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
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	#verify with Lily
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
      |Field						|Data  |
      |Diastolic Blood Pressure 3	|90 	|
	And I save the CRF page
    Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	#Verify w Lily
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-02D	
@Draft	
Scenario: @PB-US12940-02D As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, and I entered good data in field B, if I then entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
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
      | Diastolic Blood Pressure 4 | 90   |	
    And I save the CRF page
	Then I verify Query is displayed
	  | Field                      | Query Message                                                                         | Answered | Closed |
	  | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |		  
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-03A	
@Draft	
Scenario: As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field B. 
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
	When I close the Query "Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Systolic Blood Pressure 1" 	  
	And I save the CRF page  	  
    Then I verify Query is displayed	 
       | Field                      | Query Message                                                                         | Answered | Closed |
       | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 100  |
    And I save the CRF page
	Then I verify Query is displayed	 
       | Field                      | Query Message                                                                         | Answered | Closed |
       | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 1 | 85   |	
	Then I verify Query is not displayed	 
       | Field                      | Query Message                                                                         | Answered | Closed |
       | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	# Verify with Lily

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-03B	
@Draft	
Scenario: @PB-US12940-03B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = false.
# Verify with Lily	
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
      | Systolic Blood Pressure 2 | 85   |
	And I save the CRF page  	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |	  	 
# Verify with Lily
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-03C	
@Draft	
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
	And I enter the following Datas for the "Form 2" form	  
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
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
# Verify with Lily

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-03D	
@Draft	
Scenario:@PB-US12940-03D As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I entered good data in field A and then again entered the same bad data in field A as when the query was closed, then the system should not refire a query on field B. 
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
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
   	And I take a screenshot				
	And I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 85   |	
    And I save CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
   	And I take a screenshot		
# Verify with Lily	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-04A	
@Draft	
Scenario: As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I entered good data in field B and then again entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
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
    And I save CRF page
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I answer the Query " Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct" 
  	And I enter the following Datas for the "Form 2" form	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
    And I take a screenshot	
	When I close the Query " Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" 
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
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False     | False  |
    And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 85   |
	And I save the CRF page		  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
    And I take a screenshot	
	# Verify with Lily

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-04B	
@Draft	
Scenario: @PB-US12940-04B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I entered good data in field B and then again entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
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
	When I enter the following Datas for the "Form 2" form	  
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 70   |
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
  	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 2 | 85   |	
	And I save the CRF page  
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
  	And I take a screenshot	
# Verify with Lily	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-04C		
@Draft
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
	When I answer the Query " Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct" 
  	And I enter the following Datas for the "Form 2" form	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 70   |
	And I save the CRF page 
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 3 | 85   |	
	And I save the CRF page	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
	# verify with Lily
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-04D	
@Draft	
Scenario: @PB-US12940-04D	 As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I entered good data in field B and then again entered the same bad data in field B as when the query was closed, then the system should not refire a query on field B. 
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
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 85   |	  
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot	
	When I close the Query " Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 4 "
	And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 70   |
	And I save the CRF page 	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot	 
	And I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 4 | 85   |
	And I save the CRF page 		  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | True   |
	And I take a screenshot	 
	# Verify with Lily

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	  
@PB-US12940-05A	
@Draft	
Scenario: As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field B. 
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
	When I answer the Query " Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1" with "Data is correct" 
  	And I enter the following Datas for the "Form 2" form	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 85   |	  
	And I save the CRF page 
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |
	And I take a screenshot		
	When I close the Query " Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 1"
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
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-05B	
@Draft	
Scenario: @PB-US12940-05B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field B. 
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
      | Systolic Blood Pressure 2 | 85   |
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
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 2 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot
# Verify with Lily

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-05C	
@Draft	
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
	When I answer the Query " Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify." on Field "Diastolic Blood Pressure 3" with "Data is correct"
	And I save the CRF page
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
      | Systolic Blood Pressure 3 | 80   |
	And I save the CRF page
	Then I verify Query is not displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 3 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	

# Verify with Lily

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-05D	
@Draft	
Scenario: @PB-US12940-05D As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the original bad data in field A, then the system should refire a query on field B. 
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
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  
	And I take a screenshot	
	When I enter data in CRF   
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 85   |	  
	And I save the CRF page 	  
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
	When I enter data in CRF 
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 100  |
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
      | Field                     | Data |
      | Systolic Blood Pressure 4 | 80   |
	And I save the CRF page	
	Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 4 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | False    | False  |
	And I take a screenshot	
# Verify with Lily

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	  
@PB-US12940-06A	
@Draft	
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
	When I enter data in CRF 	  
      | Field                      | Data |
      | Diastolic Blood Pressure 1 | 85   | 
	And I save the CRF page 	
    Then I verify Query is displayed
      | Field                      | Query Message                                                                         | Answered | Closed |
      | Diastolic Blood Pressure 1 | Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify. | True     | False  |





	And I should see old answered query for the following fields
      |Field						|
      |Diastolic Blood Pressure 1	|
	And I take a screenshot	
	When I close the Query "{message}" on Field "{fieldNames}" for the following fields
      |Field						|
      |Diastolic Blood Pressure 1	|
	And I save the CRF page		  
	Then I should not see old open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 1	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 1	|70		|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 1	|		  
	And I take a screenshot	
	When I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 1	|90		|
	And I save the CRF page		  
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 1	|	
	And I take a screenshot	















		
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	  
@PB-US12940-06B	
@Draft	
Scenario: @PB-US12940-06B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I then entered the original bad data in field B, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I enter data in CRF 
      |Field						|Data  |
      |Systolic Blood Pressure 2	|80		|
      |Diastolic Blood Pressure 2	|90		|
	Then I verify Query is displayed
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 2	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I enter the following Datas for the "Form 2" form	  
      |Field						|Data  |
      |Diastolic Blood Pressure 2	|85		|  
	And I save the CRF page 	
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 2	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 2	|70		|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 2	|		  
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 2	|90		|		  
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 2	|
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-06C	
@Draft	
Scenario: @PB-US12940-06C	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I then entered the original bad data in field B, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | sub               |
	And I select Form "Form 2"
	And I enter data in CRF 
      |Field						|Data  |
      |Systolic Blood Pressure 3	|80		|
      |Diastolic Blood Pressure 3	|90		|
	Then I verify Query is displayed
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 3	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I answer the Query "{message}" on Field "{fieldName}" with "Data is correct"
      |Field						|Query Response  	|
      |Diastolic Blood Pressure 3	|Data is correct.	|  
  	And I enter the following Datas for the "Form 2" form	  
      |Field						|Data  |
      |Diastolic Blood Pressure 3	|85		|  
	And I save the CRF page 	
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 3	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 3	|70		|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 3	|		  
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 3	|90		|	  
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 3	|	  
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-06D	
@Draft	
Scenario: @PB-US12940-06D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I then entered the original bad data in field B, then the system should refire a query on field B. 
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
	Then I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 4	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I enter the following Datas for the "Form 2" form	  
      |Field						|Data  |
      |Diastolic Blood Pressure 4	|85		|	  
	And I save the CRF page 	
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 4	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I should see old answered query for the following fields
      |Field						|
      |Diastolic Blood Pressure 4	|
	And I take a screenshot	
	When I close the Query "{message}" on Field "{fieldNames}" for the following fields
      |Field						|
      |Diastolic Blood Pressure 4	|
	And I save the CRF page 	  
	Then I should not see old open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 4	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 4	|70		|	
	Then I should see answered query for the following fields
      |Field						|
      |Diastolic Blood Pressure 4	|		  
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 4	|90		|		  
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|	  
      |Diastolic Blood Pressure 4	|	
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-07A	
@Draft	
Scenario: @PB-US12940-07A As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 1	|80		|
      |Diastolic Blood Pressure 1	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 1	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I answer query
      |Field						|Query Response  	|
      |Diastolic Blood Pressure 1	|Data is correct.	|
	And I save the CRF page  
	When I close the Query "{message}" on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 1	|		  
	And I save the CRF page  	  
	Then I should see closed query
      |Field						|
      |Diastolic Blood Pressure 1	|
	And I take a screenshot	
	And I enter data in CRF 
      |Field						|Data  |
      |Systolic Blood Pressure 1	|85 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 1	|
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-07B	
@Draft	
Scenario: @PB-US12940-07B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 2	|80		|
      |Diastolic Blood Pressure 2	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 2	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	And I enter data in CRF 
      |Field						|Data  |
      |Systolic Blood Pressure 2	|85 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 2	|	
	And I take a screenshot	
	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-07C	
@Draft	
Scenario: @PB-US12940-07C	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 3	|80		|
      |Diastolic Blood Pressure 3	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 3	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I answer query
      |Field						|Query Response  	|
      |Diastolic Blood Pressure 3	|Data is correct.	|
	And I save the CRF page  
	Then I should see closed query
      |Field						|
      |Diastolic Blood Pressure 3	|	
	And I take a screenshot	
	And I enter data in CRF 
      |Field						|Data  |
      |Systolic Blood Pressure 3	|85 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|	
      |Diastolic Blood Pressure 3	|
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-07D
@Draft		
Scenario: @PB-US12940-07D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field A, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 4	|80		|
      |Diastolic Blood Pressure 4	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 4	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	And I enter data in CRF 
      |Field						|Data  |
      |Systolic Blood Pressure 4	|85 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 4	|
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	  
@PB-US12940-08A		
@Draft
Scenario: @PB-US12940-08A	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field B, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = true
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 1	|80		|
      |Diastolic Blood Pressure 1	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 1	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I answer query
      |Field						|Query Response  	|
      |Diastolic Blood Pressure 1	|Data is correct.	|
	And I save the CRF page  
	When I close the Query "{message}" on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 1	|		  
	And I save the CRF page  	  
	Then I should see closed query
      |Field						|
      |Diastolic Blood Pressure 1	|
	And I take a screenshot	
	And I enter data in CRF 
      |Field						|Data  |
      |Diastolic Blood Pressure 1	|100 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 1	|	
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11		
@PB-US12940-08B	
@Draft	
Scenario: @PB-US12940-08B As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field B, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 2	|80		|
      |Diastolic Blood Pressure 2	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 2	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	And I enter data in CRF 
      |Field						|Data  |
      |Diastolic Blood Pressure 2	|100 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 2	|		
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-08C		
@Draft
Scenario: @PB-US12940-08C As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field B, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 3	|80		|
      |Diastolic Blood Pressure 3	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 3	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I answer query
      |Field						|Query Response  	|
      |Diastolic Blood Pressure 3	|Data is correct.	|
	And I save the CRF page  
	Then I should see closed query
      |Field						|
      |Diastolic Blood Pressure 3	|	
	And I take a screenshot	
	And I enter data in CRF 
      |Field						|Data  |
      |Diastolic Blood Pressure 3	|100 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 3	|	
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-08D	
@Draft	
Scenario: @PB-US12940-08D	 As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in field B, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 4	|80		|
      |Diastolic Blood Pressure 4	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 4	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	And I enter data in CRF 
      |Field						|Data  |
      |Diastolic Blood Pressure 4	|100 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 4	|	
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11 
@PB-US12940-09A	
@Draft	
Scenario: @PB-US12940-09A	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the new bad data in field A, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 1	|80		|
      |Diastolic Blood Pressure 1	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 1	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I answer query
      |Field						|Query Response  	|
      |Diastolic Blood Pressure 1	|Data is correct.	|
	And I enter the following Datas for the "Form 2" form	  
      |Field						|Data  |
      |Systolic Blood Pressure 1	|85		|	  
	And I save the CRF page 	  
	Then I verify Query is displayed	 
      |Field						|	
      |Diastolic Blood Pressure 1	|	  	  
	And I should see old answered query for the following fields
      |Field						|
      |Diastolic Blood Pressure 1	|
	And I take a screenshot	
	When I close the Query "{message}" on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 1	|	  
	And I save the CRF page  	  
	Then I should see closed query
      |Field						|
      |Diastolic Blood Pressure 1	|
	And I take a screenshot	
	And I enter data in CRF 
      |Field						|Data  |
      |Systolic Blood Pressure 1	|70 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 1	|	
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-09B	
@Draft	
Scenario: @PB-US12940-09B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the new bad data in field A, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 2	|80		|
      |Diastolic Blood Pressure 2	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 2	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	And I enter the following Datas for the "Form 2" form	  
      |Field						|Data  |
      |Systolic Blood Pressure 2	|85		|	  
	And I save the CRF page 	  
	Then I verify Query is displayed	 
      |Field						|		  
      |Diastolic Blood Pressure 2	|	  	  
	And I enter data in CRF 
      |Field						|Data  |
      |Systolic Blood Pressure 2	|70 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 2	|	
	And I take a screenshot	
		
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-09C	
@Draft	
Scenario: @PB-US12940-09C	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the new bad data in field A, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 3	|80		|
      |Diastolic Blood Pressure 3	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 3	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I answer the Query "{message}" on Field "{fieldName}" with "Data is correct"
      |Field						|Query Response  	|
      |Diastolic Blood Pressure 3	|Data is correct.	|
	And I enter the following Datas for the "Form 2" form	  
      |Field						|Data  |
      |Systolic Blood Pressure 3	|85		|	  
	And I save the CRF page 	  
	Then I verify Query is displayed	 
      |Field						|	
      |Diastolic Blood Pressure 3	|		  	  
	And I enter data in CRF 
      |Field						|Data  |
      |Systolic Blood Pressure 3	|70 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 3	|	  	
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-09D	
@Draft	
Scenario: @PB-US12940-09D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field A to another bad data, and the query is then closed, if I then entered the new bad data in field A, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 4	|80		|
      |Diastolic Blood Pressure 4	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 4	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I enter the following Datas for the "Form 2" form	  
      |Field						|Data  |
      |Systolic Blood Pressure 4	|85		|	  
	And I save the CRF page 	  
	Then I verify Query is displayed	 
      |Field						|		
      |Diastolic Blood Pressure 4	|
    And I take a screenshot	
	When I close the Query "{message}" on Field "{fieldNames}"
      |Field						|
      |Diastolic Blood Pressure 4	|	  
	And I save the CRF page  	  
	Then I should see closed query
      |Field						|
      |Diastolic Blood Pressure 4	|
	And I take a screenshot	
	And I enter data in CRF 
      |Field						|Data  |
      |Systolic Blood Pressure 4	|70 	|
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|	  
      |Diastolic Blood Pressure 4	|	
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-10A	
@Draft	
Scenario: @PB-US12940-10A As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I then entered the new bad data in field B, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 1	|80		|
      |Diastolic Blood Pressure 1	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 1	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I answer query
      |Field						|Query Response  	|
      |Diastolic Blood Pressure 1	|Data is correct.	|  
  	And I enter the following Datas for the "Form 2" form	  
      |Field						|Data  |
      |Diastolic Blood Pressure 1	|85		|	  
	And I save the CRF page 	
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 1	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I should see old answered query for the following fields
      |Field						|
      |Diastolic Blood Pressure 1	|
	And I take a screenshot	
	When I close the Query "{message}" on Field "{fieldNames}" 
      |Field						|
      |Diastolic Blood Pressure 1	|
	And I save the CRF page 	  
	Then I should not see old open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 1	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 1	|100	|		  
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
	  |Field						|
      |Diastolic Blood Pressure 1	|	  	  
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-10B	
@Draft	
Scenario: @PB-US12940-10B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I then entered the new bad data in field B, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 2	|80		|
      |Diastolic Blood Pressure 2	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 2	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I enter the following Datas for the "Form 2" form	  
      |Field						|Data  |
      |Diastolic Blood Pressure 2	|85		|	  
	And I save the CRF page 	
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 2	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 2	|100	|		  
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
	  |Field						|	  
      |Diastolic Blood Pressure 2	|	  
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-10C	
@Draft	
Scenario: @PB-US12940-10C As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I then entered the new bad data in field B, then the system should refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 3	|80		|
      |Diastolic Blood Pressure 3	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 3	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I answer query
      |Field						|Query Response  	|
      |Diastolic Blood Pressure 3	|Data is correct.	|  
  	And I enter the following Datas for the "Form 2" form	  
      |Field						|Data  |
      |Diastolic Blood Pressure 3	|85		|	  
	And I save the CRF page 	
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 3	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 3	|100	|		  
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
	  |Field						|
      |Diastolic Blood Pressure 3	|	  
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-10D	
@Draft	
Scenario: @PB-US12940-10D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I answered the query and I changed the data in field B to another bad data, and the query is then closed, if I then entered the new bad data in field B, then the system should refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 4	|80		|
      |Diastolic Blood Pressure 4	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 4	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
  	When I enter the following Datas for the "Form 2" form	  
      |Field						|Data  |
      |Diastolic Blood Pressure 4	|85		|	  
	And I save the CRF page 	
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 4	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I should see old answered query for the following fields
      |Field						|
      |Diastolic Blood Pressure 4	|
	And I take a screenshot	
	When I close the Query "{message}" on Field "{fieldNames}" 
      |Field						|
      |Diastolic Blood Pressure 4	|
	And I save the CRF page 	  
	Then I should not see old open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 4	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 4	|100	|		  
	Then I verify Query with message "{message}" is not displayed on Field "{fieldNames}"
	  |Field						|
      |Diastolic Blood Pressure 4	|	  
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11 
@PB-US12940-11A		
@Draft
Scenario: @PB-US12940-11A	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 1	|80		|
      |Diastolic Blood Pressure 1	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 1	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I cancel query
      |Field						|
      |Diastolic Blood Pressure 1	|  
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 1	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Systolic Blood Pressure 1	|100	|
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 1	|	  
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Systolic Blood Pressure 1	|80		|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 1	|		
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-11B		
@Draft
Scenario: @PB-US12940-11B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 2	|80		|
      |Diastolic Blood Pressure 2	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 2	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I cancel query
      |Field						|
      |Diastolic Blood Pressure 2	|	  
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 2	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Systolic Blood Pressure 2	|100	|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 2	|	  
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Systolic Blood Pressure 2	|80		|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 2	|		
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	
@PB-US12940-11C	
@Draft	
Scenario: @PB-US12940-11C	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 3	|80		|
      |Diastolic Blood Pressure 3	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 3	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I cancel query
      |Field						|
      |Diastolic Blood Pressure 3	|	  
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 3	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Systolic Blood Pressure 3	|100	|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 3	|	  
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Systolic Blood Pressure 3	|80		|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 3	|		
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-11D	
@Draft	
Scenario: @PB-US12940-11D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field A, if I then entered the same bad data in field A as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 4	|80		|
      |Diastolic Blood Pressure 4	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 4	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I cancel query
      |Field						|
      |Diastolic Blood Pressure 4	|	  
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 4	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Systolic Blood Pressure 4	|100	|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 4	|	  
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Systolic Blood Pressure 4	|80		|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 4	|		
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11	  
@PB-US12940-12A	
@Draft	
Scenario: @PB-US12940-12A	 As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field B, if I then entered the same bad data in field B as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 1	|80		|
      |Diastolic Blood Pressure 1	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 1	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I cancel query
      |Field						|
      |Diastolic Blood Pressure 1	|	  
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 1	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 1	|75 	|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 1	|	 
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 1	|90		|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 1	|		
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-12B	
@Draft	
Scenario: @PB-US12940-12B	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field B, if I then entered the same bad data in field B as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = false.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 2	|80		|
      |Diastolic Blood Pressure 2	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 2	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I cancel query
      |Field						|
      |Diastolic Blood Pressure 2	|	  
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 2	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 2	|75 	|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 2	|	 
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 2	|90		|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 2	|		
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-12C
@Draft		
Scenario: @PB-US12940-12C	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field B, if I then entered the same bad data in field B as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = true and requires manual close = false
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |	
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 3	|80		|
      |Diastolic Blood Pressure 3	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 3	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I cancel query
      |Field						|
      |Diastolic Blood Pressure 3	|	  
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 3	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 3	|75 	|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 3	|	 
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 3	|90		|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 3	|		
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch11
@PB-US12940-12D	
@Draft	
Scenario: @PB-US12940-12D	As an EDC user, when I entered bad data in field A and field B that resulted in the system opening a query on field B, and I canceled the query, and I entered good data in field B, if I then entered the same bad data in field B as when the query was canceled, then the system should not refire a query on field B. 
Query with requires response = false and requires manual close = true.
	
	Given I select Study "Standard Study" and Site "Site 1"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
		| Subject ID       | SUB {Var(num1)}   |
	And I select Form "Form 2"
	And I have submitted the following Datas for the "Form 2" form
      |Field						|Data  |
      |Systolic Blood Pressure 4	|80		|
      |Diastolic Blood Pressure 4	|90		|
	And I see open query for the following fields
      |Field						|Query Message  																		|
      |Diastolic Blood Pressure 4	|Systolic Blood Pressure must be greater than Diastolic Blood Pressure. Please verify.	|
	And I take a screenshot	
	When I cancel query
      |Field						|
      |Diastolic Blood Pressure 4	|	  
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 4	|
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 4	|75 	|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 4	|	 
	And I take a screenshot	
	And I enter data in CRF 	  
      |Field						|Data  |
      |Diastolic Blood Pressure 4	|90		|	
	Then I should not see open query for the following fields
	  |Field						|
      |Diastolic Blood Pressure 4	|		
	And I take a screenshot	
	  
