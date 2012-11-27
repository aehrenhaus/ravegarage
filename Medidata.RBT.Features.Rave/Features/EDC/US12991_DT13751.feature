# US 12991 Core service should try to reconnect to the SQL server (web, app, reporting) until successful
# When the core service connection to the SQL server is lost (web server, app server, reporting server), the core service will try to reconnect itself automatically, and will keep trying until the connection is restored.

@ignore
Feature: US12991_DT13751 Core service should try to reconnect to the SQL server (web, app, reporting) until successful
		As a Rave Administrator
		When my connection to the SQL server is lost (web/app/reporting servers)
		Then the core service will try to reconnect itself automatically under the connection is restored

 Background:
	Given I login to Rave with user "defuser" and password "password"

#----------------------------------------------------------------------------------------------------------------------------------------
@release_564_2012.1.0
@PB_US12991_DT13751_01
@Draft	
Scenario: PB_US12991_DT13751_01, As a Rave Administrator, when I am logged into Rave, and my connection to the web, application or reporting server is lost, the core service will try and reconnect itself automatically until the connection is restored.
	
	And I set the database to offline
	And I wait for 1 minute
	When I set the database to online
	Then I login to Rave with user "defuser" and password "password"
	And I take a screenshot

#----------------------------------------------------------------------------------------------------------------------------------------
