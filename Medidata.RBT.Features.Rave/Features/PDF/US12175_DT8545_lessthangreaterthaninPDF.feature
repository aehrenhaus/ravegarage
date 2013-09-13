#Note: KnownDT14291 - &ge and &le characters are not coverted to symbols on CRF page in EDC. This issue is applicable to the entire feature file
#Note: KnownDT14335 - Bold, Italic Text and data are not converted in PDF's when Asian Fonts are used
#Note: KnownDT14336 - Bold and Italic field and data are not converted in Data PDF's and Annotated PDF's when Font: Times New Roman Embedded is used
# When a PDF form is generated special character such as "<" ">" "≤" "≥" "•" should be displayed properly
# Carriage return should display correctly on the generated data PDF when Bold font is used in Field Label.
@FT_US12175_DT8545_lessthangreaterthaninPDF
Feature: US12175_DT8545 When an EDC form contains special characters such as "<" ">" "≤" "≥" the PDF file should display the special characters appropriately.
#Rave architect allows for characters that the PDF generator does support. The PDF generator should convert the special characters so that they are displayed appropriately as follows:
#|Rave Architect |Symbol in PDF |
#|&lt |< |
#|&lt; |< |
#|&gt |> |
#|&gt; |> |
#|&le; |≤ |
#|&ge; |≥ |
#|&le |≤ |
#|&ge |≥ |
#|<li> |• |
#|<br> |line break |
#|enter |line break |
#|< |< |
#|> |> |
#|≤ |≤ |
#|≥ |≥ |
#|<b> |boldtext |
#
#NOTE: /r represents line break
#This rendering should be implemented for fonts
#|Font |
#|Helvetica |
#|Times Roman |
#|Times New Roman Embedded |
#
#|Asian Font |
#|Heisei Kaku Gothic W5 |
#|Meiryo |
#|Heisei Mincho W3 |
#
#This rendering should be implemented for blank PDFs, annotated PDFs, data populated PDFs, Rave Monitor Trip Report PDFs.
#This rendering should be implemented for all parts of the PDFs.
#Create 4 forms: lab form, log form, standard form, mixed form. Each form should contain every possible control type. Each form should contain all of
#the special characters as outlined above in at least one field pre-text, the data dictionaries, unit dictionaries, lab units, lab ranges
Background:

Given following PDF Configuration Profile Settings exist
	| Profile Name |
	| US12175PDF1  |
	| US12175PDF2  |
	| US12175PDF3  |
	| US12175PDF4  |
	| US12175PDF5  |
	| US12175PDF6  |
Given study "PDF Font Study" is assigned to Site "Site_001"
And the following Range Types exist
	| Range Type Name                        |
	| &lt &lt; &gt &gt; &le; &ge;Range&le&ge |
And xml Lab Configuration "PDF_Font_Lab_Configuration.xml" is uploaded
Given xml draft "PDF_Font_Study_Draft_1.xml" is Uploaded
Given following Project assignments exist
| User         | Project        | Environment | Role         | Site     | SecurityRole          |
| SUPER USER 1 | PDF Font Study | Live: Prod  | SUPER ROLE 1 | Site_001 | Project Admin Default |
Given following Global Configurations exist
| Name                         |
| US12175_DT8545_Configuration |
Given I publish and push eCRF "PDF_Font_Study_Draft_1.xml" to "Version 1"
Given I login to Rave with user "SUPER USER 1"
And I navigate to "Home"

#*******************************************************************************************************

@release_2012.1.0
@PB_US12175_DT8545_A
@Validation
Scenario: PB_US12175_DT8545_A A blank PDF that is generated should properly display special characters.
An annotated Blank PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                         | Profile     | Study          | Role         | Locale  | CRFVersion |
| Blank PDF A{RndNum<num2>(3)} | US12175PDF1 | PDF Font Study | SUPER ROLE 1 | English | Version 1  |
And I take a screenshot
And I generate Blank PDF "Blank PDF A{Var(num2)}"
And I wait for PDF "Blank PDF A{Var(num2)}" to complete
And I take a screenshot
When I view blank PDF "Baseline.pdf" from request "Blank PDF A{Var(num2)}"
Then I verify the PDF text does not contain
| Data                  |
| &lt                   |
| &lt;                  |
| &gt                   |
| &gt;                  |
| &le;                  |
| &ge;                  |
| &lt;li&gt;            |
| &lt;br/&gt;           |
| <li>                  |
| <br />                |
| &le                   |
| &ge                   |
| < =                   |
| > =                   |
| <b>                   |
| Test1=Test2=Test3=    |
| Test1==Test2==Test3== |
| ==                    |
| ?                     |
And I verify the PDF text contains
| Data |
| <    |
| >    |

