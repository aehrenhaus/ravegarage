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
	#And Study "Site Monitor" exist in "Architect"
	#And user "defuser" has a report assignment to "Monitor Visit - PDF Report"
	#And reports matrix for project "Site Monitor" has "<Permission>" selected for "Monitor Visit - PDF Report"
	#	| Permission |
	#	| study      |
	#	| site       |
	#	| subject    |
	
	#And role "RM Lead Monitor" exist in "Configuration"
	#And PDF Configuration Profile "Monitor Trip Report" exist
	#And study "Site Monitor" is assigned to user "defuser" and role "RM Lead Monitor"
	#And study "Test6" is assigned to user "defuser" and role "CDM1B144V1"
	#And I select Study "Site Monitor" in "Architect"
	#And I select draft "Draft 2.0 - FINAL"
	#And draft "Draft 2.0 - FINAL" has "Signature Prompt" with message "Please review and sign&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break"
	#And There are no entry restrictions against "<Form>"
	#| #     | Form                           |
	#| #     | InvisibleToVisible             |
	#| #     | Issues Log                     |
	#| #     | Visit Information and Comments |
	#And There are no entry restrictions against "<Field>" in "<Form>"
	#| Field | Form                           |
	#| ESIGN | Visit Information and Comments |
	#And I select link "Forms"
	#And I select icon "Fields" for standard form "InvisibleToVisible"
	#And I select pencil icon "Edit" for field named "TriggerField"
	#And I enter and save the field label "Trigger Field&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break"
	#And I select link "Forms"
	#And I select icon "Fields" for log form "Issues Log"
	#And I select pencil icon "Edit" for field named "ACTSTAT"
	#And I enter and save the field label "&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;breakStatus"
	#And I select link "Forms"
	#And I select icon "Fields" for mixed form "Visit Information and Comments"
	#And I select pencil icon "Edit" for field named "IVACATT"
	#And I enter and save the field label "Visit Start Date&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break"
    #And I select pencil icon "Edit" for field named "DOV_START"
	#And I enter and save the field label "&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;breakRepresentative"
	#And I assign user "defuser" to have "RM Lead Monitor" role for "Site Monitor: Prod"
	#And I assign all forms at the "Site Initiation Visit" level of the "DEFAULT" matrix
    #And I select draft "Draft 2.0 - FINAL"
	#And I publish and push CRF Version "Draft2V2" of Draft "Draft 2.0 - FINAL" to site "Site Monitor" in Study "Prod"
	#And I create study "Test6" in "EDC"
	#And I assign user "defuser" to have "CDM1B144V1" role for "Test6: Prod"
	
@release_2012.1.0
@US11043K
@Draft 
Scenario: @US11043K A blank-populated PDF that is generated should properly display special characters
This should be tested with all 3 forms (Standard, log and mixed forms)
 	
	When I select Study "test15" in "EDC"
	And I select link "Monitor Visits" located in "Left Nav"
	When I generate PDF for all visits
	Then the text should not contain "<Symbol>"
        | Symbol      |
        | &gt         |
        | &ge         |
        | &ge;        |
        | &lt         |
        | &le         |
        | &le;        |
        | &lt;li&gt;  |
        | &lt;br/&gt; |
        | <li>        |
        | <br/>       |
		
@release_2012.1.0
@US11043L
@Draft 
Scenario: @US11043L A data-populated PDF that is generated should properly display special characters
This should be tested with all 3 forms (Standard, log and mixed forms)
	
	When I select Study "test14" in "EDC
	And I select link "Monitor Visits" located in "Left Nav"
	#And I select Folder "Site Initiation Visit"
	#And I select Form "InvisibleToVisible"
	#And I enter "<Data>" in "<Field>" and save
    #  | Field                                              | Data        |
    #  | Trigger Field<>&ge≥&le≤bullet points<li><br/>break | &ge&le&lt   |
    #  | InvisibleToVisible                                 | &lt;br/&gt; |
	#And I select Form "Visit Information and Comments"
	#And I enter "<Data>" in "<Field>" and save
    #  | Field                                                 | Data                                                        |
    #  | Visit Start Date<>&ge≥&le≤bullet points<li><br/>break | 01 Feb 2012                                                 |
    #  | Visit End Date                                        | 01 Mar 2012                                                 |
    #  | <>&ge≥&le≤bullet points<li><br/>breakRepresentative   | test1                                                       |
    #  | Association                                           | Site                                                        |
    #  | Role                                                  | Lead Monitor                                                |
    #  | Comment:                                              | &lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break |
    #And I sign field "	I (Monitor) have reviewed all data recorded in this report and confirm that it is complete and accurate" with username "defuser" and password "password"
	#And I select Form "Issues Log"
	#And I enter "<Data>" in "<Field>" and save
    #  | Field                                       | Data                                                              |
    #  | <>&ge≥&le≤bullet points<li><br/>breakStatus | Open                                                              |
    #  | Issue Reported Date                         | 05 Feb 2012                                                       |
    #  | Issue Type                                  | Source Documentation                                              |
    #  | Issue Description                           | &lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;breakabc123 |
    #  | Action Item                                 | &lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;breakxyz456 |
    #  | Responsible                                 | &lt&gt&ge&ge;&le&le;qqq789                                        |
    #  | Date Resolved                               | 25 Feb 2012                                                       |
    #  | Resolution Comments                         | aaa555&lt&gt&ge&ge;&le&le;bullet points&lt;li&gt;&lt;br/&gt;break |
	When I generate PDF for all visits
	Then the text should not contain "<Symbol>"
        | Symbol      |
        | &gt         |
        | &ge         |
        | &ge;        |
        | &lt         |
        | &le         |
        | &le;        |
        | &lt;li&gt;  |
        | &lt;br/&gt; |
        | <li>        |
        | <br/>       |