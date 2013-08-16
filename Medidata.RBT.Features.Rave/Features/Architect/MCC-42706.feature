@FT_MCC-42706
Feature: Global library will support Coder settings.  This will allow forms that contain Coder settings to be copied.

Background:
	Given study "MCC-42706A" exists
	Given study "MCC-42706B" exists
	Given study "MCC-42706C" exists
	Given study "MCC-42706D" exists
	Given coding dictionary "MCC42706CodingDictionary" version "CDV1" exists with following coding columns
		| Coding Column Name |
		| CC1                |
	Given coding dictionary "MCC42706CodingDictionary" coding column "CC1" has following coding level components
		| OID   |
		| CLCL1 |

	Given following coding dictionary assignments exist
		| Project    | Coding Dictionary        |
		| MCC-42706A | MCC42706CodingDictionary |
		| MCC-42706B | MCC42706CodingDictionary |
		| MCC-42706C | MCC42706CodingDictionary |
	   
	Given I login to Rave with user "SUPER USER 1"
	Given xml draft "MCC42706ASource.xml" is Uploaded
	Given xml draft "MCC42706ATarget.xml" is Uploaded
	Given xml draft "MCC42706A1Target.xml" is Uploaded
	Given xml draft "MCC42706A2Target.xml" is Uploaded
	Given xml draft "MCC42706A3Target.xml" is Uploaded
	Given xml draft "MCC42706AGLTarget.xml" is Uploaded
	Given xml draft "MCC42706BTarget.xml" is Uploaded
	Given xml draft "MCC42706CTarget.xml" is Uploaded
	Given xml draft "MCC42706DTarget.xml" is Uploaded
	Given study "MCC-42706A" is assigned to Site "Site 1"
	Given study "MCC-42706B" is assigned to Site "Site 1"
	Given study "MCC-42706C" is assigned to Site "Site 1"
	Given study "MCC-42706D" is assigned to Site "Site 1"
	Given following Project assignments exist
		| User         | Project    | Environment | Role         | Site   | SecurityRole          | GlobalLibraryRole            | ExternalSystem |
		| SUPER USER 1 | MCC-42706A | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | Global Library Admin Default | iMedidata      |
		| SUPER USER 1 | MCC-42706B | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | Global Library Admin Default | iMedidata      |
		| SUPER USER 1 | MCC-42706C | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | Global Library Admin Default | iMedidata      |
		| SUPER USER 1 | MCC-42706D | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | Global Library Admin Default | iMedidata      |
		
	Given I publish and push eCRF "MCC42706ASource.xml" to "AVersion 1"
	
#Note: Architect Project "MCC-42706A" contains Coder settings
#Note: Architect Project "MCC-42706B" contains Coder settings
#Note: Architect Project "MCC-42706C" contain Coder settings
#Note: Architect Project "MCC-42706D" does not contain Coder settings
#Note: Global Library Project "MCC-42706A GL" does not contain Coder settings

@Release2013.1.0
@PB_MCC42706-001
@VER2013.1.0
@VR23.Jan.2013
@Validation
Scenario: PBMCC42706-001 When I copy a form from draft that contains Coder settings to a Architect Project that has the Coder settings, then coder settings get copied to the new form.

