﻿Feature: R55_PDF_GLOBAL1_V4
	This is a feature file to demonstrate what we can do with the PDF parser

Background:
#Step 1
Given I login to Rave with user "SUPER USER 1"
Given study "Mediflex" exists
Given coding dictionary "WhoDrug" version "20044" exists with following coding columns
| Coding Column Name |
| PRODUCT            |
Given coding dictionary "WhoDrug" coding column "PRODUCT" has following coding level components
| OID              |
| DRUGRECORDNUMBER |
Given following locales exist for the coding dictionary
| Coding Dictionary Name | Locale |
| WhoDrug                | eng    |
Given following coding dictionary assignments exist
| Project  | Coding Dictionary |
| Mediflex | WhoDrug           |
Given study "Mediflex" is assigned to Site "Allegheny University"
Given xml Lab Configuration "R55_PDF_GLOBAL1_V4_US.xml" is uploaded
Given xml draft "R55_PDF_GLOBAL1_V4_Mediflex.xml" is Uploaded
Given following Project assignments exist
| User         | Project  | Environment | Role                   | Site                 | SecurityRole          | ExternalSystem |
| SUPER USER 1 | Mediflex | Live: Prod  | R55_PDF_GLOBAL1V4_Role | Allegheny University | Project Admin Default | iMedidata      |
Given I publish and push eCRF "R55_PDF_GLOBAL1_V4_Mediflex.xml" to "Version 1"
Given following PDF Configuration Profile Settings exist
| Profile Name      |
| R55_GLOBAL1_DATA1 |
#Step 41
Given PDF configuration profile has properties
| Profile Name      | Cover Page Logo | Header Image |
| R55_GLOBAL1_DATA1 | 3d brain.jpg    | H_Brain1.jpg |

