;~ ------------------------------------------------------------
;~ RWSAuthentication.au3
;~ To handle the Authentication Dialogbox
;~ Create By: Debbie Silberberg
;~ Usage: RWSAuthentication.au3 "[Dialog Title]" "[User Name]" "[Password]"
;~ ------------------------------------------------------------

AutoItSetOption("WinTitleMatchMode","2")
WinWaitActive($CmdLine[1],"","10")
If WinExists($CmdLine[1]) Then
Send($CmdLine[2])
Send("{TAB}")
Send($CmdLine[3])
Send("{Enter}")
EndIf