#Given I have 1 project that has Coder active and registered
#When I copy a form that has Coder settings configured
#Then the Coder settings get transferred to the new form

	And I navigate to "Architect" module
	And I select "Project" link "MCC-42706A" in "Active Projects"
	And I select link "Define Copy Sources"
	And I check "Define all Projects and Global Libraries as Copy Sources."
	And I select "Study" link "MCC-42706A" in "Header"
	And I select "Draft" link "Target A"
	And I select link "Copy to Draft" located in "Left Nav"
	And I expand "Projects"
	And I expand "Project" "MCC-42706A"
	And I expand "Drafts"
	And I check "Source" in "Drafts"
	And I click button "Next"
	And I expand "ETE2 (ETE2)"
	And I check "CoderField2 (CODERFIELD2)"
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is checked
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is checked
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is disabled
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is disabled	
	And I verify "StdCompField3 (STDCOMPFIELD3)" is unchecked
	And I verify "StdSuppField4 (STDSUPPFIELD4)" is unchecked
	And I take a screenshot
	And I uncheck "CoderField2 (CODERFIELD2)"
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is unchecked
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is unchecked
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is enabled
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is enabled
	And I take a screenshot
	And I check "LogCompField1 (LOGCOMPFIELD1)"
	And I verify "CoderField2 (CODERFIELD2)" is unchecked
	And I take a screenshot	
	And I check "CoderField2 (CODERFIELD2)"
	And I uncheck "CoderField2 (CODERFIELD2)"
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is unchecked
	And I take a screenshot		
	And I check "CoderField2 (CODERFIELD2)"	
	And I click button "Next"
	And I click button "Finish"
	And I select link "Forms" located in "Left Nav"
	And I search for form "ETE2"
	And I select Fields for Form "ETE2"
	And I verify field "CoderField2" exists
	And I verify field "LogCompField1" exists
	And I verify field "LogSuppField2" exists
	And I verify field "StdCompField3" does not exist
	And I verify field "StdSuppField4" does not exist
	And I verify field "CoderField2" has coding dictionary "MCC42706CodingDictionary"
	And I verify button "Coder Configuration" exists
	When I click button "Coder Configuration"
	Then I verify text "CC1" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Supplemental Terms" table
		| Name          |
		| LOGSUPPFIELD2 |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I verify rows exist in "Component Terms" table
		| Name          | Component Name |
		| LOGCOMPFIELD1 | CLCL1          |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I take a screenshot

@Release2013.1.0
@PB_MCC42706-002
@VER2013.1.0
@VR23.Jan.2013
@Validation
Scenario: PBMCC42706-002 When I copy a form from versions that contains Coder settings to another Architect Project that has the Coder settings, then coder settings get copied to the new form.

#Given I have 2 project that has Coder active and registered
#When I copy a form one project to another that has Coder settings configured
#Then the Coder settings get transferred to the new form

	And I navigate to "Architect" module
	And I select "Project" link "MCC-42706A" in "Active Projects"
	And I select link "Define Copy Sources"
	And I check "Define all Projects and Global Libraries as Copy Sources."
	And I select "Study" link "MCC-42706A" in "Header"
	And I select "Draft" link "Target A1"
	And I select link "Copy to Draft" located in "Left Nav"
	And I expand "Projects"
	And I expand "Project" "MCC-42706A" 
	And I expand "Versions"
	And I check "AVersion 1" in "Versions"
	And I click button "Next"
	And I check "Forms"
	And I click button "Next"
	And I click button "Finish"
	And I select link "Forms" located in "Left Nav"
	And I search for form "ETE2"
	And I select Fields for Form "ETE2"
	And I verify field "CoderField2" exists
	And I verify field "LogCompField1" exists
	And I verify field "LogSuppField2" exists
	And I verify field "StdCompField3" exists
	And I verify field "StdSuppField4" exists
	And I verify field "CoderField2" has coding dictionary "MCC42706CodingDictionary"
	And I verify button "Coder Configuration" exists
	When I click button "Coder Configuration"
	Then I verify text "CC1" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Supplemental Terms" table
		| Name          |
		| LOGSUPPFIELD2 |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I verify rows exist in "Component Terms" table
		| Name          | Component Name |
		| LOGCOMPFIELD1 | CLCL1          |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I take a screenshot
	
@Release2013.1.0
@PB_MCC42706-003
@VER2013.1.0
@VR23.Jan.2013
@Validation
Scenario: PBMCC42706-003 When I search and copy a form that contains Coder settings to a Architect Project that has the Coder settings, then coder settings get copied to the new form.

