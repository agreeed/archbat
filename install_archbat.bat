@echo off
@setlocal enableextensions enabledelayedexpansion
set args=x%1%2%3%4%5%6%7%8%9
goto main


:silentinstall
if [%additional_args%] == [/m] (
	set installpath=C:\archbat\
) else (
	set installpath=%USERPROFILE%\Downloads\archbat\
)
mkdir %installpath%
curl https://raw.githubusercontent.com/agreeed/archbat/main/arch.bat -o %installpath%\arch.bat --silent

setx path="%path%;%installpath%" %additional_args%
exit /b %errorlevel%


:install
if [%additional_args%] == [/m] (
	set installpath=C:\archbat\
) else (
	set installpath=%USERPROFILE%\Downloads\archbat\
)
mkdir %installpath%
curl https://raw.githubusercontent.com/agreeed/archbat/main/arch.bat -o %installpath%\arch.bat

setx path "%path%;%installpath%" %additional_args%
pause
exit /b %errorlevel%


:defaultinstaller
echo Welcome to arch.bat Installer.
echo Install arch.bat to system or user?
set /p input=(system/user): 

if [%input%] == [system] (
	set additional_args=/m
) else if [%input%] == [user] (
	set additional_args= 
) else (
	echo Invalid argument. Restarting installation...
	pause
	cls
	goto defaultinstaller
)
goto install


:main
if not [%args:-system=%] == [%args%] (
	set additional_args=/m
) else (
	set additional_args= 
)

if not [%args:-silent=%] == [%args%] (
	goto silentinstall
) else (
	goto defaultinstaller
)