@FT_MCC-41783

Feature: MCC-41783 Ability to inactivate Protocol Deviation Code and Class.
	As a Rave user
	I want to inactivate Protocol Deviation Code and class
	So I cannot see inactive Protocol Deviations
	
Background:
	Given I login to Rave with user "defuser"
	Given role "MCC_41783 Role" exists
	Given xml draft "MCC_41783_Source_Draft_AM.xml" is Uploaded
	Given xml draft "MCC_41783_Target_Draft_AM.xml" is Uploaded
	Given xml draft "MCC_41783_Draft_0.xml" is Uploaded
	Given xml draft "MCC_41783_Draft_00.xml" is Uploaded
	Given xml draft "MCC_41783_Draft_1.xml" is Uploaded
	Given xml draft "MCC_41783_Draft_2.xml" is Uploaded
	Given xml draft "MCC_41783_Draft_3.xml" is Uploaded
	Given xml draft "MCC_41783_GL_Draft_0.xml" is Uploaded
	Given xml draft "MCC_41783_GL_Draft_00.xml" is Uploaded
	Given xml draft "MCC_41783_GL_Draft_1.xml" is Uploaded
	Given xml draft "MCC_41783_GL_Draft_2.xml" is Uploaded
	Given xml draft "MCC_41783_GL_Draft_3.xml" is Uploaded	
	Given Site "MCC-41783 Site" exists	
	Given study "MCC-41783" is assigned to Site "MCC-41783 Site"	
	Given following Project assignments exist
		| User         | Project    | Environment | Role           | Site           | SecurityRole          | GlobalLibraryRole            |
		| SUPER USER 1 | MCC-41783  | Live: Prod  | MCC_41783 Role | MCC-41783 Site | Project Admin Default | Global Library Admin Default |
	Given I publish and push eCRF "MCC_41783_Draft_1.xml" to "Version 1"
	Given I login to Rave with user "SUPER USER 1"
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I inactivate deviation class "20"
	And I inactivate deviation code "B"
	Given following Report assignments exist
		| User         | Report                                           |
		| SUPER USER 1 | Protocol Deviations - Protocol Deviations Report |
					
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_01
@Validation
Scenario: PB_MCC_41783_01 As an Rave user, when I select Deviation in Configuration Module, then I should see Active column and checked by default for Deviation class.

 	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	When I navigate to "Deviations"
	Then I verify "Active" column name for "Class"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_02
@Validation
Scenario: PB_MCC_41783_02 As an Rave user, when I select Deviation in Configuration Module, then I should see Active column and checked by default for Deviation codes.

	Given I navigate to "Configuration"
	And I navigate to "Other Settings"
	When I navigate to "Deviations"
	Then I verify "Active" column name for "Code"
	And I take a screenshot
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_03
@Validation
Scenario: PB_MCC_41783_03 As an Rave user, when I select edit Deviation Class in Configuration Module, then I should see Active checkbox for Deviation Class.

	Given I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I select edit for "10" in "Class"
	And I verify checkbox "Active" checked for "10" in "Class"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_04
@Validation
Scenario: PB_MCC_41783_04 As an Rave user, when I select edit Deviation Codes in Configuration Module, then I should see Active checkbox for Deviation Codes.

	Given I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I select edit for "A" in "Code"
	And I verify checkbox "Active" checked for "A" in "Code"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_05
