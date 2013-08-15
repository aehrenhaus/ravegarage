@FT_MCC-41782

Feature: MCC-41782 As a user with direct access to the Rave database, I am able to see a list of created and deleted view and entry restrictions

Background:

	Given role "SUPER ROLE 1" exists
	Given xml draft "MCC-41782AL.xml" is Uploaded
	Given xml draft "MCC-41782GL.xml" is Uploaded
	Given study "MCC-41782" is assigned to Site "Site 1" with study environment "Live: Prod"
	Given following Project assignments exist
	| User               | Project   | Environment | Role         | Site   | SecurityRole          | GlobalLibraryRole            |
	| SUPER USER 1       | MCC-41782 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | Project Admin Default        |
	| MCC41782_SUPERUSER | MCC-41782 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | Project Admin Default        |
	| SUPER USER 1       | MCC-41782 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | Global Library Admin Default |
	| MCC41782_SUPERUSER | MCC-41782 | Live: Prod  | SUPER ROLE 1 | Site 1 | Project Admin Default | Global Library Admin Default |
	
	
	


@Release_2013.2.0
@PB_MCC-41782-001
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-001 When a user add and remove Form View Restrictions in an Architect draft, then the correct Audits are generated in Database. 


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	Then I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                             | AuditSubCategory     | Property |
		| View restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionAdded | Form     |  
	And I delete Architect Audits for user "SUPER USER 1"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	Then I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                             | AuditSubCategory       | Property |
		| View restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionRemoved | Form     |
	And I delete Architect Audits for user "SUPER USER 1"




@Release_2013.2.0
@PB_MCC-41782-002
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-002 When a user add and remove Form Entry Restrictions in an Architect draft, then the correct Audits are generated in Database. 


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	Then I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                              | AuditSubCategory      | Property |
		| Entry restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Form     |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	Then I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                              | AuditSubCategory        | Property |
		| Entry restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Form     |
	And I delete Architect Audits for user "SUPER USER 1"


@Release_2013.2.0
@PB_MCC-41782-003
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-003 When a user add and remove both Form View and  Form Entry Restrictions in an Architect draft, then the correct Audits are generated in Database. 

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	Then I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                              | AuditSubCategory      | Property |
		| Entry restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Form     |
		| View restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionAdded  | Form     |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	Then I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                              | AuditSubCategory        | Property |
		| Entry restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Form     |
		| View restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionRemoved  | Form     | 
	And I delete Architect Audits for user "SUPER USER 1"


@Release_2013.2.0
@PB_MCC-41782-004
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-004 When a user add and remove Field View Restrictions in an Architect draft, then the correct Audits are generated in Database. 


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	Then I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                           | AuditSubCategory     | Property |
			| View restriction on field STD1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionAdded | Field    |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	Then I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                           | AuditSubCategory       | Property |
		| View restriction on field STD1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionRemoved | Field    |
	And I delete Architect Audits for user "SUPER USER 1"



@Release_2013.2.0
@PB_MCC-41782-005
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-005 When a user add and remove Field Entry Restrictions in an Architect draft, then the correct Audits are generated in Database.


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field Entry Restriction for role 
		| Form   | Field       | Role         | Selected |
		| Form 1 | Log Field 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                            | AuditSubCategory      | Property |
		| Entry restriction on field LOG1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field Entry Restriction for role 
		| Form   | Field       | Role         | Selected |
		| Form 1 | Log Field 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                            | AuditSubCategory        | Property |
		| Entry restriction on field LOG1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Field    |
	And I delete Architect Audits for user "SUPER USER 1"



@Release_2013.2.0
@PB_MCC-41782-006
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-006 When a user add and remove both field View and field Entry Restrictions in an Architect draft, then the correct Audits are generated in Database. 


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | True     |
	And I update field Entry Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                            | AuditSubCategory      | Property |
		| Entry restriction on field STD1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
		| View restriction on field STD1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionAdded  | Field    |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | False    |
	And I update field Entry Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                            | AuditSubCategory        | Property |
		| Entry restriction on field STD1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Field    |
		| View restriction on field STD1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionRemoved  | Field    | 
	And I delete Architect Audits for user "SUPER USER 1"



