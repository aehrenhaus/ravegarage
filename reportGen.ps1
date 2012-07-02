$scriptpath = [System.IO.Path]::GetDirectoryName($MyInvocation.MyCommand.Definition)
$scriptpath 

Set-Location $scriptpath
$resultPath ="./TestResults/"
$lastTrx = $resultPath + (Get-ChildItem -path  $resultPath -filter *.trx |select -last 1 ).name
$lastTrxPath =  $lastTrx.Replace(".trx","")+"/Out/";
$reportHtml = $lastTrxPath +"MyResult.html"
$imagePath = "Output/"


#use specflow to generate html report
specflow.exe mstestexecutionreport "Medidata.RBT.Features.Rave\Medidata.RBT.Features.Rave.csproj" /testResult:"$lastTrx" /out:"$reportHtml"

#image place function
Function ReplaceImage($ImagePath,$HtmlPath)
{

    $template=@'
<a href="$ImagePath$1">
    <img src="$ImagePath$1" height="100" />
</a>
'@
    $template = $template -replace '\$ImagePath',$ImagePath

    $text=(gc $HtmlPath);
    
    $replaced = $text -replace "{img ([^}]+)}",$template
    $replaced | out-File $reportHtml 
 
    
}
 
#call function to replace the {img ..} to actual <img />
ReplaceImage -i $imagePath -h $reportHtml

