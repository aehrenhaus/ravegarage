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
And I select link "Preview"
And I select link "Data" in "Form Preview"
And I should see the Preview of the Portrait view
And I should see the link "Click here to return to "Complete View"
When I select link "Click here to return to "Complete View"
Then I should returned to the Complete View

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
When I select link "Preview"
And I should see the Preview of the Landscape view
Then I should not see the link "Click here to return to "Complete View" 

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
And I select link "Preview"
And I select link "Data" in "Form Preview"
And I should see the Preview of the Portrait view
And I should see the link "Click here to return to "Complete View"
When I select link "Click here to return to "Complete View"
Then I should returned to the Complete View

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
When I select link "Preview"
And I should see the Preview of the Landscape view
Then I should not see the link "Click here to return to "Complete View" 

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
When I select link "Preview"
And I should see the Preview of the Portrait view
Then I should not see the link "Click here to return to "Complete View" 

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
And I select link "Form Preview"
And I select link "Data" in "Form Preview"
And I should see the Preview of the Portrait view
And I should see the link "Click here to return to "Complete View"
When I select link "Click here to return to "Complete View"
Then I should returned to the Complete View

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
When I select link "Form Preview"
And I should see the Preview of the Landscape view
Then I should not see the link "Click here to return to "Complete View" 

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
And I select link "Form Preview"
And I select link "Data" in "Form Preview"
And I should see the Preview of the Portrait view
And I should see the link "Click here to return to "Complete View"
When I select link "Click here to return to "Complete View"
Then I should returned to the Complete View

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
When I select link "Form Preview"
And I should see the Preview of the Landscape view
Then I should not see the link "Click here to return to "Complete View" 

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
When I select link "Form Preview"
And I should see the Preview of the Portrait view
Then I should not see the link "Click here to return to "Complete View" 
