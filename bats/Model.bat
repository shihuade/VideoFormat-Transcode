
@echo off

setlocal EnableDelayedExpansion

set FileNameInfoLog=log\LogFileNameLenth.txt
Set FileDirInfoLog=log\LogDirInfo.txt
set ParentDirInfoLog=log\LogParentDirInfo.txt

Set /a FileFullPathLength=0
set /a ParentDirLength=0
Set /a SubDirLength=0
set /a DirLenth=0
Set /a FileNameLength=0

rem set ParentDir=E:\FFMPEG\BatProcess
rem set OutPutDir=E:\FFMPEGTestData02
Replace--ForInputOutPutDirSetting

set FileName=""
set SubDirName=""
set NewName=""
set OutputFileFullPath=""
set OutputFileDir=""

set FlagFile=""

rem for /r E:\FFMPEG\BatProcess  %%i  in (*.mpg) do (
Replace--ForCommand	
	
	echo txt file name is %%i
	
	rem get length info
	call bats\GetStringLenth   "%%i"          %FileDirInfoLog%
	call bats\GetStringLenth   "%ParentDir%"  %ParentDirInfoLog%
	call bats\GetFileNameLenth "%%i"          %FileNameInfoLog%
	pause
	
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

	rem echo FileFullPathLength is !FileFullPathLength!
	rem echo DirLenth is        !DirLenth!
	rem echo ParentDirLength is !ParentDirLength!
	rem echo SubDirLength is    !SubDirLength!
	rem echo FileNameLength is  !FileNameLength!
	
	rem get dir info
	set FullPath=%%i
	echo Full path is !FullPath!
    call set FileName=%%FullPath:~!DirLenth!,!FileNameLength!%%
	call set SubDirName=%%FullPath:~!ParentDirLength!,!SubDirLength!%%
	
	rem echo file name  is   !FileName!
	rem echo SubDirName is   !SubDirName!
	
	rem rename file
	for /f "tokens=1 delims=.mpg"  %%j in ("!FileName!") do (
		set NewName=%%j.mp4
	)
	rem set output dir
	set OutputFileDir=!OutPutDir!!SubDirName!
	set OutputFileFullPath=!OutPutDir!!SubDirName!!NewName!
	
	echo NewName is !NewName!
	echo OutputDir is !OutputFileDir!
	echo OutputFileFullPath is !OutputFileFullPath!
	
	rem create output directory if not exist
	if not exist !OutputFileDir! (
		md !OutputFileDir!
	)
	
	rem transcode
	set FlagFile=%%i.transcoded
	echo FlagFile is !FlagFile!
	
	if exist !FlagFile! (
		rem .\bin\ffmpeg -i "%%i"  -c:v libx264  -profile:v main  -level 40 -qmin 24 -qmax 40  -y  "!OutputFileFullPath!"
		Replace--FFMPEGCommand
	)
	rem echo Test >!OutputFileFullPath!
	
	
	
)

echo all finished!
pause