#Given I have 1 project that has Coder active and registered
#When I copy a form that has Coder settings configured
#Then the Coder settings get transferred to the new form

	And I navigate to "Architect" module
	And I select "Project" link "MCC-42706A" in "Active Projects"
	And I select link "Define Copy Sources"
	And I check "Define all Projects and Global Libraries as Copy Sources."
	And I select "Study" link "MCC-42706A" in "Header"
	And I select "Draft" link "Target A3"
	And I select link "Copy to Draft" located in "Left Nav"
	And I expand "Projects"
	And I expand "Project" "MCC-42706A" 
	And I expand "Drafts"
	And I check "Source" in "Drafts"
	And I click button "Next"
	And I enter value "CoderField2 (CODERFIELD2)" in "Search" "textbox"
	And I click button "Search"
	And I check "CoderField2 (CODERFIELD2)"
	And I enter value "" in "Search" "textbox"
	And I click button "Search"
	And I expand "ETE2 (ETE2)"
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is checked
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is checked
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is disabled
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is disabled
	And I verify "StdCompField3 (STDCOMPFIELD3)" is unchecked
	And I verify "StdSuppField4 (STDSUPPFIELD4)" is unchecked
	And I take a screenshot	
	And I click button "Next"
	And I click button "Finish"
	And I select link "Forms" located in "Left Nav"
	And I search for form "ETE2"
	And I select Fields for Form "ETE2"
	And I verify field "CoderField2" exists
	And I verify field "LogCompField1" exists
	And I verify field "LogSuppField2" exists
	And I verify field "StdCompField3" does not exist
	And I verify field "StdSuppField4" does not exist
	And I verify field "CoderField2" has coding dictionary "MCC42706CodingDictionary"
	And I verify button "Coder Configuration" exists
	When I click button "Coder Configuration"
	Then I verify text "CC1" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Supplemental Terms" table
		| Name          |
		| LOGSUPPFIELD2 |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I verify rows exist in "Component Terms" table
		| Name          | Component Name |
		| LOGCOMPFIELD1 | CLCL1          |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I take a screenshot	

@Release2013.1.0
@PB_MCC42706-004
@VER2013.1.0
@VR23.Jan.2013
@Validation
Scenario: PBMCC42706-004 When I copy a form that contains Coder settings to another Architect Project that has the Coder settings, then coder settings get copied to the new form.

#Given I have 2 project that has Coder active and registered
#When I copy a form one project to another that has Coder settings configured
#Then the Coder settings get transferred to the new form

	And I navigate to "Architect" module
	And I select "Project" link "MCC-42706B" in "Active Projects"
	And I select link "Define Copy Sources"
	And I check "Define all Projects and Global Libraries as Copy Sources."
	And I select "Project" link "MCC-42706B" in "Header"
	And I select "Draft" link "Target B"
	And I select link "Copy to Draft" located in "Left Nav"
	And I expand "Projects"
	And I expand "Project" "MCC-42706A" 
	And I expand "Drafts"
	And I check "Source" in "Drafts"
	And I click button "Next"
	And I check "Forms"
	And I click button "Next"
	And I click button "Finish"
	And I select link "Forms" located in "Left Nav"
	And I search for form "ETE2"
	And I select Fields for Form "ETE2"
	And I verify field "CoderField2" exists
	And I verify field "LogCompField1" exists
	And I verify field "LogSuppField2" exists
	And I verify field "StdCompField3" exists
	And I verify field "StdSuppField4" exists
	And I verify field "CoderField2" has coding dictionary "MCC42706CodingDictionary"
	And I verify button "Coder Configuration" exists
	When I click button "Coder Configuration"
	Then I verify text "CC1" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Supplemental Terms" table
		| Name          |
		| LOGSUPPFIELD2 |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I verify rows exist in "Component Terms" table
		| Name          | Component Name |
		| LOGCOMPFIELD1 | CLCL1          |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I take a screenshot
	
@Release2013.1.0
@PB_MCC42706-005
@VER2013.1.0
@VR23.Jan.2013
@Validation
Scenario: PBMCC42706-005 When I copy a form that contains Coder settings to a Architect Project with change OID, that has the Coder settings, then coder settings get copied to the new form.