#Step 1 continued
Scenario: Converting R55_PDF_Global1_V4
Then I navigate to "Architect" module
And I select "Project" link "Mediflex" in "Active Projects"
And I select Draft "PDF Primary Draft"
Then I select link "Matrices" located in "Left Nav"
And I select link "Folder Forms" in "Base"
And I take a screenshot
#Step 2
Then I navigate to "Home"
Given I create a Subject
| Field            | Data              |
| Subject Initials | PAA               |
| Subject Number   | {RndNum<num1>(3)} |
#Step 3
Then I select Form "VIEW_TEST"
And I enter data in CRF and save
| Field  | Data         | AdditionalData | Control Type |
| REVIEW | Male         |                | dropdown     |
| SIGN   | SUPER USER 1 |                | Signature    |
#Step 4
And I place stickies
| Field  | Responder | Text                |
| STICKY | Site      | StickyTextStandard1 |
And I edit checkboxes for fields
| Field  | Review |
| REVIEW | True   |
Then I click button "Save"
#Step 5
And I select link "Inactivate Page"
And I check "Confirm"
Then I click button "Save"
And I take a screenshot
#Step 6
Then I select Form "VIEW_TESTLOG"
And I enter data in CRF and save
| Field  | Data         | AdditionalData | Control Type |
| REVIEW | Male         |                | dropdown     |
| Lock   | lTxtL1       |                | textbox      |
| SIGN   | SUPER USER 1 |                | Signature    |
And I select link "Add a new Log line"
And I enter data in CRF and save
| Field  | Data         | AdditionalData | Control Type |
| REVIEW | Male         |                | dropdown     |
| SIGN   | SUPER USER 1 |                | Signature    |
#Step 7
And I open log line 2
And I place stickies
| Field  | Responder | Text           |
| Sticky | Site      | StickyTextLog2 |
And I edit checkboxes for fields
| Field  | Review |
| REVIEW | True   |
Then I click button "Save"
And I take a screenshot
#Step 8
And I open log line 1
And I place stickies
| Field  | Responder | Text           |
| Sticky | Site      | StickyTextLog1 |
And I edit checkboxes for fields
| Field  | Review |
| REVIEW | True   |
Then I click button "Save"
#Step 9
And I select link "Inactivate"
And I choose "2" from "Inactivate"
And I click button "Inactivate"
And I take a screenshot
#Step 10
And I select Folder "Screening"
Then I select Form "VIEW_TEST"
And I enter data in CRF and save
| Field  | Data         | AdditionalData | Control Type |
| REVIEW | Male         |                | dropdown     |
| SIGN   | SUPER USER 1 |                | Signature    |
#Step 11
And I place stickies
| Field  | Responder | Text                  |
| STICKY | Site      | StickyTextScreening1a |
And I edit checkboxes for fields
| Field  | Review |
| REVIEW | True   |
Then I click button "Save"
#Step 12
And I select link "Inactivate Page"
And I check "Confirm"
Then I click button "Save"
#Step 13
Then I select Form "VIEW_TESTLOG"
And I enter data in CRF and save
| Field  | Data         | AdditionalData | Control Type |
| REVIEW | Male         |                | dropdown     |
| Lock   | lTxtScrL1    |                | textbox      |
| SIGN   | SUPER USER 1 |                | Signature    |
And I select link "Add a new Log line"
And I enter data in CRF and save
| Field  | Data         | AdditionalData | Control Type |
| REVIEW | Male         |                | dropdown     |
| Lock   | lTxtScrL2    |                | textbox      |
| SIGN   | SUPER USER 1 |                | Signature    |
#Step 14
And I open log line 1
And I place stickies
| Field  | Responder | Text                     |
| Sticky | Site      | StickyTextScreeningLog1a |
And I edit checkboxes for fields
| Field  | Review |
| REVIEW | True   |
Then I click button "Save"
And I take a screenshot
#Step 15
And I open log line 2
And I place stickies
| Field  | Responder | Text                     |
| Sticky | Site      | StickyTextScreeningLog2a |
And I edit checkboxes for fields
| Field  | Review |
| REVIEW | True   |
Then I click button "Save"
#Step 16
And I select link "Inactivate"
And I choose "1" from "Inactivate"
And I click button "Inactivate"
And I take a screenshot
#Step 17
And I select "Study" link "Mediflex" in "Header"
Given I create a Subject
| Field            | Data              |
| Subject Initials | PAB               |
| Subject Number   | {RndNum<num2>(3)} |
#Step 18
Then I select Form "Lab Demographics"
And I enter data in CRF and save
| Field | Data | AdditionalData | Control Type |
| Age   | 21   |                | textbox      |
And I take a screenshot
#Step 19
Then I select Form "Lab Form"
And I select Lab "Quest5"
And I enter data in CRF and save
| Field | Data | Control Type |
| WBC   | 11   | textbox      |
#Step 20
And I choose "Code4" from "Clinical Significance"
Then I click button "Save"
And I take a screenshot
#Step 21
And I select link "Inactivate Page"
And I check "Confirm"
Then I click button "Save"
And I take a screenshot
#Step 22
And I click audit on Field "WBC"
Then I verify Audits exist
| Audit Type                | Query Message |
| DataPoint                 | Inactivated.  |
| Clinical significance set | 'Code4'       |
And I take a screenshot
#Step 23
Then I select link "Lab Form" in "Header"
Then I select Form "VIEW_TEST"
And I enter data in CRF and save
| Field | Data         | AdditionalData | Control Type |
| CODE  | aspCode      |                | textbox      |
| SIGN  | SUPER USER 1 |                | Signature    |
#Step 24
And I code data points
 | Project  | Subject         | Field | Uncoded Data | Coded Data | Coding Dictionary | Coding Dictionary Version | Current User |
 | Mediflex | {Var(num2)} PAB | CODE  | aspCode      | ASPIRINE   | WhoDrug           | 20044                     | SUPER USER 1 |
#Step 25
And I select link "Inactivate Page"
And I check "Confirm"
Then I click button "Save"
#Step 26
Then I select Form "VIEW_TESTLOG"
And I enter data in CRF and save
| Field | Data         | AdditionalData | Control Type |
| CODE  | codeLAsp1    |                | textbox      |
| SIGN  | SUPER USER 1 |                | Signature    |
And I select link "Add a new Log line"
And I enter data in CRF and save
| Field | Data         | AdditionalData | Control Type |
| CODE  | codeLAsp2    |                | textbox      |
| SIGN  | SUPER USER 1 |                | Signature    |
#Step 27
And I code data points
 | Project  | Subject         | Field | Uncoded Data | Coded Data | Coding Dictionary | Coding Dictionary Version | Current User |
 | Mediflex | {Var(num2)} PAB | CODE  | codeLAsp1    | ASPIRINE   | WhoDrug           | 20044                     | SUPER USER 1 |
 | Mediflex | {Var(num2)} PAB | CODE  | codeLAsp2    | ASPIRINE   | WhoDrug           | 20044                     | SUPER USER 1 |
#Step 28
And I select link "Inactivate"
And I choose "1" from "Inactivate"
And I click button "Inactivate"
And I take a screenshot
#Step 29
And I select Folder "Screening"
Then I select Form "VIEW_TEST"
And I enter data in CRF and save
| Field | Data         | AdditionalData | Control Type |
| CODE  | codeRef      |                | textbox      |
| SIGN  | SUPER USER 1 |                | Signature    |
#Step 30
And I code data points
 | Project  | Subject         | Field | Uncoded Data | Coded Data | Coding Dictionary | Coding Dictionary Version | Current User |
 | Mediflex | {Var(num2)} PAB | CODE  | codeRef      | REFAGAN    | WhoDrug           | 20044                     | SUPER USER 1 |
