@MCC-46591

Feature: MCC-46591 Log Lines in Blank/Blank Annotated PDFs are not displayed.

#Note: Known DT12954 - Annotated PDFs cannot display all dictionary entries for Dictionaries with a large Number of Entries

Background:

Given I login to Rave with user "SUPER USER 1"
Given xml draft "BlankPDF Study.xml" is Uploaded
Given study "BlankPDF Study" is assigned to Site "SiteA"
Given following PDF Configuration Profile Settings exist
	| Profile Name |
	| MCC46591PDF1 |
	| MCC46591PDF2 |
	| MCC46591PDF3 |
Given following Project assignments exist
| User             | Project        | Environment | Role            | Site  | SecurityRole          |
| SUPER USER 1     | BlankPDF Study | Live: Prod  | SUPER ROLE 1    | SiteA | Project Admin Default |
Given I publish and push eCRF "BlankPDF Study.xml" to "Version 1"

#Note: 1) Adverse Events1 - log form without default values in Landscape direction 
#Note: 2) Adverse Events2 - log form without default values in Portrait direction 
#Note: 3) Adverse Events3 - mixed form without default values in Landscape direction
#Note: 4) Adverse Events4 - mixed form without default values in Portrait direction 
#Note: 5) Demographics1 - standard form without default values
#Note: 6) Demographics2 - standard form with default values
#Note: 7) Medical History1 - log form with default values in Portrait direction
#Note: 8) Medical History2 - log form with default values in Landscape direction 
#Note: 9) Medical History3 - mixed form with default values in Portrait direction
#Note: 10) Medical History4 - mixed form with default values in Landscape direction

#Note: 1) MCC46591PDF1 - PDF Configuration Profile with default settings
#Note: 2) MCC46591PDF2 - PDF Configuration Profile with Annotations (Field Label, Data Type, Values, Pre-Filled Values and Include Field OID)
#Note: 3) MCC46591PDF3 - PDF Configuration Profile with Annotations (Field Label, Units, Values, Pre-Filled Values and Include Field OID)
 

@Release_2013.1.0
@PBMCC46591-001
@RR24.JAN.2013
@Validation
Scenario: MCC46591-001 Verify log form without default values in Landscape direction display all log lines on blank PDF with default PDF Configuration Profile (MCC46591PDF1).

#Given I have a log form without default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all log lines in the form on PDF

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                            | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankA{RndNum<num2>(3)} | MCC46591PDF1 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankA{Var(num2)}"
And I wait for PDF "MCC46591BlankA{Var(num2)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankA{Var(num2)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken (1)               |
| Action taken (2)               |
| Action taken (3)               |
| Action taken (4)               |
| Action taken (5)               |
| Action taken (6)               |
| Action taken (7)               |
| Action taken (8)               |
| Duration                       |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events1 |

@Release_2013.1.0
@PBMCC46591-002
@RR24.JAN.2013
@Validation
Scenario: MCC46591-002 Verify log form without default values in Portrait direction display all log lines on blank PDF with default PDF Configuration Profile (MCC46591PDF1).

#Given I have a log form without default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all log lines in the form on PDF

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                            | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankB{RndNum<num3>(3)} | MCC46591PDF1 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankB{Var(num3)}"
And I wait for PDF "MCC46591BlankB{Var(num3)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankB{Var(num3)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken (1)               |
| Action taken (2)               |
| Action taken (3)               |
| Action taken (4)               |
| Action taken (5)               |
| Action taken (6)               |
| Action taken (7)               |
| Action taken (8)               |
| Duration                       |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events2 |

@Release_2013.1.0
@PBMCC46591-003
@RR24.JAN.2013
@Validation
Scenario: MCC46591-003 Verify mixed form without default values in Landscape direction display all fields standard and log on blank PDF with default PDF Configuration Profile (MCC46591PDF1).

#Given I have a mixed form without default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log in the form on PDF

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                            | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankC{RndNum<num4>(3)} | MCC46591PDF1 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankC{Var(num4)}"
And I wait for PDF "MCC46591BlankC{Var(num4)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankC{Var(num4)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken                   |
| Duration                       |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events3 |

