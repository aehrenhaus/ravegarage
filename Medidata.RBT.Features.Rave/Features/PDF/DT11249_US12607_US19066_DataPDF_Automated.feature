# This is an automated feature file for DT11249_@US12607_US19066
#
# When a data populated PDF file is generated and a log form is displayed in portrait mode, the user should have the ability to determine if there should be 
# page breaks between each record or a continuous listing of each record.

# NOTE: there is already functionality within the PDF generator to determine if a PDF should be generated in landscape or portrait mode
# If the log form is going to be rendered in portrait mode, the user should be able to determine if there are page breaks in between records, or if all records 
# should be displayed in a continuous list
# When a user navigates to the PDF generator and creates a data populated PDF request there should be a new section below locale that says Display multiple log lines per page"
# When the user selects the "Display multiple log lines per page" triangle, a list of all the log forms in the study that are available to the role selected in the PDF request is displayed with a tickbox next to each form name.
# A label at the top of the tickbox column is displayed that says "Display multiple log lines per page" with text in the whitespace next to the tickbox control that says "When selected all log lines on the selected form or forms will display continuously.  If un-selected a new page will be created for each log line."
# If the user does not select the box then the PDF generated should include a page break after each individual record. If the selects the box then each
# record should display on the same page as the previous record.

#Background:
# There should be a study that has log forms as follows: 
# 1) A long log form such as Adverse Events that is displayed in EDC in landscape mode
# 2) A long log form such as Adverse Events that is displayed in EDC in portrait mode
# 3) A short log form such as Medical History that is displayed in EDC in landscape mode with no default values
# 4) A short log form such as Medical History that is displayed in EDC in landscape mode with default values
# There should be a subject with data entered in each one of those forms. At least 3 records in each form.

#When a PDF is generated using the PDF generator
#If there is a log form that has default values, for example:
#
#Medical History Form
#Body System             Normal/Abnormal            Result
#Cardio                                   x                                       x
#Neuro                                    x                                       x
#Derm                                     x                                       x
#
#In the example above, the field "Body System" has default values of "Cardio", "Neuro" and "Derm"
#
#When the PDF is generated, a full page is generated for each default value. 
#Instead, 
#If there is enough room to display the PDF in horizontal log view, it should be displayed on 1 page in horizontal log view
#If there is not enough room to display the PDF in horizontal view, it should be displayed vertically.

Feature: DT11249_US12607_US19066 Users should have the option to generate data populated PDF files for log forms in portrait mode with or without page breaks 
As a Rave User with access to PDF generator and a study with a log form that render in portrait mode in the PDF generator
I want to have the option to generate the PDFs either with or without page breaks between each records
so that I can minimize the number of pages generated in the PDF if I choose to do so.

Background:

Given xml draft "US12607DataPDFStudy.xml" is Uploaded
Given Site "Site_A" exists
Given study "US12607DataPDFStudy" is assigned to Site "Site_A"
Given role "SUPER ROLE 1" exists
Given I publish and push eCRF "US12607DataPDFStudy.xml" to "Version 1"
Given following Project assignments exist
|User            |Project              |Environment |Role         | Site    |SecurityRole          |
|US12607_user1   |US12607DataPDFStudy  |Live: Prod  |SUPER ROLE 1 | Site_A  |Project Admin Default |
|US12607_locuser |US12607DataPDFStudy  |Live: Prod  |SUPER ROLE 1 | Site_A  |Project Admin Default |
Given following PDF Configuration Profile Settings exist
|Profile Name |
|US12607PDFA  |

#Note: Study "US12607DataPDFStudy" is set up with 4 forms "Adverse Events1" in "Landscape" mode, "Adverse Events2" in "Portrait" mode,
# "Medical History1" in "Landscape" mode with no default values and "Medical History2" in "Landscape" mode with default values.

@release_2012.1.0
@US12607_US19066-01A
@WIP
Scenario:@US12607_US19066-01A - By Default the user can view all assigned forms.

  Given I login to Rave with user "US12607_user1"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num1>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num1)}   |textbox      |
  And I navigate to "Home"
  And I navigate to "PDF Generator" module
  And I select link "Create Data Request"  
   And I create Data PDF
   | Name                     | Profile     | Study               | Environment |Role         | Locale  |
   | DataPDFA{RndNum<num>(3)} | US12607PDFA | US12607DataPDFStudy | Prod        |SUPER ROLE 1 | English |
  And I click edit datapdf "DataPDFA{Var(num)}" 
  And I verify text "Display multiple log lines per page" exists
  And I expand Display multiple log lines per page
  And I verify rows exist in "Display multiple log lines per page" table
   |Form             |Checked |
   |Adverse Events1  |false   |
   |Adverse Events2  |false   |
   |Medical History1 |false   |
   |Medical History2 |false   |
  And I verify text "When selected all log lines on the selected form or forms will display continuously. If un-selected a new page will be created for each log line." exists
  And I take a screenshot
  