@release_2012.1.0
@PB_US12175_DT8545_B
@Validation
Scenario: PB_US12175_DT8545_B A blank PDF that is generated should properly display special characters.
An annotated Blank PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                         | Profile     | Study          | Role         | Locale  | CRFVersion |
| Blank PDF B{RndNum<num3>(3)} | US12175PDF2 | PDF Font Study | SUPER ROLE 1 | English | Version 1  |
And I take a screenshot
And I generate Blank PDF "Blank PDF B{Var(num3)}"
And I wait for PDF "Blank PDF B{Var(num3)}" to complete
And I take a screenshot
When I view blank PDF "Baseline.pdf" from request "Blank PDF B{Var(num3)}"
Then I verify the PDF text does not contain
| Data                  |
| &lt                   |
| &lt;                  |
| &gt                   |
| &gt;                  |
| &le;                  |
| &ge;                  |
| &lt;li&gt;            |
| &lt;br/&gt;           |
| <li>                  |
| <br />                |
| &le                   |
| &ge                   |
| < =                   |
| > =                   |
| <b>                   |
| Test1=Test2=Test3=    |
| Test1==Test2==Test3== |
| ==                    |
| ?                     |
And I verify the PDF text contains
| Data |
| <    |
| >    |

@release_2012.1.0
@PB_US12175_DT8545_C
@Validation
Scenario: PB_US12175_DT8545_C A blank PDF that is generated should properly display special characters.
An annotated Blank PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                         | Profile     | Study          | Role         | Locale  | CRFVersion |
| Blank PDF C{RndNum<num4>(3)} | US12175PDF3 | PDF Font Study | SUPER ROLE 1 | English | Version 1  |
And I take a screenshot
And I generate Blank PDF "Blank PDF C{Var(num4)}"
And I wait for PDF "Blank PDF C{Var(num4)}" to complete
And I take a screenshot
When I view blank PDF "Baseline.pdf" from request "Blank PDF C{Var(num4)}"
Then I verify the PDF text does not contain
| Data                  |
| &lt                   |
| &lt;                  |
| &gt                   |
| &gt;                  |
| &le;                  |
| &ge;                  |
| &lt;li&gt;            |
| &lt;br/&gt;           |
| <li>                  |
| <br />                |
| &le                   |
| &ge                   |
| < =                   |
| > =                   |
| <b>                   |
| Test1=Test2=Test3=    |
| Test1==Test2==Test3== |
| ==                    |
| ?                     |
And I verify the PDF text contains
| Data |
| <    |
| >    |

@release_2012.1.0
@PB_US12175_DT8545_D
@Validation
Scenario: PB_US12175_DT8545_D A blank PDF that is generated should properly display special characters.
An annotated Blank PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                         | Profile     | Study          | Role         | Locale   | CRFVersion |
| Blank PDF D{RndNum<num5>(3)} | US12175PDF4 | PDF Font Study | SUPER ROLE 1 | Japanese | Version 1  |
And I take a screenshot
And I generate Blank PDF "Blank PDF D{Var(num5)}"
And I wait for PDF "Blank PDF D{Var(num5)}" to complete
And I take a screenshot
When I view blank PDF "Baseline.pdf" from request "Blank PDF D{Var(num5)}"
Then I verify the PDF text does not contain
| Data                  |
| &lt                   |
| &lt;                  |
| &gt                   |
| &gt;                  |
| &le;                  |
| &ge;                  |
| &lt;li&gt;            |
| &lt;br/&gt;           |
| <li>                  |
| <br />                |
| &le                   |
| &ge                   |
| < =                   |
| > =                   |
| <b>                   |
| Test1=Test2=Test3=    |
| Test1==Test2==Test3== |
| ==                    |
| ?                     |
And I verify the PDF text contains
| Data |
| <    |
| >    |

@release_2012.1.0
@PB_US12175_DT8545_E
@Validation
Scenario: PB_US12175_DT8545_E A blank PDF that is generated should properly display special characters.
An annotated Blank PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                         | Profile     | Study          | Role         | Locale   | CRFVersion |
| Blank PDF E{RndNum<num6>(3)} | US12175PDF5 | PDF Font Study | SUPER ROLE 1 | Japanese | Version 1  |
And I take a screenshot
And I generate Blank PDF "Blank PDF E{Var(num6)}"
And I wait for PDF "Blank PDF E{Var(num6)}" to complete
And I take a screenshot
When I view blank PDF "Baseline.pdf" from request "Blank PDF E{Var(num6)}"
Then I verify the PDF text does not contain
| Data                  |
| &lt                   |
| &lt;                  |
| &gt                   |
| &gt;                  |
| &le;                  |
| &ge;                  |
| &lt;li&gt;            |
| &lt;br/&gt;           |
| <li>                  |
| <br />                |
| &le                   |
| &ge                   |
| < =                   |
| > =                   |
| <b>                   |
| Test1=Test2=Test3=    |
| Test1==Test2==Test3== |
| ==                    |
| ?                     |
And I verify the PDF text contains
| Data |
| <    |
| >    |

