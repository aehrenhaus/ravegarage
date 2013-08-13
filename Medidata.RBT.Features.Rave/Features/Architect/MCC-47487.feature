@MCC-47487
Feature: MCC-47487 In Form Designer preview page - clicking the 'Click here to return to "Complete View" is not working

Background:

Given xml draft "MCC-47487.xml" is Uploaded
Given xml Lab Configuration "MCC-47487_Labs.xml" is uploaded
Given Site "Site_A" exists
Given study "MCC-47487" is assigned to Site "Site_A"
Given role "SUPER ROLE 1" exists
Given I publish and push eCRF "MCC-47487.xml" to "Version 1"
Given following Project assignments exist
| User          | Project   | Environment | Role         | Site   | SecurityRole          |
| SUPER USER 1  | MCC-47487 | Live: Prod  | SUPER ROLE 1 | Site_A | Project Admin Default |

#Note: 1) LOGPORT - log form in Portrait direction 
#Note: 2) LOGLAND - log form in Landscape direction 
#Note: 3) MIXEDPORT - mixed form in Portrait direction 
#Note: 4) MIXEDLAND - mixed form in Landscape direction 
#Note: 5) LABFORM - Lab Form

@Release_2013.3.0
@PBMCC47487-001
@RR06.AUG.2013
@Draft
Scenario: MCC47487-001 As an Rave Study Builder, when I select Click here to return to "Complete View" on a Portrait log form, I see the Portrait log form is returned to Complete View.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "LOGPORT"
And I take a screenshot
And I select link "Preview"
And I take a screenshot
And I select link "Data" in "Form Preview"
And I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exists
And I take a screenshot
When I select link "Click here to return to "Complete View"."
Then I verify link "Add a new Log line" exists
And I verify link "Click here to return to "Complete View"." does not exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1."does not exists
And I take a screenshot

@Release_2013.3.0
@PBMCC47487-002
@RR06.AUG.2013
@Draft
Scenario: MCC47487-002 As an Rave Study Builder, when I select Preview on a Landscape log form, I see the Click here to return to "Complete View" link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "LOGLAND"
And I take a screenshot
When I select link "Preview"
Then I verify link "Click here to return to "Complete View"." does not exists
And I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1."does not exists
And I take a screenshot

@Release_2013.3.0
@PBMCC47487-003
@RR06.AUG.2013
@Draft
Scenario: MCC47487-003 As an Rave Study Builder, when I select Click here to return to "Complete View" on a Portrait mixed form (standard fields and log fields), I see the Portrait mixed form is returned to Complete View.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "MIXEDPORT"
And I take a screenshot
And I select link "Preview"
And I take a screenshot
And I select link "Data" in "Form Preview"
And I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exists
And I take a screenshot
When I select link "Click here to return to "Complete View"."
Then I verify link "Add a new Log line" exists
And I verify link "Click here to return to "Complete View"." does not exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1."does not exists
And I take a screenshot

@Release_2013.3.0
@PBMCC47487-004
@RR06.AUG.2013
@Draft
Scenario: MCC47487-004 As an Rave Study Builder, when I select Preview on a Landscape mixed form (standard fields and log fields), I see the Click here to return to "Complete View" link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "MIXEDLAND"
And I take a screenshot
When I select link "Preview"
Then I verify link "Click here to return to "Complete View"." does not exists
And I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1."does not exists
And I take a screenshot

@Release_2013.3.0
@PBMCC47487-005
@RR06.AUG.2013
@Draft
Scenario: MCC47487-005 As an Rave Study Builder, when I select Preview on a Lab form, I see the Click here to return to "Complete View" link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "LABFORM"
And I take a screenshot
When I select link "Preview"
Then I verify link "Add a new Log line" does not exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1."does not exists
And I verify link "Click here to return to "Complete View"." does not exists
And I take a screenshot