@Release_2013.1.0
@PBMCC46591-004
@RR24.JAN.2013
@Validation
Scenario: MCC46591-004 Verify mixed form without default values in Portrait direction display all fields standard and log on blank PDF with default PDF Configuration Profile (MCC46591PDF1).

#Given I have a mixed form without default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log in the form on PDF

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                            | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankD{RndNum<num5>(3)} | MCC46591PDF1 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankD{Var(num5)}"
And I wait for PDF "MCC46591BlankD{Var(num5)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankD{Var(num5)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken                   |
| Duration                       |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events4 |

@Release_2013.1.0
@PBMCC46591-005
@RR24.JAN.2013
@Validation
Scenario: MCC46591-005 Verify standard form without default values display all fields on blank PDF with default PDF Configuration Profile (MCC46591PDF1).

#Given I have a standard form
#When I create, generate and view a blank pdf
#Then I should see all fields on blank PDF

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                            | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                           |
| MCC46591BlankE{RndNum<num6>(3)} | MCC46591PDF1 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankE{Var(num6)}"
And I wait for PDF "MCC46591BlankE{Var(num6)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankE{Var(num6)}"
Then the PDF text should contain
| Text          |
| Date of Birth |
| Ethnicity     |
| Specify race  |
| Gender        |
Then I verify PDF bookmarks exist
| Bookmark Text |
| Demographics1 |

@Release_2013.1.0
@PBMCC46591-006
@RR24.JAN.2013
Scenario: MCC46591-006 Verify log form without default values in Landscape direction display all log lines on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF2).

#Given I have a log form without default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all log lines in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                            | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankF{RndNum<num7>(3)} | MCC46591PDF2 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankF{Var(num7)}"
And I wait for PDF "MCC46591BlankF{Var(num7)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankF{Var(num7)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken (1)               |
| Action taken (2)               |
| Action taken (3)               |
| Action taken (4)               |
| Action taken (5)               |
| Action taken (6)               |
| Action taken (7)               |
| Action taken (8)               |
| Duration                       |
| Field Name                     |
| Data Type                      |
| Field Label                    |
| Values                         |
| Pre-Filled Values              |
| Include Field OID              |
| AE_INDIC                       |
| AEVERB                         |
| STARTDT                        |
| STOPDT                         |
| CONTINUE                       |
| SERIOUSCD                      |
| RELATEDCD                      |
| ACTIONCD1                      |
| ACTIONCD2                      |
| ACTIONCD3                      |
| ACTIONCD4                      |
| ACTIONCD5                      |
| ACTIONCD6                      |
| ACTIONCD7                      |
| ACTIONCD8                      |
| AE_DURATION                    |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events1 |
| Annotations     |

@Release_2013.1.0
@PBMCC46591-007
@RR24.JAN.2013
@Validation
Scenario: MCC46591-007 Verify log form without default values in Portrait direction display all log lines on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF2).

#Given I have a log form without default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all log lines in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                            | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankG{RndNum<num8>(3)} | MCC46591PDF2 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankG{Var(num8)}"
And I wait for PDF "MCC46591BlankG{Var(num8)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankG{Var(num8)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken (1)               |
| Action taken (2)               |
| Action taken (3)               |
| Action taken (4)               |
| Action taken (5)               |
| Action taken (6)               |
| Action taken (7)               |
| Action taken (8)               |
| Duration                       |
| Field Name                     |
| Data Type                      |
| Field Label                    |
| Values                         |
| Pre-Filled Values              |
| Include Field OID              |
| AE_INDIC2                      |
| AEVERB2                        |
| STARTDT2                       |
| STOPDT2                        |
| CONTINUE2                      |
| SERIOUSCD2                     |
| RELATEDCD2                     |
| ACTIONCD1A                     |
| ACTIONCD2A                     |
| ACTIONCD3A                     |
| ACTIONCD4A                     |
| ACTIONCD5A                     |
| ACTIONCD6A                     |
| ACTIONCD7A                     |
| ACTIONCD8A                     |
| AE_DURATION2                   |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events2 |
| Annotations     |

