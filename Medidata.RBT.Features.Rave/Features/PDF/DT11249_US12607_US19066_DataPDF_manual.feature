@FT_DT11249_@US12607_US19066_DataPDF
@ignore

Feature: US12607_US19066_DT11249 Manual Users should have the option to generate data populated PDF files for log forms in portrait mode with or without page breaks 
As a Rave User with access to PDF generator and a study with a log form that render in portrait mode in the PDF generator
I want to have the option to generate the PDFs either with or without page breaks between each records
so that I can minimize the number of pages generated in the PDF if I choose to do so.

When a data populated PDF file is generated and a log form is displayed in portrait mode, the user should have the ability to determine if there should be 
page breaks between each record or a continuous listing of each record.

NOTE: there is already functionality within the PDF generator to determine if a PDF should be generated in landscape or portrait mode
If the log form is going to be rendered in portrait mode, the user should be able to determine if there are page breaks in between records, or if all records 
should be displayed in a continuous list
When a user navigates to the PDF generator and creates a data populated PDF request there should be a new section below locale that says Display multiple log lines per page"
When the user selects the "Display multiple log lines per page" triangle, a list of all the log forms in the study that are available to the role selected in the PDF request is displayed with a tickbox next to each form name.
A label at the top of the tickbox column is displayed that says "Display multiple log lines per page" with text in the whitespace next to the tickbox control that says "When selected, all log lines on the selected form or forms will display continuously. If un-selected, a new page will be created for each log line."
If the user does not select the box then the PDF generated should include a page break after each individual record. If the selects the box then each
record should display on the same page as the previous record.

NOTE:
 There should be a study that has log forms as follows: 
 1) A long log form such as Adverse Events that is displayed in EDC in landscape mode
 2) A long log form such as Adverse Events that is displayed in EDC in portrait mode
 3) A short log form such as Medical History that is displayed in EDC in landscape mode with no default values
 4) A short log form such as Medical History that is displayed in EDC in landscape mode with default values
 There should be a subject with data entered in each one of those forms. At least 3 records in each form.

When a PDF is generated using the PDF generator
If there is a log form that has default values, for example:

Medical History Form
Body System             Normal/Abnormal            Result
Cardio                      x                         x
Neuro                       x                         x
Derm                        x                         x
In the example above, the field "Body System" has default values of "Cardio", "Neuro" and "Derm"

When the PDF is generated, a full page is generated for each default value. 
Instead, 
If there is enough room to display the PDF in horizontal log view, it should be displayed on 1 page in horizontal log view
If there is not enough room to display the PDF in horizontal view, it should be displayed vertically.


Background:

Given xml draft "US12607DataPDFStudy.xml" is Uploaded
Given Site "Site_A" exists
Given study "US12607DataPDFStudy" is assigned to Site "Site_A"
Given role "US12607_role1" exists
Given I publish and push eCRF "US12607DataPDFStudy.xml" to "Version 1"
Given following Project assignments exist
|User            |Project              |Environment |Role          | Site    |SecurityRole          |
|US12607_user1   |US12607DataPDFStudy  |Live: Prod  |US12607_role1 | Site_A  |Project Admin Default |
|US12607_locuser |US12607DataPDFStudy  |Live: Prod  |US12607_role1 | Site_A  |Project Admin Default |
Given following PDF Configuration Profile Settings exist
|Profile Name           |
|Default PDF Profile 1  |

