@FT_@MCC-42701DL
#@ignore
Feature: MCC-42701DL Architect download will contain Coder settings and Architect upload will save Coder settings when a URL that has Coder registered

Background:

    Given role "SUPER ROLE 1" exists
    Given study "MCC-42701DL" exists
	Given study "MCC-42701-001DL" exists
	
	Given coding dictionary "AZDD" version "Coder" exists with following coding columns
	| Coding Column Name |
	| PRODUCT            |
	| ATC                |
	| PRODUCTSYNONYM     |
	Given coding dictionary "AZDD" coding column "PRODUCT" has following coding level components
	| OID              |
	| DRUGRECORDNUMBER |
	
	Given coding dictionary "JDrug" version "Coder" exists with following coding columns
	| Coding Column Name |
	| PRODUCT            |
	| ATC                |
	Given coding dictionary "JDrug" coding column "PRODUCT" has following coding level components
	| OID              |
	| DRUGRECORDNUMBER |

	Given coding dictionary "MedDRA" version "Coder" exists with following coding columns
	| Coding Column Name |
	| PRODUCT            |
	| ATC                |
	| SOC                |
	Given coding dictionary "MedDRA" coding column "PRODUCT" has following coding level components
	| OID              |
	| DRUGRECORDNUMBER |

	Given coding dictionary "WHODRUGB2" version "Coder" exists with following coding columns
	| Coding Column Name |
	| PRODUCT            |
	| ATC                |
	Given coding dictionary "WHODRUGB2" coding column "PRODUCT" has following coding level components
	| OID              |
	| DRUGRECORDNUMBER |
	
	Given following locales exist for the coding dictionary
	| Coding Dictionary Name | Locale |
	| AZDD                   | eng    |
	| JDrug                  | eng    |
	| MedDRA                 | eng    |
	| MedDRA                 | jpn    |
	| WHODRUGB2              | eng    |
	Given following coding dictionary assignments exist
	| Project     | Coding Dictionary |
	| MCC-42701DL | AZDD              |
	| MCC-42701DL | JDrug             |
	| MCC-42701DL | MedDRA            |
	| MCC-42701DL | WHODRUGB2         |
    Given study "MCC-42701DL" is assigned to Site "Site 1"
	Given study "MCC-42701-001DL" is assigned to Site "Site 1"
    Given following Project assignments exist
	| User         | Project         | Environment | Role         | Site   | SecurityRole          |
	| SUPER USER 1 | MCC-42701DL     | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
	| SUPER USER 1 | MCC-42701-001DL | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
    Given I login to Rave with user "SUPER USER 1"


@Release_2013.1.0
@MCC-42701-01
@SJ07.FEB.2013
@Draft
    
Scenario: MCC-42701-01 When downloading an architect spreadsheet for a URL that has Coder registered, the Coder settings will be included
	
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701DL" in "Active Projects"
	And I select Draft "Draft 001"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I choose "CODER- AZDD" from "Coding Dictionary"
	And I select link "Save"
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data    | Control Type |
		| Coding Level       | PRODUCT | dropdown     |
		| Priority           | 2       | textbox      |
	And I set the coder workflow variables
		| Name               | Value |
		| IsApprovalRequired | False |
		| IsAutoApproval     | False |
	And I add the coder "Supplemental" terms
		| Name  |
		| TEST1 |
	And I add the coder "Component" terms
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701DL" in "Active Projects"
	And I select Draft "Draft 001"
	And I click the "Download" button to download
	Then I verify "CoderConfiguration" spreadsheet data
		| FormOID  | FieldOID    | CodingLevel    | Priority | Locale | IsApprovalRequired | IsAutoApproval |
		| ETE1     | CODERTERM1  | LLT            | 1        | eng    | False              | True           |
		| ETE1     | JDT         | DrugName       | 1        | jpn    | False              | True           |
		| ETE2     | CODERFIELD2 | PRODUCTSYNONYM | 1        | eng    | False              | True           |
		| TESTFORM | VARCHECKBX3 | PRODUCT        | 2        | eng    | False              | False          |
	And I take a screenshot				 
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID  | FieldOID    | SupplementalTerm |
		| TESTFORM | VARCHECKBX3 | TEST1            |
	And I take a screenshot	
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID  | FieldOID    | SupplementalTerm | ComponentName    |
		| TESTFORM | VARCHECKBX3 | VARCHECKBX       | DRUGRECORDNUMBER |
	And I take a screenshot



@Release_2013.1.0
@MCC-42701-02
@SJ07.FEB.2013
@Draft
    