@Validation
Scenario: PB_MCC_41783_05 As an Rave user, when I uncheck Active checkbox for Deviation Class in Configuration Module and save, then I should not see inactive Protocol Deviation Class in Edit Checks Step Actions for 'Add Deviation'.

	Given I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I inactivate deviation class "10"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-41783" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Edit Checks"
	And I click on icon "Check Steps" for Edit Check "EC PD"
	When  I select link "Add Check Action"
	Then I verify deviation "class" with value "10" does not exist
	And I verify deviation "code" with value "A" exists
	And I take a screenshot
	
	And I navigate to "Home"	
	And I navigate to "Architect"
    And I select "Project" link "MCC-41783" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Edit Checks"
	And I click on icon "Check Steps" for Edit Check "EC PD"
	When  I select link "Add Check Action"
	Then I verify deviation "class" with value "10" does not exist
	And I verify deviation "code" with value "A" exists
	And I take a screenshot
	And I clean "deviation class" "10" to "active"	
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_06
@Validation
Scenario: PB_MCC_41783_06 As an Rave user, when I uncheck Active checkbox for Deviation Codes in Configuration Module and save, then I should not see inactive Protocol Deviation Codes in Edit Checks Step Actions for 'Add Deviation'.

	Given I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I inactivate deviation code "A"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-41783" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Edit Checks"
	And I click on icon "Check Steps" for Edit Check "EC PD"
	When  I select link "Add Check Action"
    Then I verify deviation "code" with value "A" does not exist
	And I verify deviation "class" with value "10" exists
	And I take a screenshot
	
	And I navigate to "Home"	
	And I navigate to "Architect"
    And I select "Project" link "MCC-41783" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Edit Checks"
	And I click on icon "Check Steps" for Edit Check "EC PD"
	When  I select link "Add Check Action"
    Then I verify deviation "code" with value "A" does not exist
	And I verify deviation "class" with value "10" exists
	And I take a screenshot	
	And I clean "deviation code" "A" to "active"		
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_07
@Validation
Scenario: PB_MCC_41783_07 As an Rave user, when I uncheck Active checkbox for Deviation Class in Configuration Module and save, then I should not see inactive Protocol Deviation Class on CRF Page.

	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num7>(5)} |
		| Subject Initials | sub               |
	And I select Form "AE"
	And I enter data in CRF and save
	    | Field | Data |
	    | Age   | 22   |
	When I add Protocol Deviation
		| Field | Class | Code | Text                    |
		| Age   | 10    | A    | Protocol Deviation test |
	Then I verify deviation "class" with value "20" does not exist in CRF
	And I verify deviation "class" with value "10" exists in CRF
	And I take a screenshot
	And I select Form "ELIGMIXEDPORT"
	And I enter data in CRF and save
	    | Field  | Data |
	    | COHORT | 6    |
	When I add Protocol Deviation
		| Field  | Class | Code | Text                    |
		| COHORT | 10    | A    | Protocol Deviation test |
	Then I verify deviation "class" with value "20" does not exist in CRF
	And I verify deviation "class" with value "10" exists in CRF
	And I take a screenshot	
	And I select Form "ELIGMIXEDLAND"
	And I enter data in CRF and save
	    | Field   | Data |
	    | COHORT2 | 6    |
	When I add Protocol Deviation
		| Field   | Class | Code | Text                    | Record |
		| COHORT2 | 10    | A    | Protocol Deviation test | 1      |
	Then I verify deviation "class" with value "20" does not exist in CRF
	And I verify deviation "class" with value "10" exists in CRF
	And I take a screenshot	
	And I select Form "ELIGLOGLAND"
	And I enter data in CRF and save
	    | Field   | Data |
	    | COHORT4 | 6    |
	When I add Protocol Deviation
		| Field   | Class | Code | Text                    | Record |
		| COHORT4 | 10    | A    | Protocol Deviation test | 1      |
	Then I verify deviation "class" with value "20" does not exist in CRF
	And I verify deviation "class" with value "10" exists in CRF
	And I take a screenshot	
		And I select Form "ELIGSTANDARD"
	And I enter data in CRF and save
	    | Field   | Data |
	    | COHORT5 | 6    |
	When I add Protocol Deviation
		| Field   | Class | Code | Text                    |
		| COHORT5 | 10    | A    | Protocol Deviation test |
	Then I verify deviation "class" with value "20" does not exist in CRF
	And I verify deviation "class" with value "10" exists in CRF
	And I take a screenshot		
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_08
@Validation
Scenario: PB_MCC_41783_08 As an Rave user, when I uncheck Active checkbox for Deviation Codes in Configuration Module and save, then I should not see inactive Protocol Deviation Codes on CRF Page.

	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num7>(5)} |
		| Subject Initials | sub               |
	And I select Form "AE"
	And I enter data in CRF and save
	    | Field | Data |
	    | Age   | 22   |
	When I add Protocol Deviation
		| Field | Class | Code | Text                    |
		| Age   | 10    | A    | Protocol Deviation test |
	Then I verify deviation "code" with value "B" does not exist in CRF
	And I verify deviation "code" with value "A" exists in CRF
	And I take a screenshot
	And I select Form "ELIGMIXEDPORT"
	And I enter data in CRF and save
	    | Field  | Data |
	    | COHORT | 6    |
	When I add Protocol Deviation
		| Field  | Class | Code | Text                    |
		| COHORT | 10    | A    | Protocol Deviation test |
	Then I verify deviation "code" with value "B" does not exist in CRF
	And I verify deviation "code" with value "A" exists in CRF
	And I take a screenshot	
	And I select Form "ELIGMIXEDLAND"
	And I enter data in CRF and save
	    | Field   | Data |
	    | COHORT2 | 6    |
	When I add Protocol Deviation
		| Field   | Class | Code | Text                    | Record |
		| COHORT2 | 10    | A    | Protocol Deviation test | 1      |
	Then I verify deviation "code" with value "B" does not exist in CRF
	And I verify deviation "code" with value "A" exists in CRF
	And I take a screenshot	
	And I select Form "ELIGLOGLAND"
	And I enter data in CRF and save
	    | Field   | Data |
	    | COHORT4 | 6    |
	When I add Protocol Deviation
		| Field   | Class | Code | Text                    | Record |
		| COHORT4 | 10    | A    | Protocol Deviation test | 1      |
	Then I verify deviation "code" with value "B" does not exist in CRF
	And I verify deviation "code" with value "A" exists in CRF
	And I take a screenshot	
		And I select Form "ELIGSTANDARD"
	And I enter data in CRF and save
	    | Field   | Data |
	    | COHORT5 | 6    |
	When I add Protocol Deviation
		| Field   | Class | Code | Text                    |
		| COHORT5 | 10    | A    | Protocol Deviation test |
	Then I verify deviation "code" with value "B" does not exist in CRF
	And I verify deviation "code" with value "A" exists in CRF
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_09
@Validation
Scenario: PB_MCC_41783_09 As an Rave user, when an Edit Check is set with inactive Deviation Codes in Architect, then I should not be able to publish CRF Version and I should see message "* You cannot publish the draft. The following edit checks use an inactive Protocol Deviation class or code: [EC PD]".

	And I navigate to "Architect"
	And I select link "MCC-41783" in "Active Projects"
	And I select Draft "Draft 0"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	Then I verify text "* You cannot publish the draft. The following edit checks use an inactive Protocol Deviation class or code: [EC PD]" exists
	And I take a screenshot
	
	And I navigate to "Home"	
	And I navigate to "Architect"
    And I select "Project" link "MCC-41783" in "Active Global Library Volumes"
	And I select Draft "Draft 0"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	Then I verify text "* You cannot publish the draft. The following edit checks use an inactive Protocol Deviation class or code: [EC PD]" exists
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_10
@Validation
Scenario: PB_MCC_41783_10 As an Rave user, when an Edit Check is set with inactive Deviation Class in Architect, then I should not be able to publish CRF Version and I should see message "* You cannot publish the draft. The following edit checks use an inactive Protocol Deviation class or code: [EC PD]".

	And I navigate to "Architect"
	And I select link "MCC-41783" in "Active Projects"
	And I select Draft "Draft 00"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	Then I verify text "* You cannot publish the draft. The following edit checks use an inactive Protocol Deviation class or code: [EC PD]" exists
	And I take a screenshot

	And I navigate to "Home"	
	And I navigate to "Architect"
    And I select "Project" link "MCC-41783" in "Active Global Library Volumes"
	And I select Draft "Draft 00"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	Then I verify text "* You cannot publish the draft. The following edit checks use an inactive Protocol Deviation class or code: [EC PD]" exists
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_11
@Validation
Scenario: PB_MCC_41783_11 As an Rave user, when an Custom Function is set with inactive Deviation Codes in Architect, then I should not be able to publish CRF Version and I should see message "* You cannot publish the draft. The following custom functions use an inactive Protocol Deviation class or code: [CF_PD_test]".
	
	And I navigate to "Architect"
	And I select link "MCC-41783" in "Active Projects"
	And I select Draft "Draft 0"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	Then I verify text "* You cannot publish the draft. The following custom functions use an inactive Protocol Deviation class or code: [CF_PD_test]" exists
	And I take a screenshot
	
	And I navigate to "Home"	
	And I navigate to "Architect"
    And I select "Project" link "MCC-41783" in "Active Global Library Volumes"
	And I select Draft "Draft 0"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	Then I verify text "* You cannot publish the draft. The following custom functions use an inactive Protocol Deviation class or code: [CF_PD_test]" exists
	And I take a screenshot	
	
