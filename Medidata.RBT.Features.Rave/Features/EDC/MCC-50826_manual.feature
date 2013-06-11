@MCC-50826

@ignore
Feature: MCC-50826 DSLs on mixed forms do not get populated correctly on standard fields part 2

Background:

Given xml draft "MCC-50826.xml" is Uploaded
Given Site "Site_A" exists
Given Site "Site_B" is DDE-enabled
Given study "MCC-50826" is assigned to Site "Site_A"
Given study "MCC-50826" is assigned to Site "Site_B"
Given role "SUPER ROLE 1" exists
Given I publish and push eCRF "MCC-50826.xml" to "Version 1"
Given following Project assignments exist
| User          | Project   | Environment | Role         | Site   | SecurityRole          |
| SUPER USER 1  | MCC-50826 | Live: Prod  | SUPER ROLE 1 | Site_A | Project Admin Default |
| MCC50826user2 | MCC-50826 | Live: Prod  | SUPER ROLE 1 | Site_B | Project Admin Default |

#Note: 1) ELIGMIXEDPORT - mixed form in Portrait direction 
#Note: 2) ELIGMIXEDLAND - mixed form in Landscape direction 
#Note: 3) ELIGLOGPORT - log form in Portrait direction 
#Note: 4) ELIGLOGLAND - log form in Landscape direction 
#Note: 5) ELIGSTANDARD - standard form

@Release_2013.1.0
@PBMCC50826-006
@RR21.FEB.2013
@Manual
@Validation
Scenario: MCC50826-006 Verify mixed form in Portrait direction populates DSLs on standard field correctly in DDE on Reconciliation page

#Given I have a mixed form in Portrait direction
#When I select standard field with DSL 
#Then I should see DSL fields populates correctly for the standard field in DDE on Reconciliation page

Given I login to Rave with user "SUPER USER 1"
And I navigate to "DDE"
And I select link "First Pass"
And I select link "New Batch"
And I choose "MCC-50826" from "Study"
And I choose "Prod" from "Environment"
And I choose "Site_B" from "Site"
And I type "SUB {RndNum<num1>(3)}" in "Subject"
And I choose "Primary form" from "Form"
And I click button "Locate"
And I enter data in DDE and save
  | Field            | Data              |
  | Subject Initials | SUB               |
  | Subject Number   | {RndNum<num1>(3)} |
  | Subject ID       | SUB {Var(num1)}   |
And I take a screenshot  
And I choose "ELIGMIXEDPORT" from "Form"
And I click button "Locate"
And I take a screenshot
And I enter data in DDE and save
  | Field    | Data                          |
  |CRITNUM   |Carfilzomib and dexamethasone  |
  |ELCRITYN  |Adverse Event	                 |
  |ELIGAM2   |QD X 2                         |     	
  |ELPRCOL   |Original	                     |
And I take a screenshot
And I log out of Rave
And I login to Rave with user "MCC50826user2"
And I navigate to "DDE"
And I select link "Second Pass"
And I choose "MCC-50826" from "Study"
And I choose "Site_B" from "Site"
And I choose "SUB {Var(num3)}" from "Subject" 
And I choose "ELIGMIXEDPORT" from "Form"
And I click button "Locate"
And I take a screenshot
And I enter data in DDE and save
  | Field    | Data                      |
  |CRITNUM   |Velcade and dexamethasone  |
  |ELCRITYN  |Death	                     |
  |ELIGAM2   |QD X 5                     |     	
  |ELPRCOL   |Amendment1	             |
And I take a screenshot
And I select data in "Reconciliation - ELIGMIXEDPORT"
  | Field    | Data                      |
  |CRITNUM   |Velcade and dexamethasone  |
  |ELCRITYN  |Adverse Event	             |
  |ELIGAM2   |QD X 2                     |
  |ELPRCOL   |Amendment1	             |
When I select "Override" for "COHORT" 
When I click drop button on dynamic search list "COHORT"
And I wait for 3 seconds
Then I should see dynamic search list "COHORT" open
And I take a screenshot 
And I choose "Cohort 3" from "Override" 
And I select link "Submit"
And I navigate to "Home"
And I select Study "MCC-50826" and Site "Site_B"
And I select a Subject "SUB {Var(num3)}"
And I select Form "ELIGMIXEDPORT"
When I click drop button on dynamic search list "COHORT"
And I wait for 3 seconds
Then I should see dynamic search list "COHORT" open
And I take a screenshot  
And I click Cancel
And I take a screenshot 

