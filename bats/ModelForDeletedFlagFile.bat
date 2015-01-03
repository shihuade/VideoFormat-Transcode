@echo off
setlocal EnableDelayedExpansion
set FileNameInfoLog=..\log\LogFileNameLenth.txt
Set FileDirInfoLog=..\log\LogDirInfo.txt
set ParentDirInfoLog=..\log\LogParentDirInfo.txt
set DeletedFlagList=..\log\DeleteFlagFileList.txt
Set /a FileFullPathLength=0
set /a ParentDirLength=0
Set /a SubDirLength=0
set /a DirLenth=0
Set /a FileNameLength=0

rem --Replace--ForInputOutputDirSetting--
::set ParentDir=D:\FFMPEGTestData  
::set OutPutDir=E:\FFMPEGTestData02 

set FileName=""
set SubDirName=""
set NewName=""
set OutputFileFullPath=""
set OutputFileDir=""
set FlagFile=""

echo **************************************>!DeletedFlagList!
echo   Deleted flag file for .mpg files listed as below:>>!DeletedFlagList!
echo **************************************>>!DeletedFlagList!

rem --Replace--ForCommand--	
::  for /r E:\FFMPEG\BatProcess  %%i  in (*.mpg) do (
	
	echo txt file name is %%i
	::step 1 parse input file directory info, and generate out put path
	call ..\bats\GetStringLenth   "%%i"          %FileDirInfoLog%
	call ..\bats\GetStringLenth   "%ParentDir%"  %ParentDirInfoLog%
	call ..\bats\GetFileNameLenth "%%i"          %FileNameInfoLog%
	
	for /f "tokens=1" %%j in (%FileDirInfoLog%) do (
		set /a FileFullPathLength=%%j
	)

	for /f "tokens=1" %%j in (%ParentDirInfoLog%) do (
		set /a ParentDirLength=%%j
	)
	
	for /f "tokens=1" %%j in (%FileNameInfoLog%) do (
		set /a FileNameLength=%%j
	)
	
	set /a SubDirLength = FileFullPathLength - ParentDirLength - FileNameLength
	set /a DirLenth = FileFullPathLength - FileNameLength
	set FullPath=%%i
    call set FileName=%%FullPath:~!DirLenth!,!FileNameLength!%%
	call set SubDirName=%%FullPath:~!ParentDirLength!,!SubDirLength!%%
	
	 echo *********************************************************
	 echo Full path is !FullPath!
	 echo FileFullPathLength is !FileFullPathLength!
	 echo ParentDirLength    is !ParentDirLength!
	 echo FileNameLength     is !FileNameLength!
	 echo SubDirLength       is !SubDirLength!
	 echo DirLenth           is !DirLenth!
	 echo FileName           is !FileName!
	 echo SubDirName         is !SubDirName!
	 echo *********************************************************
	
	::rename file
	for /f "tokens=1 delims=.mpg"  %%j in ("!FileName!") do (
		set NewName=%%j.mp4
	)
	
	::step 2 set out put file based on setting and create out put directory
	set OutputFileDir=!OutPutDir!!SubDirName!
	set OutputFileFullPath=!OutPutDir!!SubDirName!!NewName!
	
	 echo *********************************************************
	 echo NewName is !NewName!
	 echo OutputDir is !OutputFileDir!
	 echo OutputFileFullPath is !OutputFileFullPath!
     echo *********************************************************

	::create output directory if not exist
	if not exist "!OutputFileDir!" (
		md "!OutputFileDir!"
	)
	
	::step 3 transcode .mpg file to .mp4 file via FFPEG tool
	set FlagFile=!OutputFileFullPath!.transcoded
	echo FlagFile is !FlagFile!
	
	if  exist "!FlagFile!" (
		
		del "!FlagFile!"
		echo deleted flag file "!FlagFile!"
		echo "!FlagFile!">>"!DeletedFlagList!"
	)
			
)
echo *********************************************************
echo ***                                                  ****
echo    now all .mpg file can be re-trnscoded 
echo    please run the start sctript
echo ***                                                  ****
echo *********************************************************