
@echo off
set /a Return=0
set InputString=%~1
set OutFile=%~2

echo input string is %InputString%
if not defined InputString goto :eof

:Continue
set /a Return+=1
set InputString=%InputString:~0,-1%
if defined InputString goto Continue

echo return is %Return%
echo %Return% >%OutFile%

goto :eof


