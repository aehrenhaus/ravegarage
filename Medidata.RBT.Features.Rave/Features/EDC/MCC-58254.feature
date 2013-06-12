@FT_MCC-58254

Feature: MCC-58254 Opened Queries are not auto answered and Closed when conditions are met.
	As a Rave user
	I want to change data on the field
	So query is auto cloased on the field
	
Background:
	Given role "MCC-58254 Role" exists
 	Given xml draft "MCC-58254_Draft_1.xml" is Uploaded
	Given Site "Site 1" exists
	Given study "MCC-58254" is assigned to Site "Site 1"	
	Given I publish and push eCRF "MCC-58254_Draft_1.xml" to "Version1" with study environment "Prod" for site "Site 1"
	Given following Project assignments exist
		| User         | Project   | Environment | Role           | Site   | SecurityRole          |
		| SUPER USER 1 | MCC-58254 | Live: Prod  | MCC-58254 Role | Site 1 | Project Admin Default |

#----------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PB_MCC_58254_01
@Validation
Scenario: PB_MCC_58254_01 As an EDC user, when a query is auto answered and auto closed with the data, then queries are not displayed. 
#Query with requires response = true and requires manual close = true.
	
	Given I login to Rave with user "SUPER USER 1"
	And I select Study "MCC-58254" and Site "Site 1"	
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "Mixed Form"
	And I enter data in CRF and save
	    | Field       | Data | Control Type |
	    | Standard 1  |      | textbox      |
	    | Log Field 1 |      | textbox      |
	    | Date Time   |      | dateTime     |
	And I take a screenshot
	And I open log line 1
	And I verify Not Requires Response Query with message "Required Field Checks" is displayed on Field "Standard 1"
	And I verify Not Requires Response Query with message "Required Field Checks" is displayed on Field "Log Field 1"
	And I verify Not Requires Response Query with message "Required Field Checks" is displayed on Field "Date Time"
	And I take a screenshot
	When I enter data in CRF and save
	    | Field           | Data        | Control Type |
	    | Standard 1      | 10          | textbox      |
	    | Log Field 1     | 10          | textbox      |
	    | Date Time       | 08 Apr 2013 | dateTime     |	
	And I open log line 1
	Then I verify Query is not displayed
      | Field      | Query Message         | Answered | Closed |
      | Standard 1 | Required Field Checks | true     | true   |
	And I verify Query is not displayed
      | Field     | Query Message         | Answered | Closed |
      | Date Time | Required Field Checks | true     | true   |  
	And I verify Query is not displayed
      | Field       | Query Message         | Answered | Closed |
      | Log Field 1 | Required Field Checks | true     | true   |
	And I take a screenshot	
		
#----------------------------------------------------------------------------------------------------------------------------------
@release_564_Patch12_CMP
@PB_MCC_58254_02
@Validation
Scenario: PB_MCC_58254_02 As an EDC user, when a query is auto answered and auto closed with the data, then queries are not displayed. 
#Query with requires response = true and requires manual close = true.
	
	Given I login to Rave with user "SUPER USER 1"
	And I select Study "MCC-58254" and Site "Site 1"	
    And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "MCC"
	And I enter data in CRF and save
	    | Field               | Data | Control Type |
	    | Age Is Less than 18 |      | textbox      |
	    | Age Null            |      | textbox      |
	And I take a screenshot			   
	And I verify Not Requires Response Query with message "Age is less than 18" is displayed on Field "Age Is Less than 18"
	And I verify Not Requires Response Query with message "Age is Null" is displayed on Field "Age Null"
	And I take a screenshot
	When I enter data in CRF and save
	    | Field               | Data | Control Type |
	    | Age Is Less than 18 | 10   | textbox      |
	    | Age Null            | 10   | textbox      |  
	Then I verify Query is not displayed
      | Field               | Query Message       | Answered | Closed |
      | Age Is Less than 18 | Age is less than 18 | true     | true   |
	And I verify Query is not displayed
      | Field    | Query Message | Answered | Closed |
      | Age Null | Age is Null   | true     | true   |
	And I take a screenshot		