#Note: Study "US12607DataPDFStudy" is set up with 4 forms "Adverse Events1" in "Landscape" mode, "Adverse Events2" in "Portrait" mode,
#"Medical History1" in "Landscape" mode with no default values and "Medical History2" in "Landscape" mode with default values.

  Given I log in to Rave with user "US12607_user1"
  And I select Study "US12607DataPDFStudy" and Site "Site_A"
  And I create a Subject
    |Field               |Data              |Control Type |
    |Subject Initials    |SUB               |textbox      |
    |Subject Number      |{RndNum<num1>(3)} |textbox      |
    |Subject ID 	      |SUB {Var(num1)}  |textbox      |
  And I select Form "Adverse Events1"
  And I enter data in CRF and save
    |Field                            |Data                     |Control Type     |
    |Were there any adverse events?   |Yes                      |Dropdown         |
    |Adverse Event Description        |Head Ache                |longtext         |
    |Start Date                       |01 Jan 2012              |datetime         |
	|Stop Date                        |05 Jan 2012              |datetime         |
	|Continuing?                      |Yes                      |Dropdown         |
    |Serious adverse event?           |No                       |Dropdown         |
	|Related to study drug?	          |Yes                      |Dropdown         |
    |Action taken (1)                 |None Taken	            |Dropdown         |
    |Action taken (2)                 |Medication               |Dropdown         |
	|Action taken (3)                 |Discontinued Study Drug  |Dropdown         |
	|Action taken (4)                 |None Taken               |Dropdown         |
    |Action taken (5)                 |None Taken               |Dropdown         |
	|Action taken (6)                 |None Taken               |Dropdown         |
    |Action taken (7)                 |None Taken               |Dropdown         |
    |Action taken (8)                 |None Taken               |Dropdown         |
	|Duration	                      |5                        |text             |
  And I select Form "Adverse Events2"
  And I enter data in CRF and save
    |Field                            |Data                     |Control Type     |
    |Were there any adverse events?   |Yes                      |Dropdown         |
    |Adverse Event Description        |Migrane                  |longtext         |
    |Start Date                       |01 Feb 2012              |datetime         |
	|Stop Date                        |08 Feb 2012              |datetime         |
	|Continuing?                      |Yes                      |Dropdown         |
    |Serious adverse event?           |Yes                      |Dropdown         |
	|Related to study drug?	          |Yes                      |Dropdown         |
    |Action taken (1)                 |None Taken	            |Dropdown         |
    |Action taken (2)                 |Medication               |Dropdown         |
	|Action taken (3)                 |None Taken               |Dropdown         |
	|Action taken (4)                 |None Taken               |Dropdown         |
    |Action taken (5)                 |None Taken               |Dropdown         |
	|Action taken (6)                 |None Taken	            |Dropdown         |
    |Action taken (7)                 |Medication               |Dropdown         |
    |Action taken (8)                 |Discontinued Study Drug  |Dropdown         |
	|Duration	                      |8                        |text             |
  And I select Form "Medical History1"
  And I enter data in CRF and save
    |Field         |Data          |Control Type |
    |Visit Date:   |01 Jan 2012   |datetime     |
    |Gender        |Female        |radiobutton  |
    |Body System:  |HEENT         |Dropdown     |
	|Result:       |Normal        |Dropdown     |
	|Description:  |TestA         |longtext     |
  And I select Form "Medical History2"
  And I enter data in CRF and save
    |Field         |Data          |Control Type |
    |Visit Date:   |01 Jan 2012   |datetime     |
    |Gender        |Male          |radiobutton  |
	|Result:       |Abnormal      |Dropdown     |
	|Description:  |Test1         |longtext     |
	|Visit Date:   |02 Jan 2012   |datetime     |
    |Gender        |Female        |radiobutton  |
	|Result:       |Normal        |Dropdown     |
	|Description:  |Test2         |longtext     |
	|Visit Date:   |03 Jan 2012   |datetime     |
    |Gender        |Male          |radiobutton  |
	|Result:       |Abnormal      |Dropdown     |
	|Description:  |Test3         |longtext     |
	|Visit Date:   |04 Jan 2012   |datetime     |
    |Gender        |Female        |radiobutton  |
	|Result:       |Normal        |Dropdown     |
	|Description:  |Test4         |longtext     |
	|Visit Date:   |05 Jan 2012   |datetime     |
    |Gender        |Male          |radiobutton  |
	|Result:       |Abnormal      |Dropdown     |
	|Description:  |Test5         |longtext     |
	|Visit Date:   |01 Feb 2012   |datetime     |
    |Gender        |Female        |radiobutton  |
	|Result:       |Abnormal      |Dropdown     |
	|Description:  |Test6         |longtext     |
	|Visit Date:   |02 Feb 2012   |datetime     |
    |Gender        |Male          |radiobutton  |
	|Result:       |Normal        |Dropdown     |
	|Description:  |Test7         |longtext     |
	|Visit Date:   |03 Feb 2012   |datetime     |
    |Gender        |Female        |radiobutton  |
	|Result:       |Normal        |Dropdown     |
	|Description:  |Test8         |longtext     |
	|Visit Date:   |04 Feb 2012   |datetime     |
    |Gender        |Male          |radiobutton  |
	|Result:       |Abnormal      |Dropdown     |
	|Description:  |Test9         |longtext     |
    |Visit Date:   |05 Feb 2012   |datetime     |
    |Gender        |Male          |radiobutton  |
	|Result:       |Normal        |Dropdown     |
	|Description:  |Test10        |longtext     |
	|Visit Date:   |06 Feb 2012   |datetime     |
    |Gender        |Female        |radiobutton  |
	|Result:       |Abnormal      |Dropdown     |
	|Description:  |Test11        |longtext     |
	|Visit Date:   |07 Feb 2012   |datetime     |
    |Gender        |Male          |radiobutton  |
	|Result:       |Normal        |Dropdown     |
	|Description:  |Test12        |longtext     |
	|Visit Date:   |08 Feb 2012   |datetime     |
    |Gender        |Male          |radiobutton  |
	|Result:       |Abnormal      |Dropdown     |
	|Description:  |Test13        |longtext     |
	|Visit Date:   |09 Feb 2012   |datetime     |
    |Gender        |Female        |radiobutton  |
	|Result:       |Normal        |Dropdown     |
	|Description:  |Test14        |longtext     |
	|Visit Date:   |10 Feb 2012   |datetime     |
    |Gender        |Male          |radiobutton  |
	|Result:       |Normal        |Dropdown     |
	|Description:  |Test15        |longtext     |
	|Visit Date:   |11 Feb 2012   |datetime     |
    |Gender        |Male          |radiobutton  |
	|Body System:  |Migrane       |text         |
	|Result:       |Abnormal      |Dropdown     |
	|Description:  |Test16        |longtext     |
  And I verify data on Fields in CRF
	|Field         |Data                             |
    |Visit Date:   |01 Jan 2012                      |
    |Gender        |Male                             |
	|Body System:  |HEENT                            |
    |Result:       |Abnormal                         |
    |Description:  |Test1                            |
    |Visit Date:   |02 Jan 2012                      |
    |Gender        |Female                           |
	|Body System:  |Cardiovascular                   |
    |Result:       |Normal                           |
    |Description:  |Test2                            |
    |Visit Date:   |03 Jan 2012                      |
    |Gender        |Male                             |
	|Body System:  |Respiratory                      |
    |Result:       |Abnormal                         |
    |Description:  |Test3                            |
    |Visit Date:   |04 Jan 2012                      |
    |Gender        |Female                           |
	|Body System:  |Gastrointestinal                 |
    |Result:       |Normal                           |
    |Description:  |Test4                            |
    |Visit Date:   |05 Jan 2012                      |
    |Gender        |Male                             |
	|Body System:  |Genitourinary                    |
    |Result:       |Abnormal                         |
    |Description:  |Test5                            |
    |Visit Date:   |01 Feb 2012                      |
    |Gender        |Female                           |
	|Body System:  |Skin                             |
    |Result:       |Abnormal                         |
    |Description:  |Test6                            |
    |Visit Date:   |02 Feb 2012                      |
    |Gender        |Male                             |
	|Body System:  |Endocrine/Metabolic              |
    |Result:       |Normal                           |
    |Description:  |Test7                            |
    |Visit Date:   |03 Feb 2012                      |
    |Gender        |Female                           |
	|Body System:  |Hepatic                          |
    |Result:       |Normal                           |
    |Description:  |Test8                            |
    |Visit Date:   |04 Feb 2012                      |
    |Gender        |Male                             |
	|Body System:  |Musculoskeletal                  |
    |Result:       |Abnormal                         |
    |Description:  |Test9                            |
    |Visit Date:   |05 Feb 2012                      |
    |Gender        |Male                             |
	|Body System:  |SpecialSenses                    |
    |Result:       |Normal                           |
    |Description:  |Test10                           |
    |Visit Date:   |06 Feb 2012                      |
    |Gender        |Female                           |
	|Body System:  |Renal                            |
    |Result:       |Abnormal                         |
    |Description:  |Test11                           |
    |Visit Date:   |07 Feb 2012                      |
    |Gender        |Male                             |
	|Body System:  |Hemotologic                      |
    |Result:       |Normal                           |
    |Description:  |Test12                           |
    |Visit Date:   |08 Feb 2012                      |
    |Gender        |Male                             |
	|Body System:  |Neurologic                       |
    |Result:       |Abnormal                         |
    |Description:  |Test13                           |
    |Visit Date:   |09 Feb 2012                      |
    |Gender        |Female                           |
	|Body System:  |Dermatologic                     |
    |Result:       |Normal                           |
    |Description:  |Test14                           |
    |Visit Date:   |10 Feb 2012                      |
    |Gender        |Male                             |
	|Body System:  |Immunologic                      |
    |Result:       |Normal                           |
    |Description:  |Test15                           |
    |Visit Date:   |11 Feb 2012                      |
    |Gender        |Male                             |
    |Body System:  |Other (please specify) (Migrane) |
    |Result:       |Abnormal                         |
    |Description:  |Test16                           |
  And I navigate to "Home"
  And I log out of Rave