#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_12
@Validation
Scenario: PB_MCC_41783_12 As an Rave user, when an Custom Function is set with inactive Deviation Class in Architect, then I should not be able to publish CRF Version and I should see message "* You cannot publish the draft. The following custom functions use an inactive Protocol Deviation class or code: [CF_PD_test]".

	And I navigate to "Architect"
	And I select link "MCC-41783" in "Active Projects"
	And I select Draft "Draft 0"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	Then I verify text "* You cannot publish the draft. The following custom functions use an inactive Protocol Deviation class or code: [CF_PD_test]" exists
	And I take a screenshot

	And I navigate to "Home"	
	And I navigate to "Architect"
    And I select "Project" link "MCC-41783" in "Active Global Library Volumes"
	And I select Draft "Draft 0"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	Then I verify text "* You cannot publish the draft. The following custom functions use an inactive Protocol Deviation class or code: [CF_PD_test]" exists
	And I take a screenshot		

#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_13
@Validation
Scenario: PB_MCC_41783_13 As an Rave user, when an invalid Edit Check is set with inactive Deviation Code in Architect, then I should be able to publish CRF Version.

	And I navigate to "Architect"
	And I select link "MCC-41783" in "Active Projects"
	And I select Draft "Draft 2"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	And I wait for 5 seconds
	Then I verify text "* You cannot publish the draft." does not exist
	And I take a screenshot

	And I navigate to "Home"	
	And I navigate to "Architect"
    And I select "Project" link "MCC-41783" in "Active Global Library Volumes"
	And I select Draft "Draft 2"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	And I wait for 5 seconds
	Then I verify text "* You cannot publish the draft." does not exist
	And I take a screenshot		

