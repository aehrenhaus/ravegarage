AutoItSetOption("WinTitleMatchMode","2")
WinWaitActive("Windows Security","","10")
If WinExists("Windows Security") Then
   MsgBox(1,"1", "1")
Send("defuser{TAB}")
Send("password{Enter}")
EndIf