@Release_2013.2.0
@PB_MCC-41782-007
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-007 When a user add and remove Global View Restrictions in an Architect draft, then the correct Audits are generated in Database. 


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update Global View Restrictions for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                               | AuditSubCategory     | Property |
		| View restriction on field DATETIME in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionAdded | Field    |
		| View restriction on field LOG2 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionAdded | Field    |
		| View restriction on field LOG1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionAdded | Field    |
		| View restriction on field STD1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionAdded | Field    | 
	And I delete Architect Audits for user "SUPER USER 1"
	And I update Global View Restrictions for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                               | AuditSubCategory       | Property |
		| View restriction on field DATETIME in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionRemoved | Field    |
		| View restriction on field LOG2 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionRemoved | Field    |
		| View restriction on field LOG1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionRemoved | Field    |
		| View restriction on field STD1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionRemoved | Field    |  
	And I delete Architect Audits for user "SUPER USER 1"




@Release_2013.2.0
@PB_MCC-41782-008
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-008 When a user add and remove Global Entry Restrictions in an Architect draft, then the correct Audits are generated in Database.	



	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update Global Entry Restrictions for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                | AuditSubCategory      | Property |
		| Entry restriction on field DATETIME in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
		| Entry restriction on field LOG2 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionAdded | Field    |
		| Entry restriction on field LOG1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionAdded | Field    |
		| Entry restriction on field STD1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionAdded | Field    | 
	And I delete Architect Audits for user "SUPER USER 1"
	And I update Global Entry Restrictions for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                | AuditSubCategory        | Property |
		| Entry restriction on field DATETIME in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Field    |
		| Entry restriction on field LOG2 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionRemoved | Field    |
		| Entry restriction on field LOG1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionRemoved | Field    |
		| Entry restriction on field STD1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionRemoved | Field    |
	And I delete Architect Audits for user "SUPER USER 1"




@Release_2013.2.0
@PB_MCC-41782-009
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-009 When a user add and remove View Restrictions through Fields in an Architect draft, then the correct Audits are generated in Database. 

	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "Form 2"
	And I edit Field "Standard 2"
	And I expand "View Restrictions"
	And I update field View Restriction for role
		| Role         | Selected |
		| SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                  | AuditSubCategory     | Property |
		| View restriction on field STD1 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionAdded | Field    |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field View Restriction for role
		| Role         | Selected |
		| SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                                  | AuditSubCategory       | Property |
		| View restriction on field STD1 in form SCENARIO1 was deleted for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionRemoved | Field    |
	And I delete Architect Audits for user "SUPER USER 1"




@Release_2013.2.0
@PB_MCC-41782-010
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-010  When a user add and remove Entry Restrictions through Fields in an Architect draft, then the correct Audits are generated in Database. 

	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "Form 2"
	And I edit Field "AGEN"
	And I expand "Entry Restrictions"
	And I update field Entry Restriction for role
		| Role         | Selected |
		| SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                                   | AuditSubCategory      | Property |
		| Entry restriction on field AGEN in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field Entry Restriction for role
		| Role         | Selected |
		| SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                                   | AuditSubCategory        | Property |
		| Entry restriction on field AGEN in form SCENARIO1 was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Field    |
	And I delete Architect Audits for user "SUPER USER 1"



@Release_2013.2.0
@PB_MCC-41782-011
@SJ13.MAY.2013
@Validation



Scenario: MCC-41782-011  When a user upload an Architect draft with View and Entry Restrictions, then the correct Audits are generated in Database. 


	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	When I navigate to "Architect"
	When xml draft "MCC-41782-011.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                   | AuditSubCategory      | Property |
		| View restriction on field AGE18 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionAdded  | Field    |
		| Entry restriction on field LOG2 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"        | EntryRestrictionAdded | Field    |
		| View restriction on form FORM3 was created for role SUPERROLE % CRF Draft: "Draft 1"                    | ViewRestrictionAdded  | Form     |
		| Entry restriction on form FORM3 was created for role SUPERROLE % CRF Draft: "Draft 1"                   | EntryRestrictionAdded | Form     |
	And I delete Architect Audits for user "SUPER USER 1"
	And I navigate to "Home"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I update field View Restriction for role 
		| Form   | Field | Role         | Selected |
		| Form 2 | AGE18 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update field Entry Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 2 | Standard 2 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 3 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 3 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                   | AuditSubCategory        | Property |
		| View restriction on field AGE18 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionRemoved  | Field    |
		| Entry restriction on field LOG2 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"        | EntryRestrictionRemoved | Field    |
		| View restriction on form FORM3 was created for role SUPERROLE % CRF Draft: "Draft 1"                    | ViewRestrictionRemoved  | Form     |
		| Entry restriction on form FORM3 was created for role SUPERROLE % CRF Draft: "Draft 1"                   | EntryRestrictionRemoved | Form     |
	And I delete Architect Audits for user "SUPER USER 1"


