
@echo off
set InputFile=%~1
set OutputFile=%~2
set f=\
set /a n=1

:begin
rem call set x=%%s:~-%n%,1%%
call set x=%%InputFile:~-%n%,1%%
::echo x is %x%
::echo f is %f%
::echo n is %n%

if "%x%"=="%f%" goto :end
set /a n+=1
goto :begin

:end
set /a n-=1
rem echo n is %n%
echo %n% >%OutputFile%

goto :eof