@Release_2013.1.0
@PBMCC46591-008
@RR24.JAN.2013
@Validation
Scenario: MCC46591-008 Verify mixed form without default values in Landscape direction display all fields standard and log on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF2).

#Given I have a mixed form without default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                            | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankH{RndNum<num9>(3)} | MCC46591PDF2 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankH{Var(num9)}"
And I wait for PDF "MCC46591BlankH{Var(num9)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankH{Var(num9)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken                   |
| Duration                       |
| Field Name                     |
| Data Type                      |
| Field Label                    |
| Values                         |
| Pre-Filled Values              |
| Include Field OID              |
| AE_INDIC3                      |
| AEVERB3                        |
| STARTDT3                       |
| STOPDT3                        |
| CONTINUE3                      |
| SERIOUSCD3                     |
| RELATEDCD3                     |
| ACTIONCD                       |
| AE_DURATION3                   |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events3 |
| Annotations     |

@Release_2013.1.0
@PBMCC46591-009
@RR24.JAN.2013
@Validation
Scenario: MCC46591-009 Verify mixed form without default values in Portrait direction display all fields standard and log on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF2).

#Given I have a mixed form without default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankI{RndNum<num10>(3)} | MCC46591PDF2 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankI{Var(num10)}"
And I wait for PDF "MCC46591BlankI{Var(num10)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankI{Var(num10)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken                   |
| Duration                       |
| Field Name                     |
| Data Type                      |
| Field Label                    |
| Values                         |
| Pre-Filled Values              |
| Include Field OID              |
| AE_INDIC4                      |
| AEVERB4                        |
| STARTDT4                       |
| STOPDT4                        |
| CONTINUE4                      |
| SERIOUSCD4                     |
| RELATEDCD4                     |
| ACTIONCDA                      |
| AE_DURATION4                   |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events4 |
| Annotations     |

@Release_2013.1.0
@PBMCC46591-010
@RR24.JAN.2013
@Validation
Scenario: MCC46591-010 Verify standard form without default values display all fields on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF2).

#Given I have a standard form
#When I create, generate and view a blank pdf
#Then I should see all fields on blank PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                           |
| MCC46591BlankJ{RndNum<num11>(3)} | MCC46591PDF2 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankJ{Var(num11)}"
And I wait for PDF "MCC46591BlankJ{Var(num11)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankJ{Var(num11)}"
Then the PDF text should contain
| Text              |
| Date of Birth     |
| Ethnicity         |
| Specify race      |
| Gender            |
| Field Name        |
| Data Type         |
| Field Label       |
| Values            |
| Pre-Filled Values |
| Include Field OID |
| BIRTHDT           |
| RACE1             |
| SPECIFY           |
| GENDER3           |
Then I verify PDF bookmarks exist
| Bookmark Text |
| Demographics1 |
| Annotations   |

@Release_2013.1.0
@PBMCC46591-011
@RR24.JAN.2013
@Validation
Scenario: MCC46591-011 Verify log form without default values in Landscape direction display all log lines on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF3).

#Given I have a log form without default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all log lines in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankK{RndNum<num12>(3)} | MCC46591PDF3 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankK{Var(num12)}"
And I wait for PDF "MCC46591BlankK{Var(num12)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankK{Var(num12)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken (1)               |
| Action taken (2)               |
| Action taken (3)               |
| Action taken (4)               |
| Action taken (5)               |
| Action taken (6)               |
| Action taken (7)               |
| Action taken (8)               |
| Duration                       |
| Field Name                     |
| Field Label                    |
| Units                          |
| Values                         |
| Pre-Filled Values              |
| Include Field OID              |
| AE_INDIC                       |
| AEVERB                         |
| STARTDT                        |
| STOPDT                         |
| CONTINUE                       |
| SERIOUSCD                      |
| RELATEDCD                      |
| ACTIONCD1                      |
| ACTIONCD2                      |
| ACTIONCD3                      |
| ACTIONCD4                      |
| ACTIONCD5                      |
| ACTIONCD6                      |
| ACTIONCD7                      |
| ACTIONCD8                      |
| AE_DURATION                    |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events1 |
| Annotations     |

@Release_2013.1.0
@PBMCC46591-012
@RR24.JAN.2013
@Validation
Scenario: MCC46591-012 Verify log form without default values in Portrait direction display all log lines on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF3).

