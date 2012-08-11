Feature: test


@PB_DT14168
@Draft
Scenario: TestScenario
	Given I am logged in to Rave with username "defuser" and password "password"
	And I verify rows exist in "study" table
	| Studies            |
	| Auto Test          |
	| NewStudy_DT5899    |
	| US12999_DT13977_SJ |