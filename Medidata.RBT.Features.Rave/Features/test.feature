Feature: test

@PB_DT14168
@Draft
Scenario: TestScenario
	Given I login to Rave with user "zlpass1" and password "password"
	Given xml draft "US18812_SJ.xml" is Uploaded
	
