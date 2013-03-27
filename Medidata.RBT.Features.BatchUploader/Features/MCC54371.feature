﻿# When a .... 
# It is ...
# This ...
#@ignore
@FT_MCC54371
@BatchUploader
Feature: MCC54371 ......
	As a Rave user with BU capability
	Given I drop a file in BU configured network path
	And I ...
	When I ...
	Then I ...

Background:

	#Given I login to Rave with user "SUPER USER 1"
	#And Site "Site 01" exists
	#And study "MCC54371" is assigned to Site "Site 01"
	#And xml draft "MCC54371_Version1.xml" is Uploaded
	#And following Project assignments exist
	#	| User         | Project  | Environment | Role         | Site    | SecurityRole          |
	#	| SUPER USER 1 | MCC54371 | Live: Prod  | SUPER ROLE 1 | Site 01 | Project Admin Default |
	#And Role "SUPER ROLE 1" has Action "Entry" in ActionGroup "Entry" with Status "Checked"
	#And I publish and push eCRF "MCC54371_Version1.xml" to "Version1"
	#And I login to BUUI with user "SUPER USER 1"
	#And Upload Configuration "rst" is Uploaded in BUUI
	#And BU service "abc" is running
	#And BU service "abc" is configured to access network path "xyz" 


#@release_2013.2.0 
@PB_MCC54371_01
@ignore
Scenario: PB_MCC54371_01 As an EDC user, ..... This demonstrates zipping files from a folder before copying to a network drive and unzipping afterwards.
#
	When I zip the files from Directory "BU/UploadFiles/k2"
	When I unzip the file "k2.zip" in Directory "BU/UploadFiles/k3"
	And I take a screenshot


#@release_2013.2.0 
@PB_MCC54371_02
@ignore
Scenario: PB_MCC54371_02 As an EDC user, ... I would like to copy the files from a given local directory to a given network directory and verify that batch uploader processed it and the file disappears from the network drive using login credentials
#
	When I drop files from source directory "BU\UploadFiles\MCC54371_02" to target directory "\\DL5RL8FV1\BuShare\Input\"
	Then I verify file "KS_TEST-Prod-S-D-Full-20120201.txt" from network path "\\DL5RL8FV1\BuShare\Input\" is processed
	And I take a screenshot


#@release_2013.2.0 
@PB_MCC54371_03
@ignore
Scenario: PB_MCC54371_03 As an EDC user, I would like to copy the files from a given local directory to a given ftp directory and verify that batch uploader processed it and the file disappears from the network drive using ftp and login credentials
#
	When I transfer 
	| File Names                                                            | Source Directory           | Ftp Directory | Ftp Mode |
	| KS_TEST-Prod-S-D-Full-20120301.txt,KS_TEST-Prod-S-D-Full-20120302.txt | BU\UploadFiles\MCC54371_03 | Input         | binary  |
	Then I verify file "KS_TEST-Prod-S-D-Full-20120301.txt" from network path "\\DL5RL8FV1\BuShare\Input\" is processed
	And I take a screenshot

#@release_2013.2.0 
@PB_MCC54371_04
#@ignore
Scenario: PB_MCC54371_04 As an EDC user, I would like to copy the files from a given local directory to a given network directory and verify that batch uploader processed it and the file disappears from the network drive using user impersonation
#
    When I drop files from source directory "BU\UploadFiles\MCC54371_04" to target directory "\\hdc505lbiswv001.lab1.hdc.mdsol.com\ftp\rave564conlabtesting7\k2" using user impersonation
	Then I verify file "KS_TEST-Prod-S-D-Full-20120401.txt" from network path "\\hdc505lbiswv001.lab1.hdc.mdsol.com\ftp\rave564conlabtesting7\k2" is processed using user impersonation
	And I take a screenshot


