@FT_MCC-46558
@ignore

Feature: MCC-46558 Rave Architect Coder Configuration Security Issue

Background:
Given role "SUPER ROLE 1" exists
Given role "MCC-46558 Role" exists
Given study "MCC-465581" exists
Given study "MCC-465582" exists
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
	| Project    | Coding Dictionary |
	| MCC-465581 | AZDD              |
	| MCC-465581 | JDrug             |
	| MCC-465581 | MedDRA            |
	| MCC-465581 | WHODRUGB2         |

	Given study "MCC-465581" is assigned to Site "Site 1"
	Given study "MCC-465582" is assigned to Site "Site 1"

	Given xml draft "MCC-465581.xml" is Uploaded
	Given xml draft "MCC-465582.xml" is Uploaded

	Given following Project assignments exist
	| User         | Project    | Environment | Role           | Site   | SecurityRole          |
	| SUPER USER 1 | MCC-465581 | Live: Prod  | SUPER ROLE 1   | Site 1 | Project Admin Default |
	| SUPER USER 1 | MCC-465582 | Live: Prod  | SUPER ROLE 1   | Site 1 | Project Admin Default |
	| SUPER USER 2 | MCC-465581 | Live: Prod  | MCC-46558 Role | Site 1 | Project Admin Default |
		
	


@Release_2013.1.0
@PB_MCC-46558_01
@SJ12.FEB.2013
@Draft

Scenario: PB_MCC-46558_01 Projects that are not registered in Coder can modify Coder Registered Studies by manipulation the URL on Coder Configuration page.


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-465581" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42707"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	And I copy the following fields from query string in current url
		| Data               |
		| FieldID            |
		| CodingDictionaryID |
	And I navigate to "Architect"
	And I select "Project" link "MCC-465582" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42707"
	And I edit Field "varcheckbx3"
	And I choose "CODER- AZDD" from "Coding Dictionary:"
	And I replace current page with "CoderConfigPage.aspx" and append following copied fields to query string
		| Data               |
		| FieldID            |
		| CodingDictionaryID |
	Then I verify text "Your request could not be completed." exists
	And I take a screenshot
	

@Release_2013.1.0
@PB_MCC-46558_02
@SJ12.FEB.2013
@Draft

Scenario: PB_MCC-46558_02 Project with Read Only Architect Security Role permission can edit Coder Configuration page.


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-465581" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42707"
	And I edit Field "varcheckbx2"
	And I click button "Coder Configuration"
	And I copy the following fields from query string in current url
		| Data               |
		| FieldID            |
		| CodingDictionaryID |
	Given I login to Rave with user "SUPER USER 2"
	And I navigate to "Architect"
	And I select "Project" link "MCC-465581" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42707"
	And I choose "CODER- AZDD" from "Coding Dictionary:"
	And I replace current page with "CoderConfigPage.aspx" and append following copied fields to query string
		| Data               |
		| FieldID            |
		| CodingDictionaryID |
	Then I verify text "Your request could not be completed." exists
	And I take a screenshot
	


@Release_2013.1.0
@PB_MCC-46558_03
@SJ12.FEB.2013
@Draft

Scenario: PB_MCC-46558_03 Coder Configuration page can be accessed from CRF Versions and can be modified.


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-465581" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42707"
	And I edit Field "varcheckbx"
	And I click button "Coder Configuration"
	And I copy the following fields from query string in current url
		| Data               |
		| FieldID            |
		| CodingDictionaryID |
	And I select Draft "Draft 1"
	And I publish and push eCRF "Draft 1" to "Version 1" with study environment "Prod"
	And I navigate to "Architect"
	And I select "Project" link "MCC-465581" in "Active Projects" 
	And I select Version "Version 1"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42707"
	And I edit Field "varcheckbx"
	And I take a screenshot	
	And I replace current page with "CoderConfigPage.aspx" and append following copied fields to query string
		| Data               |
		| FieldID            |
		| CodingDictionaryID |
	Then I verify text "Your request could not be completed." exists
	And I take a screenshot
	

@Release_2013.1.0
@PB_MCC-46558_04
@SJ12.FEB.2013
@Draft
Scenario: PB_MCC-46558_04 Coder Configuration page can be accessed on a URL, where Coder is not enabled.


	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Configuration"	
	And I navigate to "Other Settings"
	And I replace current page with "CoderConfigPage.aspx" and append following copied fields to query string
		| Data               |
		| FieldID            |
		| CodingDictionaryID |
	Then I verify text "Your request could not be completed." exists
	And I take a screenshot
	