Scenario: MCC-42701-01 When delete Supplemental and Component terms and downloading an architect spreadsheet for a URL that has Coder registered and, the Coder settings will be included
	
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701DL" in "Active Projects"
	And I select Draft "Draft 001"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx2"
	And I choose "CODER- AZDD" from "Coding Dictionary"
	And I select link "Save"
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data    | Control Type |
		| Coding Level       | PRODUCT | dropdown     |
		| Priority           | 2       | textbox      |
	And I set the coder workflow variables
		| Name               | Value |
		| IsApprovalRequired | False |
		| IsAutoApproval     | False |
	And I add the coder "Supplemental" terms
		| Name  |
		| TEST1 |
	And I add the coder "Component" terms
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701DL" in "Active Projects"
	And I select Draft "Draft 001"
	And I click the "Download" button to download
	Then I verify "CoderConfiguration" spreadsheet data
		| FormOID  | FieldOID    | CodingLevel    | Priority | Locale | IsApprovalRequired | IsAutoApproval |
		| ETE1     | CODERTERM1  | LLT            | 1        | eng    | False              | True           |
		| ETE1     | JDT         | DrugName       | 1        | jpn    | False              | True           |
		| ETE2     | CODERFIELD2 | PRODUCTSYNONYM | 1        | eng    | False              | True           |
		| TESTFORM | VARCHECKBX3 | PRODUCT        | 2        | eng    | False              | False          |
		| TESTFORM | VARCHECKBX3 | PRODUCT        | 2        | eng    | False              | False          | 
	And I take a screenshot				 
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID  | FieldOID    | SupplementalTerm |
		| TESTFORM | VARCHECKBX2 | TEST1            |
		| TESTFORM | VARCHECKBX3 | TEST1            |
	And I take a screenshot	
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID  | FieldOID    | SupplementalTerm | ComponentName    |
		| TESTFORM | CODERFIELD2 | VARCHECKBX       | DRUGRECORDNUMBER |
		| TESTFORM | VARCHECKBX3 | VARCHECKBX       | DRUGRECORDNUMBER |
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701DL" in "Active Projects"
	And I select Draft "Draft 001"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx2"
	And I click button "Coder Configuration"
	And I delete the coder "Supplemental" terms
		| Name |
		| TEST1|
	And I delete the coder "Component" terms
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot
	And I enter data in architect coder configuration and save
		| Configuration Name | Data | Control Type |
		| Coding Level       | ATC  | dropdown     |
		| Priority           | 3    | textbox      |
	And I set the coder workflow variables
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701DL" in "Active Projects"
	And I select Draft "Draft 001"
	And I click the "Download" button to download
	Then I verify "CoderConfiguration" spreadsheet data
		| FormOID  | FieldOID    | CodingLevel    | Priority | Locale | IsApprovalRequired | IsAutoApproval |
		| ETE1     | CODERTERM1  | LLT            | 1        | eng    | False              | True           |
		| ETE1     | JDT         | DrugName       | 1        | jpn    | False              | True           |
		| ETE2     | CODERFIELD2 | PRODUCTSYNONYM | 1        | eng    | False              | True           |
		| TESTFORM | VARCHECKBX2 | ATC            | 3        | eng    | True               | True           |
		| TESTFORM | VARCHECKBX3 | PRODUCT        | 2        | eng    | False              | False          |
	And I take a screenshot				 
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID  | FieldOID    | SupplementalTerm |
		| TESTFORM | VARCHECKBX3 | TEST1            |
	And I take a screenshot	
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID  | FieldOID    | SupplementalTerm | ComponentName    |
		| TESTFORM | VARCHECKBX3 | VARCHECKBX       | DRUGRECORDNUMBER |

@Release_2013.1.0
@MCC-42701-03
@SJ07.FEB.2013
@Draft

Scenario: MCC-42701-03 When downloading an architect draft template for a URL that has Coder registered, the Coder settings will be included
		
	
	When I navigate to "Architect"
	And I click the "Get Draft Template" button to download
	Then I verify "Coder Configuration" spreadsheet data
		| FormOID | FieldOID | CodingLevel | Priority | Locale | IsApprovalRequired | IsAutoApproval | Instructions/ Comments |
		|         |          |             |          |        |                    |                |                        |
	And I take a screenshot				 
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID | FieldOID | SupplementalTerm | Instructions/ Comments |
		|         |          |                  |                        |
	And I take a screenshot		   
	And I verify "CoderComponentTerms" spreadsheet data
		| FormOID | FieldOID | ComponentTerm | ComponentName | Instructions/ Comments |
		|         |          |               |               |                        |
	And I take a screenshot 	

@Release_2013.1.0
@MCC-42701-04
@SJ07.FEB.2013
@Draft

Scenario: When downloading an architect spreadsheet for a URL that does not have Coder registered, the Coder settings will not be included

	When I navigate to "Architect"
	And I select "Project" link "MCC-42701-001DL" in "Active Projects"
	And I select Draft "Draft 001"
	And I click the "Download" button to download
	Then I verify "Coder Configuration" spreadsheet data
		| FormOID | FieldOID | CodingLevel | Priority | Locale | IsApprovalRequired | IsAutoApproval | Instructions/ Comments |
		|         |          |             |          |        |                    |                |                        |
	And I take a screenshot				 
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID | FieldOID | SupplementalTerm | Instructions/ Comments |
		|         |          |                  |                        |
	And I take a screenshot		   
	And I verify "CoderComponentTerms" spreadsheet data
		| FormOID | FieldOID | ComponentTerm | ComponentName | Instructions/ Comments |
		|         |          |               |               |                        |
	And I take a screenshot