@Release_2013.2.0
@PB_MCC-41782-012
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-012 When a user copy an Architect draft by using Copy to Draft Wizard with View and Entry Restrictions, then the correct Audits are generated in Database. 

 	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	And I navigate to "Architect"
	And xml draft "MCC-41782-012.xml" is Uploaded without redirecting
	And I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select link "Define Copy Sources"
	And I check "Define all Projects and Global Libraries as Copy Sources."
	And I select "Study" link "MCC-41782" in "Header"
	And I select "Draft" link "Draft 1"
	And I select link "Copy to Draft" located in "Left Nav"
	And I expand "Projects"
	And I expand "Project" "MCC-41782"
	And I expand "Drafts"
	And I check "Draft 2" in "Drafts"
	And I click button "Next"
	And I expand "Form 4 (FORM4)"
	And I check "STDRES1 (STDRES1)"
	And I verify "STDRES1 (STDRES1)" is checked
	And I expand "Form 5 (FORM5)"
	And I check "STDRES2 (STDRES2)"
	And I verify "STDRES2 (STDRES2)" is checked
	And I click button "Next"
	And I take a screenshot
	And I click button "Finish"
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                  | AuditSubCategory      | Property |
		| View restriction on field STDRES2 in form FORM5 was created for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionAdded  | Field    |
		| Entry restriction on field STDRES2 in form FORM5 was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
		| View restriction on form FORM4 was created for role SUPERROLE % CRF Draft: "Draft 1"                   | ViewRestrictionAdded  | Form     |
		| Entry restriction on form FORM4 was created for role SUPERROLE % CRF Draft: "Draft 1"                  | EntryRestrictionAdded | Form     |
	And I delete Architect Audits for user "SUPER USER 1"




@Release_2013.2.0
@PB_MCC-41782-013
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-013 When a user add a new field in an Architect draft with View and Entry Restrictions, then the correct Audits are generated in Database. 


	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	And I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects" 
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "Form 1"
	And I select link "Add New"
	And I enter data in Architect Field and save
		| Field       | Data  | ControlType |
		| VarOID      | Test1 | textbox     |
		| Format      | 3     | textbox     |
		| Field Name  | Test1 | textbox     |
		| Field OID   | Test1 | textbox     |
		| Field Label | Test1 | textarea    |
	And I expand "View Restrictions"
	And I update field View Restriction for role
		| Role         | Selected |
		| SUPER ROLE 1 | True     |
	And I take a screenshot
	And I expand "Entry Restrictions"
	And I update field Entry Restriction for role 
		| Role         | Selected |
		| SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                             | AuditSubCategory      | Property |
		| Entry restriction on field Test1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
		| View restriction on field Test1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionAdded  | Field    |
	And I delete Architect Audits for user "SUPER USER 1"