@release_2012.1.0
@PB_US12175_DT8545_F
@Validation
Scenario: PB_US12175_DT8545_F A data-populated PDF that is generated should properly display special characters
An annotated Data PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

And I create a Subject
 | Field      | Data               | Control Type |
 | Subject ID | S{RndNum<num1>(3)} | textbox      |
And I select link "< < > > ≤ ≥ •\brPDF Folder &le &ge"
And I select link "< < > > ≤ ≥ •\brPDF Standard Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 01 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata1&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br Field&le &ge              | &le &geaaaaaaaaaa123&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br Radio Button\rField< < > > ≤ ≥ •          | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton Vertical |
| &le &geSearch\rField< < > > ≤ ≥ •\br                 | <>≤ ≥DD2                                                           |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Log Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 02 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata2&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gebbbbbbbbbb456&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;1                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | <>≤ ≥DD2                                                           |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Mixed Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 03 25 1995                                                         |                                                 | DateTime             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata3&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gecccccccccc789&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | Long Text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | Long Text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | Long Text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "PDF Unbold Form"
And I enter data in CRF and save
| Field     | Data                                                               | Control Type |
| LongText1 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                        | Long Text    |
| LongText2 | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] | Long Text    |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Lab Form &le &ge"
And I select Lab "&le&geLab&lt &lt; &gt &gt; &le; &ge;"
And I enter data in CRF and save
| Field                            | Data | Control Type |
| &le&ge\brWBC< < > > ≤ ≥•         | 20   | textbox      |
| < < > > ≤ ≥•\brNEUTROPHILS&le&ge | 45   | textbox      |
And I take a screenshot
And I navigate to "PDF Generator" module
When I create Data PDF
| Name                        | Profile     | Study          | Role         | Locale  | Site Groups | Sites    | Subjects     |
| Data PDF A{RndNum<num7>(3)} | US12175PDF6 | PDF Font Study | SUPER ROLE 1 | English | World       | Site_001 | S{Var(num1)} |
And I take a screenshot
And I generate Data PDF "Data PDF A{Var(num7)}"
And I wait for PDF "Data PDF A{Var(num7)}" to complete
And I take a screenshot
When I view data PDF "S{Var(num1)}.pdf" from request "Data PDF A{Var(num7)}"
Then I verify the PDF text does not contain
| Data                  |
| &lt                   |
| &lt;                  |
| &gt                   |
| &gt;                  |
| &le;                  |
| &ge;                  |
| &lt;li&gt;            |
| &lt;br/&gt;           |
| <li>                  |
| <br />                |
| &le                   |
| &ge                   |
| < =                   |
| > =                   |
| <b>                   |
| Test1=Test2=Test3=    |
| Test1==Test2==Test3== |
| ==                    |
| ?                     |
And I verify the PDF text contains
| Data |
| <    |
| >    |


@release_2012.1.0
@PB_US12175_DT8545_G
@Validation
Scenario: PB_US12175_DT8545_G A data-populated PDF that is generated should properly display special characters
An annotated Data PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

And I create a Subject
 | Field      | Data               | Control Type |
 | Subject ID | S{RndNum<num1>(3)} | textbox      |
