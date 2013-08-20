@MCC-47487
Feature: MCC-47487 In Form Designer preview page - clicking the "Click here to return to "Complete View"." does not work as expected.

Background:
Given xml Lab Configuration "MCC-47487_Labs.xml" is uploaded
Given xml draft "MCC-47487.xml" is Uploaded
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

@Release_2013.4.0
@PB_MCC-47487-01
@RR06.AUG.2013
@Draft
Scenario: MCC-47487-01 As a Rave Study Builder, when I select "Click here to return to "Complete View"." on a Portrait log form preview page, I should see that the Portrait log form is returned to Complete View.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft1"
And I navigate to "Forms"
And I select Fields for Form "LOGPORT"
And I take a screenshot
And I select link " Preview"
And I switch to "Form Preview" window
And I take a screenshot
And I select link "Data"
And I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exist
And I take a screenshot
When I select link containing quotes "Click here to return to "Complete View"."
Then I verify link "Add a new Log line" exists
And I verify link "Click here to return to "Complete View"." does not exist
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-47487-02
@RR06.AUG.2013
@Draft
Scenario: MCC-47487-02 As a Rave Study Builder, when I select Preview on a Landscape log form, I should see the "Click here to return to "Complete View"." link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft1"
And I navigate to "Forms"
And I select Fields for Form "LOGLAND"
And I take a screenshot
When I select link " Preview"
And I switch to "Form Preview" window
Then I verify link "Click here to return to "Complete View"." does not exist
And I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-47487-03
@RR06.AUG.2013
@Draft
Scenario: MCC-47487-03 As a Rave Study Builder, when I select "Click here to return to "Complete View"." on a Portrait mixed form (standard fields and log fields), I should see that the Portrait mixed form is returned to the Complete View.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft1"
And I navigate to "Forms"
And I select Fields for Form "MIXEDPORT"
And I take a screenshot
And I select link " Preview"
And I switch to "Form Preview" window
And I take a screenshot
And I select link "Data"
And I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exist
And I take a screenshot
When I select link containing quotes "Click here to return to "Complete View"."
Then I verify link "Add a new Log line" exists
And I verify link "Click here to return to "Complete View"." does not exist
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-47487-04
@RR06.AUG.2013
@Draft
Scenario: MCC-47487-04 As a Rave Study Builder, when I select Preview on a Landscape mixed form (standard fields and log fields), I should see that the "Click here to return to "Complete View"." link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft1"
And I navigate to "Forms"
And I select Fields for Form "MIXEDLAND"
And I take a screenshot
When I select link " Preview"
And I switch to "Form Preview" window
Then I verify link "Click here to return to "Complete View"." does not exist
And I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-47487-05
@RR06.AUG.2013
@Draft
Scenario: MCC-47487-05 As a Rave Study Builder, when I select Preview on a Lab form, I should see that the "Click here to return to "Complete View"." link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft1"
And I navigate to "Forms"
And I select Fields for Form "LABFORM"
And I take a screenshot
When I select link " Preview"
And I switch to "Form Preview" window
Then I verify link "Add a new Log line" does not exist
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I verify link "Click here to return to "Complete View"." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-47487-06
@RR06.AUG.2013
@Draft
Scenario: MCC-47487-06 As a Rave Study Builder, On the Global Library Wizard, when I select "Click here to return to "Complete View"." on a Portrait log form, I see the Portrait log form is returned to Complete View.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LOGPORT (LOGPORT)"
And I select link "LOGPORT (LOGPORT)"
And I expand "LOGPORT (LOGPORT) details"
And I take a screenshot
And I select link "Form Preview"
And I switch to "Global Draft Preview" window
And I take a screenshot
And I select link "Data"
And I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exist
And I take a screenshot
When I select link containing quotes "Click here to return to "Complete View"."
Then I verify link "Add a new Log line" exists
And I verify link "Click here to return to "Complete View"." does not exist
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-47487-07
@RR06.AUG.2013
@Draft
Scenario: MCC-47487-07 As a Rave Study Builder, On the Global Library Wizard, when I select Preview on a Landscape log form, I should see that the "Click here to return to "Complete View"." link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LOGLAND (LOGLAND)"
And I select link "LOGLAND (LOGLAND)"
And I expand "LOGLAND (LOGLAND) details"
And I take a screenshot
When I select link "Form Preview"
And I switch to "Global Draft Preview" window
Then I verify link "Click here to return to "Complete View"." does not exist
And I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-47487-08
@RR06.AUG.2013
@Draft
Scenario: MCC-47487-08 As a Rave Study Builder, On the Global Library Wizard, when I select "Click here to return to "Complete View"." on a Portrait mixed form (standard fields and log fields), I should see that the Portrait mixed form is returned to Complete View.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft1"
And I select link "Propose Objects" located in "Left Nav"
And I check "MIXEDPORT (MIXEDPORT)"
And I select link "MIXEDPORT (MIXEDPORT)"
And I expand "MIXEDPORT (MIXEDPORT) details"
And I take a screenshot
And I select link "Form Preview"
And I switch to "Global Draft Preview" window
And I take a screenshot
And I select link "Data"
And I verify link "Click here to return to "Complete View"." exists
And I verify image "LogPic.gif" exists
And I verify text "Currently viewing line 1 of 1." exists
And I verify link "Add a new Log line" does not exist
And I take a screenshot
When I select link containing quotes "Click here to return to "Complete View"."
Then I verify link "Add a new Log line" exists
And I verify link "Click here to return to "Complete View"." does not exist
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-47487-09
@RR06.AUG.2013
@Draft
Scenario: MCC-47487-09 As a Rave Study Builder, On the Global Library Wizard, when I select Preview on a Landscape mixed form (standard fields and log fields), I should see that the "Click here to return to "Complete View"." link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft1"
And I select link "Propose Objects" located in "Left Nav"
And I check "MIXEDLAND (MIXEDLAND)"
And I select link "MIXEDLAND (MIXEDLAND)"
And I expand "MIXEDLAND (MIXEDLAND) details"
And I take a screenshot
When I select link "Form Preview"
And I switch to "Global Draft Preview" window
Then I verify link "Click here to return to "Complete View"." does not exist
And I verify link "Add a new Log line" exists
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I take a screenshot

@Release_2013.4.0
@PB_MCC-47487-010
@RR06.AUG.2013
@Draft
Scenario: MCC-47487-010 As a Rave Study Builder, On the Global Library Wizard, when I select Preview on a Lab form, I should see the "Click here to return to "Complete View"." link is not displayed.

Given I login to Rave with user "SUPER USER 1"
And I navigate to "Architect"
And I select "Project" link "MCC-47487" in "Active Projects"
And I select Draft "Draft1"
And I select link "Propose Objects" located in "Left Nav"
And I check "LABFORM (LABFORM)"
And I select link "LABFORM (LABFORM)"
And I expand "LABFORM (LABFORM) details"
And I take a screenshot
When I select link "Form Preview"
And I switch to "Global Draft Preview" window
Then I verify link "Add a new Log line" does not exist
And I verify image "LogPic.gif" does not exists
And I verify text "Currently viewing line 1 of 1." does not exist
And I verify link "Click here to return to "Complete View"." does not exist
And I take a screenshot