#Given I have a log form without default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all log lines in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankL{RndNum<num13>(3)} | MCC46591PDF3 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankL{Var(num13)}"
And I wait for PDF "MCC46591BlankL{Var(num13)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankL{Var(num13)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken (1)               |
| Action taken (2)               |
| Action taken (3)               |
| Action taken (4)               |
| Action taken (5)               |
| Action taken (6)               |
| Action taken (7)               |
| Action taken (8)               |
| Duration                       |
| Field Name                     |
| Field Label                    |
| Units                          |
| Values                         |
| Pre-Filled Values              |
| Include Field OID              |
| AE_INDIC2                      |
| AEVERB2                        |
| STARTDT2                       |
| STOPDT2                        |
| CONTINUE2                      |
| SERIOUSCD2                     |
| RELATEDCD2                     |
| ACTIONCD1A                     |
| ACTIONCD2A                     |
| ACTIONCD3A                     |
| ACTIONCD4A                     |
| ACTIONCD5A                     |
| ACTIONCD6A                     |
| ACTIONCD7A                     |
| ACTIONCD8A                     |
| AE_DURATION2                   |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events2 |
| Annotations     |

@Release_2013.1.0
@PBMCC46591-013
@RR24.JAN.2013
@Validation
Scenario: MCC46591-013 Verify mixed form without default values in Landscape direction display all fields standard and log on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF3).

#Given I have a mixed form without default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankM{RndNum<num14>(3)} | MCC46591PDF3 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankM{Var(num14)}"
And I wait for PDF "MCC46591BlankM{Var(num14)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankM{Var(num14)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken                   |
| Duration                       |
| Field Name                     |
| Field Label                    |
| Units                          |
| Values                         |
| Pre-Filled Values              |
| Include Field OID              |
| AE_INDIC3                      |
| AEVERB3                        |
| STARTDT3                       |
| STOPDT3                        |
| CONTINUE3                      |
| SERIOUSCD3                     |
| RELATEDCD3                     |
| ACTIONCD                       |
| AE_DURATION3                   |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events3 |
| Annotations     |

@Release_2013.1.0
@PBMCC46591-014
@RR24.JAN.2013
@Validation
Scenario: MCC46591-014 Verify mixed form without default values in Portrait direction display all fields standard and log on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF3).

#Given I have a mixed form without default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                         |
| MCC46591BlankN{RndNum<num15>(3)} | MCC46591PDF3 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankN{Var(num15)}"
And I wait for PDF "MCC46591BlankN{Var(num15)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankN{Var(num15)}"
Then the PDF text should contain
| Text                           |
| Were there any adverse events? |
| Adverse Event Description      |
| Start Date                     |
| Stop Date                      |
| Continuing?                    |
| Serious adverse event?         |
| Related to study drug?         |
| Action taken                   |
| Duration                       |
| Field Name                     |
| Field Label                    |
| Units                          |
| Values                         |
| Pre-Filled Values              |
| Include Field OID              |
| AE_INDIC4                      |
| AEVERB4                        |
| STARTDT4                       |
| STOPDT4                        |
| CONTINUE4                      |
| SERIOUSCD4                     |
| RELATEDCD4                     |
| ACTIONCDA                      |
| AE_DURATION4                   |
Then I verify PDF bookmarks exist
| Bookmark Text   |
| Adverse Events4 |
| Annotations     |

@Release_2013.1.0
@PBMCC46591-015
@RR24.JAN.2013
@Validation
Scenario: MCC46591-015 Verify standard form without default values display all fields on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF3).