@release_2012.1.0
@PB_US12607_US19066_DT11249_01B
@Validation
Scenario: PB_US12607_US19066_DT11249_01B When I select all assigned forms while creating PDF with default PDF Configuration Profile, then i should see a continuous list of all records.

    Given I log in to Rave with user "US12607_user1"
	And I navigate to "PDF Generator" module
    And I select link "Create Data Request" 
	And I create Data PDF
		|Name                    |Profile     |Study                      |Role           |Locale  |Display multiple log lines per page|Site Groups|Sites  |Subjects      |
		|DataPDFA{RndNum<num>(3)}|US12607PDFA |US12607DataPDFStudy (Prod) |US12607_role1  |English |Select All                         |World      |Site_A |Sub{Var(num1)}|
	And I take a screenshot
	And I generate Data PDF "DataPDFA{Var(num)}"
	And I wait for PDF "DataPDFA{Var(num)}" to complete
	And I take a screenshot
	When I view data PDF "Sub{Var(num1)}.pdf" from request "DataPDFA{Var(num)}"
	Then I should see continuous list of all records/loglines on "Medical History2" form with default values
	And I should see all fields correctly on one page (depending on the fields) on "Adverse Events1", "Adverse Events2" and "Medical History1" forms without default values
	And I take a screenshot
	