#Given I have 2 project that has Coder active and registered
#When I copy a form with OID change that has Coder settings configured
#Then the Coder settings get transferred to the new form

	And I navigate to "Architect" module
	And I select "Project" link "MCC-42706A" in "Active Projects"
	And I select link "Define Copy Sources"
	And I check "Define all Projects and Global Libraries as Copy Sources."
	And I select "Study" link "MCC-42706A" in "Header"
	And I select "Draft" link "Target A2"
	And I select link "Copy to Draft" located in "Left Nav"
	And I expand "Projects"
	And I expand "Project" "MCC-42706A" 
	And I expand "Drafts"
	And I check "Source" in "Drafts"
	And I click button "Next"
	And I select link "ETE2 (ETE2)"
	And I expand "ETE2 (ETE2) details"
	And I select link "Change OID in source"
	And I enter value "ETE22" in "Change OID in source" "textbox"
	And I click button "Accept"
	And I expand "ETE2 (ETE22)" in area "Right"
	And I check "CoderField2 (CODERFIELD2)"
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is checked in "Right"
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is checked in "Right"
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is disabled in "Right"
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is disabled in "Right"	
	And I verify "StdCompField3 (STDCOMPFIELD3)" is unchecked in "Right"
	And I verify "StdSuppField4 (STDSUPPFIELD4)" is unchecked in "Right"
	And I take a screenshot
	And I uncheck "CoderField2 (CODERFIELD2)" in "Right"
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is unchecked in "Right"
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is unchecked in "Right"
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is enabled in "Right"
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is enabled in "Right"
	And I take a screenshot
	And I check "LogCompField1 (LOGCOMPFIELD1)" in "Right"
	And I verify "CoderField2 (CODERFIELD2)" is unchecked in "Right"
	And I take a screenshot	
	And I check "CoderField2 (CODERFIELD2)" in "Right"
	And I uncheck "CoderField2 (CODERFIELD2)" in "Right"
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is unchecked in "Right"
	And I take a screenshot		
	And I check "CoderField2 (CODERFIELD2)" in "Right"
	And I click button "Next"
	And I click button "Finish"
	And I select link "Forms" located in "Left Nav"
	And I search for form "ETE2"
	And I select Fields for Form "ETE2"
	And I verify field "CoderField2" exists
	And I verify field "LogCompField1" exists
	And I verify field "LogSuppField2" exists
	And I verify field "StdCompField3" does not exist
	And I verify field "StdSuppField4" does not exist
	And I verify field "CoderField2" has coding dictionary "MCC42706CodingDictionary"
	And I verify button "Coder Configuration" exists
	When I click button "Coder Configuration"
	Then I verify text "CC1" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Supplemental Terms" table
		| Name          |
		| LOGSUPPFIELD2 |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I verify rows exist in "Component Terms" table
		| Name          | Component Name |
		| LOGCOMPFIELD1 | CLCL1          |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I take a screenshot
	
@Release2013.1.0
@PB_MCC42706-006
@VER2013.1.0
@VR23.Jan.2013
@Validation
Scenario: PBMCC42706-006 When I copy a form from an Architect Project that contains Coder settings to a Propose Objects, then the field that has coder settings does not get copied to the new form.

#Given I have a project that has Coder active and registered
#When I copy a form to Propose objects
#Then I see error message
#And the Coder settings does not get transferred to the new form

	And I navigate to "Architect" module
	And I select "Project" link "MCC-42706A" in "Active Projects"
	And I select link "Define Copy Sources"
	And I check "Define all Projects and Global Libraries as Copy Sources."
	And I select "Study" link "MCC-42706A" in "Header"
	And I select "Draft" link "Source"
	And I select link "Propose Objects" located in "Left Nav"
	And I expand "ETE2 (ETE2)"
	When I check "CoderField2 (CODERFIELD2)"
	Then I verify text "Invalid selection. Proposal is not registered with Coder coding dictionary MCC42706CodingDictionary" exists with seeded
	| Data                     |
	| MCC42706CodingDictionary |
	And I take a screenshot
	And I verify "CoderField2 (CODERFIELD2)" is unchecked
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is unchecked
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is unchecked
	And I verify "StdCompField3 (STDCOMPFIELD3)" is unchecked
	And I verify "StdSuppField4 (STDSUPPFIELD4)" is unchecked
	And I verify "CoderField2 (CODERFIELD2)" is enabled
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is enabled
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is enabled
	And I verify "StdCompField3 (STDCOMPFIELD3)" is enabled
	And I verify "StdSuppField4 (STDSUPPFIELD4)" is enabled
	When I uncheck "ETE2 (ETE2)"
	Then I verify text "Invalid selection. Proposal is not registered with Coder coding dictionary MCC42706CodingDictionary" does not exist with seeded
	| Data                     |
	| MCC42706CodingDictionary |
	And I take a screenshot
	When I check "ETE2 (ETE2)"
	And I verify "CoderField2 (CODERFIELD2)" is unchecked
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is checked
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is checked
	And I verify "StdCompField3 (STDCOMPFIELD3)" is checked
	And I verify "StdSuppField4 (STDSUPPFIELD4)" is checked
	And I verify "CoderField2 (CODERFIELD2)" is enabled
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is enabled
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is enabled
	And I verify "StdCompField3 (STDCOMPFIELD3)" is enabled
	And I verify "StdSuppField4 (STDSUPPFIELD4)" is enabled
	And I take a screenshot
	And I click button "Next"
	And I enter value "Proposal006" in "Proposal Name" "textbox"
	And I enter value "ProposalDescription006" in "Proposal Description" "textbox"
	And I click button "Finish"
	And I navigate to "Architect" module
	And I select "Proposal" link "Proposal006" in "Proposed Global Library Volumes"
	And I select link "Forms" located in "Left Nav"
	And I search for form "ETE2"
	And I select Fields for Form "ETE2"
	And I verify field "CoderField2" does not exist
	And I verify field "LogCompField1" exists
	And I verify field "LogSuppField2" exists
	And I verify field "StdCompField3" exists
	And I verify field "StdSuppField4" exists
	And I edit Field "LogCompField1"
	And I verify button "Coder Configuration" does not exist
	And I take a screenshot
	And I edit Field "LogSuppField2"
	And I verify button "Coder Configuration" does not exist
	And I take a screenshot
	And I edit Field "StdCompField3"
	And I verify button "Coder Configuration" does not exist
	And I take a screenshot
	And I edit Field "StdSuppField4"
	And I verify button "Coder Configuration" does not exist
	And I take a screenshot