@Release_2013.2.0
@PB_MCC-41782-014
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-014 When a user copy Architect draft by using Propose Objects with View and Entry Restrictions, then the correct Audits are generated in Database.


	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	And I navigate to "Architect"
	And xml draft "MCC-41782-014.xml" is Uploaded without redirecting
	And I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-41782-014" in "Active Projects" 
	And I select Draft "Draft 1"
	And I select link "Propose Objects" located in "Left Nav"
	And I expand "Form 1 (MX)"
	And I check "Form 1 (MX)"
	And I verify "Standard 1 (STD1)" is checked
	And I verify "Log Field 1 (LOG1)" is checked
	And I verify "Log Field 2 (LOG2)" is checked
	And I verify "DATETIME (DATETIME)" is checked
	And I expand "Form 2 (SCENARIO1)"
	And I check "AGE18 (AGE18)"
	And I verify "AGE18 (AGE18)" is checked
	And I take a screenshot
	And I click button "Next"
	And I enter value "MCC-41782-014proposal" in "Proposal Name" "textbox"
	And I enter value "MCC-41782-014Description" in "Proposal Description" "textbox"
	And I click button "Finish"
	And I navigate to "Architect" module
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782-014", draft "Draft 1" 
		| Audit                                                                                                          | AuditSubCategory      | Property |
		| View restriction on form MX was created for role SUPERROLE % CRF Draft: "MCC-41782-014"                        | ViewRestrictionAdded  | Form     |
		| Entry restriction on form MX was created for role SUPERROLE % CRF Draft: "MCC-41782-014"                       | EntryRestrictionAdded | Form     |
		| View restriction on field AGE18 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "MCC-41782-014"  | ViewRestrictionAdded  | Field    |
		| Entry restriction on field AGE18 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "MCC-41782-014" | EntryRestrictionAdded | Field    |
	And I delete Architect Audits for user "SUPER USER 1"




@Release_2013.2.0
@PB_MCC-41782-015
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-015 When multiple users take actions to restrict view and entry in an Architect draft, then the correct Audits are generated in Database for individual actions per user.


	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I navigate to "Restrictions"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 2 | Standard 2 | SUPER ROLE 1 | True     |
	And I navigate to "Restrictions"
	And I update field Entry Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 2 | Standard 2 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                   | AuditSubCategory      | Property |
		| Entry restriction on field STD1 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
		| View restriction on field STD1 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionAdded  | Field    |
		| Entry restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1"                      | EntryRestrictionAdded | Form     |
		| View restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1"                       | ViewRestrictionAdded  | Form     |
	And I delete Architect Audits for user "SUPER USER 1"
	And I login to Rave with user "MCC41782_SUPERUSER"
	And I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Projects"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I navigate to "Restrictions"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 2 | Standard 2 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update field Entry Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 2 | Standard 2 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "MCC41782_SUPERUSER", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                    | AuditSubCategory        | Property |
		| View restriction on field AGE18 in form SCENARIO1 was deleted for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionRemoved  | Field    |
		| Entry restriction on field AGE18 in form SCENARIO1 was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Field    |
		| View restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"                        | ViewRestrictionRemoved  | Form     |
		| Entry restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"                       | EntryRestrictionRemoved | Form     |
	And I delete Architect Audits for user "SUPER USER 2"





@Release_2013.2.0
@PB_MCC-41782-016
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-016 When a user add and remove Form View Restrictions in a Global Library draft, then the correct Audits are generated in Database. 


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                             | AuditSubCategory     | Property |
		| View restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionAdded | Form     | 
	And I delete Architect Audits for user "SUPER USER 1"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                             | AuditSubCategory       | Property |
		| View restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionRemoved | Form     |
	And I delete Architect Audits for user "SUPER USER 1"



@Release_2013.2.0
@PB_MCC-41782-017
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-017 When a user add and remove Form Entry Restrictions in a Global Library draft, then the correct Audits are generated in Database. 


	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                              | AuditSubCategory      | Property |
		| Entry restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Form     |
	And I delete Architect Audits for user "SUPER USER 1"
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                              | AuditSubCategory        | Property |
		| Entry restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Form     |
	And I delete Architect Audits for user "SUPER USER 1"




@Release_2013.2.0
@PB_MCC-41782-018
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-018 When a user add and remove both Form View and  Form Entry Restrictions in a Global Library draft, then the correct Audits are generated in Database. 

	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                              | AuditSubCategory      | Property |
		| Entry restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Form     |
		| View restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionAdded  | Form     |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                              | AuditSubCategory        | Property |
		| Entry restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Form     |
		| View restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionRemoved  | Form     | 
	And I delete Architect Audits for user "SUPER USER 1"



