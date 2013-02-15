@FT_MCC-42701UL


Feature: MCC_42701UL Architect download will contain Coder settings and Architect upload will save Coder settings

Background:

    Given role "SUPER ROLE 1" exists
    Given study "MCC-42701-001" exists
	Given classic coding dictionary "WhoDrugClassic" version "20044" exists
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


@Release_2013.1.0
@PBMCC-42701-001
@SJ15.FEB.2013
@Validation

Scenario: PBMCC-42701-001 When uploading an architect spreadsheet that contains Coder settings and the URL has Coder registered, the Coder settings will be saved and the upload will be successfull
	
	When xml draft "MCC-42701-001.xml" is Uploaded
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 001" 
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
	And I verify rows exist in "Supplemental Terms" table
		| Name |
		| TEST1|
	And I verify rows exist in "Component Terms" table
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-002
@SJ15.FEB.2013
@Validation
Scenario: PBMCC-42701-002 When uploading an architect spreadsheet that does not contain Coder settings including coder in field level and the URL has Coder registered, the upload will be successfull
	

	When xml draft "MCC-42701-002.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 002" 
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	Then I verify button "Coder Configuration" is not visible
	And I take a screenshot



@Release_2013.1.0
@PBMCC-42701-003
@SJ15.FEB.2013
@Validation
Scenario: PBMCC-42701-003 When uploading an architect spreadsheet that contain same Field OID and same name for Supplemental Terms and Component Terms and the URL has Coder registered, the upload will fail and user will be provided with appropriate message

 	When xml draft "MCC-42701-003.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Component term Field OID 'VARCHECKBX' is already configured as Supplemental term" exists
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-004
@SJ15.FEB.2013
@Validation
Scenario: PBMCC-42701-004 When uploading an architect spreadsheet that contain name and component name for Component Terms and the URL has Coder registered, the upload will be successfull

	
	When xml draft "MCC-42701-004.xml" is Uploaded without redirecting
	And I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 004"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
		And I verify rows exist in "Component Terms" table
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot



@Release_2013.1.0
@PBMCC-42701-005
@SJ15.FEB.2013
@Validation
Scenario: PBMCC-42701-005 When uploading an architect spreadsheet that contain name and no component name in Component Terms and the URL has Coder registered, the upload will fail and user will be provided with appropriate message
	

	When xml draft "MCC-42701-005.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Both Component Name and Component Term is required" exists
	And I take a screenshot

	

@Release_2013.1.0
@PBMCC-42701-006
@SJ15.FEB.2013
@Validation
Scenario: PBMCC-42701-006 When uploading an architect spreadsheet after updating coding level in coder configuration and the URL has Coder registered, upload will be successfull and updated coding level will show on Coder configuration page with the intial coding level.

	
	When xml draft "MCC-42701-006A.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 006"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | False |
		| IsAutoApproval     | False |
	And I take a screenshot
	And xml draft "MCC-42701-006B.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 006"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	And I verify text "ATC" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-007
@SJ15.FEB.2013
@Validation
Scenario: PBMCC-42701-007 When uploading an architect spreadsheet that assigned coder dictionary to a field and have no Coder settings for the URL which Coder registered, the upload will fail and user will be provided with appropriate message
	
	
	When xml draft "MCC-42701-007.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Field with OID 'VARCHECKBX3' is configured to use coding dictionary but coder configuration for this field was not found." exists
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-008
@SJ15.FEB.2013
@Validation
Scenario: PBMCC-42701-008 When uploading an architect spreadsheet that assigned coder dictionary to a field and does not contain Coder settings for CoderConfiguration tab and have Coder settings for the URL which Coder is registered, the upload will fail and user will be provided with appropriate message


	When xml draft "MCC-42701-008.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Field with OID 'CODERTERM1' is configured to use coding dictionary but coder configuration for this field was not found." exists
	And I verify text "CoderConfiguration not found for Field OID 'VARCHECKBX3'" exists
	And I verify text "CoderConfiguration not found for Field OID 'VARCHECKBX3'" exists
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-009
@SJ15.FEB.2013
@Validation
Scenario: PBMCC-42701-009 When uploading an architect spreadsheet which contains same field name for SupplementalTerms and ComponentTerms and the URL has Coder registered, the upload will fail and user will be provided with appropriate message

	
	When xml draft "MCC-42701-009A.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 009"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "3" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
		And I verify rows exist in "Supplemental Terms" table
		| Name |
		| TEST1|
		And I verify rows exist in "Component Terms" table
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot
	When xml draft "MCC-42701-009B.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Supplemental term Field OID 'VARCHECKBX' is already configured as Component term" exists
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-010
@SJ15.FEB.2013
@Validation
Scenario: PBMCC-42701-010 When uploading an architect spreadsheet by changing Coding Level and the URL has Coder registered, the upload will fail and user will be provided with appropriate message


	When xml draft "MCC-42701-010A.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 010"
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "PRODUCT" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | False |
		| IsAutoApproval     | False |
	And I verify rows exist in "Supplemental Terms" table
		| Name  |
		| TEST1 |
	And I verify rows exist in "Component Terms" table
		| Name       | Component Name   |
		| VARCHECKBX | DRUGRECORDNUMBER |
	And I take a screenshot
	When xml draft "MCC-42701-010B.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Please remove all supplemental and component linked fields before changing coding level to 'ATC'." exists
	And I take a screenshot
	