#----------------------------------------------------------------------------------------------------------------------------------
@release_2013.2.0
@PB_MCC_41783_14
@Validation
Scenario: PB_MCC_41783_14 As an Rave user, when an invalid Edit Check is set with inactive Deviation Class in Architect, then I should be able to publish CRF Version.

	And I navigate to "Architect"
	And I select link "MCC-41783" in "Active Projects"
	And I select Draft "Draft 3"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	And I wait for 5 seconds
	Then I verify text "* You cannot publish the draft." does not exist
	And I take a screenshot

	And I navigate to "Home"	
	And I navigate to "Architect"
    And I select "Project" link "MCC-41783" in "Active Global Library Volumes"
	And I select Draft "Draft 3"
	When I publish CRF Version "Pub1{RndNum<TV#>(5)}"
	And I wait for 5 seconds
	Then I verify text "* You cannot publish the draft." does not exist
	And I take a screenshot	

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_2013.2.0
@PB_MCC_41783_15
@Validation
@Validation
Scenario: PB_MCC_41783_15 As an EDC user, Migrating Subject Verification for inactive class and code protocol deviation. 
	
	Given I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I clean "deviation class" "20" to "active"
	And I clean "deviation code" "B" to "active"	
	And I take a screenshot
	And I navigate to "Home"	
	And I navigate to "Architect"
	And I select link "MCC-41783" in "Active Projects"
	And I select Draft "Source Draft AM"
	And I publish CRF Version "MIG1{RndNum<TV#>(5)}"
	And I note down "crfversion" to "newversion1#"
	And I navigate to "Home"	
	And I navigate to "Architect"
	And I select link "MCC-41783" in "Active Projects"
	And I push CRF Version "{Var(newversion1#)}" to "All Sites"
	And I navigate to "Home"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num7>(5)} |
		| Subject Initials | sub               |
	And I note down "crfversion" to "ver#"
	And I select Form "VISIT_INFO"
	And I enter data in CRF and save
	    | Field      | Data        |
	    | VISIT_DATE | 07 Jan 2000 |
	And I take a screenshot
	When I add Protocol Deviation
		| Field      | Class | Code | Text                    |
		| VISIT_DATE | 20    | B    | Protocol Deviation test |
	Then I verify deviation "code" with value "A" exists in CRF
	And I verify deviation "code" with value "B" exists in CRF
	And I verify deviation "class" with value "10" exists in CRF
	And I verify deviation "class" with value "20" exists in CRF
	And I take a screenshot	
	And I navigate to "Home"
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I inactivate deviation class "20"
	And I inactivate deviation code "B"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select link "MCC-41783" in "Active Projects"
	And I select Draft "Target Draft AM"
	And I publish CRF Version "Target{RndNum<TV#>(3)}"
	And I note down "crfversion" to "newversion2#"
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select link "MCC-41783" in "Active Projects"
	And I navigate to "Amendment Manager"
	And I choose "{Var(newversion1#)}" from "Source CRF"
	And I choose "{Var(newversion2#)}" from "Target CRF"
	And I click button "Create Plan"
	And I take a screenshot
	And I navigate to "Execute Plan"
	And I migrate all Subjects
	And I select link "Migration Results"
	And I verify Job Status is set to Complete
	And I take a screenshot
	And I navigate to "Home"
    And I select a Subject "sub{Var(num7)}"
	And I select Form "VISIT_INFO"
	When I add Protocol Deviation
		| Field      | Class | Code | Text                    |
		| VISIT_DATE | 10    | A    | Protocol Deviation test |
	Then I verify deviation "code" with value "B" does not exist in CRF
	And I verify deviation "code" with value "A" exists in CRF
	And I verify deviation "class" with value "20" does not exist in CRF
	And I verify deviation "class" with value "10" exists in CRF
	And I take a screenshot
	And I select link "SUB{Var(num1)}" in "Header"	
	And I select Form "VISIT_INFO"
	And I enter data in CRF and save
	    | Field      | Data        |
	    | VISIT_DATE | 08 Jan 2000 |
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_2013.2.0
@PB_MCC_41783_16
@Validation
Scenario: PB_MCC_41783_16, As an user, When I run Protocol Deviation Report, then i should see inactive class and code protocol deviation assigned to data points.

	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I clean "deviation class" "20" to "active"
	And I clean "deviation code" "B" to "active"	
	And I take a screenshot
	And I navigate to "Home"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I note down "crfversion" to "ver#"
	And I select Form "VISIT_INFO"
	And I enter data in CRF and save
	    | Field      | Data        |
	    | VISIT_DATE | 07 Jan 2000 |
	And I take a screenshot
	And I add Protocol Deviation
		| Field      | Class | Code | Text               |
		| VISIT_DATE | 20    | B    | Protocol Deviation |
	And I save the CRF page
	And I take a screenshot
	And I select link "SUB{Var(num1)}" in "Header"	
	And I select Form "VISIT_INFO"
	When I click audit on Field "VISIT_DATE"
	Then I verify last audit exist
		| Audit Type         | Query Message                                                     |
		| Protocol Deviation | Protocol deviation created: Protocol Deviation Class: 20 Code: B. |
	And I navigate to "Home"
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I inactivate deviation class "20"
	And I inactivate deviation code "B"
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Reporter"
	When I select Report "Protocol Deviations"
	And I set report parameter "Study" with table
		| Name      | Environment |
		| MCC-41783 | Prod        |
	And I click button "Submit Report"
	Then I switch to "ReportViewer" window
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------	
@release_2013.2.0
@PB_MCC_41783_17
@Validation
Scenario: PB_MCC_41783_17, As an EDC user, When I submit data in EDC, then edit check with inactive protocol deviation class or code fires on data points.

	And I clean "deviation class" "20" to "active"
	And I clean "deviation code" "B" to "active"	
	And I navigate to "Configuration"
	And I navigate to "Other Settings"
	And I navigate to "Deviations"
	And I inactivate deviation class "10"
	And I inactivate deviation code "A"
	And I take a screenshot
	And I navigate to "Home"
	And I create a Subject
		| Field            | Data              |
		| Subject Number   | {RndNum<num1>(5)} |
		| Subject Initials | SUB               |
	And I select Form "VISIT_INFO"
	And I enter data in CRF and save
	    | Field      | Data        |
	    | VISIT_DATE | 07 Jan 2000 |
	And I take a screenshot
	When I add Protocol Deviation
		| Field      | Class | Code | Text                 |
		| VISIT_DATE | 20    | B    | Protocol Deviation 1 |
	Then I verify deviation "code" with value "A" does not exist in CRF
	And I verify deviation "class" with value "10" does not exist in CRF
	And I take a screenshot	
	And I select link "SUB{Var(num1)}" in "Header"	
	And I select Form "VISIT_INFO"
	And I add Protocol Deviation
		| Field      | Class | Code | Text                 |
		| VISIT_DATE | ...   | ...  | Protocol Deviation 2 |
	When I save the CRF page
	Then I verify text "Missing protocol deviation code or class." exists
	And I take a screenshot
	And I select link "SUB{Var(num1)}" in "Header"	
	And I select Form "VISIT_INFO"
	When I click audit on Field "VISIT_DATE"
	Then I verify last audit exist
		| Audit Type         | Query Message                                                           | 
		| Protocol Deviation | Protocol deviation created: Protocol Deviation Added Class: 10 Code: A. |
	And I take a screenshot
	And I clean "deviation class" "10" to "active"
	And I clean "deviation code" "A" to "active"