
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


for /f "delims=""" %%i in (%ModelFile%) do (

	echo line is %%i
	pause
	for /f "tokens=1 delims=--" %%j in ("%%i") do (
		set FirstWord=%%j
		set SencondWord=%%k	
	)
	
	if "%FirstWord%" == "Replace" (
		
		echo FirstWord   is %FirstWord%
		echo SencondWord is %SencondWord%
		if "%SencondWord%" == "ForInputOutPutDirSetting" (
		
			echo set ParentDir=!InputDir!  >> %OutputTemFile%
			echo set OutPutDir=!OutputDir! >> %OutputTemFile%
		)
		
		if "%SencondWord%" == "ForCommand" (
			echo for /r !InputDir!  %%%%i  in (*.mpg) do (  >> %OutputTemFile%
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
