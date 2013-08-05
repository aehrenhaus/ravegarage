@MCC-46334
Feature: MCC-46334 Clicking Data in Form Designer Portrait Preview does not take the user to the Portrait view of that form

Background:

Given xml draft "MCC-46334.xml" is Uploaded
Given xml Lab Configuration "MCC-46334_Labs.xml" is uploaded
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

@Release_2013.3.0
@PBMCC46334-001
@RR01.AUG.2013
@Draft
Scenario: MCC46334-001 As an Rave Study Builder, when I select Preview on a Portrait log form, and then select Data on the Preview page, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "LOGPORT"
When I select link "Preview"
And I select link "Data" in "Form Preview"
Then I should see the Preview of the Portrait view

@Release_2013.3.0
@PBMCC46334-002
@RR01.AUG.2013
@Draft
Scenario: MCC46334-002 As an Rave Study Builder, when I select Preview on a Landscape log form, I see the Preview of the Landscape view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "LOGLAND"
When I select link "Preview"
Then I should see the Preview of the Landscape view

@Release_2013.3.0
@PBMCC46334-003
@RR01.AUG.2013
@Draft
Scenario: MCC46334-003 As an Rave Study Builder, when I select Preview on a Portrait mixed form (standard fields and log fields), and then select Data on the Preview page, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "MIXEDPORT"
When I select link "Preview"
And I select link "Data" in "Form Preview"
Then I should see the Preview of the Portrait view

@Release_2013.3.0
@PBMCC46334-004
@RR01.AUG.2013
@Draft
Scenario: MCC46334-004 As an Rave Study Builder, when I select Preview on a Landscape mixed form (standard fields and log fields), I see the Preview of the Landscape view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "MIXEDLAND"
When I select link "Preview"
Then I should see the Preview of the Landscape view

@Release_2013.3.0
@PBMCC46334-005
@RR01.AUG.2013
@Draft
Scenario: MCC46334-005 As an Rave Study Builder, when I select Preview on a Lab form, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I navigate to "Forms"
And I select Fields for Form "LABFORM"
When I select link "Preview"
Then I should see the Preview of the Portrait view

@Release_2013.3.0
@PBMCC46334-006
@RR01.AUG.2013
@Draft
Scenario: MCC46334-006 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Portrait log form, and then select Data on the Preview page, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LOGPORT (LOGPORT)"
And I select link "LOGPORT (LOGPORT)"
And I select link "LOGPORT (LOGPORT) details"
When I select link "Form Preview"
And I select link "Data" in "Form Preview"
Then I should see the Preview of the Portrait view

@Release_2013.3.0
@PBMCC46334-007
@RR01.AUG.2013
@Draft
Scenario: MCC46334-007 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Landscape log form, I see the Preview of the Landscape view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LOGLAND (LOGLAND)"
And I select link "LOGLAND (LOGLAND)"
And I select link "LOGLAND (LOGLAND) details"
When I select link "Form Preview"
Then I should see the Preview of the Landscape view

@Release_2013.3.0
@PBMCC46334-008
@RR01.AUG.2013
@Draft
Scenario: MCC46334-008 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Portrait mixed form (standard fields and log fields), and then select Data on the Preview page, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "MIXEDPORT (MIXEDPORT)"
And I select link "MIXEDPORT (MIXEDPORT)"
And I select link "MIXEDPORT (MIXEDPORT) details"
When I select link "Form Preview"
And I select link "Data" in "Form Preview"
Then I should see the Preview of the Portrait view

@Release_2013.3.0
@PBMCC46334-009
@RR01.AUG.2013
@Draft
Scenario: MCC46334-009 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Landscape mixed form (standard fields and log fields), I see the Preview of the Landscape view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "MIXEDLAND (MIXEDLAND)"
And I select link "MIXEDLAND (MIXEDLAND)"
And I select link "MIXEDLAND (MIXEDLAND) details"
When I select link "Form Preview"
Then I should see the Preview of the Landscape view

@Release_2013.3.0
@PBMCC46334-010
@RR01.AUG.2013
@Draft
Scenario: MCC46334-010 As an Rave Study Builder, On the Global Library Wizard, when I select Preview on a Lab form, I see the Preview of the Portrait view.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-46334" in "Active Projects"
And I select Draft "Draft 1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LABFORM (LABFORM)"
And I select link "LABFORM (LABFORM)"
And I select link "LABFORM (LABFORM) details"
When I select link "Form Preview"
Then I should see the Preview of the Portrait view