@Release_2013.2.0
@PB_MCC-41782-019
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-019 When a user add and remove Field View Restrictions in a Global Library draft, then the correct Audits are generated in Database. 


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                           | AuditSubCategory     | Property |
		| View restriction on field STD1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionAdded | Field    |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                           | AuditSubCategory       | Property |
		| View restriction on field STD1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionRemoved | Field    |
	And I delete Architect Audits for user "SUPER USER 1"



@Release_2013.2.0
@PB_MCC-41782-020
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-020 When a user add and remove Field Entry Restrictions in a Global Library draft, then the correct Audits are generated in Database.


	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field Entry Restriction for role 
		| Form   | Field       | Role         | Selected |
		| Form 1 | Log Field 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                            | AuditSubCategory      | Property |
		| Entry restriction on field LOG1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field Entry Restriction for role 
		| Form   | Field       | Role         | Selected |
		| Form 1 | Log Field 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                            | AuditSubCategory        | Property |
		| Entry restriction on field LOG1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Field    | 
	And I delete Architect Audits for user "SUPER USER 1"




@Release_2013.2.0
@PB_MCC-41782-021
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-021 When a user add and remove both field View and field Entry Restrictions in a Global Library draft, then the correct Audits are generated in Database. 

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | True     |
	And I navigate to "Restrictions"
	And I update field Entry Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                            | AuditSubCategory      | Property |
		| Entry restriction on field STD1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
		| View restriction on field STD1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionAdded  | Field    |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update field Entry Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 1 | Standard 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                            | AuditSubCategory        | Property |
		| Entry restriction on field STD1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Field    |
		| View restriction on field STD1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionRemoved  | Field    | 
	And I delete Architect Audits for user "SUPER USER 1"




@Release_2013.2.0
@PB_MCC-41782-022
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-022 When a user add and remove Global View Restrictions in a Global Library draft, then the correct Audits are generated in Database. 

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update Global View Restrictions for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                               | AuditSubCategory     | Property |
		| View restriction on field DATETIME in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionAdded | Field    |
		| View restriction on field LOG2 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionAdded | Field    |
		| View restriction on field LOG1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionAdded | Field    |
		| View restriction on field STD1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionAdded | Field    |  
	And I delete Architect Audits for user "SUPER USER 1"
	And I update Global View Restrictions for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                               | AuditSubCategory       | Property |
		| View restriction on field DATETIME in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionRemoved | Field    |
		| View restriction on field LOG2 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionRemoved | Field    |
		| View restriction on field LOG1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionRemoved | Field    |
		| View restriction on field STD1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | ViewRestrictionRemoved | Field    |  
	And I delete Architect Audits for user "SUPER USER 1"




@Release_2013.2.0
@PB_MCC-41782-023
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-023 When a user add and remove Global Entry Restrictions in a Global Library draft, then the correct Audits are generated in Database.	

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 1"
	And I update Global Entry Restrictions for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                | AuditSubCategory      | Property |
		| Entry restriction on field DATETIME in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
		| Entry restriction on field LOG2 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionAdded | Field    |
		| Entry restriction on field LOG1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionAdded | Field    |
		| Entry restriction on field STD1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionAdded | Field    | 
	And I delete Architect Audits for user "SUPER USER 1"
	And I update Global Entry Restrictions for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                | AuditSubCategory        | Property |
		| Entry restriction on field DATETIME in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Field    |
		| Entry restriction on field LOG2 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionRemoved | Field    |
		| Entry restriction on field LOG1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionRemoved | Field    |
		| Entry restriction on field STD1 in form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"     | EntryRestrictionRemoved | Field    |
	And I delete Architect Audits for user "SUPER USER 1"




@Release_2013.2.0
@PB_MCC-41782-024
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-024 When a user add and remove View Restrictions through Fields in a Global Library draft, then the correct Audits are generated in Database. 

	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "Form 2"
	And I edit Field "Standard 2"
	And I expand "View Restrictions"
	And I update field View Restriction for role
		| Role         | Selected |
		| SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                  | AuditSubCategory     | Property |
		| View restriction on field STD1 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionAdded | Field    |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field View Restriction for role
		| Role         | Selected |
		| SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                                  | AuditSubCategory       | Property |
		| View restriction on field STD1 in form SCENARIO1 was deleted for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionRemoved | Field    | 
	And I delete Architect Audits for user "SUPER USER 1"