@Release_2013.1.0
@PBMCC50826-007
@RR21.FEB.2013
@Manual
@Validation
Scenario: MCC50826-007 Verify mixed form in Landscape direction populates DSLs on standard field correctly in DDE on Reconciliation page

#Given I have a mixed form in Landscape direction
#When I select standard field with DSL 
#Then I should see DSL fields populates correctly for the standard field in DDE on Reconciliation page

Given I login to Rave with user "SUPER USER 1"
And I navigate to "DDE"
And I select link "First Pass"
And I select link "New Batch"
And I choose "MCC-50826" from "Study"
And I choose "Prod" from "Environment"
And I choose "Site_B" from "Site"
And I type "SUB {RndNum<num1>(3)}" in "Subject"
And I choose "Primary form" from "Form"
And I click button "Locate"
And I enter data in DDE and save
  | Field            | Data              |
  | Subject Initials | SUB               |
  | Subject Number   | {RndNum<num1>(3)} |
  | Subject ID       | SUB {Var(num1)}   |
And I take a screenshot  
And I choose "ELIGMIXEDLAND" from "Form"
And I click button "Locate"
And I take a screenshot
And I enter data in DDE and save
  | Field     | Data                         |
  |CRITNUM2   |Carfilzomib and dexamethasone |
  |ELCRITYN2  |Adverse Event	             |
  |ELIGAM3    |QD X 5                        |    	
  |ELPRCOL2   |Amendment2	                 |
And I take a screenshot 
And I log out of Rave
And I log in to Rave with user "MCC50826user2"
And I navigate to "DDE"
And I select link "Second Pass"
And I choose "MCC-50826" from "Study"
And I choose "Site_B" from "Site"
And I choose "SUB {Var(num3)}" from "Subject" 
And I choose "ELIGMIXEDLAND" from "Form"
And I click button "Locate"
And I take a screenshot
And I enter data in DDE and save
  | Field     | Data                      |
  |CRITNUM2   |Velcade and dexamethasone  |
  |ELCRITYN2  |Lost to Follow-up	      |
  |ELIGAM3    |QD X 2                     |    	
  |ELPRCOL2   |Amendment1	              |
And I take a screenshot 
And I select data in "Reconciliation - ELIGMIXEDLAND"
  | Field     | Data                          |
  |CRITNUM2   |Carfilzomib and dexamethasone  |
  |ELCRITYN2  |Lost to Follow-up	          |
  |ELIGAM3    |QD X 5                         |
  |ELPRCOL2   |Amendment2	                  |
And I select "Override" for "COHORT2"
When I click drop button on dynamic search list "COHORT2"
And I wait for 3 seconds
Then I should see dynamic search list "COHORT2" open 
And I take a screenshot 
And I choose "Cohort 102" from "Override" 
And I select link "Submit" 
And I navigate to "Home"
And I select Study "MCC-50826" and Site "Site_B"
And I select a Subject "SUB {Var(num3)}"
And I select Form "ELIGMIXEDLAND"
When I click drop button on dynamic search list "COHORT2"
And I wait for 3 seconds
Then I should see dynamic search list "COHORT2" open
And I take a screenshot  
And I click Cancel
And I take a screenshot 

@Release_2013.1.0
@PBMCC50826-008
@RR21.FEB.2013
@Manual
@Validation
Scenario: MCC50826-008 Verify log form in Portrait direction populates DSLs on log field correctly in DDE on Reconciliation page

#Given I have a log form in Portrait direction
#When I select log field with DSL 
#Then I should see DSL fields populates correctly for the log field in DDE on Reconciliation page

Given I login to Rave with user "SUPER USER 1"
And I navigate to "DDE"
And I select link "First Pass"
And I select link "New Batch"
And I choose "MCC-50826" from "Study"
And I choose "Prod" from "Environment"
And I choose "Site_B" from "Site"
And I type "SUB {RndNum<num1>(3)}" in "Subject"
And I choose "Primary form" from "Form"
And I click button "Locate"
And I enter data in DDE and save
  | Field            | Data              |
  | Subject Initials | SUB               |
  | Subject Number   | {RndNum<num1>(3)} |
  | Subject ID       | SUB {Var(num1)}   |