@Release2013.1.0
@PB_MCC42706-007
@VER2013.1.0
@VR23.Jan.2013
@Validation    
Scenario: PBMCC42706-007 When I copy a form from an Architect Project that contains Coder settings to a Global Library Volume, then coder settings does not get copied to the field on new form.

#Given I have a project that has Coder active and registered
#When I copy a form to Global Library Volume
#Then I see error message
#And the Coder settings does not get transferred to the new form

    And I navigate to "Architect" module
    And I select "Project" link "MCC-42706A GL" in "Active Global Library Volumes"
    And I select link "Define Copy Sources"
    And I check "Define all Projects and Global Libraries as Copy Sources."
    And I select "Study" link "MCC-42706A GL" in "Header"
    And I select "Draft" link "Global Target A"
    And I select link "Copy to Draft" located in "Left Nav"
    And I expand "Projects"
    And I expand "Project" "MCC-42706A"
    And I expand "Drafts"
    And I check "Source" in "Drafts"
    And I click button "Next"
    And I expand "ETE2 (ETE2)"
    When I check "ETE2 (ETE2)"
    Then I verify text "Invalid selection. Project is not registered with Coder coding dictionary MCC42706CodingDictionary" does not exist with seeded
	| Data                     |
	| MCC42706CodingDictionary |
    And I take a screenshot
    And I verify "CoderField2 (CODERFIELD2)" is checked
    And I verify "LogCompField1 (LOGCOMPFIELD1)" is checked
    And I verify "LogSuppField2 (LOGSUPPFIELD2)" is checked
    And I verify "StdCompField3 (STDCOMPFIELD3)" is checked
    And I verify "StdSuppField4 (STDSUPPFIELD4)" is checked
    And I verify "CoderField2 (CODERFIELD2)" is enabled
    And I verify "LogCompField1 (LOGCOMPFIELD1)" is disabled
    And I verify "LogSuppField2 (LOGSUPPFIELD2)" is disabled
    And I verify "StdCompField3 (STDCOMPFIELD3)" is enabled
    And I verify "StdSuppField4 (STDSUPPFIELD4)" is enabled
    When I uncheck "ETE2 (ETE2)"
    Then I verify text "Invalid selection. Project is not registered with Coder coding dictionary MCC42706CodingDictionary" does not exist with seeded
	| Data                     |
	| MCC42706CodingDictionary |
    And I take a screenshot
    When I check "CoderField2 (CODERFIELD2)"
    And I verify "CoderField2 (CODERFIELD2)" is checked	
    And I verify "LogCompField1 (LOGCOMPFIELD1)" is checked
    And I verify "LogSuppField2 (LOGSUPPFIELD2)" is checked
    And I verify "StdCompField3 (STDCOMPFIELD3)" is unchecked
    And I verify "StdSuppField4 (STDSUPPFIELD4)" is unchecked
    And I verify "CoderField2 (CODERFIELD2)" is enabled
    And I verify "LogCompField1 (LOGCOMPFIELD1)" is disabled
    And I verify "LogSuppField2 (LOGSUPPFIELD2)" is disabled
    And I verify "StdCompField3 (STDCOMPFIELD3)" is enabled
    And I verify "StdSuppField4 (STDSUPPFIELD4)" is enabled
    And I take a screenshot
    And I click button "Next"
    And I click button "Finish"
    And I select link "Forms" located in "Left Nav"
    And I search for form "ETE2"
    And I select Fields for Form "ETE2"
    And I verify field "CoderField2" exists
    And I verify field "LogCompField1" exists
    And I verify field "LogSuppField2" exists
    And I verify field "StdCompField3" does not exist
    And I verify field "StdSuppField4" does not exist
    And I edit Field "CoderField2"
    And I verify button "Coder Configuration" does not exist
    And I take a screenshot	
    And I edit Field "LogCompField1"
    And I verify button "Coder Configuration" does not exist
    And I take a screenshot
    And I edit Field "LogSuppField2"
    And I verify button "Coder Configuration" does not exist
    And I take a screenshot
	And I edit Field "LogSuppField2"
	And I verify button "Coder Configuration" does not exist
	And I take a screenshot
	
