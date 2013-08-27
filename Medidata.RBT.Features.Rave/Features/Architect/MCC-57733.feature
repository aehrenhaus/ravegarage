@FT_MCC-57733


Feature: MCC-57733 When configuring Coder settings, the settings are preserved even after I overwrite my existing eCRF version to save my changes.


Background:

	Given role "SUPER ROLE 1" exists
	Given study "MCC-57733-001" exists
	Given study "MCC-57733-002" exists
	Given study "MCC-57733-003" exists
	Given study "MCC-57733-004" exists
	Given coding dictionary "AZDD" version "Coder" exists with following coding columns
	| Coding Column Name |
	| PRODUCT            |
	| ATC                |
	Given coding dictionary "AZDD" coding column "PRODUCT" has following coding level components
	| OID              |
	| DRUGRECORDNUMBER |
	| SOURCE           |
	
	Given coding dictionary "AZDD" coding column "ATC" has following coding level components
	| OID              |
	| SOURCE           |

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
	Given coding dictionary "WHODRUGB2" coding column "ATC" has following coding level components
	| OID    |
	| SOURCE |
	Given following locales exist for the coding dictionary
	| Coding Dictionary Name | Locale |
	| AZDD                   | eng    |
	| JDrug                  | eng    |
	| MedDRA                 | eng    |
	| MedDRA                 | jpn    |
	| WHODRUGB2              | eng    |

	Given following coding dictionary assignments exist
	| Project       | Coding Dictionary |
	| MCC-57733-001 | AZDD              |
	| MCC-57733-001 | JDrug             |
	| MCC-57733-001 | MedDRA            |
	| MCC-57733-001 | WHODRUGB2         |
	| MCC-57733-002 | AZDD              |
	| MCC-57733-002 | JDrug             |
	| MCC-57733-002 | MedDRA            |
	| MCC-57733-002 | WHODRUGB2         |
	| MCC-57733-003 | AZDD              |
	| MCC-57733-003 | JDrug             |
	| MCC-57733-003 | MedDRA            |
	| MCC-57733-003 | WHODRUGB2         |
	| MCC-57733-004 | AZDD              |
	| MCC-57733-004 | JDrug             |
	| MCC-57733-004 | MedDRA            |
	| MCC-57733-004 | WHODRUGB2         |
	
    Given study "MCC-57733-001" is assigned to Site "Site 1"
	Given study "MCC-57733-002" is assigned to Site "Site 1"
	Given study "MCC-57733-003" is assigned to Site "Site 1"
	Given study "MCC-57733-004" is assigned to Site "Site 1"
	Given xml draft "MCC-57733-001.xml" is Uploaded
	Given xml draft "MCC-57733-002.xml" is Uploaded
	Given xml draft "MCC-57733-003.xml" is Uploaded
	Given xml draft "MCC-57733-004.xml" is Uploaded
    Given following Project assignments exist
    | User         | Project       | Environment | Role         | Site   | SecurityRole          |
    | SUPER USER 1 | MCC-57733-001 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
	| SUPER USER 1 | MCC-57733-002 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
	| SUPER USER 1 | MCC-57733-003 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
	| SUPER USER 1 | MCC-57733-004 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |



@Release_2013.4.0
@PB_MCC-57733-001
@VY15.AUG.2013
@DRAFT

Scenario: MCC-57733-001 As a Rave Study Administor, when I update the Coder Configuration settings for a field associated with Coder, and I overwrite my existing eCRF version to save my changes, when I download the Architect Loader Specification for that version, I am able to see the Coder Configuration settings in the specification.

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-57733-001" in "Active Projects"
	And I select Draft "Draft 1"
	And I publish CRF Version "Version1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC57733"
	And I edit Field "varcheckbx3"
	And I choose "CODER- AZDD" from "Coding Dictionary:"
	And I select link "Save"
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data    | Control Type |
		| Coding Level       | PRODUCT | dropdown     |
		| Priority           | 2       | textbox      |
	And I set the coder workflow variables
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
	And I add the coder "Supplemental" terms
		| Name |
		| TEST1|
	And I add the coder "Component" terms
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot
	And I select link "Draft 1"
	And I overwrite CRF Version "Version1"
	And I verify message is displayed "Overwrite of Version1 completed."
	And I take a screenshot
	And I select "Study" link "MCC-57733-001" in "Header"
	And I select link(partial) "Version1 "
	And I click the "Download" button to download
	Then I verify "CoderConfiguration" spreadsheet data
		| FormOID  | FieldOID    | CodingLevel | Priority | Locale | IsApprovalRequired | IsAutoApproval |
		| ETE1     | CODERTERM1  | SOC         | 1        | eng    | False              | True           |
		| ETE1     | JDT         | ATC         | 1        | eng    | False              | True           |
		| TESTFORM | VARCHECKBX3 | PRODUCT     | 2        | eng    | True               | True           |
	And I take a screenshot				 
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID  | FieldOID    | SupplementalTerm |
		| TESTFORM | VARCHECKBX3 | TEST1            |
	And I take a screenshot	
	And I verify "CoderComponentTerms" spreadsheet data
		| FormOID  | FieldOID    | ComponentTerm | ComponentName    |
		| TESTFORM | VARCHECKBX3 | VARCHECKBX    | DRUGRECORDNUMBER |
	And I take a screenshot


