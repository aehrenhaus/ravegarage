# When a PDF form is generated special character such as "<" ">" "<=" ">=" should be displayed properly 

Feature: When an EDC form contains special characters such as "<" ">" "<=" ">=" the PDF file should display the special characters appropriately. 
	Rave architect allows for characters that the PDF generator does support. The PDF generator should convert the special characters so that they are displayed appropriately as follows:
	|Rave Architect	 		|PDF Interpretation |Symbol in PDF                 |
	|&lt 					|&lt;               |<                             |
	|&gt					|&gt;               |>                             |
	|&ge					|<u>&gt;</u>        |>(underlined)                 |
	|&ge;					|<u>&gt;</u>        |>(underlined)                 |
	|&le					|<u>&lt;</u>        |<(underlined)                 |
	|&le;					|<u>&lt;</u>        |<(underlined)                 |
	|bullet points <li>		|<br/> •            |(Line Break/carriage return) •|
	|(user hitting "enter")	|<br/>              |(Line Break/carriage return)  |
	
	NOTE: An underlined ">" will display instead of ">=" which is represented by ">(underlined)" in this feature file as text editors do not allow underlines.
	      An underlined "<" will display instead of "<=" which is represented by "<(underlined)" in this feature file as text editors do not allow underlines.
	NOTE: user hitting "enter" was previously interpreted as " " but should be interpreted as a new line. In certain Japanese fonts it had been
		interpreted as "="
		
    This rendering should be implemented for blank PDFs, annotated PDFs, data populated PDFs, Rave Monitor Trip Report PDFs. 
	This rendering should be implemented for:
		translations
		field pretext
		data dictionaries on the CRF but NOT in the audit trail
		unit dictionaries on the CRF but NOT in the audit trail
		coding dictionaries on the CRF but NOT in the audit trail
		lab units on the CRF but NOT in the audit trail (does not apply to Rave Monitor Trip Report PDFs)
		lab ranges on the CRF but NOT in the audit trail (does not apply to Rave Monitor Trip Report PDFs)
	This rendering will NOT be implented for:
		bookmarks
		lab names
		Form names
		
Background:
    Given I am logged in to Rave with username "defuser" and password "password"
	And Study "Site Monitor" exist in "Architect"
	And Study "Mediflex_Monitor" exist in "EDC"
	And role "RM Lead Monitor" exist in "Configuration"
	And PDF Configuration Profile "Monitor Trip Report" exist
	And study "Site Monitor" is assigned to user "defuser" and role "RM Lead Monitor"
	And study "Mediflex_Monitor" is assigned to user "defuser" and role "CDM1B144V1"
	And I select Study "Site Monitor" in "Architect"
	And I select draft "Draft 1.0"
	And draft "Draft 1.0" has "Signature Prompt" with message "Please review and sign&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break"
	And I select link "Forms"
	And I select icon "Fields" for standard form "CRF and Source Documentation"
	And I select pencil icon "Edit" for field label "Date of Visit"
	And I enter and save the field label "Date of Visit&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break"
	And I select link "Forms"
	And I select icon "Fields" for log form "Issues Log"
	And I select pencil icon "Edit" for field label "Status"
	And I enter and save the field label "&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;breakStatus"
	And I select link "Forms"
	And I select icon "Fields" for mixed form "Visit Information and Comments"
	And I select pencil icon "Edit" for field label "Visit Start Date"
	And I enter and save the field label "Visit Start Date&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break"
    And I select pencil icon "Edit" for field label "Representative"
	And I enter and save the field label "&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;breakRepresentative"
    And I select draft "Draft 1.0"
	And I publish and push CRF Version "CRF Version<RANDOMNUMBER>" of Draft "<Draft 1.0>" to site "SiteABC" in Study "Site Monitor"
	
@release_2012.1.0
@US11043K
@Draft 
Scenario: @US11043K A blank-populated PDF that is generated should properly display special characters
This should be tested with all 3 forms (Standard, log and mixed forms)
 	
	And I select Study "Mediflex_Monitor" in "EDC"
	And I select link "Monitor Visits"
	When I View Blank PDF "PDF Report"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |
		
@release_2012.1.0
@US11043L
@Draft 
Scenario: @US11043L A data-populated PDF that is generated should properly display special characters
This should be tested with all 3 forms (Standard, log and mixed forms)
		
	And I select Folder "Interim Visit"
	And I select Form "CRF and Source Documentation"
	And I verify the field label "Date of Visit<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hitting "enter")" is displayed
	And I enter data in CRF and save
      |Field		                                                                                                            |Data                                     |
      |Date of Visit<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hitting "enter")              |01 Jan 2012                              |
	  |Not reviewed at this visit                                                                                               |true		                              |
      |Were original source documents and CRFs available for review? (list the documents that have been reviewed in "Comments") |Yes		                              |
	  |Comment:                                                                                                                 |&lt&gt&ge&ge;                            |
	  |Do the source documents adequately support the data on the CRFs?                                                         |No                                       |
	  |Comment:                                                                                                                 |;&le&le;                                 |
	  |Are CRFs being completed accurately, legibly and in a timely manner?                                                     |Yes                                      |
	  |Comment:                                                                                                                 |bullet points&lt;li&gt;&lt;br/&gt;break  |
	And I select Form "Visit Information and Comments"
	And I verify the field label "Visit Start Date<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hitting "enter")" is displayed
	And I verify the field label "<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hitting "enter")Representative" is displayed
	And I enter data in CRF and save
      |Field		                                                                                                            |Data                                                          |
      |Visit Start Date<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hitting "enter")           |01 Feb 2012                                                   |
	  |Visit End Date                                                                                                           |01 Mar 2012		                                           |
      |<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hitting "enter")Representative             |test1		                                                   |
	  |Association                                                                                                              |Site                                                          |
	  |Role                                                                                                                     |Lead Monitor                                                  |
	  |Comment:                                                                                                                 |&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break   |
      |have reviewed all data recorded in this report and confirm that it is complete and accurate                              |defuser password                                              |
    And I select link "Monitor Visits"
	And I select Form "Issues Log"
	And I verify the field label "<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hitting "enter")Status" is displayed
	And I enter data in CRF and save
      |Field		                                                                                          |Data                                                                 |
      |<>>(underlined)>(underlined)<(underlined)<(underlined)bullet points <li>(user hitting "enter")Status   |Open                                                                 |
	  |Issue Reported Date                                                                                    |05 Feb 2012                                                          |
	  |Issue Type                                                                                             |Source Documentation                                                 |
	  |Issue Description                                                                                      |&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;breakabc123    |
	  |Action Item                                                                                            |&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;breakxyz456    |
	  |Responsible                                                                                            |&lt&gt&ge&ge;&le&le;qqq789                                           |
	  |Date Resolved                                                                                          |25 Feb 2012                                                          |
	  |Resolution Comments                                                                                    |aaa555&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break    |
	And I select link "Monitor Visits"
	When I View Blank PDF "PDF Report"
	Then the text should not contain "<Symbol>"
        |Symbol         |
        |&gt            |
        |&ge            |
        |&ge;           |
        |&lt            |
        |&le            |
		|&le;           |
        |&lt;li&gt;     |
        |&lt;br&gt;     |
      