@echo off
setlocal ENABLEDELAYEDEXPANSION
type ".\lua\server\CompanionDialogue.lua"> penis.txt
echo. >temp.txt
for /f "tokens=1 delims=0,1,2,3,4,5,6,7,8,9" %%a in (.\lua\shared\Translate\PL\GameSound_PL.txt) do (
    set "string=%%a"
	echo !string:~11!>>temp.txt
)
echo. >output.txt
setlocal ENABLEDELAYEDEXPANSION
for /f "tokens=1 delims= " %%b in (temp.txt) do (
    find "%%b" penis.txt >nul
	if errorlevel 1  (
        if not %%b==ECHO echo %%b>>output.txt
    )
) 
del temp.txt
del penis.txt
pause