And I select link "< < > > ≤ ≥ •\brPDF Folder &le &ge"
And I select link "< < > > ≤ ≥ •\brPDF Standard Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 01 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata1&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br Field&le &ge              | &le &geaaaaaaaaaa123&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br Radio Button\rField< < > > ≤ ≥ •          | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton Vertical |
| &le &geSearch\rField< < > > ≤ ≥ •\br                 | <>≤ ≥DD2                                                           |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Log Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 02 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata2&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gebbbbbbbbbb456&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;1                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | <>≤ ≥DD2                                                           |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Mixed Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 03 25 1995                                                         |                                                 | DateTime             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata3&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gecccccccccc789&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | Long Text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | Long Text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | Long Text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "PDF Unbold Form"
And I enter data in CRF and save
| Field     | Data                                                               | Control Type |
| LongText1 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                        | Long Text    |
| LongText2 | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] | Long Text    |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Lab Form &le &ge"
And I select Lab "&le&geLab&lt &lt; &gt &gt; &le; &ge;"
And I enter data in CRF and save
| Field                            | Data | Control Type |
| &le&ge\brWBC< < > > ≤ ≥•         | 20   | textbox      |
| < < > > ≤ ≥•\brNEUTROPHILS&le&ge | 45   | textbox      |
And I take a screenshot
And I navigate to "PDF Generator" module
When I create Data PDF
| Name                        | Profile     | Study          | Role         | Locale  | Site Groups | Sites    | Subjects     |
| Data PDF B{RndNum<num8>(3)} | US12175PDF2 | PDF Font Study | SUPER ROLE 1 | English | World       | Site_001 | S{Var(num1)} |
And I take a screenshot
And I generate Data PDF "Data PDF B{Var(num8)}"
And I wait for PDF "Data PDF B{Var(num8)}" to complete
And I take a screenshot
When I view data PDF "S{Var(num1)}.pdf" from request "Data PDF B{Var(num8)}"
Then I verify the PDF text does not contain
| Data                  |
| &lt                   |
| &lt;                  |
| &gt                   |
| &gt;                  |
| &le;                  |
| &ge;                  |
| &lt;li&gt;            |
| &lt;br/&gt;           |
| <li>                  |
| <br />                |
| &le                   |
| &ge                   |
| < =                   |
| > =                   |
| <b>                   |
| Test1=Test2=Test3=    |
| Test1==Test2==Test3== |
| ==                    |
| ?                     |
And I verify the PDF text contains
| Data |
| <    |
| >    |

@release_2013.2.0
@MCC-59855
@PB_US12175_DT8545_H
@Validation
Scenario: PB_US12175_DT8545_H A data-populated PDF that is generated should properly display special characters
An annotated Data PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms
Carriage return should display correctly on the data PDF when Bold font is used in Field Label.
Data PDF Generation should complete successfully with angle brackets < > on Markings.

And I create a Subject
 | Field      | Data               | Control Type |
 | Subject ID | S{RndNum<num1>(3)} | textbox      |