@Release_2013.4.0
@PB_MCC-57733-002
@VY15.AUG.2013
@DRAFT

Scenario: MCC-57733-002 As a Rave Study Administor, when I associate a field with Coder, and I add Coder Configuration settings for that field, and I overwrite my existing eCRF version to save my changes, when I download the Architect Loader Specification for that version, I am able to see the Coder Configuration settings in the specification.

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-57733-002" in "Active Projects"
	And I select Draft "Draft 1"
	And I publish CRF Version "Version1"
	And I navigate to "Forms"
	And I select Fields for Form "ETE2"
	And I edit Field "CoderField"
	And I choose "CODER- WHODRUGB2" from "Coding Dictionary:"
	And I select link "Save"
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data | Control Type |
		| Coding Level       | ATC  | dropdown     |
		| Priority           | 4    | textbox      |
	And I set the coder workflow variables
		| Name               | Value|
		| IsApprovalRequired | True |
		| IsAutoApproval     | True |
	And I add the coder "Supplemental" terms
		| Name         |
		| LOGSUPPFIELD2|
	And I add the coder "Component" terms
		| Name          | Component Name|
		| LOGCOMPFIELD1 | SOURCE        |
	And I take a screenshot
	And I select link "Draft 1"
	And I overwrite CRF Version "Version1"
	And I verify message is displayed "Overwrite of Version1 completed."
	And I take a screenshot
	And I select "Study" link "MCC-57733-002" in "Header"
	And I select link(partial) "Version1 "
	And I click the "Download" button to download
	Then I verify "CoderConfiguration" spreadsheet data
		| FormOID  | FieldOID    | CodingLevel | Priority | Locale | IsApprovalRequired | IsAutoApproval |
		| ETE1     | CODERTERM1  | SOC         | 1        | eng    | False              | True           |
		| ETE1     | JDT         | ATC         | 1        | eng    | False              | True           |
		| ETE2     | CODERFIELD2 | ATC         | 4        | eng    | True               | True           |
		| TESTFORM | VARCHECKBX3 | ATC         | 1        | eng    | False              | False          |
	And I take a screenshot				 
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID | FieldOID    | SupplementalTerm |
		| ETE2    | CODERFIELD2 | LOGSUPPFIELD2    |
	And I take a screenshot	
	And I verify "CoderComponentTerms" spreadsheet data
		| FormOID | FieldOID    | ComponentTerm | ComponentName | 
		| ETE2    | CODERFIELD2 | LOGCOMPFIELD1 | SOURCE        |
	And I take a screenshot


@Release_2013.4.0
@PB_MCC-57733-003
@VY15.AUG.2013
@DRAFT