#Given I have a standard form
#When I create, generate and view a blank pdf
#Then I should see all fields on blank PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                           |
| MCC46591BlankO{RndNum<num16>(3)} | MCC46591PDF3 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics2, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankO{Var(num16)}"
And I wait for PDF "MCC46591BlankO{Var(num16)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankO{Var(num16)}"
Then the PDF text should contain
| Text              |
| Date of Birth     |
| Ethnicity         |
| Specify race      |
| Gender            |
| Field Name        |
| Field Label       |
| Units             |
| Values            |
| Pre-Filled Values |
| Include Field OID |
| BIRTHDT           |
| RACE1             |
| SPECIFY           |
| GENDER3           |
Then I verify PDF bookmarks exist
| Bookmark Text |
| Demographics1 |
| Annotations   |
#Then the PDF page "6" contains
#| Text          |
#| Date of Birth |
#| Ethnicity     |
#| Specify race  |
#| Gender        |
#Then the PDF page "7" contains
#| Text              |
#| Field Name        |
#| Field Label       |
#| Units             |
#| Values            |
#| Pre-Filled Values |
#| Include Field OID |
#| BIRTHDT           |
#| RACE1             |
#| SPECIFY           |
#| GENDER3           |

@Release_2013.1.0
@PBMCC46591-016
@RR24.JAN.2013
@Validation
Scenario: MCC46591-016 Verify log form with default values in Portrait direction display all log lines with default values on blank PDF with default PDF Configuration Profile (MCC46591PDF1).

#Given I have a log form with default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all log lines with default values in the form on PDF

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankP{RndNum<num17>(3)} | MCC46591PDF1 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History2, Medical History3, Medical History4 | 
And I take a screenshot
And I generate Blank PDF "MCC46591BlankP{Var(num17)}"
And I wait for PDF "MCC46591BlankP{Var(num17)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankP{Var(num17)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History1 |

@Release_2013.1.0
@PBMCC46591-017
@RR24.JAN.2013
@Validation
Scenario: MCC46591-017 Verify log form with default values in Landscape direction display all log lines with default values on blank PDF with default PDF Configuration Profile (MCC46591PDF1).

#Given I have a log form with default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all log lines with default values in the form on PDF

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankQ{RndNum<num18>(3)} | MCC46591PDF1 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankQ{Var(num18)}"
And I wait for PDF "MCC46591BlankQ{Var(num18)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankQ{Var(num18)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History2 |

@Release_2013.1.0
@PBMCC46591-018
@RR24.JAN.2013
@Validation
Scenario: MCC46591-018 Verify log form with default values in Portrait direction display all log lines with default values on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF2).

#Given I have a log form with default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all log lines with default values in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankR{RndNum<num19>(3)} | MCC46591PDF2 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankR{Var(num19)}"
And I wait for PDF "MCC46591BlankR{Var(num19)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankR{Var(num19)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| Field Name            |
| Data Type             |
| Field Label           |
| Values                |
| Pre-Filled Values     |
| Include Field OID     |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History1 |
| Annotations      |

@Release_2013.1.0
@PBMCC46591-019
@RR24.JAN.2013
@Validation
Scenario: MCC46591-019 Verify log form with default values in Landscape direction display all log lines with default values on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF2).

#Given I have a log form with default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all log lines with default values in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankS{RndNum<num20>(3)} | MCC46591PDF2 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankS{Var(num20)}"
And I wait for PDF "MCC46591BlankS{Var(num20)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankS{Var(num20)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| Field Name            |
| Data Type             |
| Field Label           |
| Values                |
| Pre-Filled Values     |
| Include Field OID     |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History2 |
| Annotations      |

@Release_2013.1.0
@PBMCC46591-020
@RR24.JAN.2013
@Validation
Scenario: MCC46591-020 Verify log form with default values in Portrait direction display all log lines with default values on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF3).

#Given I have a log form with default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all log lines with default values in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankT{RndNum<num21>(3)} | MCC46591PDF3 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankT{Var(num21)}"
And I wait for PDF "MCC46591BlankT{Var(num21)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankT{Var(num21)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| Field Name            |
| Field Label           |
| Units                 |
| Values                |
| Pre-Filled Values     |
| Include Field OID     |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History1 |
| Annotations      |

@Release_2013.1.0
@PBMCC46591-021
@RR24.JAN.2013
@Validation
Scenario: MCC46591-021 Verify log form with default values in Landscape direction display all log lines with default values on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF3).

#Given I have a log form with default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all log lines with default values in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankU{RndNum<num22>(3)} | MCC46591PDF3 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankU{Var(num22)}"
And I wait for PDF "MCC46591BlankU{Var(num22)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankU{Var(num22)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| Field Name            |
| Field Label           |
| Units                 |
| Values                |
| Pre-Filled Values     |
| Include Field OID     |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History2 |
| Annotations      |