@Release_2013.1.0
@PBMCC-42701-011
@SJ15.FEB.2013
@Validation
	Scenario: PBMCC-42701-011 When uploading an architect spreadsheet where a field does not have VarOID and assigned to coding dictionary and the URL has Coder registered, the upload will fail and user will be provided with appropriate message


	When xml draft "MCC-42701-011.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Error while reading row 47. Field OID 'FIELDNOVAR' in form OID 'TESTFORM' : Label fields (those that do not reference a variable) must not reference a data dictionary, unit dictionary or coding dictionary, and must not define data format" exists
	And I verify text "Field OID 'FIELDNOVAR' is invalid." exists
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-012
@SJ15.FEB.2013
@Validation
	Scenario: PBMCC-42701-012 When uploading an architect spreadsheet where a field does not have VarOID,format and field is not assign to coding dictionary and the URL has Coder registered, the upload will fail and user will be provided with appropriate message


	When xml draft "MCC-42701-012.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "The Field OID 'VARCHECKBX3' has not been set up as coding dictionary field" exists
	And I take a screenshot




@Release_2013.1.0
@PBMCC-42701-013
@SJ15.FEB.2013
@Validation

Scenario: PBMCC-42701-013 When uploading an architect spreadsheet that contains local jpn, the upload upload will be successfull and coder page will show local as jpn.

	When xml draft "MCC-42701-013.xml" is Uploaded
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 013" 
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "SOC" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify text "jpn" exists in "Locale"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
	And I verify rows exist in "Supplemental Terms" table
		| Name |
		| TEST1|
	And I take a screenshot

@Release_2013.1.0
@PBMCC-42701-014
@SJ15.FEB.2013
@Validation

Scenario: PBMCC-42701-014 When uploading an architect spreadsheet that does not contain a local, the upload upload will be successfull and coder page will show local as eng.

	When xml draft "MCC-42701-014.xml" is Uploaded
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-001" in "Active Projects"
	And I select Draft "Draft 014" 
	And I navigate to "Forms"
	And I select Fields for Form "MCC42701-001"
	And I edit Field "varcheckbx3"
	And I click button "Coder Configuration"
	Then I verify text "SOC" exists in "Coding Level"
	And I verify text "2" exists in "Priority"
	And I verify text "eng" exists in "Locale"
	And I verify rows exist in "Workflow Variables" table
		| Name               | Value |
		| IsApprovalRequired | True  |
		| IsAutoApproval     | True  |
	And I verify rows exist in "Supplemental Terms" table
		| Name |
		| TEST1|
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-015
@SJ15.FEB.2013
@Validation
Scenario: PBMCC-42701-015 When uploading an architect spreadsheet that does not contain tabs for CoderConfiguration, CoderSupplementalTerms and CoderComponentTerms, the upload will be successfull and will not have any coder settings.

	When xml draft "MCC-42701-015.xml" is Uploaded without redirecting
	And I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "MCC-42701-002" in "Active Projects"
	And I select Draft "Draft 001"
	And I navigate to "Forms"
	And I select Fields for Form "Form 3"
	And I edit Field "F3Field2"
	Then I verify button "Coder Configuration" is not visible
	And I take a screenshot

