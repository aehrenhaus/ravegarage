@pushd %~dp0

%windir%\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe "Medidata.RBT.Features.Rave.csproj"

@if ERRORLEVEL 1 goto end

@cd ..\packages\SpecRun.Runner.*\tools

@set profile=%1
@if "%profile%" == "" set profile=Default

@set FlagLocation=%2
@if "%FlagLocation%" == "" set FlagLocation="..\TestResults"

@echo "Deleting any result html file in base folder"
@del %~dp0\bin\Debug\*.html
@echo "Deleting any images in the base folder's image directory"
@del %~dp0\bin\Debug\Output\*.jpg
@echo "Deleting any failure flags in the base folder's flag directory"
@del %~dp0\bin\Debug\flags\*.failure

@echo "Cleaning test results directory before specrun starts running tests"
@del %~dp0\..\TestResults\. /Q /S
@rmdir %~dp0\..\TestResults\. /Q /S

@set TIMESTAMP=%DATE:~10,4%_%DATE:~4,2%_%DATE:~7,2%_%TIME:~0,2%_%TIME:~3,2%_%TIME:~6,2%

SpecRun.exe run %profile%.srprofile "/baseFolder:%~dp0\bin\Debug" /log:"%~dp0\..\TestResults\%TIMESTAMP%\specrun.log" %3 %4 %5 %6

@popd

@echo Moving results to the results directory %~dp0\..\TestResults\%TIMESTAMP%

@mkdir "..\TestResults\%TIMESTAMP%"
@mkdir "..\TestResults\%TIMESTAMP%\Output"
@mkdir "..\TestResults\flags"

@move %~dp0\bin\Debug\*.html "..\TestResults\%TIMESTAMP%"
@move %~dp0\bin\Debug\Output\*.jpg "..\TestResults\%TIMESTAMP%\Output"
@move %~dp0\bin\Debug\flags\*.failure "%FlagLocation%\flags"

:end