@Release_2013.2.0
@PB_MCC-41782-025
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-025  When a user add and remove Entry Restrictions through Fields in a Global Library draft, then the correct Audits are generated in Database. 

	Given I login to Rave with user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "Form 2"
	And I edit Field "AGEN"
	And I expand "Entry Restrictions"
	And I update field Entry Restriction for role 
		| Form   | Field | Role         | Selected |
		| Form 2 | AGEN  | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                                   | AuditSubCategory      | Property |
		| Entry restriction on field AGEN in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
	And I delete Architect Audits for user "SUPER USER 1"
	And I update field Entry Restriction for role 
		| Form   | Field | Role         | Selected |
		| Form 2 | AGEN  | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1"
		| Audit                                                                                                   | AuditSubCategory        | Property |
		| Entry restriction on field AGEN in form SCENARIO1 was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Field    |
	And I delete Architect Audits for user "SUPER USER 1"



@Release_2013.2.0
@PB_MCC-41782-026
@SJ13.MAY.2013
@Validation



Scenario: MCC-41782-026 When a user upload a Global Library draft with View and Entry Restrictions, then the correct Audits are generated in Database. 

	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	When I navigate to "Architect"
	When xml draft "MCC-41782-026.xml" is Uploaded without redirecting
	Then I verify text "Save successful" exists
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                   | AuditSubCategory      | Property |
		| View restriction on field AGE18 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionAdded  | Field    |
		| Entry restriction on field LOG2 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"        | EntryRestrictionAdded | Field    |
		| View restriction on form FORM3 was created for role SUPERROLE % CRF Draft: "Draft 1"                    | ViewRestrictionAdded  | Form     |
		| Entry restriction on form FORM3 was created for role SUPERROLE % CRF Draft: "Draft 1"                   | EntryRestrictionAdded | Form     |
	And I delete Architect Audits for user "SUPER USER 1"
	And I navigate to "Home"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I update field View Restriction for role 
		| Form   | Field | Role         | Selected |
		| Form 2 | AGE18 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update field Entry Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 2 | Standard 2 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 3 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 3 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                   | AuditSubCategory        | Property |
		| View restriction on field AGE18 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1" | ViewRestrictionRemoved  | Field    |
		| Entry restriction on field LOG2 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"        | EntryRestrictionRemoved | Field    |
		| View restriction on form FORM3 was created for role SUPERROLE % CRF Draft: "Draft 1"                    | ViewRestrictionRemoved  | Form     |
		| Entry restriction on form FORM3 was created for role SUPERROLE % CRF Draft: "Draft 1"                   | EntryRestrictionRemoved | Form     |
	And I delete Architect Audits for user "SUPER USER 1"



@Release_2013.2.0
@PB_MCC-41782-027
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-027 When a user copy a Global Library draft by using Copy to Draft Wizard with View and Entry Restrictions, then the correct Audits are generated in Database. 

	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	And I navigate to "Architect"
	And xml draft "MCC-41782-027.xml" is Uploaded without redirecting
	And I verify text "Save successful" exists
	And I take a screenshot
	And I navigate to "Home"
	And I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select link "Define Copy Sources"
	And I check "Define all Projects and Global Libraries as Copy Sources."
	And I select "Study" link "MCC-41782" in "Header"
	And I select "Draft" link "Draft 1"
	And I select link "Copy to Draft" located in "Left Nav"
	And I expand "Projects"
	And I expand "Project" "MCC-41782"
	And I expand "Drafts"
	And I check "Draft 2" in "Drafts"
	And I click button "Next"
	And I expand "Form 4 (FORM4)"
	And I check "STDRES1 (STDRES1)"
	And I verify "STDRES1 (STDRES1)" is checked
	And I expand "Form 5 (FORM5)"
	And I check "STDRES2 (STDRES2)"
	And I verify "STDRES2 (STDRES2)" is checked
	And I click button "Next"
	And I take a screenshot
	And I click button "Finish"
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                  | AuditSubCategory      | Property |
		| View restriction on field STDRES2 in form FORM5 was created for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionAdded  | Field    |
		| Entry restriction on field STDRES2 in form FORM5 was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
		| View restriction on form FORM4 was created for role SUPERROLE % CRF Draft: "Draft 1"                   | ViewRestrictionAdded  | Form     |
		| Entry restriction on form FORM4 was created for role SUPERROLE % CRF Draft: "Draft 1"                  | EntryRestrictionAdded | Form     | 
	And I delete Architect Audits for user "SUPER USER 1"


