Feature: Query Issue: Edit Checks with require response and require manual close
Open, answer and close a query, change the data and verify that the query did re-fire and verify no log

Background:
	Given Rave has user-study-site assignments from the table below:
		|User		|Study		       |Role |Site		        |Site Number |
		|editcheck  |Edit Check Study 1|cdm1 |Edit Check Site 1 |10001       |
    And  Role "cdm1" has "Query" Action
	And Study  "Edit Check Study" has Draft "<Draft1>"
	And CRF "CRF Version<RANDOMNUMBER>" is pushed in Site "Edit Check Site"


@Web
Scenario: Verifies query firing between cross forms with require response and require manual close.
Cross Forms: Standard form to log form
Folder "Test A Single Edit" enter and save data on forms "Informed Consent Date Form 1" and "Assessment Date Log2"
	When I login to Rave with username "cdm1" and password "password"
    When I create a Subject "sub<RND_NUM,3>"
	And I select Folder "Test A Single Edit"
	And I select Form "Informed Consent Date Form 1"
	And I fill current Form with
	    |Field									|Data				|
        |Informed Consent Date 1	|09 Jan 2000	|
	    |Informed Consent Date 2	|10 Jan 2000	 |
	    |Numeric Field 1					|10					|
	    |Numeric Field 2					|19					|
	And I take screenshot 1
	And I select Form "Assessment Date Log2"
    And I fill current Form with
	    |Field						|Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Assessment Date 2 |11 Jan 2000 |
	    |Numeric Field 1	|10          |
	    |Numeric Field 2   |20          |	
	And I verify Field "Assessment Date 1" displays Query and requires response
    And I verify Field "Numeric Field 2" displays Query and requires response
	And I take screenshot 2
	And I answer the Query on Field "Assessment Date 1" with "<RND_TEXT,5>"
	And I answer the Query on Field "Numeric Field 2" with "<RND_TEXT,5>"
	And I save current Form
	And I close the Query on Field "Assessment Date 1, Numeric Field 2"
	And I save current Form
	And I take screenshot 3
	And I fill current Form with
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |	
	And I save current Form
    And I verify Field "Assessment Date 1, Numeric Field 2" has NO Query
	And I take screenshot 4
	And I fill current Form with
		|Field             |Data        |
        |Assessment Date 1 |08 Jan 2000 |
	    |Numeric Field 2   |20          |
	And I save current Form
	And I verify Field "Assessment Date 1, Numeric Field 2" has NO Query
	And I take screenshot 5
    And I run SQL Script "Query Logging Script" I shoud see result
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub101       |Test A Single Edit          |Assessment Date Log2            |1                         |Assessment Date 1    |08 Jan 2000          |Test A Single Edit       |Assessment Date Log2			  |1                          |Assessment Date 1       |08 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub101       |Test A Single Edit          |Assessment Date Log2            |1                         |Numeric Field 2      |20                   |Test A Single Edit       |Assessment Date Log2             |1                          |Numeric Field 2         |20               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |

	And I select Form "Assessment Date Log2" in Folder "Test A Single Edit"
    And I add a new log line 
	And I fill current Form with
	    |Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Assessment Date 2 |12 Jan 2000 |
	    |Numeric Field 1   |10          |
	    |Numeric Field 2   |18          |
	And I save current Form
	And I open log line 2
	And I verify Field "Assessment Date 1" has NO Query
	And I verify Field "Numeric Field 2" displays Query and requires response


	And I verify Field "Assessment Date 1" displays Query and requires response
	And I verify Field "Numeric Field 2" displays Query and requires response
	And I take screenshot 7
	And I modify current form with
		|Field             |Data        |
        |Assessment Date 1 |09 Jan 2000 |
	    |Numeric Field 2   |19          |

	And I answer the Query on Field "Assessment Date 1,Numeric Field 2"
	And I save current Form
	And I close the Query on Field "Assessment Date 1, Numeric Field 2"
	And I save current Form

	And I take screenshot 8
	And I verify Field "Assessment Date 1,Numeric Field 2" has NO Query
	And I take screenshot 9

	And I modify current form with
		|Field             |Data        |
        |Assessment Date 1 |07 Jan 2000 |
	    |Numeric Field 2   |18          |

	And I save current Form
	And I verify Field "Assessment Date 1,Numeric Field 2" has NO Query
	And I take screenshot 10

    And I run SQL Script "Query Logging Script" I shoud NOT see result
      |ProjectName        |SiteNumber  |SiteName          |Environment |SubjectName  |CheckActionInstanceName     |CheckActionInstanceDataPageName |CheckActionRecordPosition |CheckActionFieldName |CheckActionFieldData |TriggerFieldInstanceName |TriggerFieldInstanceDatapageName |TriggerFieldRecordPosition |TriggerFieldName        |TriggerFieldData |EditCheckName                               |MarkingGroupName |QueryMessage                                                                |EventTime  |
      |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub101       |Test A Single Edit          |Assessment Date Log2            |2                         |Assessment Date 1    |07 Jan 2000          |Test A Single Edit       |Assessment Date Log2             |2                          |Assessment Date 1       |07 Jan 2000      |*Greater Than Open Query Log Cross Form     |Marking Group 1  |Informed Consent Date 1 is greater. Please revise.                          |{DateTime} |
	  |Edit Check Study 1 |10001       |Edit Check Site 1 |PROD        |sub101       |Test A Single Edit          |Assessment Date Log2            |2                         |Numeric Field 2      |18                   |Test A Single Edit       |Assessment Date Log2             |2                          |Numeric Field 2         |18               |*Is Not Equal to Open Query Log Cross Form* |Site             |Informed Consent numeric field 2 is not equal to assessment numeric field 2 |{DateTime} |
	And I take screenshot 11

	