@Release_2013.3.0
@PBMCC47487-006
@RR06.AUG.2013
@Draft
Scenario: MCC47487-006 As an Rave Study Builder, On the Global Library Wizard, when I select Click here to return to "Complete View" on a Portrait log form, I see the Portrait log form is returned to Complete View.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LOGPORT (LOGPORT)"
And I select link "LOGPORT (LOGPORT)"
And I select link "LOGPORT (LOGPORT) details"
And I take a screenshot
And I select link "Form Preview"
And I take a screenshot
And I select link "Data" in "Form Preview"
And I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exists
And I take a screenshot
When I select link "Click here to return to "Complete View"."
Then I verify link "Add a new Log line" exists
And I verify link "Click here to return to "Complete View"." does not exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1."does not exists
And I take a screenshot

@Release_2013.3.0
@PBMCC47487-007
@RR06.AUG.2013
@Draft
Scenario: MCC47487-007 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Landscape log form, I see the Click here to return to "Complete View" link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LOGLAND (LOGLAND)"
And I select link "LOGLAND (LOGLAND)"
And I select link "LOGLAND (LOGLAND) details"
And I take a screenshot
When I select link "Form Preview"
Then I verify link "Click here to return to "Complete View"." does not exists
And I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1."does not exists
And I take a screenshot

@Release_2013.3.0
@PBMCC47487-008
@RR06.AUG.2013
@Draft
Scenario: MCC47487-008 As an Rave Study Builder, On the Global Library Wizard, when I select Click here to return to "Complete View" on a Portrait mixed form (standard fields and log fields), I see the Portrait mixed form is returned to Complete View.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "MIXEDPORT (MIXEDPORT)"
And I select link "MIXEDPORT (MIXEDPORT)"
And I select link "MIXEDPORT (MIXEDPORT) details"
And I take a screenshot
And I select link "Form Preview"
And I take a screenshot
And I select link "Data" in "Form Preview"
And I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exists
And I take a screenshot
When I select link "Click here to return to "Complete View"."
Then I verify link "Add a new Log line" exists
And I verify link "Click here to return to "Complete View"." does not exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1."does not exists
And I take a screenshot

@Release_2013.3.0
@PBMCC47487-009
@RR06.AUG.2013
@Draft
Scenario: MCC47487-009 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Landscape mixed form (standard fields and log fields), I see the Click here to return to "Complete View" link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "MIXEDLAND (MIXEDLAND)"
And I select link "MIXEDLAND (MIXEDLAND)"
And I select link "MIXEDLAND (MIXEDLAND) details"
And I take a screenshot
When I select link "Form Preview"
Then I verify link "Click here to return to "Complete View"." does not exists
And I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1."does not exists
And I take a screenshot

@Release_2013.3.0
@PBMCC47487-010
@RR06.AUG.2013
@Draft
Scenario: MCC47487-010 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Lab form, I see the Click here to return to "Complete View" link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LABFORM (LABFORM)"
And I select link "LABFORM (LABFORM)"
And I select link "LABFORM (LABFORM) details"
And I take a screenshot
When I select link "Form Preview"
Then I verify link "Add a new Log line" does not exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1."does not exists
And I verify link "Click here to return to "Complete View"." does not exists
And I take a screenshot

@Release_2013.3.0
@PBMCC47487-011
@RR06.AUG.2013
@Draft
Scenario: MCC47487-011  As an Rave Study Builder, On the EDC CRF page when I enter data on a form and try to navigate to a different form, then I see the pop-up confirmation message to leave page or stay on page.

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-47487" and Site "Site_A"
And I create a Subject
 |Field               |Data              |Control Type |
 |Subject Initials    |SUB               |textbox      |
 |Subject Number      |{RndNum<num1>(3)} |textbox      |
 |Subject ID 	      |SUB {Var(num1)}   |textbox      |
And I select Form "LOGPORT"
And I enter data in CRF
 |Field                                      |Data           |Control Type |
 |Is this Adverse Event Serious?             |HeadAche       |longtext     |
 |Date of First Occurrence of Adverse Event. |10 Dec 2012    |datetime     |
 |Is this Adverse Event Serious?             |YES            |dropdownlist |
When I select link "SUB {Var(num1)}"
Then I should see pop-up confirmation message to leave page or stay on page
And I take a screenshot
