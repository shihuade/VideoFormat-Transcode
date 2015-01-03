@echo off
rem ***************************************************************************
rem *
rem *
rem *
rem ***************************************************************************

rem ***************************************************************************
rem  step 1: overall setting and initialization
rem ***************************************************************************

setlocal EnableDelayedExpansion
rem setlocal DisableDelayedExpansion
set ConfigureFile=MuLuSheZhi.txt
set OutputTemFile=bats\ZhuanMa.bat
set ModelFile=bats\Model.bat

rem ***************************************************************************
rem  step 2: parse input and output setting from configure file
rem ***************************************************************************
echo  ConfigureFile is %ConfigureFile%
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

echo  InputDir  is !InputDir!
echo  OutputDir is !OutputDir!

if not exist "!InputDir!" (
	echo ******************************************
	echo   **************************************
	echo      Input directory does not exist
	echo      Please double check your setting
	echo   **************************************
	echo ******************************************
	pause
	exit 1
)
rem generate bat file 
if exist %OutputTemFile% (
	del %OutputTemFile%
)

rem ***************************************************************************
rem  step 3: generate bat script file for final transcode
rem ***************************************************************************
setlocal DisableDelayedExpansion
for /f "tokens=*" %%m in (%ModelFile%) do (

	if not "%%m" == "" (
		echo %%m>>%OutputTemFile%
		
		set FirstWord=NULL
		set SencondWord=NULL
		for /f "tokens=1" %%j in ("%%m") do (

			rem echo Pattern is --aa%%jaa--
			if  "aa%%jaa" == "aaremaa" (
				setlocal EnableDelayedExpansion

				echo line is --%%m--
				for /f "tokens=2" %%j in ("%%m") do (
					set FirstWord=%%j
					for /f "tokens=2 delims=--" %%k in ("!FirstWord!") do (
							set SencondWord=%%k
					)
					echo FirstWord is !FirstWord!
					echo SencondWord is --!SencondWord!--

				)
				
				if "!SencondWord!" == "ForInputOutputDirSetting" (
					echo  InputDir is !InputDir!
					echo  OutputDir is !OutputDir!	
					echo set ParentDir=!InputDir!>>%OutputTemFile%
					echo set OutPutDir=!OutputDir!>>%OutputTemFile%
				)
								
				if "!SencondWord!" == "ForCommand" (
					set ForLoopLine1=for /r %InputDir%  %%%%i in (*.mpg
					for /f "tokens=2 delims=--" %%n in ("xxx--)--xxx") do (
						set Part2=%%n
					)					  
					echo ForLoopLine is --!ForLoopLine1!!Part2! do (--
					echo !ForLoopLine1!!Part2! do (>>%OutputTemFile%
				)
				
				if "!SencondWord!" == "FFMPEGCommand" (				
					setlocal DisableDelayedExpansion
					echo ..\bin\ffmpeg -i "%%%%i"  -c:v libx264  -profile:v main  -level 40 -qmin 30 -qmax 40  -y  "!OutputFileFullPath!">> %OutputTemFile%
				)			
				
				setlocal DisableDelayedExpansion
			)
		)	
	)	
)

rem ***************************************************************************
rem  step 4: call the bat script file for final transcode
rem ***************************************************************************

echo "now call bats fie***********"
cd bats
call ZhuanMa.bat
cd ..
pause

rem ***************************************************************************
rem     end
rem ***************************************************************************


