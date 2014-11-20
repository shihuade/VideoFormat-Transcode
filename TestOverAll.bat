
@echo off

rem set A=E:\口语学习
set A=E:\ABC\EFG\123.txt
echo A is %A%
rem setlocal EnableDelayedExpansion
set /a n=1
call set B=%%A:~-%n%,1%%

echo B is %B%
pause
call GetStringLenth %A% Lenth.txt
echo after call lentth 1
call GetFileNameLenth %A% FileNameLenth.txt
echo after file name lenth

for /f "tokens=1" %%i in (Lenth.txt) do (
	set /a lenth=%%i
)

for /f "tokens=1" %%i in (FileNameLenth.txt) do (
	set /a FileNameLenth=%%i
)

set /a DirLen=lenth - FileNameLenth
set /a n=2
call set Dir=%%A:~%n%,%DirLen%%%
echo Dir is %Dir%
echo DirLen is %DirLen%
echo lenth is %lenth%
echo FileNameLenth is %FileNameLenth%
pause

echo after call
echo A is %A%
echo Lenth is %Lenth%
goto :eof