And I select link "< < > > ≤ ≥ •\brPDF Folder &le &ge"
And I select link "< < > > ≤ ≥ •\brPDF Standard Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 01 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata1&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br Field&le &ge              | &le &geaaaaaaaaaa123&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br Radio Button\rField< < > > ≤ ≥ •          | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton Vertical |
| &le &geSearch\rField< < > > ≤ ≥ •\br                 | <>≤ ≥DD2                                                           |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
And I add queries
| Field                               | Responder       | Text    |
| &le &ge\br Text\rField< < > > ≤ ≥ • | Marking Group 1 | <Query> |
And I click button "Save"
And I verify Requires Response Query with message "<Query>" is displayed on Field "&le &ge\br Text\rField< < > > ≤ ≥ •"
And I cancel the Query "<Query>" on Field "&le &ge\br Text\rField< < > > ≤ ≥ •"
And I click button "Save"
And I verify Query with message "<Query>" is not displayed on Field "&le &ge\br Text\rField< < > > ≤ ≥ •"
And I add queries
| Field                               | Responder       | Text    |
| &le &ge\br Text\rField< < > > ≤ ≥ • | Marking Group 1 | <Query> |
And I click button "Save"
And I verify Requires Response Query with message "<Query>" is displayed on Field "&le &ge\br Text\rField< < > > ≤ ≥ •"
And I add stickies
| Field           | Responder       | Text     |
| Long Text Field | Marking Group 1 | <Sticky> |
And I click button "Save"
And I verify Sticky with message "<Sticky>" is displayed on Field "Long Text Field"
And I add protocol deviations
| Field                               | Text | Code | Class |
| < < > > ≤ ≥ •\br Date\rField&le &ge | <PD> | A    | 10    |
And I click button "Save"
And I verify Protocol Deviation with message "<PD>" is displayed on Field "< < > > ≤ ≥ •\br Date\rField&le &ge"
And I click audit on Field "< < > > ≤ ≥ •\br DropDown\rField1&le &ge"
And I add comment "<Comment>"
And I verify Comment with message "<Comment>" is displayed on Field "< < > > ≤ ≥ •\br DropDown\rField1&le &ge"
And I select link "S{Var(num1)}" in "Header"
And I select link "< < > > ≤ ≥ •\brPDF Folder &le &ge"
And I select link "< < > > ≤ ≥ •\brPDF Standard Form &le &ge"
And I enter data in CRF and save
| Field                                    | Data         | Control Type |
| < < > > ≤ ≥ •\br Signature\rField&le &ge | SUPER USER 1 | Signature    |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Log Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 02 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata2&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gebbbbbbbbbb456&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;1                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | <>≤ ≥DD2                                                           |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
And I click button "Save"
And I open log line 1
And I add queries
| Field                                    | Responder       | Text    |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge | Marking Group 1 | <Query> |
And I click button "Save"
And I open log line 1
And I verify Requires Response Query with message "<Query>" is displayed on Field "< < > > ≤ ≥ •\br DropDown\rField2&le &ge"
And I add stickies
| Field                                    | Responder       | Text     |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge | Marking Group 1 | <Sticky> |
And I click button "Save"
And I open log line 1
And I verify Sticky with message "<Sticky>" is displayed on Field "Long\rText< < > > ≤ ≥ •\br  Field&le &ge"
And I add protocol deviations
| Field           | Text | Code | Class |
| Long Text Field | <PD> | A    | 10    |
And I click button "Save"
And I open log line 1
And I verify Protocol Deviation with message "<PD>" is displayed on Field "Long Text Field"
And I click audit on Field "< < > > ≤ ≥ •\br Text\rField1&le &ge"
And I add comment "<Comment>"
And I open log line 1
And I verify Comment with message "<Comment>" is displayed on Field "< < > > ≤ ≥ •\br Text\rField1&le &ge"
And I select link "S{Var(num1)}" in "Header"
And I select link "< < > > ≤ ≥ •\brPDF Folder &le &ge"
And I select link "< < > > ≤ ≥ •\brPDF Log Form &le &ge"
And I enter data in CRF and save
| Field                                    | Data         | Control Type |
| < < > > ≤ ≥ •\br Signature\rField&le &ge | SUPER USER 1 | Signature    |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Mixed Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 03 25 1995                                                         |                                                 | DateTime             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata3&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gecccccccccc789&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | Long Text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | Long Text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | Long Text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
And I open log line 1
And I add queries
| Field                                | Responder       | Text    |
| < < > > ≤ ≥ •\br Text\rField2&le &ge | Marking Group 1 | <Query> |
And I click button "Save"
And I open log line 1
And I verify Requires Response Query with message "<Query>" is displayed on Field "< < > > ≤ ≥ •\br Text\rField2&le &ge"
And I add stickies
| Field                              | Responder       | Text     |
| < < > > ≤ ≥ •\br DSL\rField&le &ge | Marking Group 1 | <Sticky> |
And I click button "Save"
And I open log line 1
And I verify Sticky with message "<Sticky>" is displayed on Field "< < > > ≤ ≥ •\br DSL\rField&le &ge"
And I add protocol deviations
| Field                                        | Text | Code | Class |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ • | <PD> | A    | 10    |
And I click button "Save"
And I open log line 1
And I verify Protocol Deviation with message "<PD>" is displayed on Field "&le &ge\br  Radio Button\rField< < > > ≤ ≥ •"
And I click audit on Field "< < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge"
And I add comment "<Comment>"
And I open log line 1
And I verify Comment with message "<Comment>" is displayed on Field "< < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge"
And I select link "S{Var(num1)}" in "Header"
And I select link "< < > > ≤ ≥ •\brPDF Folder &le &ge"
And I select link "< < > > ≤ ≥ •\brPDF Mixed Form &le &ge"
And I enter data in CRF and save
| Field                                    | Data         | Control Type |
| < < > > ≤ ≥ •\br Signature\rField&le &ge | SUPER USER 1 | Signature    |
And I take a screenshot
And I select link "PDF Unbold Form"
And I enter data in CRF and save
| Field     | Data                                                               | Control Type |
| LongText1 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                        | Long Text    |
| LongText2 | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] | Long Text    |
And I add queries
| Field     | Responder       | Text    |
| LongText1 | Marking Group 1 | <Query> |
And I click button "Save"
And I verify Requires Response Query with message "<Query>" is displayed on Field "LongText1"
And I add stickies
| Field     | Responder       | Text     |
| LongText1 | Marking Group 1 | <Sticky> |
And I click button "Save"
And I verify Sticky with message "<Sticky>" is displayed on Field "LongText1"
And I add protocol deviations
| Field     | Text | Code | Class |
| LongText2 | <PD> | A    | 10    |
And I click button "Save"
And I verify Protocol Deviation with message "<PD>" is displayed on Field "LongText2"
And I click audit on Field "LongText2"
And I add comment "<Comment>"
And I verify Comment with message "<Comment>" is displayed on Field "LongText2"
And I take a screenshot
And I select link "S{Var(num1)}" in "Header"
And I select link "< < > > ≤ ≥ •\brPDF Folder &le &ge"
And I select link "< < > > ≤ ≥ •\brPDF Lab Form &le &ge"
And I select Lab "&le&geLab&lt &lt; &gt &gt; &le; &ge;"
And I enter data in CRF and save
| Field                            | Data | Control Type |
| &le&ge\brWBC< < > > ≤ ≥•         | 20   | textbox      |
| < < > > ≤ ≥•\brNEUTROPHILS&le&ge | 45   | textbox      |
And I add queries
| Field                    | Responder       | Text    |
| &le&ge\brWBC< < > > ≤ ≥• | Marking Group 1 | <Query> |
And I click button "Save"
And I verify Requires Response Query with message "<Query>" is displayed on Field "&le&ge\brWBC< < > > ≤ ≥•"
And I add stickies
| Field                    | Responder       | Text     |
| &le&ge\brWBC< < > > ≤ ≥• | Marking Group 1 | <Sticky> |
And I click button "Save"
And I verify Sticky with message "<Sticky>" is displayed on Field "&le&ge\brWBC< < > > ≤ ≥•"
 And I add protocol deviations