@Release_2013.1.0
@PBMCC-42701-016
@SJ15.FEB.2013
@Validation
Scenario: PBMCC-42701-016 When uploading an architect spreadsheet that contains Coder settings and the URL does not have Coder registered, the upload will fail and user will be provided with appropriate message

	
	When xml draft "MCC-42701-016.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And  I verify text "Error while reading row 5. Field OID 'CODERTERM1' in form OID 'ETE1' : Coding dictionary 'MedDRA (Coder)' is not registered for this project." exists in "Coding Dictionary:MedDRA"
	And  I verify text "Error while reading row 6. Field OID 'JDT' in form OID 'ETE1' : Coding dictionary 'JDrug (Coder)' is not registered for this project." exists in "Coding Dictionary:JDrug"
	And I verify text "Error while reading row 11. Field OID 'CODERFIELD2' in form OID 'ETE2' : Coding dictionary 'WHODRUGB2 (Coder)' is not registered for this project." exists in "Coding Dictionary:WHODRUGB2"
	And I verify text "Error while reading row 46. Field OID 'VARCHECKBX3' in form OID 'TESTFORM' : Coding dictionary 'WHODRUGB2 (Coder)' is not registered for this project." exists in "Coding Dictionary:WHODRUGB2"
	And I verify text "Error while reading row 10. Check step in check 'testing', ordinal 1 : Field OID 'CODERTERM1' is invalid." exists
	And I verify text "Field OID 'CODERTERM1' is invalid." exists
	And I verify text "Field OID 'JDT' is invalid." exists
	And I verify text "Field OID 'CODERFIELD2' is invalid." exists
	And I verify text "Field OID 'VARCHECKBX3' is invalid." exists
	And I verify text "Field OID 'VARCHECKBX3' is invalid." exists
	And I verify text "Field OID 'VARCHECKBX3' is invalid." exists
	And I take a screenshot

@Release_2013.1.0
@PBMCC-42701-017
@SJ15.FEB.2013
@Validation

Scenario: PBMCC-42701-017 When uploading an architect spreadsheet that contains classic Coder settings, coder configuration tabs do not exist and the URL has Coder registered, the upload will be successfull and  Coder configuration button will not exists

	When xml draft "MCC-42701-017.xml" is Uploaded without redirecting
	And I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "Classic Coding Dictionary 1" in "Active Projects"
	And I select Draft "Draft 1" 
	And I navigate to "Forms"
	And I select Fields for Form "Form1"
	And I edit Field "FIELD1A"
	And I choose "Rave- WhoDrugClassic" from "Coding Dictionary:"
	And I select link "Save"
	And I verify button "Coder Configuration" is not visible
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-018
@SJ15.FEB.2013
@Validation

Scenario: PBMCC-42701-018 When uploading an architect spreadsheet that contains classic Coder settings without correct version and the URL has Coder registered, the upload will fail and user will be provided with appropriate message

	When xml draft "MCC-42701-018.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Error while reading row 5. Field OID 'FIELD1A' in form OID 'FORM1' : Coding dictionary 'WhoDrugClassic (20)' not found in the target database." exists in "Classic Coding Dictionary:WhoDrugClassic"
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-019
@SJ15.FEB.2013
@Validation

Scenario: PBMCC-42701-019 When uploading an architect spreadsheet that contains classic Coder settings, no coder configuration settings and the URL has Coder registered, the upload will be successfull and  Coder configuration button will not exists

	When xml draft "MCC-42701-019.xml" is Uploaded without redirecting
	And I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Architect"
	And I select "Project" link "Classic Coding Dictionary 3" in "Active Projects"
	And I select Draft "Draft 1" 
	And I navigate to "Forms"
	And I select Fields for Form "Form1"
	And I edit Field "FIELD1A"
	And I choose "Rave- WhoDrugClassic" from "Coding Dictionary:"
	And I select link "Save"
	And I verify button "Coder Configuration" is not visible
	And I take a screenshot


@Release_2013.1.0
@PBMCC-42701-020
@SJ15.FEB.2013
@Validation

Scenario: PBMCC-42701-020 When uploading an architect spreadsheet that contains classic Coder settings, Coder configuration settings exist and the URL has Coder registered, the upload will fail and user will be provided with appropriate message

	When xml draft "MCC-42701-020.xml" is Uploaded without redirecting
	Then I verify text "Transaction rolled back." exists
	And I verify text "Error while reading row 6. Field OID 'FIELD2A' in form OID 'FORM1' : Coding dictionary 'WHODRUGB2 (Coder)' is not registered for this project." exists in "Coding Dictionary:WHODRUGB2"
	And I verify text "Field OID 'FIELD2A' is invalid." exists
	And I take a screenshot