$scriptpath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)
$scriptpath 

Set-Location $scriptpath
$resultPath ="./TestResults/"

$OutputBuildDir = "D:\CI_Specflow_SQA\SpecflowSeeding_SQA_Testing\Output"
$testDll = "Medidata.RBT.Features.Rave\bin\Debug\Medidata.RBT.Features.Rave.dll"

.\GetTestList.exe "$testDll" > testList.txt

$categories = cat testList.txt


if($args.Count -eq 1)
{
    $OutputBuildDir = $args[0];
}

rd "TestResults" -force -recurse 
md "TestResults"

if (Test-Path $OutputBuildDir\flags\$_.success)	{
	Remove-Item $OutputBuildDir\flags\FT*.success
}
	
if (Test-Path $OutputBuildDir\flags\$_.failure) {
	Remove-Item $OutputBuildDir\flags\FT*.failure
}
	
$categories | %{
  
    Write-Host "Running $_"
    Set-Alias mstest "C:\Program Files (x86)\Microsoft Visual Studio 10.0\Common7\IDE\mstest.exe"

    mstest /testcontainer:"$testDll" /runconfig:Default.testsettings /resultsfile:"TestResults\$_.trx" /category:$_
    
	if ($?) {
		Write-Host "FF passed"
		New-Item $OutputBuildDir\flags\$_.success -type file -force
	} else {
		Write-Host "FF failed"
		New-Item $OutputBuildDir\flags\$_.failure -type file -force
	}
    $resultPath ="./TestResults/"
    $lastTrx = $resultPath + (Get-ChildItem -path  $resultPath -filter *.trx |sort LastWriteTime | select -last 1 ).name
    $lastTrxFolder = $resultPath + (Get-ChildItem -path  $resultPath |sort LastWriteTime |?{$_.PSIsContainer }| select -last 1 ).name


    $reportHtml = $lastTrxFolder+"/Out/" +"MyResult.html"
    ./ExternalDlls/SpecflowModified/specflow.exe mstestexecutionreport "Medidata.RBT.Features.Rave\Medidata.RBT.Features.Rave.csproj" /testResult:"$lastTrx" /out:"$reportHtml"



    #move the file outside a level

    $oldName = (Get-ChildItem -path  $resultPath |sort LastWriteTime |?{$_.PSIsContainer }| select -last 1 ).name

    cd TestResults
   
    Rename-Item  $oldName $_
    cd ..
    $lastTrxFolder = "./TestResults/$_"

    #delete files
    rd -Force "$lastTrxFolder/*.dll" 
    rd -Force "$lastTrxFolder/*.pdb" 
    rd -Force "$lastTrxFolder/*.config" 
}