@Release2013.1.0
@PB_MCC42706-008
@VER2013.1.0
@VR23.Jan.2013
@Validation	
Scenario: PBMCC42706-008 When I copy a form from an Architect Project that contains Coder settings to a project that does not contains Coder settings, then the field and the coder settings does not get copied to the new form.

#Given I have a project that has Coder active and registered
#When I copy a form to a project that does not contain coder settings
#Then I see error message
#And the Coder settings does not get transferred to the new form

	And I navigate to "Architect" module
	And I select "Project" link "MCC-42706D" in "Active Projects"
	And I select link "Define Copy Sources"
	And I check "Define all Projects and Global Libraries as Copy Sources."
	And I select "Study" link "MCC-42706D" in "Header"
	And I select "Draft" link "Target D"
	And I select link "Copy to Draft" located in "Left Nav"
	And I expand "Projects"
	And I expand "Project" "MCC-42706A"
	And I expand "Drafts"
	And I check "Source" in "Drafts"
	And I click button "Next"
	And I expand "ETE2 (ETE2)"
	When I check "CoderField2 (CODERFIELD2)"
	Then I verify text "Invalid selection. Project is not registered with Coder coding dictionary MCC42706CodingDictionary" exists with seeded
	| Data                     |
	| MCC42706CodingDictionary |
	And I take a screenshot
	And I verify "CoderField2 (CODERFIELD2)" is unchecked
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is unchecked
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is unchecked
	And I verify "StdCompField3 (STDCOMPFIELD3)" is unchecked
	And I verify "StdSuppField4 (STDSUPPFIELD4)" is unchecked
	And I verify "CoderField2 (CODERFIELD2)" is enabled
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is enabled
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is enabled
	And I verify "StdCompField3 (STDCOMPFIELD3)" is enabled
	And I verify "StdSuppField4 (STDSUPPFIELD4)" is enabled
	When I uncheck "ETE2 (ETE2)"
	Then I verify text "Invalid selection. Project is not registered with Coder coding dictionary MCC42706CodingDictionary" does not exist with seeded
	| Data                     |
	| MCC42706CodingDictionary |
	And I take a screenshot
	When I check "ETE2 (ETE2)"
	And I verify "CoderField2 (CODERFIELD2)" is unchecked
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is checked
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is checked
	And I verify "StdCompField3 (STDCOMPFIELD3)" is checked
	And I verify "StdSuppField4 (STDSUPPFIELD4)" is checked
	And I verify "CoderField2 (CODERFIELD2)" is enabled
	And I verify "LogCompField1 (LOGCOMPFIELD1)" is enabled
	And I verify "LogSuppField2 (LOGSUPPFIELD2)" is enabled
	And I verify "StdCompField3 (STDCOMPFIELD3)" is enabled
	And I verify "StdSuppField4 (STDSUPPFIELD4)" is enabled
	And I take a screenshot
	And I click button "Next"
	And I click button "Finish"
	And I select link "Forms" located in "Left Nav"
	And I search for form "ETE2"
	And I select Fields for Form "ETE2"
	And I verify field "CoderField2" does not exist
	And I verify field "LogCompField1" exists
	And I verify field "LogSuppField2" exists
	And I verify field "StdCompField3" exists
	And I verify field "StdSuppField4" exists
	And I edit Field "LogCompField1"
	And I verify button "Coder Configuration" does not exist
	And I take a screenshot
	And I edit Field "LogSuppField2"
	And I verify button "Coder Configuration" does not exist
	And I take a screenshot
	And I edit Field "StdCompField3"
	And I verify button "Coder Configuration" does not exist
	And I take a screenshot
	And I edit Field "StdSuppField4"
	And I verify button "Coder Configuration" does not exist
	And I take a screenshot
	