And I take a screenshot  
And I choose "ELIGLOGPORT" from "Form"
And I click button "Locate"
And I take a screenshot
And I enter data in DDE and save
  | Field     | Data                      |
  |CRITNUM3   |Velcade and dexamethasone  |
  |ELCRITYN3  |Patient withdrew consent	  |
  |ELIGAM4    |QD X 2                     |     	
  |ELPRCOL3   |Amendment2	              |
And I take a screenshot 
And I log out of Rave
And I log in to Rave with user "MCC50826user2"
And I navigate to "DDE"
And I select link "Second Pass"
And I choose "MCC-50826" from "Study"
And I choose "Site_B" from "Site"
And I choose "SUB {Var(num3)}" from "Subject" 
And I choose "ELIGLOGPORT" from "Form"
And I click button "Locate"
And I take a screenshot
And I enter data in DDE and save
  | Field     | Data                          |
  |CRITNUM3   |Carfilzomib and dexamethasone  |
  |ELCRITYN3  |Other	                      |
  |ELIGAM4    |QD X 5                         |     	
  |ELPRCOL3   |Original	                      |
And I take a screenshot 
And I select data in "Reconciliation - ELIGLOGPORT"
  | Field     | Data                          |
  |CRITNUM3   |Carfilzomib and dexamethasone  |
  |ELCRITYN3  |Patient withdrew consent	     |
  |ELIGAM4    |QD X 2                         |
  |ELPRCOL3   |Amendment2	                 |
When I select "Override" for "COHORT3" 
Then I should see dynamic search list "COHORT3" in log line 1 open
And I take a screenshot 
And I choose "Cohort 205" from "Override" 
And I select link "Submit" 
And I navigate to "Home"
And I select Study "MCC-50826" and Site "Site_B"
And I select a Subject "SUB {Var(num3)}"
And I select Form "ELIGLOGPORT"
When I click drop button on dynamic search list "COHORT3"
Then I should see dynamic search list "COHORT3" in log line 1 open 
And I take a screenshot  
And I click Cancel
And I take a screenshot 

@Release_2013.1.0
@PBMCC50826-009
@RR21.FEB.2013
@Manual
@Validation
Scenario: MCC50826-009 Verify log form in Landscape direction populates DSLs on log field correctly in DDE on Reconciliation page

#Given I have a log form in Landscape direction
#When I select log field with DSL 
#Then I should see DSL fields populates correctly for the log field in DDE on Reconciliation page

Given I login to Rave with user "SUPER USER 1"
And I navigate to "DDE"
And I select link "First Pass"
And I select link "New Batch"
And I choose "MCC-50826" from "Study"
And I choose "Prod" from "Environment"
And I choose "Site_B" from "Site"
And I type "SUB {RndNum<num1>(3)}" in "Subject"
And I choose "Primary form" from "Form"
And I click button "Locate"
And I enter data in DDE and save
  | Field            | Data              |
  | Subject Initials | SUB               |
  | Subject Number   | {RndNum<num1>(3)} |
  | Subject ID       | SUB {Var(num1)}   |
And I take a screenshot  
And I choose "ELIGLOGLAND" from "Form"
And I click button "Locate"
And I take a screenshot
And I enter data in DDE and save
  | Field     | Data                          |
  |CRITNUM4   |Carfilzomib and dexamethasone  |
  |ELCRITYN4  |Death	                      |
  |ELIGAM5    |QD X 5                         |   	
  |ELPRCOL4   |Original	                      |
And I take a screenshot 
And I log out of Rave
And I log in to Rave with user "MCC50826user2"
And I navigate to "DDE"
And I select link "Second Pass"
And I choose "MCC-50826" from "Study"
And I choose "Site_B" from "Site"
And I choose "SUB {Var(num3)}" from "Subject" 
And I choose "ELIGLOGLAND" from "Form"
And I click button "Locate"
And I take a screenshot
And I enter data in DDE and save
  | Field     | Data                      |
  |CRITNUM4   |Velcade and dexamethasone  |
  |ELCRITYN4  |Lost to Follow-up	      |
  |ELIGAM5    |QD X 2                     |    	
  |ELPRCOL4   |Amendment2	              |
