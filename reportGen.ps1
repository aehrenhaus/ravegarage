param (
	[string]$projectFile
)

"Waiting for test to finish"
sleep 1
$scriptpath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)
$scriptpath 

Set-Location $scriptpath
$resultPath ="./TestResults/"
$lastTrx = $resultPath + (Get-ChildItem -path  $resultPath -filter *.trx |sort LastWriteTime | select -last 1 ).name

$lastTrx

$lastTrxPath =  $lastTrx.Replace(".trx","")+"/Out/";
$reportHtml = $lastTrxPath +"MyResult.html"

#get the path for the output file
$reportHtmlPath = [System.IO.Path]::GetDirectoryName($reportHtml)

#create the path if not present.
#not sure why this wasn't needed for Medidata.RBT
if(!(Test-Path -Path $reportHtmlPath))
{
	New-Item $reportHtmlPath -type Directory
}

./ExternalDlls/SpecflowModified/specflow.exe mstestexecutionreport $projectFile /testResult:"$lastTrx" /out:"$reportHtml"


Set-Alias report "$reportHtml"
report