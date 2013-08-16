@MCC-46334
Feature: MCC-46334 Clicking Data in Form Designer Portrait Preview does not take the user to the Portrait view of that form

Background:

Given xml Lab Configuration "MCC-46334_Labs.xml" is uploaded
Given xml draft "MCC-46334.xml" is Uploaded
Given Site "Site_A" exists
Given study "MCC-46334" is assigned to Site "Site_A"
Given role "SUPER ROLE 1" exists
Given I publish and push eCRF "MCC-46334.xml" to "Version 1"
Given following Project assignments exist
| User          | Project   | Environment | Role         | Site   | SecurityRole          |
| SUPER USER 1  | MCC-46334 | Live: Prod  | SUPER ROLE 1 | Site_A | Project Admin Default |

#Note: 1) LOGPORT - log form in Portrait direction 
#Note: 2) LOGLAND - log form in Landscape direction 
#Note: 3) MIXEDPORT - mixed form in Portrait direction 
#Note: 4) MIXEDLAND - mixed form in Landscape direction 
#Note: 5) LABFORM - Lab Form

@Release_2013.4.0
@PB_MCC-46334-01
@RR01.AUG.2013
@Validation
Scenario: MCC-46334-01 As an Rave Study Builder, when I select Preview on a Portrait log form, and then select Data on the Preview page, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "LOGPORT"
And I take a screenshot
And I select link(partial) "Preview"
And I switch to "Form Preview" window
And I take a screenshot
When I select link "Data"
Then I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-46334-02
@RR01.AUG.2013
@Validation
Scenario: MCC-46334-02 As an Rave Study Builder, when I select Preview on a Landscape log form, I see the Preview of the Landscape view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "LOGLAND"
And I take a screenshot
When I select link(partial) "Preview"
And I switch to "Form Preview" window
Then I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I verify link "Click here to return to "Complete View"." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-46334-03
@RR01.AUG.2013
@Validation
Scenario: MCC-46334-03 As an Rave Study Builder, when I select Preview on a Portrait mixed form (standard fields and log fields), and then select Data on the Preview page, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "MIXEDPORT"
And I take a screenshot
And I select link(partial) "Preview"
And I switch to "Form Preview" window
And I take a screenshot
When I select link "Data"
Then I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-46334-04
@RR01.AUG.2013
@Validation
Scenario: MCC-46334-04 As an Rave Study Builder, when I select Preview on a Landscape mixed form (standard fields and log fields), I see the Preview of the Landscape view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "MIXEDLAND"
And I take a screenshot
When I select link(partial) "Preview"
And I switch to "Form Preview" window
And I take a screenshot
Then I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I verify link "Click here to return to "Complete View"." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-46334-05
@RR01.AUG.2013
@Validation
Scenario: MCC-46334-05 As an Rave Study Builder, when I select Preview on a Lab form, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "LABFORM"
And I take a screenshot
When I select link(partial) "Preview"
And I switch to "Form Preview" window
And I take a screenshot
Then I verify link "Add a new Log line" does not exist
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I verify link "Click here to return to "Complete View"." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-46334-06
@RR01.AUG.2013
@Validation
Scenario: MCC-46334-06 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Portrait log form, and then select Data on the Preview page, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LOGPORT (LOGPORT)"
And I select link "LOGPORT (LOGPORT)"
And I select link "LOGPORT (LOGPORT) details"
And I take a screenshot
And I select link "Form Preview"
And I switch to "Global Draft Preview" window
And I take a screenshot
When I select link "Data"
Then I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-46334-07
@RR01.AUG.2013
@Validation
Scenario: MCC-46334-07 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Landscape log form, I see the Preview of the Landscape view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LOGLAND (LOGLAND)"
And I select link "LOGLAND (LOGLAND)"
And I select link "LOGLAND (LOGLAND) details"
And I take a screenshot
When I select link "Form Preview"
And I switch to "Global Draft Preview" window
And I take a screenshot
Then I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I verify link "Click here to return to "Complete View"." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-46334-08
@RR01.AUG.2013
@Validation
Scenario: MCC-46334-08 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Portrait mixed form (standard fields and log fields), and then select Data on the Preview page, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "MIXEDPORT (MIXEDPORT)"
And I select link "MIXEDPORT (MIXEDPORT)"
And I select link "MIXEDPORT (MIXEDPORT) details"
And I take a screenshot
And I select link "Form Preview"
And I switch to "Global Draft Preview" window
And I take a screenshot
When I select link "Data"
Then I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-46334-09
@RR01.AUG.2013
@Validation
Scenario: MCC-46334-09 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Landscape mixed form (standard fields and log fields), I see the Preview of the Landscape view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "MIXEDLAND (MIXEDLAND)"
And I select link "MIXEDLAND (MIXEDLAND)"
And I select link "MIXEDLAND (MIXEDLAND) details"
And I take a screenshot
When I select link "Form Preview"
And I switch to "Global Draft Preview" window
And I take a screenshot
Then I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I verify link "Click here to return to "Complete View"." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-46334-010
@RR01.AUG.2013
@Validation
Scenario: MCC-46334-010 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Lab form, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LABFORM (LABFORM)"
And I select link "LABFORM (LABFORM)"
And I select link "LABFORM (LABFORM) details"
And I take a screenshot
When I select link "Form Preview"
And I switch to "Global Draft Preview" window
And I take a screenshot
Then I verify link "Add a new Log line" does not exist
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I verify link "Click here to return to "Complete View"." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-46334-011
@RR01.AUG.2013
@Validation
Scenario: MCC-46334-011  As an Rave Study Builder, On the EDC CRF page when I enter data on a form and try to navigate to a different form, then I see the pop-up confirmation message to leave page or stay on page.

Given I login to Rave with user "SUPER USER 1"
And I select Study "MCC-46334" and Site "Site_A"
And I create a Subject
 |Field               |Data              |Control Type |
 |Subject Initials    |SUB               |textbox      |
 |Subject Number      |{RndNum<num1>(3)} |textbox      |
 |Subject ID 	      |SUB {Var(num1)}   |textbox      |
And I select Form "LOGPORT"
And I enter data in CRF
 |Field                                      |Data           |Control Type |
 |Is this Adverse Event Serious?             |migrane        |longtext     |
 |Date of First Occurrence of Adverse Event. |01 Jan 2012    |datetime     |
 |Is this Adverse Event Serious?             |YES            |dropdownlist |
When I select link "SUB {Var(num1)}"
Then I should see alert window with one of the messages
| Data                                                                                                |
| This page is asking you to confirm that you want to leave - data you have entered may not be saved. |
| Are you sure you want to leave this page?                                                           |
| You have unsaved modifications. Do you want to continue anyway?                                     |
Then I accept alert window
And I take a screenshot