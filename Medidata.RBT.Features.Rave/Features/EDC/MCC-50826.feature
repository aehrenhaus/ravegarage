@MCC-50826


Feature: MCC-50826 DSLs on mixed forms do not get populated correctly on standard fields

Background:

Given xml draft "MCC-50826.xml" is Uploaded
Given Site "Site_A" exists
Given study "MCC-50826" is assigned to Site "Site_A"
Given role "SUPER ROLE 1" exists
Given I publish and push eCRF "MCC-50826.xml" to "Version 1"
Given following Project assignments exist
| User          | Project   | Environment | Role         | Site   | SecurityRole          |
| SUPER USER 1  | MCC-50826 | Live: Prod  | SUPER ROLE 1 | Site_A | Project Admin Default |

#Note: 1) ELIGMIXEDPORT - mixed form in Portrait direction 
#Note: 2) ELIGMIXEDLAND - mixed form in Landscape direction 
#Note: 3) ELIGLOGPORT - log form in Portrait direction 
#Note: 4) ELIGLOGLAND - log form in Landscape direction 
#Note: 5) ELIGSTANDARD - standard form

@Release_2013.1.0
@PBMCC50826-001
@RR21.FEB.2013
@Validation
Scenario: MCC50826-001 Verify mixed form in Portrait direction populates DSLs on standard field correctly in EDC

#Given I have a mixed form in Portrait direction
#When I select standard field with DSL 
#Then I should see DSL fields populates correctly for the standard field in EDC

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-50826" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ELIGMIXEDPORT"
And I take a screenshot
When I enter data in CRF
  | Field    | Data                          | Control Type  |
  |CRITNUM   |Carfilzomib and dexamethasone  |dropdownlist   |
  |ELCRITYN  |Adverse Event	                 |radiobutton    |
  |ELIGAM2   |QD X 2                         |dropdownlist   |     	
  |ELPRCOL   |Original	                     |dropdownlist   |
And I take a screenshot
When I click drop button on dynamic search list "COHORT"
And I wait for 3 seconds
Then I should see dynamic search list "COHORT" open
And I take a screenshot
And I enter "Cohort 1" on dynamic search list "COHORT"
And I save the CRF page
And I take a screenshot
	
@Release_2013.1.0
@PBMCC50826-002
@RR21.FEB.2013
@Validation
Scenario: MCC50826-002 Verify mixed form in Landscape direction populates DSLs on standard field correctly in EDC

#Given I have a mixed form in Landscape direction
#When I select standard field with DSL 
#Then I should see DSL fields populates correctly for the standard field in EDC

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-50826" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ELIGMIXEDLAND"
And I take a screenshot
When I enter data in CRF
  | Field     | Data                      | Control Type |
  | CRITNUM2  | Velcade and dexamethasone | dropdownlist |
  | ELCRITYN2 | Death                     | radiobutton  |
  | ELIGAM3   | QD X 5                    | dropdownlist |
  | ELPRCOL2  | Amendment 1               | dropdownlist |
And I take a screenshot
When I click drop button on dynamic search list "COHORT2"
And I wait for 3 seconds
Then I should see dynamic search list "COHORT2" open
And I take a screenshot
And I enter "Cohort 2" on dynamic search list "COHORT2"
And I save the CRF page
And I take a screenshot

@Release_2013.1.0
@PBMCC50826-003
@RR21.FEB.2013
@Validation
Scenario: MCC50826-003 Verify log form in Portrait direction populates DSLs on log field correctly in EDC

#Given I have a log form in Portrait direction
#When I select log field with DSL 
#Then I should see DSL fields populates correctly for the log field in EDC

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-50826" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot 
And I select Form "ELIGLOGPORT"
And I take a screenshot
When I enter data in CRF
  | Field     | Data                          | Control Type  |
  |CRITNUM3   |Carfilzomib and dexamethasone  |dropdownlist   |
  |ELCRITYN3  |Lost to Follow-up	          |radiobutton    |
  |ELIGAM4    |QD X 2                         |dropdownlist   |     	
  |ELPRCOL3   |Amendment 2	                  |dropdownlist   |
And I take a screenshot
When I click drop button on dynamic search list "COHORT3"
And I wait for 3 seconds
Then I should see dynamic search list "COHORT3" open
And I take a screenshot
And I enter "Cohort -201" on dynamic search list "COHORT3"
And I save the CRF page
And I take a screenshot

@Release_2013.1.0
@PBMCC50826-004
@RR21.FEB.2013
@Validation
Scenario: MCC50826-004 Verify log form in Landscape direction populates DSLs on log field correctly in EDC

#Given I have a log form in Landscape direction
#When I select log field with DSL 
#Then I should see DSL fields populates correctly for the log field in EDC

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-50826" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot
And I select Form "ELIGLOGLAND"
And I take a screenshot
# below is wrong!
When I open log line 1
And I enter data in CRF
  | Field     | Data                         | Control Type  |
  |CRITNUM4   |Velcade and dexamethasone     |dropdownlist   |
  |ELCRITYN4  |Patient withdrew consent	     |radiobutton    |
  |ELIGAM5    |QD X 5                        |dropdownlist   |     	
  |ELPRCOL4   |Amendment 2	                 |dropdownlist   |
And I take a screenshot
When I click drop button on dynamic search list "COHORT4" in log line 1
And I wait for 3 seconds
Then I should see dynamic search list "COHORT4" in log line 1 open   
And I take a screenshot
And I enter "Cohort 107" on dynamic search list "COHORT4" in log line 1
And I save the CRF page 
And I take a screenshot

@Release_2013.1.0
@PBMCC50826-005
@RR21.FEB.2013
@Validation
Scenario: MCC50826-005 Verify standard form populates DSLs on standard field correctly in EDC

#Given I have a standard form
#When I select standard field with DSL 
#Then I should see DSL fields populates correctly for the standard field in EDC

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-50826" and Site "Site_A"
And I create a Subject
  | Field            | Data              | Control Type |
  | Subject Initials | SUB               | textbox      |
  | Subject Number   | {RndNum<num1>(3)} | textbox      |
  | Subject ID       | SUB {Var(num1)}   | textbox      |
And I take a screenshot
And I select Form "ELIGSTANDARD"
And I take a screenshot
When I enter data in CRF
  | Field     | Data                          | Control Type  |
  |CRITNUM5   |Carfilzomib and dexamethasone  |dropdownlist   |
  |ELCRITYN5  |Other	                      |radiobutton    |
  |ELIGAM6    |QD X 2                         |dropdownlist   |     	
  |ELPRCOL5   |Amendment 1	                  |dropdownlist   |
And I take a screenshot
When I click drop button on dynamic search list "COHORT5"
And I wait for 3 seconds
Then I should see dynamic search list "COHORT5" open
And I take a screenshot
And I enter "Cohort 5" on dynamic search list "COHORT5"
And I save the CRF page
And I take a screenshot