@FT_US12175_DT8545_RaveMonitor
@ignore

Feature: US12175_DT8545_Rave Monitor. When an EDC form contains special characters such as "<" ">" "<=" ">=" the PDF file should display the special characters appropriately. 
	Rave architect allows for characters that the PDF generator does support. The PDF generator should convert the special characters so that they are displayed appropriately as follows:
	|Rave Architect	 	|Symbol in PDF     |
	|&lt 				|<                 |
	|&lt;				|<                 |
	|&gt				|>                 |
	|&gt;				|>                 |
	|&le;				|≤                 |
	|&ge;				|≥                 |
	|&le				|≤                 |
	|&ge				|≥                 |
	|<li>	            |•                 |
	|<br>               |line break        |
    This rendering should be implemented for blank PDFs, annotated PDFs, data populated PDFs, Rave Monitor Trip Report PDFs. 
	This rendering should be implemented for all parts of the PDFs.

Background:
    Given I login to Rave with user "defuser" and password "password"
	And Study "Site Monitor" exist in "Architect"
	And user "defuser" has a report assignment to "Monitor Visit - PDF Report"
	And reports matrix for project "Site Monitor" has "<Permission>" selected for "Monitor Visit - PDF Report"
		| Permission |
		| study      |
		| site       |
		| subject    |	
	And role "RM Lead Monitor" exist in "Configuration"
	And PDF Configuration Profile "Monitor Trip Report" exist
	And study "Site Monitor" is assigned to user "defuser" and role "RM Lead Monitor"
	And study "Test14" is assigned to user "defuser" and role "CDM1"
	And I select Study "Site Monitor" in "Architect"
	And I select draft "Draft 2.0 - FINAL"
	And There are no entry restrictions against "<Form>"
	| #     | Form                           |
	| #     | InvisibleToVisible             |
	| #     | Issues Log                     |
	| #     | Visit Information and Comments |
	And There are no entry restrictions against "<Field>" in "<Form>"
	| Field | Form                           |
	| ESIGN | Visit Information and Comments |
	And I select link "Forms"
	And I select icon "Fields" for standard form "InvisibleToVisible"
	And I select pencil icon "Edit" for field named "TriggerField"
	And I enter and save the field label "&le &ge<br />TriggerField&lt &lt; &gt &gt; &le; &ge;<li></li>"
	And I select link "Forms"
	And I select icon "Fields" for log form "Issues Log"
	And I select pencil icon "Edit" for field named "ACTSTAT"
	And I enter and save the field label "&le &ge<br />breakStatus&lt &lt; &gt &gt; &le; &ge;<li></li>"
	And I select link "Forms"
	And I select icon "Fields" for mixed form "Visit Information and Comments"
	And I select pencil icon "Edit" for field named "IVACATT"
	And I enter and save the field label "&le &ge<br />Representative&lt &lt; &gt &gt; &le; &ge;<li></li>"
    And I select pencil icon "Edit" for field named "DOV_START"
	And I enter and save the field label "&le &ge<br />Visit Start Date&lt &lt; &gt &gt; &le; &ge;<li></li>"
	And I assign user "defuser" to have "RM Lead Monitor" role for "Site Monitor: Prod"
	And I assign all forms at the "Site Initiation Visit" level of the "DEFAULT" matrix
    And I select draft "Draft 2.0 - FINAL"
	And I publish and push CRF Version "Draft2_A" of Draft "Draft 2.0 - FINAL" to site "Site Monitor" in Study "Prod"
	And I create study "Test15"
	And I assign user "defuser" to have "CDM1" role for "Test15: Prod"
	
@release_2012.1.0
@PB_US12175_DT8545_L
@Validation
Scenario: PB_US12175_DT8545_L A blank-populated PDF that is generated should properly display special characters
 	
	When I select Study "test15"
	And I take a screenshot
	And I select link "Monitor Visits" located in "Left Nav"
	And I take a screenshot
	When I generate PDF for all visits
	And I take a screenshot
	Then I verify the PDF text does not contain
        |Symbol       |
        |&lt          |
        |&lt;         |
        |&gt          |
        |&gt;         |
        |&le;         |
        |&ge;         |
		|&lt;li&gt;   |
        |&lt;br/&gt;  |
        |<li>         |
        |<br />       |
        |&le          |
        |&ge          |
And I take a screenshot		
		
@release_2012.1.0
@PB_US12175_DT8545_M
@Validation
Scenario: PB_US12175_DT8545_M A data-populated PDF that is generated should properly display special characters
	
	When I select Study "test14"
	And I take a screenshot
	And I select link "Monitor Visits" located in "Left Nav"
	And I take a screenshot
	And I select Folder "Site Initiation Visit"
	And I select Form "InvisibleToVisible"
	And I enter "<Data>" in "<Field>" and save
      | Field                          | Data      |
      | &le &ge\rTrigger Field<<>> ≤≥• | data123   |
      | InvisibleToVisible             | data456   |
	And I take a screenshot 
	And I select Form "Visit Information and Comments"
	And I enter "<Data>" in "<Field>" and save
      | Field                                         | Data                                  |
      | &le &ge\rVisit Start\rDate<<>> ≤≥•            | 01 Feb 2012                           |
      | Visit End Date                                | 01 Mar 2012                           |
      | &le &ge\rRepresentative<<>> ≤≥•               | test1                                 |
      | Association                                   | Site                                  |
      | Role                                          | Lead Monitor                          |
      | Comment:                                      | &lt &lt; &gt &gt; &le; &ge;<li></li>  |
    And I sign field "I (Monitor) have reviewed all data recorded in this report and confirm that it is complete and accurate" with username "defuser" and password "password"
	And I take a screenshot
	And I select Form "Issues Log"
	And I enter "<Data>" in "<Field>" and save
      | Field                                             | Data                                          |
      | &le &ge\rbreakStatus<<>> ≤≥•                      | Open                                          |
      | Issue Reported Date                               | 05 Feb 2012                                   |
      | Issue Type                                        | Source Documentation                          |
      | Issue Description                                 | &lt &lt; &gt &gt; &le; &ge;<li></li>abc123    |
      | Action Item                                       | &lt &lt; &gt &gt; &le; &ge;<li></li>xyz456    |
      | Responsible                                       | dataABC                                       |
      | Date Resolved                                     | 25 Feb 2012                                   |
      | Resolution Comments                               | aaa555&lt &lt; &gt &gt; &le; &ge;<li></li>    |
	And I take a screenshot
	When I generate PDF for all visits
	And I take a screenshot
	Then I verify the PDF text does not contain
        |Symbol       |
        |&lt          |
        |&lt;         |
        |&gt          |
        |&gt;         |
        |&le;         |
        |&ge;         |
		|&lt;li&gt;   |
        |&lt;br/&gt;  |
        |<li>         |
        |<br />       |
        |&le          |
        |&ge          |	
    And I take a screenshot		