#Step 31
Then I select Form "VIEW_TESTLOG"
And I enter data in CRF and save
| Field | Data         | AdditionalData | Control Type |
| CODE  | codeRefL1    |                | textbox      |
| SIGN  | SUPER USER 1 |                | Signature    |
And I select link "Add a new Log line"
And I enter data in CRF and save
| Field | Data         | AdditionalData | Control Type |
| CODE  | codeRefL2    |                | textbox      |
| SIGN  | SUPER USER 1 |                | Signature    |
#Step 32
And I code data points
 | Project  | Subject         | Field | Uncoded Data | Coded Data | Coding Dictionary | Coding Dictionary Version | Current User |
 | Mediflex | {Var(num2)} PAB | CODE  | codeRefL1    | REFAGAN    | WhoDrug           | 20044                     | SUPER USER 1 |
 | Mediflex | {Var(num2)} PAB | CODE  | codeRefL2    | REFAGAN    | WhoDrug           | 20044                     | SUPER USER 1 |
#Step 33
And I select link "Inactivate"
And I choose "2" from "Inactivate"
And I click button "Inactivate"
And I take a screenshot
#Step 34
Then I select Form "Standard Form"
And I enter data in CRF and save
| Field          | Data   | AdditionalData | Control Type |
| \\bText\\/b\br | txtStd |                | textbox      |
#Step 35
Then I login to Rave with user "SUPER USER 1"
Then I navigate to "PDF Generator" module
#Step 36
#Step 37
#Step 38
#Step 39
#Step 40
#Step 42
#Step 43
Then I create Data PDF
| Name                           | Profile           | Study    | Role                   | Locale  | Site Groups | Sites                | Subjects        | Form Exclusions | Folder Exclusions |
| GLOBAL1_DATA1{RndNum<num3>(3)} | R55_GLOBAL1_DATA1 | Mediflex | R55_PDF_GLOBAL1V4_Role | English | World       | Allegheny University | {Var(num1)} PAA | Enrollment      | Week 1            |
And I take a screenshot
#Step 44
And I generate Data PDF "GLOBAL1_DATA1{Var(num3)}"
And I wait for PDF "GLOBAL1_DATA1{Var(num3)}" to complete
And I take a screenshot
#SUBSTEP (Step 45): Subjects	Subject created with initials “PAA”.
When I view data PDF "{Var(num1)} PAA.pdf" from request "GLOBAL1_DATA1{Var(num3)}"

#This is where the pdf parsing steps begin
#Step 45
#SUBSTEP: Study 	Mediflex (Verified through Document Properties in file menu)
#SUBSTEP: Select Role	CDM1 (only users with this role should be able to download and open the PDF)\
#SUBSTEP: Select Role is verified through automation itself, since we were able to download the pdf with the role
#SUBSTEP: Select Locale	English
#SUBSTEP: Site Groups and Sites	Allegheny University Hospital
Then I verify PDF properties
| Study    | Locale  | Sites                |
| Mediflex | English | Allegheny University |

#SUBSTEP: Folder Exclusion	Week 1 does not appear
#SUBSTEP: Form Exclusion	Enrollment does not appear
Then I verify PDF bookmarks don't exist
| Bookmark Text |
| Week 1        |
| Enrollment    |

#Step 46
#SUBSTEP: Include Inactivate Records 	CHECK
Then I verify PDF bookmarks exist directly under parent bookmark "Screening"
| Bookmark Text               |
| VIEW_TEST - Inactive        |
| VIEW_TESTLOG (1) - Inactive |

Then I verify PDF bookmarks exist directly under parent bookmark "{Var(num1)} PAA"
| Bookmark Text               |
| VIEW_TEST - Inactive        |
| VIEW_TESTLOG (2) - Inactive |

#SUBSTEP: Include Inactive Records if Audit Category Exists
Then I verify PDF Audits exist on page "REVIEW"
| Audit Type   | Query Message  | User                               | Time                 |
| reviewed     | Review Group 1 | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
| User entered | 'Male (m)'     | Default User ([id] - SUPER USER 1) | dd MMM yyyy HH:mm:ss |
#SUBSTEP: Maximum Data Dictionary Entries
#Don't need to test this since no data dictionaries have more than 20 entries in this pdf
#SUBSTEP: Display select Dictionary Entry Only UNCHECK
#We verify here that male and female appear on the page, not just the selected "Male"
Then I verify PDF text on page "VIEW_TEST - Inactive"
| Text   |
| Male   |
| Female |