@release_2012.1.0
@US12607_US19066-02A
@WIP
Scenario:@US12607_US19066-02A - The localization user can view strings are localized

  Given I login to Rave with user "US12607_locuser"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num2>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num2)}   |textbox      |
  And I navigate to "LHome"
  And I navigate to "LPDF Generator" module
  And I select link "LCreate Data Request"  
  And I create Data PDF
   |Name                       |Profile      |Study                |Environment  |Role          |Locale             |
   |LocDataPDF{RndNum<num>(3)} |LUS12607PDFA |LUS12607DataPDFStudy |LProd        |LSUPER ROLE 1 |LLocalization Test |
  And I click edit datapdf "LLocDataPDF{Var(num)}"  
  And I verify text "LDisplay multiple log lines per page" exists
  And I expand LDisplay multiple log lines per page
  And I verify rows exist in "Display multiple log lines per page" table
   |Form              |Checked |
   |LAdverse Events1  |false   |
   |LAdverse Events2  |false   |
   |LMedical History1 |false   |
   |LMedical History2 |false   |
  And I verify text "LWhen selected all log lines on the selected form or forms will display continuously. If un-selected a new page will be created for each log line." exists
  And I take a screenshot
  
@release_2012.1.0
@US12607_US19066-03A
@WIP
Scenario:@US12607_US19066-03A - Selecting all assigned forms.

  Given I login to Rave with user "US12607_user1"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num3>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num3)}   |textbox      |
  And I navigate to "Home"
  And I navigate to "PDF Generator" module
  And I select link "Create Data Request"  
  And I create Data PDF
   | Name                     | Profile     | Study               | Environment |Role         | Locale  |
   | DataPDFC{RndNum<num>(3)} | US12607PDFA | US12607DataPDFStudy | Prod        |SUPER ROLE 1 | English |
  And I click edit datapdf "DataPDFC{Var(num)}"  
  And I verify text "Display multiple log lines per page" exists
  And I expand Display multiple log lines per page
  And I verify rows exist in "Display multiple log lines per page" table
   |Form             |Checked |
   |Adverse Events1  |false   |
   |Adverse Events2  |false   |
   |Medical History1 |false   |
   |Medical History2 |false   |
  And I verify text "When selected all log lines on the selected form or forms will display continuously. If un-selected a new page will be created for each log line." exists
  And I take a screenshot
  When I check "Select All" in "Display multiple log lines per page"
  Then I verify rows exist in "Display multiple log lines per page" table
   |Form             |Checked |
   |Adverse Events1  |true    |
   |Adverse Events2  |true    |
   |Medical History1 |true    |
   |Medical History2 |true    |
  And I take a screenshot  
  And I select link "Save"
  
@release_2012.1.0
@US12607_US19066-04A
@WIP
Scenario:@US12607_US19066-04A - Unselecting all assigned forms.

  Given I login to Rave with user "US12607_user1"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num4>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num4)}   |textbox      |
  And I navigate to "Home"
  And I navigate to "PDF Generator" module
  And I select link "Create Data Request"  
  And I create Data PDF
   | Name                     | Profile     | Study               | Environment |Role         | Locale  |
   | DataPDFD{RndNum<num>(3)} | US12607PDFA | US12607DataPDFStudy | Prod        |SUPER ROLE 1 | English |
  And I click edit datapdf "DataPDFD{Var(num)}"  
  And I verify text "Display multiple log lines per page" exists
  And I expand Display multiple log lines per page
  And I verify rows exist in "Display multiple log lines per page" table
   |Form             |Checked |
   |Adverse Events1  |false   |
   |Adverse Events2  |false   |
   |Medical History1 |false   |
   |Medical History2 |false   |
  And I verify text "When selected all log lines on the selected form or forms will display continuously. If un-selected a new page will be created for each log line." exists
  And I take a screenshot
  And I check "Select All" in "Display multiple log lines per page"
  When I uncheck "Select All" in "Display multiple log lines per page"
  Then I verify rows exist in "Display multiple log lines per page" table
   |Form             |Checked |
   |Adverse Events1  |false   |
   |Adverse Events2  |false   |
   |Medical History1 |false   |
   |Medical History2 |false   |
  And I take a screenshot  
  And I select link "Save"
  