@Release_2013.1.0
@PBMCC46591-022
@RR24.JAN.2013
@Validation
Scenario: MCC46591-022 Verify mixed form with default values in Portrait direction display all fields standard and log with default values on blank PDF with default PDF Configuration Profile (MCC46591PDF1).

#Given I have a mixed form with default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log with default values in the form on PDF

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankV{RndNum<num23>(3)} | MCC46591PDF1 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History2, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankV{Var(num23)}"
And I wait for PDF "MCC46591BlankV{Var(num23)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankV{Var(num23)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History3 |

@Release_2013.1.0
@PBMCC46591-023
@RR24.JAN.2013
@Validation
Scenario: MCC46591-023 Verify mixed form with default values in Landscape direction display all fields standard and log with default values on blank PDF with default PDF Configuration Profile (MCC46591PDF1).

#Given I have a mixed form with default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log with default values in the form on PDF

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankW{RndNum<num24>(3)} | MCC46591PDF1 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History2, Medical History3 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankW{Var(num24)}"
And I wait for PDF "MCC46591BlankW{Var(num24)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankW{Var(num24)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History4 |

@Release_2013.1.0
@PBMCC46591-024
@RR24.JAN.2013
@Validation
Scenario: MCC46591-024 Verify mixed form with default values in Portrait direction display all fields standard and log with default values on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF2).

#Given I have a mixed form with default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log with default values in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankX{RndNum<num25>(3)} | MCC46591PDF2 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankX{Var(num25)}"
And I wait for PDF "MCC46591BlankX{Var(num25)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankX{Var(num25)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| Field Name            |
| Data Type             |
| Field Label           |
| Values                |
| Pre-Filled Values     |
| Include Field OID     |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History1 |
| Annotations      |

@Release_2013.1.0
@PBMCC46591-025
@RR24.JAN.2013
@Validation
Scenario: MCC46591-025 Verify mixed form with default values in Landscape direction display all fields standard and log with default values on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF2).

#Given I have a mixed form with default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log with default values in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankY{RndNum<num26>(3)} | MCC46591PDF2 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankY{Var(num26)}"
And I wait for PDF "MCC46591BlankY{Var(num26)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankY{Var(num26)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| Field Name            |
| Data Type             |
| Field Label           |
| Values                |
| Pre-Filled Values     |
| Include Field OID     |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History2 |
| Annotations      |

@Release_2013.1.0
@PBMCC46591-026
@RR24.JAN.2013
@Validation
Scenario: MCC46591-026 Verify mixed form with default values in Portrait direction display all fields standard and log with default values on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF3).

#Given I have a mixed form with default values in Portrait direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log with default values in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                             | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankZ{RndNum<num26>(3)} | MCC46591PDF3 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankZ{Var(num26)}"
And I wait for PDF "MCC46591BlankZ{Var(num26)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankZ{Var(num26)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| Field Name            |
| Field Label           |
| Units                 |
| Values                |
| Pre-Filled Values     |
| Include Field OID     |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History1 |
| Annotations      |

@Release_2013.1.0
@PBMCC46591-027
@RR24.JAN.2013
@Validation
Scenario: MCC46591-027 Verify mixed form with default values in Landscape direction display all fields standard and log with default values on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF3).