| Field                            | Text | Code | Class |
| < < > > ≤ ≥•\brNEUTROPHILS&le&ge | <PD> | A    | 10    |
And I click button "Save"
And I verify Protocol Deviation with message "<PD>" is displayed on Field "< < > > ≤ ≥•\brNEUTROPHILS&le&ge"
And I click audit on Field "< < > > ≤ ≥•\brNEUTROPHILS&le&ge"
And I add comment "<Comment>"
And I verify Comment with message "<Comment>" is displayed on Field "< < > > ≤ ≥•\brNEUTROPHILS&le&ge"
And I take a screenshot
And I navigate to "PDF Generator" module
When I create Data PDF
| Name                        | Profile     | Study          | Role         | Locale  | Site Groups | Sites    | Subjects     |
| Data PDF C{RndNum<num9>(3)} | US12175PDF3 | PDF Font Study | SUPER ROLE 1 | English | World       | Site_001 | S{Var(num1)} |
And I take a screenshot
And I generate Data PDF "Data PDF C{Var(num9)}"
And I wait for PDF "Data PDF C{Var(num9)}" to complete
And I take a screenshot
When I view data PDF "S{Var(num1)}.pdf" from request "Data PDF C{Var(num9)}"
Then I verify the PDF text does not contain
| Data                  |
| &lt                   |
| &lt;                  |
| &gt                   |
| &gt;                  |
| &le;                  |
| &ge;                  |
| &lt;li&gt;            |
| &lt;br/&gt;           |
| <li>                  |
| <br />                |
| &le                   |
| &ge                   |
| < =                   |
| > =                   |
| <b>                   |
| Test1=Test2=Test3=    |
| Test1==Test2==Test3== |
| ==                    |
| ?                     |
And I verify the PDF text contains
| Data      |
| <         |
| >         |
| <Query>   |
| <PD>      |
| <Comment> |
| <Sticky>  |

@release_2012.1.0
@PB_US12175_DT8545_I
@Validation
Scenario: PB_US12175_DT8545_I A data-populated PDF that is generated should properly display special characters
An annotated Data PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

And I create a Subject
 | Field      | Data               | Control Type |
 | Subject ID | S{RndNum<num1>(3)} | textbox      |
And I select link "< < > > ≤ ≥ •\brPDF Folder &le &ge"
And I select link "< < > > ≤ ≥ •\brPDF Standard Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 01 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata1&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br Field&le &ge              | &le &geaaaaaaaaaa123&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br Radio Button\rField< < > > ≤ ≥ •          | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton Vertical |
| &le &geSearch\rField< < > > ≤ ≥ •\br                 | <>≤ ≥DD2                                                           |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Log Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 02 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata2&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gebbbbbbbbbb456&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;1                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | <>≤ ≥DD2                                                           |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Mixed Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 03 25 1995                                                         |                                                 | DateTime             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata3&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gecccccccccc789&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | Long Text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | Long Text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | Long Text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "PDF Unbold Form"
And I enter data in CRF and save
| Field     | Data                                                               | Control Type |
| LongText1 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                        | Long Text    |
| LongText2 | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] | Long Text    |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Lab Form &le &ge"
And I select Lab "&le&geLab&lt &lt; &gt &gt; &le; &ge;"
And I enter data in CRF and save
| Field                            | Data | Control Type |
| &le&ge\brWBC< < > > ≤ ≥•         | 20   | textbox      |
| < < > > ≤ ≥•\brNEUTROPHILS&le&ge | 45   | textbox      |
And I take a screenshot
And I navigate to "PDF Generator" module
When I create Data PDF
| Name                         | Profile     | Study          | Role         | Locale   | Site Groups | Sites    | Subjects     |
| Data PDF D{RndNum<num10>(3)} | US12175PDF4 | PDF Font Study | SUPER ROLE 1 | Japanese | World       | Site_001 | S{Var(num1)} |
And I take a screenshot
And I generate Data PDF "Data PDF D{Var(num10)}"
And I wait for PDF "Data PDF D{Var(num10)}" to complete
And I take a screenshot
When I view data PDF "S{Var(num1)}.pdf" from request "Data PDF D{Var(num10)}"
Then I verify the PDF text does not contain
| Data                  |
| &lt                   |
| &lt;                  |
| &gt                   |
| &gt;                  |
| &le;                  |
| &ge;                  |
| &lt;li&gt;            |
| &lt;br/&gt;           |
| <li>                  |
| <br />                |
| &le                   |
| &ge                   |
| < =                   |
| > =                   |
| <b>                   |
| Test1=Test2=Test3=    |
| Test1==Test2==Test3== |
| ==                    |
| ?                     |
And I verify the PDF text contains
| Data |
| <    |
| >    |

