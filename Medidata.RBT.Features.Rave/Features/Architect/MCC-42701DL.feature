@FT_@MCC-42701
@ignore
Feature: Architect download will contain Coder settings and Architect upload will save Coder settings when a URL that has Coder registered

Background:

    Given role "SUPER ROLE 1" exists
    Given xml draft "MCC-42701DL.xml" is Uploaded
    Given study "MCC-42701DL" is assigned to Site "Site 1"
    Given following Project assignments exist
    | User         | Project     | Environment | Role         | Site   | SecurityRole          |
    | SUPER USER 1 | MCC-42701DL | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | 
    Given I publish and push eCRF "MCC-42701DL.xml" to "Version 1"
    When I login to Rave with user "SUPER USER 1"

@Release_2013.1.0
@MCC-42701-01
@SJ30.JAN.2013
@Draft
    
Scenario: MCC-42701-01 When downloading an architect spreadsheet for a URL that has Coder registered, the Coder settings will be included
	
	When I navigate to "Architect"
	And I select "Project" link "MCC-42701DL" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42707"
	And I edit Field "varcheckbx3"
	And I choose "CODER- AZDD" from "Coding Dictionary:"
	And I select link "Save"
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data    | Control Type |
		| Coding Level       | PRODUCT | dropdown     |
		| Priority           | 2       | textbox      |
	And I set the coder workflow variables
		| Name               | Value|
		| IsApprovalRequired | True |
		| IsAutoApproval     | True |
	And I add the coder "Supplemental" terms
		| Name |
		| TEST1|
	And I add the coder "Component" terms
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701DL" in "Active Projects"
	And I select Draft "Draft 1"
	And I click the "Download" button to download
	And I select tab "CoderConfiguration"
	Then I verify "Coder Configuration" spreadsheet data
		| FormOID  | FieldOID    | CodingLevel | Priority | Locale | IsApprovalRequired | IsAutoApproval | Instructions/ Comments |
		| TESTFORM | VARCHECKBX3 | PRODUCT     | 2        |        | True               | True           |                        |
	And I take a screenshot				 
	And I select tab "CoderSupplementalTerms"
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID  | FieldOID    | SupplementalTerm | Instructions/ Comments |
		| TESTFORM | VARCHECKBX3 | TEST1            |                        |
	And I take a screenshot		   
	And I select tab "CoderComponentTerms"
	And I verify "CoderComponentTerms" spreadsheet data
		| FormOID  | FieldOID    | ComponentTerm | ComponentName    | Instructions/ Comments |
		| TESTFORM | VARCHECKBX3 | VARCHECKBX    | DRUGRECORDNUMBER |                        |
	And I take a screenshot



@Release_2013.1.0
@MCC-42701-02
@SJ30.JAN.2013
@Draft
    
Scenario: MCC-42701-01 When downloading an architect spreadsheet for a URL that has Coder registered, the Coder settings will be included
	
	When I navigate to "Architect"
	And I select "Project" link "MCC-42701DL" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42707"
	And I edit Field "varcheckbx3"
	And I choose "CODER- AZDD" from "Coding Dictionary:"
	And I select link "Save"
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data    | Control Type |
		| Coding Level       | PRODUCT | dropdown     |
		| Priority           | 3       | textbox      |
	And I set the coder workflow variables
		| Name               | Value|
		| IsApprovalRequired | True |
		| IsAutoApproval     | True |
	And I delete the coder "Supplemental" terms
		| Name |
		| TEST1|
	And I delete the coder "Component" terms
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701DL" in "Active Projects"
	And I select Draft "Draft 1"
	And I click the "Download" button to download
	And I select tab "CoderConfiguration"
	Then I verify "Coder Configuration" spreadsheet data
		| FormOID  | FieldOID    | CodingLevel | Priority | Locale | IsApprovalRequired | IsAutoApproval | Instructions/ Comments |
		| TESTFORM | VARCHECKBX3 | PRODUCT     | 3        |        | True               | True           |                        |
	And I take a screenshot				 
	And I select tab "CoderSupplementalTerms"
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID | FieldOID | SupplementalTerm | Instructions/ Comments |
		|         |          |                  |                        |
	And I take a screenshot		   
	And I select tab "CoderComponentTerms"
	And I verify "CoderComponentTerms" spreadsheet data
		| FormOID | FieldOID | ComponentTerm | ComponentName | Instructions/ Comments |
		|         |          |               |               |                        |
	And I take a screenshot




@Release_2013.1.0
@MCC-42701-03
@SJ30.JAN.2013
@Draft

Scenario: MCC-42701-03 When downloading an architect draft template for a URL that has Coder registered, the Coder settings will be included
		
	
	When I navigate to "Architect"
	And I click the "Get Draft Template" button to download
	And I select tab "CoderConfiguration"
	Then I verify "Coder Configuration" spreadsheet data
		| FormOID | FieldOID| CodingLevel | Priority | Locale | IsApprovalRequired | IsAutoApproval | Instructions/ Comments|   
		|		  |		 	|			  |		  	 |		  |					   |				|						|
	And I take a screenshot				 
	And I select tab "CoderSupplementalTerms"
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID | FieldOID| SupplementalTerm | Instructions/ Comments|   
		|		  |		 	|			   	   |		  		       |
	And I take a screenshot		   
	And I select tab "CoderComponentTerms"
	And I verify "CoderComponentTerms" spreadsheet data
		| FormOID | FieldOID| ComponentTerm | ComponentName | Instructions/ Comments|   
		|		  |		 	|			   	|		  		|				        |
	And I take a screenshot 	