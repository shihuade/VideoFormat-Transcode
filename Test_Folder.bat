
@echo off

setlocal EnableDelayedExpansion

set FileNameInfoLog=LogFileNameLenth.txt
Set FileDirInfoLog=LogDirInfo.txt
set ParentDirInfoLog=LogParentDirInfo.txt

Set /a FileFullPathLength=0
set /a ParentDirLength=0
Set /a SubDirLength=0
set /a DirLenth=0
Set /a FileNameLength=0

set ParentDir=D:\FFMPEGTestData
set OutPutDir=E:\FFMPEGTestData02

set FileName=""
set SubDirName=""
set NewName=""
set OutputFileFullPath=""
set OutputFileDir=""

for /r D:\FFMPEGTestData  %%i  in (*.txt) do (
	
	
	echo txt file name is %%i
	
	rem get length info
	call GetStringLenth   "%%i"          %FileDirInfoLog%
	call GetStringLenth   "%ParentDir%"  %ParentDirInfoLog%
	call GetFileNameLenth "%%i"          %FileNameInfoLog%
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
	rem call set B=%%A:~-%n%,1%%
	echo FileFullPathLength is !FileFullPathLength!
	echo DirLenth is        !DirLenth!
	echo ParentDirLength is !ParentDirLength!
	echo SubDirLength is    !SubDirLength!
	echo FileNameLength is  !FileNameLength!
	
	rem get dir info
	set FullPath=%%i
	echo Full path is !FullPath!
    call set FileName=%%FullPath:~!DirLenth!,!FileNameLength!%%
	call set SubDirName=%%FullPath:~!ParentDirLength!,!SubDirLength!%%
	
	echo file name is-!FileName!--
	echo SubDirName is -!SubDirName!--
	
	rem rename file
	for /f "tokens=1 delims=.txt"  %%j in ("!FileName!") do (
		set NewName=%%j.log
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
	
	
	
)

