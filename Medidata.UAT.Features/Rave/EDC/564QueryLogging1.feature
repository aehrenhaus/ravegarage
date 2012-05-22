Feature: Feaature 1

@Web
Scenario: Can enter search text
	When I login
	And I enter search text

@Web
Scenario: Can search
	When I login
	And I enter search text
	And I click search
	Then I sould see result