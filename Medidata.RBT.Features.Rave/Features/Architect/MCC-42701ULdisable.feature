@FT_MCC-42701ULdisable
@ignore
Feature: Architect download will contain Coder settings and Architect upload will save Coder settings

Background:

    Given role "SUPER ROLE 1" exists
    Given study "MCC-42701-001" exists
	Given coding dictionary "AZDD" version "Coder" exists with following coding columns
	| Coding Column Name |
	| PRODUCT            |
	| ATC                |
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

	Given following coding dictionary assignments exist
		| Project       | Coding Dictionary |
		| MCC-42701-001 | AZDD              |
		| MCC-42701-001 | JDrug             |
		| MCC-42701-001 | MedDRA            |
		| MCC-42701-001 | WHODRUGB2         |
    Given study "MCC-42701-001" is assigned to Site "Site 1"
    Given following Project assignments exist
		| User         | Project       | Environment | Role         | Site   | SecurityRole          |
		| SUPER USER 1 | MCC-42701-001 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default |
 
    Given I login to Rave with user "SUPER USER 1"


@PBMCC-42701-002
Scenario: When uploading an architect spreadsheet that contains Coder settings and the URL does not have Coder registered, the upload will fail and user will be provided with appropriate message

	
	When xml Architect "MCC-42701-002" is uploaded
	Then I verify message "failed to upload draft"
	And I take a screenshot