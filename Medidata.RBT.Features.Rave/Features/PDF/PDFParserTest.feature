Feature: PDFParserTest
	This is a feature file to demonstrate what we can do with the PDF parser

@mytag
Scenario: Testing out the PDF Parsers
	Given I load PDF at location "..\..\..\Mediflex Prod\131231-Allegheny University Hospitals\1122 PAA.pdf"
	Then I verify PDF properties
	| Study    | Locale  | Sites Groups and Sites         | Subject Initials | Page Size |
	| Mediflex | English | Allegheny University Hospitals | PAA              | Letter    | 
	Then I verify PDF bookmarks don't exist
	| Bookmark Text |
	| Week 1        |
	| Enrollment    |
	Then I verify PDF bookmarks exist
	| Bookmark Text        |
	| VIEW_TEST - Inactive |
	Then I verify PDF bookmarks exist under bookmark "auditLinkTEXT"
	| Bookmark Text |
	| DATA          |
	| REVIEW        |
	Then I verify link "SUBJINI" on page "77" goes to page "2"
	Then I verify PDF properties on page "2"
	| Font      | Font Size | Top Margin | Bottom Margin | Left Margin | Right Margin | Page Number |
	| Helvetica | 8         | 1          | 1             | 1.5         | 1.5          | 1 of 164    |