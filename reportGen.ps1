"Waiting for test to finish"
sleep 1
$scriptpath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)
$scriptpath 

Set-Location $scriptpath
$resultPath ="./TestResults/"
$lastTrx = $resultPath + (Get-ChildItem -path  $resultPath -filter *.trx |sort LastWriteTime | select -last 1 ).name
$lastTrxPath =  $lastTrx.Replace(".trx","")+"/Out/";
$reportHtml = $lastTrxPath +"MyResult.html"


./ExternalDlls/SpecflowModified/specflow.exe mstestexecutionreport "Medidata.RBT.Features.Rave\Medidata.RBT.Features.Rave.csproj" /testResult:"$lastTrx" /out:"$reportHtml"



Set-Alias report "$reportHtml"
report