@release_2012.1.0
@PB_US12607_US19066_DT11249_02B
@Validation
Scenario: PB_US12607_US19066_DT11249_02B When I unselect all assigned forms while creating PDF with default PDF Configuration Profile, then i should see a page break after each individual record.

    Given I log in to Rave with user "US12607_user1"
	And I navigate to "PDF Generator" module
    And I select link "Create Data Request" 
	And I create Data PDF
		|Name                    |Profile     |Study                      |Role           |Locale  |Display multiple log lines per page|Site Groups|Sites  |Subjects      |
		|DataPDFB{RndNum<num>(3)}|US12607PDFA |US12607DataPDFStudy (Prod) |US12607_role1  |English |                                   |World      |Site_A |Sub{Var(num1)}|
	And I take a screenshot
	And I generate Data PDF "DataPDFB{Var(num)}"
	And I wait for PDF "DataPDFB{Var(num)}" to complete
	And I take a screenshot
    When I view data PDF "Sub{Var(num1)}.pdf" from request "DataPDFB{Var(num)}"
   	Then I should see a page break after each individual record/logline on "Medical History2" form with default values
	And I should see all fields correctly on one page (depending on the fields) on "Adverse Events1", "Adverse Events2" and "Medical History1" forms without default values
    And I take a screenshot
	