@release_2012.1.0
@PB_US12175_DT8545_J
@Validation
Scenario: PB_US12175_DT8545_J A data-populated PDF that is generated should properly display special characters
An annotated Data PDF that is generated should properly display special characters.
This should be tested for each possible font combination (english & Japanese fonts)
This should be tested with all 4 forms

And I create a Subject
 | Field      | Data               | Control Type |
 | Subject ID | S{RndNum<num1>(3)} | textbox      |
And I select link "< < > > ≤ ≥ •\brPDF Folder &le &ge"
And I select link "< < > > ≤ ≥ •\brPDF Standard Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 01 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata1&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br Field&le &ge              | &le &geaaaaaaaaaa123&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br Radio Button\rField< < > > ≤ ≥ •          | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton Vertical |
| &le &geSearch\rField< < > > ≤ ≥ •\br                 | <>≤ ≥DD2                                                           |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Log Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 02 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata2&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gebbbbbbbbbb456&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;1                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | <>≤ ≥DD2                                                           |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Mixed Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 03 25 1995                                                         |                                                 | DateTime             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata3&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gecccccccccc789&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | Long Text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | Long Text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | Long Text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "PDF Unbold Form"
And I enter data in CRF and save
| Field     | Data                                                               | Control Type |
| LongText1 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                        | Long Text    |
| LongText2 | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] | Long Text    |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Lab Form &le &ge"
And I select Lab "&le&geLab&lt &lt; &gt &gt; &le; &ge;"
And I enter data in CRF and save
| Field                            | Data | Control Type |
| &le&ge\brWBC< < > > ≤ ≥•         | 20   | textbox      |
| < < > > ≤ ≥•\brNEUTROPHILS&le&ge | 45   | textbox      |
And I take a screenshot
And I navigate to "PDF Generator" module
When I create Data PDF
| Name                         | Profile     | Study          | Role         | Locale   | Site Groups | Sites    | Subjects     |
| Data PDF E{RndNum<num11>(3)} | US12175PDF5 | PDF Font Study | SUPER ROLE 1 | Japanese | World       | Site_001 | S{Var(num1)} |
And I take a screenshot
And I generate Data PDF "Data PDF E{Var(num11)}"
And I wait for PDF "Data PDF E{Var(num11)}" to complete
And I take a screenshot
When I view data PDF "S{Var(num1)}.pdf" from request "Data PDF E{Var(num11)}"
Then I verify the PDF text does not contain
| Data                  |
| &lt                   |
| &lt;                  |
| &gt                   |
| &gt;                  |
| &le;                  |
| &ge;                  |
| &lt;li&gt;            |
| &lt;br/&gt;           |
| <li>                  |
| <br />                |
| &le                   |
| &ge                   |
| < =                   |
| > =                   |
| <b>                   |
| Test1=Test2=Test3=    |
| Test1==Test2==Test3== |
| ==                    |
| ?                     |
And I verify the PDF text contains
| Data |
| <    |
| >    |

@release_2012.1.0
@PB_US12175_DT8545_K
@Validation
Scenario: PB_US12175_DT8545_K A data-populated PDF that is generated should properly display special characters
An annotated Data PDF that is generated should properly display special characters.
Carriage return should display correctly on the data PDF when Bold font is used in Field Label.

And I create a Subject
 | Field      | Data               | Control Type |
 | Subject ID | S{RndNum<num1>(3)} | textbox      |
