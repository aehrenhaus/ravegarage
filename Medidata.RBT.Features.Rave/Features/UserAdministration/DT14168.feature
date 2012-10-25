@ignore
Feature: DT14168

@PB_DT14168
@Draft
Scenario: DT14168
	Given I login to Rave with user "defuser" and password "password"
	And I navigate to "User Administration"
	When I search User by
		| Login     | Authenticator |
		| Bmalizia1 | iMedidata     |

	And I click edit User "bmalizia1"
	Then I shoud see following controls are disabled
		| Control       |
		| Top Update    |
		| Bottom Update |
		| Active        |
		| Locked Out    |
		| Log In        |


