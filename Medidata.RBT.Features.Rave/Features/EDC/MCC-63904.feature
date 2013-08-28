﻿@MCC-63904
Feature: MCC-63904 User Loader fails completely if project name (excluding environment) includes parenthesis
	
Background:
Given study "MCC-63904 (test)" exists
Given role "SUPER ROLE 1" exists
Given following Project assignments exist
| User          | Project		   | Environment | Role         | SecurityRole          |
| SUPER USER 1  | MCC-63904 (test) | Live: Prod  | SUPER ROLE 1 | Project Admin Default |
Given I login to Rave with user "SUPER USER 1"

@Release_2013.4.0
@PB_MCC63904-001
@PS28.AUG.2013
@Draft
Scenario: PB_MCC63904-001 As a Rave user, when I download a user loader file where one of the project names has parenthesis in it, uploading the same file back should be successful.

@Release_2013.4.0
@PB_MCC63904-002
@PS28.AUG.2013
@Draft
Scenario: PB_MCC63904-002 As a Rave user, when I download a user loader file where one of the project names has parenthesis in it which is the same as the target environment name, uploading the same file back should be successful.

@Release_2013.4.0
@PB_MCC63904-003
@PS28.AUG.2013
@Draft
Scenario: PB_MCC63904-003 As a Rave user, when I download a user loader file where one of the project names has multiple groups of parenthesis in it, uploading the same file back should be successful.

@Release_2013.4.0
@PB_MCC63904-004
@PS28.AUG.2013
@Draft
Scenario: PB_MCC63904-004 As a Rave user, when I download a user loader file where one of the project names has multiple groups of parenthesis in it, and at least one is a reference to the current environment, uploading the same file back should be successful.


