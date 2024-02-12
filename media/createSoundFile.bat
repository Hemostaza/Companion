@echo off
break>.\file.txt
echo module Companion ^{>>file.txt
echo imports^{>>file.txt
echo Base^}>>file.txt

setlocal ENABLEDELAYEDEXPANSION
FOR /R %%F in (.\sound\idnas\*) do (
	echo ^	sound %%~nF>>file.txt
	echo ^	^{>>file.txt
	echo ^	^	category ^= Voice^, loop ^= false^, is3D ^= true^,>>file.txt 
	echo ^	^	clip ^{ file ^= media^/sound^/idnas^/%%~nF.ogg ^,distanceMax ^= 10^, volume ^= 0^.8^,^}>>file.txt
	echo ^	^}>>file.txt
)
echo ^}>>file.txt
PAUSE