@Release_2013.2.0
@PB_MCC-41782-028
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-028 When a user add a new field in a Global Library draft with View and Entry Restrictions, then the correct Audits are generated in Database. 


	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	And I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes" 
	And I select Draft "Draft 1"
	And I navigate to "Forms"
	And I select Fields for Form "Form 1"
	And I select link "Add New"
	And I enter data in Architect Field and save
		| Field       | Data  | ControlType |
		| VarOID      | Test1 | textbox     |
		| Format      | 3     | textbox     |
		| Field Name  | Test1 | textbox     |
		| Field OID   | Test1 | textbox     |
		| Field Label | Test1 | textarea    |
	And I expand "View Restrictions"
	And I update field View Restriction for role
		| Role         | Selected |
		| SUPER ROLE 1 | True     |
	And I take a screenshot
	And I expand "Entry Restrictions"
	And I update field Entry Restriction for role 
		| Role         | Selected |
		| SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                             | AuditSubCategory      | Property |
		| Entry restriction on field Test1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
		| View restriction on field Test1 in form MX was created for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionAdded  | Field    |
	And I delete Architect Audits for user "SUPER USER 1"


@Release_2013.2.0
@PB_MCC-41782-029
@SJ13.MAY.2013
@Validation

Scenario: MCC-41782-029 When multiple users take actions to restrict view and entry in  a Global Library draft, then the correct Audits are generated in Database for individual actions per user.


	Given I login to Rave with user "SUPER USER 1"
	And I delete Architect Audits for user "SUPER USER 1"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I navigate to "Restrictions"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 2 | Standard 2 | SUPER ROLE 1 | True     |
	And I navigate to "Restrictions"
	And I update field Entry Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 2 | Standard 2 | SUPER ROLE 1 | True     |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 1", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                   | AuditSubCategory      | Property |
		| Entry restriction on field STD1 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionAdded | Field    |
		| View restriction on field STD1 in form SCENARIO1 was created for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionAdded  | Field    |
		| Entry restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1"                      | EntryRestrictionAdded | Form     |
		| View restriction on form MX was created for role SUPERROLE % CRF Draft: "Draft 1"                       | ViewRestrictionAdded  | Form     |
	And I delete Architect Audits for user "SUPER USER 1"
	Given I login to Rave with user "MCC41782_SUPERUSER"
	When I navigate to "Architect"
	And I select "Project" link "MCC-41782" in "Active Global Library Volumes"
	And I select Draft "Draft 1"
	And I navigate to "Restrictions"
	And I delete Architect Audits for user "SUPER USER 2"
	And I update form View Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I navigate to "Restrictions"
	And I update form Entry Restriction for role 
		| Form   | Role         | Selected |
		| Form 1 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I navigate to "Restrictions"
	And I update field View Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 2 | Standard 2 | SUPER ROLE 1 | False    |
		And I navigate to "Restrictions"
	And I update field Entry Restriction for role 
		| Form   | Field      | Role         | Selected |
		| Form 2 | Standard 2 | SUPER ROLE 1 | False    |
	And I take a screenshot
	And I verify the following Architect audits exist for user "SUPER USER 2", project "MCC-41782", draft "Draft 1" 
		| Audit                                                                                                    | AuditSubCategory        | Property |
		| View restriction on field AGE18 in form SCENARIO1 was deleted for role SUPERROLE % CRF Draft: "Draft 1"  | ViewRestrictionRemoved  | Field    |
		| Entry restriction on field AGE18 in form SCENARIO1 was deleted for role SUPERROLE % CRF Draft: "Draft 1" | EntryRestrictionRemoved | Field    |
		| View restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"                        | ViewRestrictionRemoved  | Form     |
		| Entry restriction on form MX was deleted for role SUPERROLE % CRF Draft: "Draft 1"                       | EntryRestrictionRemoved | Form     |
	And I delete Architect Audits for user "SUPER USER 2"