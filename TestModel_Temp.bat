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
ECHO is off.
	echo txt file name is %%i 
ECHO is off.
	rem get length info 
	call bats\GetStringLenth   "%%i"          %FileDirInfoLog% 
	call bats\GetStringLenth   "%ParentDir%"  %ParentDirInfoLog% 
	call bats\GetFileNameLenth "%%i"          %FileNameInfoLog% 
	pause 
ECHO is off.
	for /f "tokens=1" %%j in (%FileDirInfoLog%) do ( 
		set /a FileFullPathLength=%%j 
	) 
	for /f "tokens=1" %%j in (%ParentDirInfoLog%) do ( 
		set /a ParentDirLength=%%j 
	) 
ECHO is off.
	for /f "tokens=1" %%j in (%FileNameInfoLog%) do ( 
		set /a FileNameLength=%%j 
	) 
ECHO is off.
	set /a SubDirLength = FileFullPathLength - ParentDirLength - FileNameLength 
	set /a DirLenth = FileFullPathLength - FileNameLength 
	rem echo FileFullPathLength is  
	rem echo DirLenth is         
	rem echo ParentDirLength is  
	rem echo SubDirLength is     
	rem echo FileNameLength is   
ECHO is off.
	rem get dir info 
	set FullPath=%%i 
	echo Full path is  
    call set FileName=%%FullPath:~,%% 
	call set SubDirName=%%FullPath:~,%% 
ECHO is off.
	rem echo file name  is    
	rem echo SubDirName is    
ECHO is off.
	rem rename file 
	for /f "tokens=1 delims=.mpg"  %%j in ("") do ( 
		set NewName=%%j.mp4 
	) 
	rem set output dir 
	set OutputFileDir=E:\FFMPEGTestData02 
	set OutputFileFullPath=E:\FFMPEGTestData02 
ECHO is off.
	echo NewName is  
	echo OutputDir is  
	echo OutputFileFullPath is  
ECHO is off.
	rem create output directory if not exist 
	if not exist  ( 
		md  
	) 
ECHO is off.
	rem transcode 
	set FlagFile=%%i.transcoded 
	echo FlagFile is  
ECHO is off.
	if exist  ( 
		rem .\bin\ffmpeg -i "%%i"  -c:v libx264  -profile:v main  -level 40 -qmin 24 -qmax 40  -y  "" 
		Replace--FFMPEGCommand 
	) 
	rem echo Test > 
ECHO is off.
ECHO is off.
ECHO is off.
) 
echo all finished 
pause 
