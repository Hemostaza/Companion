@echo off
setlocal ENABLEDELAYEDEXPANSION
type ".\lua\shared\Translate\PL\GameSound_PL.txt"> penis.txt
echo Flies>temp.txt
for /f "delims= " %%a in (.\lua\shared\Translate\PL\GameSound_PL.txt) do (
    set "string=%%a"
	echo !string:~11!>>temp.txt
)
echo >temp2.txt
FOR /R %%F in (.\sound\idnas\*) do (
	set string=%%~nF
	echo %%~nF>>temp2.txt
	
)
findstr /v /x /g:temp2.txt temp.txt > out.txt
del temp.txt
del temp2.txt
findstr /g:out.txt penis.txt > output.txt
del penis.txt
pause