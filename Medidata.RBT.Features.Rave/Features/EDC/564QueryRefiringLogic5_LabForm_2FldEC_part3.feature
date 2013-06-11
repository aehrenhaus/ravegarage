
# The logic that is used to determine when a query that has already been cancelled or closed should or should not be re-fired in Rave 
# will be examining the answered query data instead of the original query data.

#TESTING FOR LAB FORM WITH 2 FIELDS INVOLVED IN QUERY FIRING

#-- project to be uploaded in excel spreadsheet 'Standard Study'
@FT_564QueryRefiringLogic5_LabForm_2FldEC_Part3
Feature: US12940_Query_Part3 Refiring Logic5 The logic that is used to determine when a query that has already been cancelled or closed should or should not be re-fired in Rave.
	As a Rave user
	When I manually close a query or cancel, the query should not re-fire if the exact same data is entered into the system
	So that I dont have to re-enter the exact same response

Background:
    Given the following Range Types exist
	| Range Type Name |
	| StandardREG_STD |
	Given xml Lab Configuration "All_STD.xml" is uploaded
	Given role "Edit Check Role" exists
 	Given xml draft "Standard_Study_Draft_2.xml" is Uploaded
	Given Site "Site 1" exists
	Given study "Standard Study" is assigned to Site "Site 1"
	Given I publish and push eCRF "Standard_Study_Draft_2.xml" to "Version 1"
	Given following Project assignments exist
		| User         | Project        | Environment | Role            | Site   | SecurityRole          |
		| SUPER USER 1 | Standard Study | Live: Prod  | Edit Check Role | Site 1 | Project Admin Default |
	Given I login to Rave with user "SUPER USER 1"

    #Given I login to Rave with user "defuser" and password "password"
	#And I select Study "Standard Study" and Site "Site 1"
	#And following Study assignments exist
	#	|User	|Study		    |Role |Site	  |Site Number	|
	#	|User 1 |Standard Study	|cdm1 |Site 1 |S100			|
	#And Role "cdm1" has Action "Query"
	#And Study "Standard Study" has Draft "<Draft1>"
	#And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft1>" to site "Site 1" in Study "Standard Study"




@release_564_Patch11
@PB_US12940_07B	
@ignore
#Failing due to DT14200
@Validation
Scenario: PB_US12940_07B As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, if I then entered new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = false.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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

@release_564_Patch11
@PB_US12940_07C	
@Validation	
Scenario: PB_US12940_07C As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, if I then entered new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = false.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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

@release_564_Patch11
@PB_US12940_07D
@ignore
#Failing due to DT14207	
@Validation	
Scenario: PB_US12940_07D As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, if I then entered new bad data in lab field A, then the system should not refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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

@release_564_Patch11	
@PB_US12940_08A
@Validation		
Scenario: PB_US12940_08A As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, and the query is then closed, if I then entered new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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

@release_564_Patch11
@PB_US12940_08B	
@Validation	
Scenario: PB_US12940_08B As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B,if I then entered new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_08C
@Validation		
Scenario: PB_US12940_08C As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query without changing the data, if I then entered new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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

@release_564_Patch11
@PB_US12940_08D
@Validation		
Scenario: PB_US12940_08D As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, if I then entered new bad data in lab field B, then the system should answers the old query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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

@release_564_Patch11
@PB_US12940_09A	
@Validation	
Scenario: PB_US12940_09A As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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

@release_564_Patch11
@PB_US12940_09B	
@ignore
#Failing due to DT14200	
@Validation
Scenario: PB_US12940_09B As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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

@release_564_Patch11
@PB_US12940_09C	
@ignore
#Failing due to DT14208
@Validation	
Scenario: PB_US12940_09C As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field A to another bad data, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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

@release_564_Patch11
@PB_US12940_09D	
@ignore
#Failing due to DT14207
@Validation	
Scenario: PB_US12940_09D As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I changed the data in lab field A to another bad data, and the query is then closed, if I then entered the new bad data in lab field A, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = true.
	
	And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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

@release_564_Patch11
@PB_US12940_10A	
@Validation	
Scenario: PB_US12940_10A As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, and the query is then closed, if I then entered the new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = true.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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

@release_564_Patch11
@PB_US12940_10B	
@Validation	
Scenario: PB_US12940_10B As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, if I then entered the new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = false and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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
	When I enter data in CRF and save	  
      |Field		                                |Data   |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |1		|	  
	And I verify Query is displayed
      |Field		                                |Query Message  												|Answered| Closed |
      |Lab Field 4 - WBC - rr = F ; rmc = F    	    |Lab Field 4 must be greater than Lab Field 3. Please verify.	|false   |false   |
	And I take a screenshot

@release_564_Patch11
@PB_US12940_10C
@ignore
#Failing due to DT14208
@Validation		
Scenario: PB_US12940_10C As an EDC user, when I entered bad data in lab field A and lab field B that resulted in the system opening a query on lab field B, and I answered the query and I changed the data in lab field B to another bad data, if I then entered the new bad data in lab field B, then the system should refire a query on lab field B. Query with requires response = true and requires manual close = false.

    And I create a Subject
	| Field            | Data              |
	| Subject Number   | {RndNum<num1>(5)} |
	| Subject Initials | SUB               |
	| Subject ID       | SUB {Var(num1)}   |	
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