#Step 47
#SUBSTEP: Exclude All Audits UNCHECK
#SUBSTEP: Audit Link Label “auditLinkTEXT”
Then I verify PDF bookmarks exist
| Bookmark Text |
| auditLinkTEXT |
#SUBSTEP: Audit trail included if audit history rows is at least 1
#Review has at least 1 audit, make sure it shows up
Then I verify PDF bookmarks exist directly under parent bookmark "auditLinkTEXT"
| Bookmark Text |
| REVIEW        |
#SUBSTEP: Audit Categories to include Data, Review 
#We have already verified this with the "Then I verify PDF Audits exist on page "REVIEW"" step
#SUBSTEP: Second-tier Audit Categories to include	N/A
#Nothing to check here
#SUBSTEP: Link Fields to audits	CHECK
#SUBSTEP: Hyperlink fields to audits if number of audit history rows is at least 1
Then I verify link "Subject Initials" on page "Subject ID" goes to page "SUBJINI"
#SUBSTEP: Nest Audit Bookmarks below relevant fields UNCHECK
Then I verify PDF bookmarks don't exist under bookmark "Subject ID"
#Printscreen 13 of 22
#TODO: !!!Find a printscreen alternative

#Step 48
#SUBSTEP: Bookmark Hierarchy	Folder->Form
Then I verify PDF bookmarks exist directly under parent bookmark "Screening"
| Bookmark Text |
| Standard Form |

#SUBSTEP: Bookmark Order	Ordinal
#This is enough to prove that they are in ordinal and not alphabetical because "L" is before "S" in the alphabet
Then I verify PDF bookmarks exist directly under parent bookmark "Screening" in the following order
| Bookmark Text        |
| Standard Form        |
| Standard Form 1      |
| Log Form (1)         |
| Log Form 1           |

#SUBSTEP: Bookmark Label Style	Field Pretext: UNCHECK
#SUBSTEP: Field OID: CHECK
#We have already checked this by refering to bookmarks by their oid and not pretext several times


#Step 49
#SUBSTEP: Font	Helvetica (Verified through Document Properties in file menu)
#SUBSTEP: Font Size	8 (Visually verify)
#SUBSTEP: Top Margin	1 (Visually verify)
#SUBSTEP: Bottom Margin	1 (Visually verify)
#SUBSTEP: Left Margin	1.5 (Visually verify)
#SUBSTEP: Right Margin	1.5 (Visually verify)
Then I verify PDF properties on page "Subject ID"
| Font      | Font Size | Top Margin | Bottom Margin | Left Margin | Right Margin |
| Helvetica | 8         | 1          | 1             | 1.5         | 1.5          |

#SUBSTEP: Page Size	Letter (Verified through Document Properties in file menu)
Then I verify PDF properties
| Page Size |
| Letter    |

#Step 50 
#SUBSTEP: Include Cover page	CHECK
Then I verify PDF bookmarks exist
| Bookmark Text |
| auditLinkTEXT |

#SUBSTEP: Additional Cover Page Text	“addcovTEXT”
Then I verify PDF text on page "{Var(num1)} PAA"
| Text       |
| addcovText |

#SUBSTEP: Cover page Logo	3d brain
Then I verify image "3d brain.jpg" exits on PDF page "{Var(num1)} PAA"

#SUBSTEP: Include in Header	Date, Folder
Then I verify PDF properties on page "Screening"
| Generated On         | Folder    |
| dd MMM yyyy HH:mm:ss | Screening |

#SUBSTEP: Bold Header Text 	CHECK
Then I verify PDF text on page "Screening"
| Text              | Bold |
| Folder: Screening | true |

#SUBSTEP: Header Image	H_Brain1
Then I verify image "H_Brain1.jpg" exits on PDF page "Screening"

#SUBSTEP: Page Numbering Style	Page number-total pages
#SUBSTEP: Include CRF Version Number 	CHECK (appears in footer)
Then I verify PDF properties on page "Subject ID"
| Page Number | CRF Version |
| 1 of 164    | Version 1   |

#SUBSTEP: Minimum Allowed Column Width	2
Then I verify the "x" distance between "Height" and "Action Taken" on PDF page "Log Form 1" is greater than "2"

#SUBSTEP: Maximum Vertical Line Wraps Allowed	10
#Can't be checked in this specific test as there is no field which exceeds this value

#SUBSTEP: Include Site Information File	CHECK (titled InvestigatorInformation.txt)
Then I verify file "InvestigatorInformation.txt" was downloaded
#Printscreen 13 of 22
#TODO: !!!Find a printscreen alternative