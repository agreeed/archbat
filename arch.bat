@echo off
set ARCH_Version=v0.1

:boot
setlocal
@setlocal enableextensions enabledelayedexpansion
cls
echo Starting arch.bat %version%...
call:window || call:log WARN "Call :window failed with error code %errorlevel%"
call:setESC || call:log WARN "Call :setESC failed with error code %errorlevel%"
call:setVars || call:log WARN "Call :setVars failed with error code %errorlevel%"
call:verifylog || call:log WARN "Call :verifylog failed with error code %errorlevel%"
call:version || call:log WARN "Call :version failed with error code %errorlevel%"
call:log LOG "Currently logged in as %username%"
call:log LOG "Executed from %~dp0"
call:log LOG "Home drive: %homedrive%"
call:log LOG "Operating System: %os%"
call:log LOG "Called: %0"
echo.
call:log LOG "Booting finished. Loading terminal."
set args=x%1%2%3%4%5%6%7%8%9

if [%args:-nowelcome=%] == [%args%] (
	echo.
	echo Welcome to Arch.bat
)

if not [%args:-pause=%] == [%args%] (
	echo Press any key to proceed to terminal.
	pause > nul
)
if not [%args:-cls=%] == [%args%] (
	cls
)
goto terminal


:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B %errorlevel%
)
exit /B %errorlevel%

:setVars
set AClr=%ESC%[
exit /B %errorlevel%

:window
color 07
title Arch.bat %ARCH_Version%
exit /B %errorlevel%

:verifylog
if not exist %~dp0\logs.txt (
	>nul copy NUL logs.txt
)
exit /B %errorlevel%

:version
echo Current arch.bat version is %ARCH_Version%
exit /B %errorlevel%

:log
if [%1] == [ERROR] (
	echo %AClr%91m[%1 %date% %time%] %0:%2 %AClr%0m
) else if [%1] == [WARN] (
	echo %AClr%93m[%1 %date% %time%] %0:%2 %AClr%0m
) else if [%1] == [LOG] (
	echo %AClr%97m[%1 %date% %time%] %0:%2 %AClr%0m
)
echo [%1 %date% %time%] %0:%2>>%~dp0\logs.txt
exit /B %errorlevel%


:logs
more %~dp0\logs.txt
exit /B %errorlevel%

:clearlogs
echo. >%~dp0\logs.txt && echo Logs are cleared successfully. || echo Failed to clear logs.
exit /B %errorlevel%

:restart
set args=x%1%2%3%4%5%6%7%8%9
if [%args:-fast=%] == [%args%] (
	echo.
	echo Restarting in 3 seconds. Press any key to skip.
	timeout 3 > nul
)
start %~dpnx0
exit

:cmds
echo %AClr%102;30m                       Help outlet.                       %AClr%0m
echo To execute a function, type %AClr%97mcall:%AClr%93mfunction%AClr%0m
echo.
echo %AClr%97mArch.bat functions. These are executed on start.%AClr%0m
echo   :boot [-nowelcome] [-pause] [-cls]
echo      Boots up Arch.bat.
echo      -nowelcome Hides welcome message when finished.
echo      -pause When finished loading, pauses.
echo      -cls Clears console before loading terminal.
echo   :setESC
echo      Sets up ^%ESC^% variable for console color escaping.
echo   :setVars
echo      Sets up variables for Arch.bat environment such as
echo      console coloring etc.
echo   :window
echo      Sets up console window.
echo   :verifylog
echo      If logs.txt is not found. Creates one for you.
echo   :version
echo      Displays the arch.bat version.
echo.
echo %AClr%97mUtilities.%AClr%0m
echo   :logs
echo      Displays contents of logs.txt.
echo   :clearlogs
echo      Clears the logs.txt file.
echo   :restart [-fast]
echo      Restarts arch.bat completely. It's recommended to use
echo      call:boot instead.
echo   :cmds
echo      Displays this message.
echo.      
exit /B %errorlevel%


:terminal
cd C:\
rem -----------------------------------
rem              Terminal              
rem -----------------------------------

:terminal_prompt
set TERMINAL_INPUT= 
set /p TERMINAL_INPUT=%AClr%91m%errorlevel% %AClr%97m%username%%AClr%0m@%AClr%97m%cd% %AClr%0m# 
@echo off
%TERMINAL_INPUT%

goto terminal_prompt