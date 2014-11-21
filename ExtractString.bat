
@echo off

set Str=123456789


set A=%Str:~0,5%
echo A is %A%
echo String is %Str%
pause

set /a i=1
set /a j=3
call set B=%%Str:~%i%,%j%%%
rem call set x=%%InputFile:~-%n%,1%%
echo B is %B%
echo String is %Str%
pause