@Release2013.1.0
@PB_MCC42706-009
@VER2013.1.0
@VR23.Jan.2013
@Validation
Scenario: PBMCC42706-009 When I copy a form that contains Coder settings to a Architect Project with change OID, that has the Coder settings, then coder settings get copied to the new form and I should not see duplicate terms on Coder Configuration page.

	And I navigate to "Architect" module
	And I select "Project" link "MCC-42706C" in "Active Projects"
	And I select link "Define Copy Sources"
	And I check "Define all Projects and Global Libraries as Copy Sources."
	And I select "Study" link "MCC-42706C" in "Header"
	And I select "Draft" link "Target C"
	And I select link "Copy to Draft" located in "Left Nav"
	And I expand "Projects"
	And I expand "Project" "MCC-42706A"
	And I expand "Drafts"
	And I check "Source" in "Drafts"
	And I click button "Next"
	And I check "Forms"
	And I click button "Next"
	And I click button "Finish"
	And I select link "Forms" located in "Left Nav"
	And I search for form "ETE2"
	And I select Fields for Form "ETE2"
	And I verify field "CoderField2" exists
	And I verify field "LogCompField1" exists
	And I verify field "LogSuppField2" exists
	And I verify field "StdCompField3" exists
	And I verify field "StdSuppField4" exists
	And I verify field "CoderField2" has coding dictionary "MCC42706CodingDictionary"
	And I verify button "Coder Configuration" exists
	When I click button "Coder Configuration"
	Then I verify text "CC1" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Supplemental Terms" table
		| Name          |
		| LOGSUPPFIELD2 |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I verify rows exist in "Component Terms" table
		| Name          | Component Name |
		| LOGCOMPFIELD1 | CLCL1          |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I take a screenshot
	And I navigate to "Architect" module
	And I select "Project" link "MCC-42706C" in "Active Projects"
	And I select link "Define Copy Sources"
	And I check "Define all Projects and Global Libraries as Copy Sources."
	And I select "Study" link "MCC-42706C" in "Header"
	And I select "Draft" link "Target C"
	And I select link "Copy to Draft" located in "Left Nav"
	And I expand "Projects"
	And I expand "Project" "MCC-42706A"
	And I expand "Drafts"
	And I check "Source" in "Drafts"
	And I click button "Next"
	And I expand "ETE2 (ETE2)"
	And I select link "CoderField2 (CODERFIELD2)"
	And I expand "CoderField2 (CODERFIELD2) details"
	And I select link "Change OID in source"
	And I enter value "CoderField22" in "Change OID in source" "textbox"
	And I click button "Accept"
	And I check "CoderField2 (CODERFIELD22)"
	And I take a screenshot
	And I click button "Next"
	And I click button "Finish"
	And I select link "Forms" located in "Left Nav"
	And I search for form "ETE2"
	And I select Fields for Form "ETE2"
	And I verify field "CoderField2" with field OID "CODERFIELD22" exists
	And I verify field "LogCompField1" exists
	And I verify field "LogSuppField2" exists
	And I verify field "StdCompField3" exists
	And I verify field "StdSuppField4" exists
	And I verify field "CoderField2" has coding dictionary "MCC42706CodingDictionary"
	And I verify button "Coder Configuration" exists
	When I click button "Coder Configuration"
	Then I verify text "CC1" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Supplemental Terms" table "1" time(s)
		| Name          |
		| LOGSUPPFIELD2 |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I verify rows exist in "Component Terms" table "1" time(s)
		| Name          | Component Name |
		| LOGCOMPFIELD1 | CLCL1          |
	And I verify rows do not exist in "Supplemental Terms" table
		| Name          |
		| STDSUPPFIELD4 |
	And I take a screenshot