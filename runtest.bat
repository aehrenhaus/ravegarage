rem this is path to mstest C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE 

mstest /testcontainer:RBTTest\Medidata.RBT.Features.Rave.dll /test:_8Feature.PB_8_1_3

powershell .\reportGen.ps1