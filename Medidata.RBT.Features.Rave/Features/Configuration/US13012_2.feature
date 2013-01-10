@ignore
@FT_US13011_DT13976
Feature: US13011_2


Background:
	Given I login to Rave with user "defuser" and password "password"
	


Scenario: Template file has Recursive Depth column

	Given I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I check "GetTemplate"
	And I click the "Get File" button to download	
	And I verify "Coding Settings" spreadsheet has column "Recursive Depth"

Scenario: Non-template file has Recursive Depth column

	Given I navigate to "Configuration"
	And I navigate to "Configuration Loader"
	And I click the "Get File" button to download	
	And I verify "Coding Settings" spreadsheet has column "Recursive Depth"


Scenario: Recursive Depth can be changed by uploading file


	Given I navigate to "Configuration"
	And I select link "Configuration Loader"
	And I click the "Get File" button to download
	And I clear "Coding Settings" spreadsheet data from line 4
	And I modify "Coding Settings" spreadsheet data
		| Column | Recursive Depth          |
		| SOC    | {RndRangeNum<num1>(1,10)} |
		| HLGT   | {RndRangeNum<num2>(1,10)} |
	And I upload configuration settings file

	And I navigate to "Clinical View Settings"
	And I navigate to "Coding Settings"
	And I verify rows exist in "settings" table

		| Column | [RecursiveDepth] |
		| SOC    | {Var(num1)}       |
		| HLGT   | {Var(num2)}       |


Scenario: Recursive Depth is presented correctly in file

	Given I navigate to "Configuration"
	And I navigate to "Clinical View Settings"
	And I navigate to "Coding Settings"

	
	And I enter data in Coding Settings
		| Column | RecursiveDepth |
		| SOC    | 1                |
		| HLGT   | 8                |

	And I select link "Configuration Loader"
	And I click the "Get File" button to download
	And I verify "Coding Settings" spreadsheet data
		| Column | Recursive Depth |
		| SOC    | 1               |
		| HLGT   | 8              |
	
	And I navigate to "Clinical View Settings"
	And I navigate to "Coding Settings"		
	And I enter data in Coding Settings
		| Column | RecursiveDepth |
		| SOC    | 2                |
		| HLGT   | 7                |

	And I select link "Configuration Loader"
	And I click the "Get File" button to download
	And I verify "Coding Settings" spreadsheet data
		| Column | Recursive Depth |
		| SOC    | 2               |
		| HLGT   | 7              |

		
Scenario: Error is shown if Recursive Depth is set out of range

	Given I navigate to "Configuration"
	And I navigate to "Clinical View Settings"
	And I navigate to "Coding Settings"

	
	And I enter data in Coding Settings
		| Column | RecursiveDepth |
		| SOC    | 11             |

	And I verify text "InvalidRecursiveDepthValue" exists

		
	And I enter data in Coding Settings
		| Column | RecursiveDepth |
		| SOC    | 10             |

	And I verify text "InvalidRecursiveDepthValue" does not exist

	And I enter data in Coding Settings
		| Column | RecursiveDepth |
		| SOC    | -1             |

	And I verify text "InvalidRecursiveDepthValue" exists


Scenario: Error is shown if Recursive Depth is not integer

	Given I navigate to "Configuration"
	And I navigate to "Clinical View Settings"
	And I navigate to "Coding Settings"

	
	And I enter data in Coding Settings
		| Column | RecursiveDepth |
		| SOC    | alpha          |

	And I verify text "InvalidRecursiveDepthValue" exists

		
	And I enter data in Coding Settings
		| Column | RecursiveDepth |
		| SOC    | 10             |

	And I verify text "InvalidRecursiveDepthValue" does not exist

	And I enter data in Coding Settings
		| Column | RecursiveDepth |
		| SOC    | beta           |

	And I verify text "InvalidRecursiveDepthValue" exists