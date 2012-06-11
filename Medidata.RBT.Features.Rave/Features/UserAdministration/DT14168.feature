Feature: DT14168


@PB_DT14168
@Draft
Scenario: DT14168
       Given I am logged in to Rave with username "defuser" and password "password"
	   And I navigate to "User Administration"
	   #And I choose "iMedidata" from "Authenticator"
	  # And I type "" in "Log In"
	  # And I click "Search"
	   When I search User by
		| Control       | Value     |
		| Log In        | Bmalizia1 |
		| Authenticator | iMedidata |
		And I click edit User "bmalizia1"
		Then I shoud see following controls are disabled
		| Control |
		|  Top Update       |
		|  Bottom Update       |
		|  Active       |
		|  Locked Out     |
		| Log In       |


