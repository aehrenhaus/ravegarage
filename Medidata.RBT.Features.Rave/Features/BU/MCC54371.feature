﻿# When a .... 
# It is ...
# This ...
#@ignore
@FT_MCC54371
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
	When I zip the files from sourceDirectory "k1"
	When I unzip the file "test.zip" from targetDirectory "k2"






#@release_2013.2.0 
@PB_MCC54371_02
#@ignore
Scenario: PB_MCC54371_02 As an EDC user, ..... This demonstrates using file copy with login user credentials to copy to network drive, and confirm it is processed afterwards
#
	When I drop files from source directory "k2" to target directory "\\DL5RL8FV1\k2\Input\" using logged in user
	Then I confirm file "KS_TEST-Prod-S-D-Full-20121003.txt" from network path "\\DL5RL8FV1\k2\Input\" is processed within 10 minutes
	And I take a screenshot






#@release_2013.2.0 
@PB_MCC54371_03
@ignore
Scenario: PB_MCC54371_03 As an EDC user, intention is to use ftp to transfer file to network drive and confirm using impersonation
#
	When I transfer the files "KS_TEST-Prod-S-D-Full-20121003.txt,KS_TEST-Prod-S-D-Full-20121004.txt" from source directory "k2" to ftp directory "K2Input" on ftp server "10.97.11.47" using ftp user name "anonymous" and password "password" and file transfer mode "binary"
	Then I confirm file "KS_TEST-Prod-S-D-Full-20121003.txt" from network path "\\DL5RL8FV1\k2\Input\" is processed within 10 minutes
	And I take a screenshot








#@release_2013.2.0 
@PB_MCC54371_04
@ignore
Scenario: PB_MCC54371_04 As an EDC user, intention is to check whether file is processed by BU service when dropped with user impersonation
#

#   When I drop files from sourceDirectory "k2" to target directory "\\hdc505lbiswv001.lab1.hdc.mdsol.com\ftp\rave564conlabtesting7\k2" using user name "spigot0matic" and password "spigot$2010" on domain "HDC"
#	When I drop files from sourceDirectory "k2" to target directory "\\hdc501pradmv007.hdc.mdsol.com\ftp\rave564conlabtesting7\k2" using user name "spigot0matic" and password "spigot$2010" on domain "HDC"

    When I drop files from source directory "k2" to target directory "\\hdc505lbiswv001.lab1.hdc.mdsol.com\ftp\rave564conlabtesting7\k2" using user name "kiritharan.sandraseg" and password "xyz" on domain "HDC"
	Then I confirm file "KS_TEST-Prod-S-D-Full-20121003.txt" from network path "\\hdc505lbiswv001.lab1.hdc.mdsol.com\ftp\rave564conlabtesting7\k2" is processed within 10 minutes using user name "kiritharan.sandraseg" and password "xyz" on domain "HDC"
	And I take a screenshot