And I select link "< < > > ≤ ≥ •\brPDF Folder &le &ge"
And I select link "< < > > ≤ ≥ •\brPDF Standard Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 01 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata1&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br Field&le &ge              | &le &geaaaaaaaaaa123&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br Radio Button\rField< < > > ≤ ≥ •          | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton Vertical |
| &le &geSearch\rField< < > > ≤ ≥ •\br                 | <>≤ ≥DD2                                                           |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Log Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 02 25 1995                                                         |                                                 | DateTime             |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata2&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gebbbbbbbbbb456&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | long text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | long text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | long text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;1                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | <>≤ ≥DD2                                                           |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Mixed Form &le &ge"
And I enter data in CRF and save
| Field                                                | Data                                                               | AdditionalData                                  | Control Type         |
| < < > > ≤ ≥ •\br Date\rField&le &ge                  | 03 25 1995                                                         |                                                 | DateTime             |
| &le &ge\br Text\rField< < > > ≤ ≥ •                  | &le &gedata3&lt &lt; &gt &gt; &le; &ge;<li></li>                   |                                                 | textbox              |
| < < > > ≤ ≥ •\br DropDown\rField1&le &ge             | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Dropdown             |
| < < > > ≤ ≥ •\br DropDown\rField2&le &ge             | <>≤ ≥DD2                                                           |                                                 | Dropdown             |
| Long\rText< < > > ≤ ≥ •\br  Field&le &ge             | &le &gecccccccccc789&lt &lt; &gt &gt; &le; &ge;<li></li>           |                                                 | Long Text            |
| \bLongText Field\\/b                                 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                   |                                                 | Long Text            |
| Long Text Field                                      | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] |                                                 | Long Text            |
| < < > > ≤ ≥ •\br Text\rField1&le &ge                 | 1.1                                                                | &lt &lt; &gt &gt; &le; &ge; <li></li>UD1&le &ge | textbox              |
| < < > > ≤ ≥ •\br Text\rField2&le &ge                 | 2.2                                                                | <>≤ ≥UD2                                        | textbox              |
| < < > > ≤ ≥ •\br DSL\rField&le &ge                   | &le&ge&lt &lt; &gt &gt; &le; &ge;0                                 |                                                 | Dynamic Search List  |
| &le &ge\br  Radio Button\rField< < > > ≤ ≥ •         | < < > > ≤ ≥ •DD1&le &ge                                            |                                                 | RadioButton          |
| < < > > ≤ ≥ •\br Radio Button Vertical\rField&le &ge | <>≤ ≥DD2                                                           |                                                 | RadioButton Vertical |
| &le &ge\br Search\rField< < > > ≤ ≥ •                | &lt &lt; &gt &gt; &le; &ge; <li></li>DD1&le &ge                    |                                                 | Search List          |
| < < > > ≤ ≥ •\br CheckBox\rField1&le &ge             | true                                                               |                                                 | CheckBox             |
| < < > > ≤ ≥ •\br Signature\rField&le &ge             | SUPER USER 1                                                       |                                                 | Signature            |
And I take a screenshot
And I select link "PDF Unbold Form"
And I enter data in CRF and save
| Field     | Data                                                               | Control Type |
| LongText1 | Test1[cmd:enter]Test2[cmd:enter]Test3[cmd:enter]                        | Long Text    |
| LongText2 | Test1[cmd:shift+enter]Test2[cmd:shift+enter]Test3[cmd:shift+enter] | Long Text    |
And I take a screenshot
And I select link "< < > > ≤ ≥ •\brPDF Lab Form &le &ge"
And I select Lab "&le&geLab&lt &lt; &gt &gt; &le; &ge;"
And I enter data in CRF and save
| Field                            | Data | Control Type |
| &le&ge\brWBC< < > > ≤ ≥•         | 20   | textbox      |
| < < > > ≤ ≥•\brNEUTROPHILS&le&ge | 45   | textbox      |
And I take a screenshot
And I navigate to "PDF Generator" module
When I create Data PDF
| Name                         | Profile     | Study          | Role         | Locale  | Site Groups | Sites    | Subjects     |
| Data PDF F{RndNum<num12>(3)} | US12175PDF6 | PDF Font Study | SUPER ROLE 1 | English | World       | Site_001 | S{Var(num1)} |
And I take a screenshot
And I generate Data PDF "Data PDF F{Var(num12)}"
And I wait for PDF "Data PDF F{Var(num12)}" to complete
And I take a screenshot
When I view data PDF "S{Var(num1)}.pdf" from request "Data PDF F{Var(num12)}"
Then I verify the PDF text does not contain
| Data                  |
| &lt                   |
| &lt;                  |
| &gt                   |
| &gt;                  |
| &le;                  |
| &ge;                  |
| &lt;li&gt;            |
| &lt;br/&gt;           |
| <li>                  |
| <br />                |
| &le                   |
| &ge                   |
| < =                   |
| > =                   |
| <b>                   |
| Test1=Test2=Test3=    |
| Test1==Test2==Test3== |
| ==                    |
| ?                     |
And I verify the PDF text contains
| Data |
| <    |
| >    |