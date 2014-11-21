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
	rem echo FileFullPathLength is   
	rem echo DirLenth is          
	rem echo ParentDirLength is   
	rem echo SubDirLength is      
	rem echo FileNameLength is    
	rem get dir info  
	set FullPath=%%i  
	echo Full path is   
    call set FileName=%%FullPath:~,%%  
	call set SubDirName=%%FullPath:~,%%  
	rem echo file name  is     
	rem echo SubDirName is     
	rem rename file  
	for /f "tokens=1 delims=.mpg"  %%j in ("") do (  
		set NewName=%%j.mp4  
	)  
	rem set output dir  
	set OutputFileDir=E:\FFMPEGTestData02  
	set OutputFileFullPath=E:\FFMPEGTestData02  
	echo NewName is   
	echo OutputDir is   
	echo OutputFileFullPath is   
	rem create output directory if not exist  
	if not exist  (  
		md   
	)  
	rem transcode  
	set FlagFile=%%i.transcoded  
	echo FlagFile is   
	if exist  (  
		rem .\bin\ffmpeg -i "%%i"  -c:v libx264  -profile:v main  -level 40 -qmin 24 -qmax 40  -y  ""  
		Replace--FFMPEGCommand  
	)  
	rem echo Test >  
)  
echo all finished  
pause  