@release_2012.1.0
@PB_US12607_US19066_DT11249_03B
@Validation
Scenario: PB_US12607_US19066_DT11249_03B When i select two forms while creating PDF with default PDF Configuration Profile, then i should see continuous list of records on selected two forms and i should see a page break after each individual record on unselected forms.

    Given I log in to Rave with user "US12607_user1"
	And I navigate to "PDF Generator" module
    And I select link "Create Data Request" 
	And I create Data PDF
		|Name                    |Profile      |Study                      |Role           |Locale  |Display multiple log lines per page |Site Groups|Sites  |Subjects      |
		|DataPDFC{RndNum<num>(3)}|US12607PDFA  |US12607DataPDFStudy (Prod) |US12607_role1  |English |Adverse Events2 Medical History2    |World      |Site_A |Sub{Var(num1)}|
	And I take a screenshot
	And I generate Data PDF "DataPDFC{Var(num)}"
	And I wait for PDF "DataPDFC{Var(num)}" to complete
	And I take a screenshot
	When I view data PDF "Sub{Var(num1)}.pdf" from request "DataPDFC{Var(num)}"
	Then I should see continuous list of all records/loglines on "Medical History2" form with default values
	And I should see all fields correctly on one page (depending on the fields) on "Adverse Events1", "Adverse Events2" and "Medical History1" forms without default values
	And I take a screenshot
		
@release_2012.1.0
@PB_US12607_US19066_DT11249_04B
@Validation
Scenario: PB_US12607_US19066_DT11249_04B When I select all assigned forms while creating PDF with default PDF Configuration Profile with Localization locale, then i should see a continuous list of all records with "L" locale.

    Given I log in to Rave with user "US12607_locuser"
	And I navigate to "LPDF Generator" module
    And I select link "LCreate Data Request" 
	And I create Data PDF
		|LName                    |LProfile     |LStudy                       |LRole          |LLocale             |LDisplay multiple log lines per page |LSite Groups |LSites   |LSubjects     |
		|DataPDFG{RndNum<num>(3)} |LUS12607PDFA |LUS12607DataPDFStudy (Prod)  |LUS12607_role1 |LLocalization Test  |LSelect All                          |LWorld       |LSite_A  |Sub{Var(num1)}|
	And I take a screenshot
	And I generate Data PDF "LDataPDFG{Var(num)}"
	And I wait for PDF "LDataPDFG{Var(num)}" to complete
	And I take a screenshot
	When I view data PDF "Sub{Var(num1)}.pdf" from request "LDataPDFG{Var(num)}"
	Then I should see continuous list of all records/loglines with "L" locale on "LMedical History2" form with default values
	And I should see all fields correctly on one page (depending on the fields) with "L" locale on "LAdverse Events1", "LAdverse Events2" and "LMedical History1" forms without default values
	And I take a screenshot
	
@release_2012.1.0
@PB_US12607_US19066_DT11249_05B
@Validation
Scenario: PB_US12607_US19066_DT11249_05B When I unselect all assigned forms while creating PDF with default PDF Configuration Profile with Localization locale, then i should see a page break after each individual record with "L" locale.

    Given I log in to Rave with user "US12607_locuser"
	And I navigate to "LPDF Generator" module
    And I select link "LCreate Data Request" 
	And I create Data PDF
		|LName                    |LProfile     |LStudy                       |LRole          |LLocale             |LDisplay multiple log lines per page|LSite Groups |LSites   |LSubjects     |
		|DataPDFH{RndNum<num>(3)} |LUS12607PDFA |LUS12607DataPDFStudy (Prod)  |LUS12607_role1 |LLocalization Test  |                                    |LWorld       |LSite_A  |Sub{Var(num1)}|
	And I take a screenshot
	And I generate Data PDF "LDataPDFH{Var(num)}"
	And I wait for PDF "LDataPDFH{Var(num)}" to complete
	And I take a screenshot
	When I view data PDF "Sub{Var(num1)}.pdf" from request "LDataPDFH{Var(num)}"
	Then I should see a page break after each individual record/logline with "L" locale on "LMedical History2" form with default values
	And I should see all fields correctly on one page (depending on the fields) with "L" locale on "LAdverse Events1", "LAdverse Events2" and "LMedical History1" forms without default values
	And I take a screenshot