#Given I have a mixed form with default values in Landscape direction
#When I create, generate and view a blank pdf
#Then I should see all fields standard and log with default values in the form on PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                              | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                        |
| MCC46591BlankZa{RndNum<num27>(3)} | MCC46591PDF3 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Demographics2, Medical History1, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankZa{Var(num27)}"
And I wait for PDF "MCC46591BlankZa{Var(num27)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankZa{Var(num27)}"
Then the PDF text should contain
| Text                  |
| Visit Date:           |
| Gender                |
| Body System:          |
| Result:               |
| Description:          |
| Field Name            |
| Field Label           |
| Units                 |
| Values                |
| Pre-Filled Values     |
| Include Field OID     |
| HEENT                 |
| Cardiovascular        |
| Respiratory           |
| Gastrointestinal      |
| Genitourinary         |
| Skin                  |
| Endocrine             |
| Hepatic               |
| Musculoskeletal       |
| SpecialSenses         |
| Renal                 |
| Hemotologic           |
| Neurologic            |
| Dermatologic          |
| Immunologic           |
| Metabolic             |
| Biliary               |
| Reproductive          |
| Lymphatic             |
| Psychiatric           |
| Surgery               |
| Binary                |
| Sensation             |
| Glands                |
| Pulmonary             |
| Aortic                |
| Atrium                |
| Aorta                 |
| Mitral                |
| Other(please specify) |
Then I verify PDF bookmarks exist
| Bookmark Text    |
| Medical History2 |
| Annotations      |

@Release_2013.1.0
@PBMCC46591-028
@RR24.JAN.2013
@Validation
Scenario: MCC46591-028 Verify standard form with default values display all fields on blank PDF with default PDF Configuration Profile (MCC46591PDF1).

#Given I have a standard form with default values
#When I create, generate and view a blank pdf
#Then I should see all fields with default values on blank PDF

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                              | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                           |
| MCC46591BlankZb{RndNum<num31>(3)} | MCC46591PDF1 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankZb{Var(num31)}"
And I wait for PDF "MCC46591BlankZb{Var(num31)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankZb{Var(num31)}"
Then the PDF text should contain
| Text          |
| Date of Birth |
| Ethnicity     |
| Specify race  |
| Gender        |
| Asian         |
| Female        |
Then I verify PDF bookmarks exist
| Bookmark Text |
| Demographics2 |

@Release_2013.1.0
@PBMCC46591-029
@RR24.JAN.2013
@Validation
Scenario: MCC46591-029 Verify standard form with default values display all fields on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF2).

#Given I have a standard form with default values
#When I create, generate and view a blank pdf
#Then I should see all fields with default values on blank PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                              | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                           |
| MCC46591BlankZc{RndNum<num32>(3)} | MCC46591PDF2 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankZc{Var(num32)}"
And I wait for PDF "MCC46591BlankZc{Var(num32)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankZc{Var(num32)}"
Then the PDF text should contain
| Text              |
| Date of Birth     |
| Ethnicity         |
| Specify race      |
| Gender            |
| Field Name        |
| Data Type         |
| Field Label       |
| Values            |
| Pre-Filled Values |
| Include Field OID |
| Asian             |
| Female            |
Then I verify PDF bookmarks exist
| Bookmark Text |
| Demographics2 |
| Annotations   |

@Release_2013.1.0
@PBMCC46591-030
@RR24.JAN.2013
@Validation
Scenario: MCC46591-030 Verify standard form with default values display all fields on blank PDF with Annotated PDF Configuration Profile (MCC46591PDF3).

#Given I have a standard form with default values
#When I create, generate and view a blank pdf
#Then I should see all fields with default values on blank PDF with selected Annotations

And I navigate to "PDF Generator" module
When I create Blank PDF
| Name                              | Profile      | Study          | Role         | Locale  | CRFVersion |Form Exclusions                                                                                                                                           |
| MCC46591BlankZd{RndNum<num33>(3)} | MCC46591PDF3 | BlankPDF Study | SUPER ROLE 1 | English | Version 1  |Adverse Events1, Adverse Events2, Adverse Events3, Adverse Events4, Demographics1, Medical History1, Medical History2, Medical History3, Medical History4 |
And I take a screenshot
And I generate Blank PDF "MCC46591BlankZd{Var(num33)}"
And I wait for PDF "MCC46591BlankZd{Var(num33)}" to complete
And I take a screenshot
When I View Blank PDF "MCC46591BlankZd{Var(num33)}"
Then the PDF text should contain
| Text              |
| Date of Birth     |
| Ethnicity         |
| Specify race      |
| Gender            |
| Field Name        |
| Field Label       |
| Units             |
| Values            |
| Pre-Filled Values |
| Include Field OID |
| Asian             |
| Female            |
Then I verify PDF bookmarks exist
| Bookmark Text |
| Demographics2 |
| Annotations   |