And I take a screenshot 
And I select data in "Reconciliation - ELIGLOGLAND"
  | Field     | Data                      |
  |CRITNUM4   |Velcade and dexamethasone  |
  |ELCRITYN4  |Lost to Follow-up	      |
  |ELIGAM5    |QD X 5                     |
  |ELPRCOL4   |Original	                  |
When I select "Override" for "COHORT4" 
Then I should see dynamic search list "COHORT4" in log line 1 open 
And I take a screenshot 
And I choose "Cohort 4" from "Override" 
And I select link "Submit"  
And I navigate to "Home"
And I select Study "MCC-50826" and Site "Site_B"
And I select a Subject "SUB {Var(num3)}"
And I select Form "ELIGLOGLAND"
When I click drop button on dynamic search list "COHORT4" 
Then I should see dynamic search list "COHORT4" in log line 1 open  
And I take a screenshot  
And I click Cancel
And I take a screenshot 

@Release_2013.1.0
@PBMCC50826-010
@RR21.FEB.2013
@Manual
@Validation
Scenario: MCC50826-010 Verify standard form populates DSLs on standard field correctly in DDE on Reconciliation page

#Given I have a standard form
#When I select standard field with DSL 
#Then I should see DSL fields populates correctly for the standard field in DDE on Reconciliation page

Given I login to Rave with user "SUPER USER 1"
And I navigate to "DDE"
And I select link "First Pass"
And I select link "New Batch"
And I choose "MCC-50826" from "Study"
And I choose "Prod" from "Environment"
And I choose "Site_B" from "Site"
And I type "SUB {RndNum<num1>(3)}" in "Subject"
And I choose "Primary form" from "Form"
And I click button "Locate"
And I enter data in DDE and save
  | Field            | Data              |
  | Subject Initials | SUB               |
  | Subject Number   | {RndNum<num1>(3)} |
  | Subject ID       | SUB {Var(num1)}   |
And I take a screenshot  
And I choose "ELIGSTANDARD" from "Form"
And I click button "Locate"
And I take a screenshot
And I enter data in DDE and save
  | Field     | Data                      |
  |CRITNUM5   |Velcade and dexamethasone  |
  |ELCRITYN5  |Patient withdrew consent	  |
  |ELIGAM6    |QD X 5                     |     	
  |ELPRCOL5   |Amendment2	              |
And I take a screenshot 
And I log out of Rave
And I login to Rave with user "MCC50826user2"
And I navigate to "DDE"
And I select link "Second Pass"
And I choose "MCC-50826" from "Study"
And I choose "Site_B" from "Site"
And I choose "SUB {Var(num3)}" from "Subject" 
And I choose "ELIGSTANDARD" from "Form"
And I click button "Locate"
And I take a screenshot
And I enter data in DDE and save
  | Field     | Data                          |
  |CRITNUM5   |Carfilzomib and dexamethasone  |
  |ELCRITYN5  |Other	                      |
  |ELIGAM6    |QD X 2                         |     	
  |ELPRCOL5   |Amendment1	                  |
And I take a screenshot 
And I select data in "Reconciliation - ELIGSTANDARD"
  | Field     | Data                          |
  |CRITNUM5   |Carfilzomib and dexamethasone  |
  |ELCRITYN5  |Other	                      |
  |ELIGAM6    |QD X 2                         |
  |ELPRCOL5   |Amendment2	                  |
When I select "Override" for "COHORT5" 
Then I should see dynamic search list "COHORT5" open 
And I take a screenshot 
And I choose "Cohort 207" from "Override" 
And I select link "Submit"  
And I navigate to "Home"
And I select Study "MCC-50826" and Site "Site_B"
And I select a Subject "SUB {Var(num3)}"
And I select Form "ELIGSTANDARD"
When I click drop button on dynamic search list "COHORT5"
Then I should see dynamic search list "COHORT5" open 
And I take a screenshot  
And I click Cancel
And I take a screenshot 