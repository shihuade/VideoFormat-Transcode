
@echo off
setlocal EnableDelayedExpansion

set ConfigureFile=ShuRuShuChu.txt
set OutputTemFile=TestModel_Temp.bat
set OutputBatFile=TestModel--00.bat
set ModelFile=bats\Model.bat


echo  ConfigureFile is %ConfigureFile%

pause

for /f "tokens=1,2" %%i in (!ConfigureFile!) do (

	if "%%i" == "input" (
		echo input info
		set InputDir=%%j
	)
	
	if "%%i" == "output" (
		echo outputInfo
		set OutputDir=%%j
	)	
)

echo  InputDir is !InputDir!
echo  OutputDir is !OutputDir!
pause


rem generate bat file 
if exist %OutputTemFile% (
	del %OutputTemFile%
)
echo first try
pause

set InputSetting="set ParentDir=!InputDir!"
set OutputSetting="set OutPutDir=!OutputDir!"
set ForSetting="for /r !InputDir!  %%%%i  in (*.mpg) do ("
set InputSetting=%InputSetting:"=%
set OutputSetting=%OutputSetting:"%
set ForSetting=%ForSetting:"=%

echo InputSetting is %InputSetting%
echo ForSetting is %ForSetting%
pause


for /f "delims=""" %%i in (%ModelFile%) do (

	echo line is %%i
	for /f "tokens=1,2 delims=--" %%j in ("%%i") do (
		set FirstWord=%%j
		set SencondWord=%%k	
	)
	
	rem echo FirstWord   is !FirstWord!
	rem echo SencondWord is !SencondWord!
	
	if "%FirstWord%" == "Replace" (
		
		echo FirstWord   is !FirstWord!
		echo SencondWord is !SencondWord!
		if "%SencondWord%" == "ForInputOutPutDirSetting" (
		
			echo %InputSetting% >> %OutputTemFile%
			echo %OutputSetting% >> %OutputTemFile%
		)
		
		if "%SencondWord%" == "ForCommand" (
			rem echo for /r !InputDir!  %%%%i  in (*.mpg) do (  >> %OutputTemFile%
			set ddd=""
		)
		
	) else (
		echo %%i >> %OutputTemFile%
	)	
)

pause
if exist %OutputBatFile% (
	del %OutputBatFile%
)

echo "sencod try"
pause

for /f "delims=""" %%i in (%OutputTemFile%) do (

	set line=%%i
	if "%%i" == "ECHO is off." ( 
		echo %%i
	) else (
	
		echo %%i >> %OutputBatFile%
	)
	
)
echo "out of loop"

pause