Scenario: MCC-57733-003 As a Rave Study Administor, when I add a new field to the draft, and I associate that field with Coder, and I add Coder Configuration settings for that field, and I overwrite my existing eCRF version to save my changes, when I download the Architect Loader Specification for that version, I am able to see the Coder Configuration settings in the specification.

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-57733-003" in "Active Projects"
	And I select Draft "Draft 1"
	And I publish CRF Version "Version1"
	And I navigate to "Forms"
	And I select link "Add Form"
	And I select "Bottom" from "Add Form" dropdown
	And I enter data in Architect Form and save
		| Form Name | OID       | Active  |
		| MCC577333 | MCC577333 | checked |
	And I select Fields for Form "MCC577333"
	And I select link "Add New"
	And I enter data in Architect Field and save
		| Field       | Data | ControlType |
		| VarOID      | Code | textbox     |
		| Format      | $10  | textbox     |
		| Field Name  | Code | textbox     |
		| Field OID   | Code | textbox     |
		| Field Label | Code | textarea    |
	And I select link "Add New"
	And I enter data in Architect Field and save
		| Field       | Data | ControlType |
		| VarOID      | Supp | textbox     |
		| Format      | $10  | textbox     |
		| Field Name  | Supp | textbox     |
		| Field OID   | Supp | textbox     |
		| Field Label | Supp | textarea    |
	And I select link "Add New"
	And I enter data in Architect Field and save
		| Field       | Data | ControlType |
		| VarOID      | Comp | textbox     |
		| Format      | $10  | textbox     |
		| Field Name  | Comp | textbox     |
		| Field OID   | Comp | textbox     |
		| Field Label | Comp | textarea    |
	And I edit Field "Code"
	And I choose "CODER- AZDD" from "Coding Dictionary:"
	And I select link "Save"
	And I take a screenshot
	And I click button "Coder Configuration"
	And I enter data in architect coder configuration and save
		| Configuration Name | Data    | Control Type |
		| Coding Level       | PRODUCT | dropdown     |
		| Priority           | 3       | textbox      |
	And I set the coder workflow variables
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | False |
	And I add the coder "Supplemental" terms
		| Name |
		| Supp |
	And I add the coder "Component" terms
		| Name | Component Name   |
		| Comp | DRUGRECORDNUMBER |
	And I take a screenshot
	And I select link "Draft 1"
	And I overwrite CRF Version "Version1"
	And I verify message is displayed "Overwrite of Version1 completed."
	And I take a screenshot
	And I select "Study" link "MCC-57733-003" in "Header"
	And I select link(partial) "Version1 "
	And I click the "Download" button to download
	Then I verify "CoderConfiguration" spreadsheet data
		| FormOID   | FieldOID    | CodingLevel | Priority | Locale | IsApprovalRequired | IsAutoApproval |
		| ETE1      | CODERTERM1  | SOC         | 1        | eng    | False              | True           |
		| ETE1      | JDT         | ATC         | 1        | eng    | False              | True           |
		| TESTFORM  | VARCHECKBX3 | ATC         | 1        | eng    | False              | False          |
		| MCC577333 | Code        | PRODUCT     | 3        | eng    | True               | False          |
	And I take a screenshot				 
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID   | FieldOID    | SupplementalTerm |
		| MCC577333 | Code        | Supp             |
	And I take a screenshot	
	And I verify "CoderComponentTerms" spreadsheet data
		| FormOID | FieldOID | ComponentTerm | ComponentName |
		| MCC577333 | Code        | Comp          | DRUGRECORDNUMBER |
	And I take a screenshot


@Release_2013.4.0
@PB_MCC-57733-004
@VY15.AUG.2013
@DRAFT

Scenario: MCC-57733-004 As a Rave Study Administor, when I delete the Coder Configuration settings for a field associated with Coder, and I overwrite my existing eCRF version to save my changes, when I download the Architect Loader Specification for that version, I do not see the Coder Configuration settings for that field in the specification.

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-57733-004" in "Active Projects"
	And I select Draft "Draft 1"
	And I publish CRF Version "Version1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC57733"
	And I edit Field "varcheckbx3"
	And I choose "..." from "Coding Dictionary:"
	And I select link "Save"
	And I take a screenshot
	And I select link "Draft 1"
	And I overwrite CRF Version "Version1"
	And I verify message is displayed "Overwrite of Version1 completed."
	And I take a screenshot
	And I select "Study" link "MCC-57733-004" in "Header"
	And I select link(partial) "Version1 "
	And I click the "Download" button to download
	Then I verify "CoderConfiguration" spreadsheet data
		| FormOID  | FieldOID    | CodingLevel | Priority | Locale | IsApprovalRequired | IsAutoApproval |
		| ETE1     | CODERTERM1  | SOC         | 1        | eng    | False              | True           |
		| ETE1     | JDT         | ATC         | 1        | eng    | False              | True           |
	And I take a screenshot				 
	And I verify "CoderSupplementalTerms" spreadsheet data
		| FormOID | FieldOID | SupplementalTerm |
		|         |          |                  |
	And I take a screenshot	
	And I verify "CoderComponentTerms" spreadsheet data
		| FormOID | FieldOID | ComponentTerm | ComponentName |
		|         |          |               |               |
	And I take a screenshot