@release_2012.1.0
@US12607_US19066-05A
@WIP
Scenario:@US12607_US19066-05A - Selecting only one assigned form.

  Given I login to Rave with user "US12607_user1"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num5>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num5)}   |textbox      |
  And I navigate to "Home"
  And I navigate to "PDF Generator" module
  And I select link "Create Data Request"  
  And I create Data PDF
   | Name                     | Profile     | Study               | Environment |Role         | Locale  |
   | DataPDFE{RndNum<num>(3)} | US12607PDFA | US12607DataPDFStudy | Prod        |SUPER ROLE 1 | English |
  And I click edit datapdf "DataPDFE{Var(num)}"  
  And I verify text "Display multiple log lines per page" exists
  And I expand Display multiple log lines per page
  And I verify rows exist in "Display multiple log lines per page" table
   |Form             |Checked |
   |Adverse Events1  |false   |
   |Adverse Events2  |false   |
   |Medical History1 |false   |
   |Medical History2 |false   |
  And I verify text "When selected all log lines on the selected form or forms will display continuously. If un-selected a new page will be created for each log line." exists
  And I take a screenshot
  When I check "Adverse Events1" in "Display multiple log lines per page"
  Then I verify rows exist in "Display multiple log lines per page" table
   |Form            |Checked |
   |Adverse Events1 |true    |
  And I take a screenshot  
  And I select link "Save"
  
@release_2012.1.0
@US12607_US19066-06A
@WIP
Scenario:@US12607_US19066-06A - Selecting only one assigned form.

  Given I login to Rave with user "US12607_user1"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num6>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num6)}   |textbox      |
  And I navigate to "Home"
  And I navigate to "PDF Generator" module
  And I select link "Create Data Request"  
  And I create Data PDF
   | Name                     | Profile     | Study               | Environment |Role         | Locale  |
   | DataPDFF{RndNum<num>(3)} | US12607PDFA | US12607DataPDFStudy | Prod        |SUPER ROLE 1 | English |
  And I click edit datapdf "DataPDFF{Var(num)}"  
  And I verify text "Display multiple log lines per page" exists
  And I expand Display multiple log lines per page
  And I verify rows exist in "Display multiple log lines per page" table
   |Form             |Checked |
   |Adverse Events1  |false   |
   |Adverse Events2  |false   |
   |Medical History1 |false   |
   |Medical History2 |false   |
  And I verify text "When selected all log lines on the selected form or forms will display continuously. If un-selected a new page will be created for each log line." exists
  And I take a screenshot
  When I check "Adverse Events2" in "Display multiple log lines per page"
  Then I verify rows exist in "Display multiple log lines per page" table
   |Form            |Checked |
   |Adverse Events2 |true    |
  And I take a screenshot  
  And I select link "Save"
  
@release_2012.1.0
@US12607_US19066-07A
@WIP
Scenario:@US12607_US19066-07A - Selecting only one assigned form.

  Given I login to Rave with user "US12607_user1"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num7>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num7)}   |textbox      |
  And I navigate to "Home"
  And I navigate to "PDF Generator" module
  And I select link "Create Data Request"  
  And I create Data PDF
   | Name                     | Profile     | Study               | Environment |Role         | Locale  |
   | DataPDFG{RndNum<num>(3)} | US12607PDFA | US12607DataPDFStudy | Prod        |SUPER ROLE 1 | English |
  And I click edit datapdf "DataPDFG{Var(num)}" 
  And I verify text "Display multiple log lines per page" exists
  And I expand Display multiple log lines per page
  And I verify rows exist in "Display multiple log lines per page" table
   |Form             |Checked |
   |Adverse Events1  |false   |
   |Adverse Events2  |false   |
   |Medical History1 |false   |
   |Medical History2 |false   |
  And I verify text "When selected all log lines on the selected form or forms will display continuously. If un-selected a new page will be created for each log line." exists
  And I take a screenshot
  When I check "Medical History1" in "Display multiple log lines per page"
  Then I verify rows exist in "Display multiple log lines per page" table
   |Form             |Checked |
   |Medical History1 |true    |
  And I take a screenshot  
  And I select link "Save"
  
@release_2012.1.0
@US12607_US19066-08A
@WIP
Scenario:@US12607_US19066-08A - Selecting only one assigned form.

  Given I login to Rave with user "US12607_user1"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num8>(3)} |textbox      |
    |Subject ID 	     |SUB {Var(num8)}   |textbox      |
  And I navigate to "Home"
  And I navigate to "PDF Generator" module
  And I select link "Create Data Request"  
    And I create Data PDF
   | Name                     | Profile     | Study               | Environment |Role         | Locale  |
   | DataPDFH{RndNum<num>(3)} | US12607PDFA | US12607DataPDFStudy | Prod        |SUPER ROLE 1 | English |
  And I click edit datapdf "DataPDFH{Var(num)}"  
  And I verify text "Display multiple log lines per page" exists
  And I expand Display multiple log lines per page
  And I verify rows exist in "Display multiple log lines per page" table
   |Form             |Checked |
   |Adverse Events1  |false   |
   |Adverse Events2  |false   |
   |Medical History1 |false   |
   |Medical History2 |false   |
  And I verify text "When selected all log lines on the selected form or forms will display continuously. If un-selected a new page will be created for each log line." exists
  And I take a screenshot
  When I check "Medical History2" in "Display multiple log lines per page"
  Then I verify rows exist in "Display multiple log lines per page" table
   |Form             |Checked |
   |Medical History2 |true    |
  And I take a screenshot  
  And I select link "Save"